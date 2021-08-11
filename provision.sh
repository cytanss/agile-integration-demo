#!/bin/bash

echo "###############################################################################"
echo "#  MAKE SURE YOU ARE LOGGED IN:                                               #"
echo "#  $ oc login http://api.your.openshift.com                                   #"
echo "###############################################################################"

function usage() {
    echo
    echo "Usage:"
    echo " $0 [command] [options]"
    echo " $0 --help"
    echo
    echo "Example:"
    echo " $0 deploy --project-suffix mydemo"
    echo
    echo "COMMANDS:"
    echo "   deploy                   Set up the demo projects and deploy demo apps"
    echo "   delete                   Clean up and remove demo projects and objects"
    echo "   idle                     Make all demo services idle"
    echo "   unidle                   Make all demo services unidle"
    echo 
    echo "OPTIONS:"
    echo "   --enable-quay              Optional    Enable integration of build and deployments with quay.io"
    echo "   --quay-username            Optional    quay.io username to push the images to a quay.io account. Required if --enable-quay is set"
    echo "   --quay-password            Optional    quay.io password to push the images to a quay.io account. Required if --enable-quay is set"
    echo "   --project-suffix [suffix]  Optional    Suffix to be added to demo project names e.g. ci-SUFFIX. If empty, user will be used as suffix"
    echo
}

ARG_USERNAME=
ARG_PROJECT_SUFFIX=
ARG_COMMAND=
ARG_EPHEMERAL=false
ARG_DEPLOY_CHE=false
ARG_ENABLE_QUAY=false
ARG_QUAY_USER=
ARG_QUAY_PASS=
DEMO_USERNAME=demouser
DEMO_PASSWORD=demo123

while :; do
    case $1 in
        deploy)
            ARG_COMMAND=deploy
            ;;
        delete)
            ARG_COMMAND=delete
            ;;
        idle)
            ARG_COMMAND=idle
            ;;
        unidle)
            ARG_COMMAND=unidle
            ;;
        --user)
            if [ -n "$2" ]; then
                ARG_USERNAME=$2
                shift
            else
                printf 'ERROR: "--user" requires a non-empty value.\n' >&2
                usage
                exit 255
            fi
            ;;
        --project-suffix)
            if [ -n "$2" ]; then
                ARG_PROJECT_SUFFIX=$2
                shift
            else
                printf 'ERROR: "--project-suffix" requires a non-empty value.\n' >&2
                usage
                exit 255
            fi
            ;;
        --enable-quay)
            ARG_ENABLE_QUAY=true
            ;;
        --quay-username)
            if [ -n "$2" ]; then
                ARG_QUAY_USER=$2
                shift
            else
                printf 'ERROR: "--quay-username" requires a non-empty value.\n' >&2
                usage
                exit 255
            fi
            ;;
        --quay-password)
            if [ -n "$2" ]; then
                ARG_QUAY_PASS=$2
                shift
            else
                printf 'ERROR: "--quay-password" requires a non-empty value.\n' >&2
                usage
                exit 255
            fi
            ;;
        --ephemeral)
            ARG_EPHEMERAL=true
            ;;
        --enable-che|--deploy-che)
            ARG_DEPLOY_CHE=true
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        --)
            shift
            break
            ;;
        -?*)
            printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
            shift
            ;;
        *) # Default case: If no more options then break out of the loop.
            break
    esac

    shift
done

################################################################################
# CONFIGURATION                                                                #
################################################################################
echo "Start CONFIGURATION"
LOGGEDIN_USER=$(oc whoami)
OPENSHIFT_USER=${ARG_USERNAME:-$LOGGEDIN_USER}
PRJ_SUFFIX=${ARG_PROJECT_SUFFIX:-`echo $OPENSHIFT_USER | sed -e 's/[-@].*//g'`}
GITHUB_ACCOUNT=${GITHUB_ACCOUNT:-}
GITHUB_REF=${GITHUB_REF:-ocp-4.4.8}

#echo ${OPENSHIFT_USER}
#echo ${PRJ_SUFFIX}
#echo ${GITHUB_ACCOUNT}
#echo ${GITHUB_REF}

#echo "function deploy"
function deploy() {

  #START : Use for scripts testing purposes
  #oc delete project fuse-online amq-online 3scale-project demo-project
  #sleep 5
  #oc patch -n amq-online messagingusers.user.enmasse.io/myspace.demouser --type=merge -p '{"metadata": {"finalizers":null}}'
  #oc delete messagingusers.user.enmasse.io myspace.demouser -n amq-online
  #sleep 5
  #oc delete addressspaceschemas.enmasse.io brokered standard -n amq-online
  #sleep 5
  #oc patch -n amq-online addressspaces.enmasse.io/myspace --type=merge -p '{"metadata": {"finalizers":null}}'
  #oc delete addressspaces.enmasse.io myspace -n amq-online
  #sleep 5
  #read -p "Press Enter to confirm to proceed? " CONFIRMED
  #END : Use for scripts testing purposes

  read -p "Enter Your OpenShift Wildcard Domain: "  WILDCARD_DOMAIN
  read -p "Enter Your Registry Service Account Username: "  RUSERNAME
  read -p "Enter Your Registry Service Account Password: "  RPASSWORD
  
  #WILDCARD_DOMAIN="apps.cluster-86af.86af.sandbox254.opentlc.com"

  echo "Wild Card entered: $WILDCARD_DOMAIN"
  echo "Username entered: $RUSERNAME"
  echo "Password entered: $RPASSWORD"
  read -p "Press Enter Y to confirm to proceed? " CONFIRMED
  
  if [ -z "$CONFIRMED" ];
  then
    echo "Cancel Configuration!"
    exit 0
  else
    if  [ $CONFIRMED != "Y" ] && [ $CONFIRMED != "y" ];
    then
        echo "Cancel Configuration!"
        exit 0
    fi
  fi

  sleep 2

  oc  new-project fuse-online --display-name="Fuse Online Project"
  oc  new-project amq-online  --display-name="AMQ Online Project"
  oc  new-project 3scale-project --display-name="3scale Project"
  oc  new-project demo-project --display-name="Demo Project"

# Provisioning 3scale using Operator
  echo_header "Start provisioning 3scale AMP"
  oc create secret docker-registry threescale-registry-auth --docker-server=registry.redhat.io --docker-username=${RUSERNAME} --docker-password=${RPASSWORD} -n 3scale-project
  oc create -f templates/3scaleoperatorgroup.yaml -n 3scale-project
  oc create -f templates/3scalesub.yaml -n 3scale-project
  oc create secret generic system-seed --from-literal=ADMIN_PASSWORD=$DEMO_PASSWORD -n 3scale-project
  sleep 8
  #sed -i'.original' -e 's/WILDCARD_DOMAIN/'"$WILDCARD_DOMAIN"'/g' templates/3scale-apimanager.yaml
  oc create -f templates/3scale-apimanager.yaml -n 3scale-project
  oc patch APIManager example-apimanager --type='json' -p='[{"op": "replace", "path": "/spec/wildcardDomain", "value": "'$WILDCARD_DOMAIN'" }]' -n 3scale-project

  sleep 1
  oc new-app --template=postgresql-persistent --param=POSTGRESQL_USER=$DEMO_USERNAME --param=POSTGRESQL_PASSWORD=$DEMO_PASSWORD -n demo-project

  oc create secret docker-registry syndesis-pull-secret --docker-server=registry.redhat.io --docker-username=${RUSERNAME} --docker-password=${RPASSWORD} -n fuse-online

  sleep 2

  oc apply -f ./templates/amqonlineoperatorgroup.yaml -n amq-online
  oc apply -f ./templates/amqonlinesub.yaml -n amq-online

  sleep 2

  oc apply -f ./templates/fuseoperatorgroup.yaml -n fuse-online
  oc apply -f ./templates/fusesub.yaml -n fuse-online

  echo_header "Entering 10 sec sleep to wait for Fuse Online core services provisioning"
  sleep 10

  oc secrets link syndesis-operator syndesis-pull-secret --for=pull -n fuse-online
  sleep 1
  oc apply -f ./templates/fusesyndesis.yaml -n fuse-online

  echo_header "Entering 30 sec sleep to wait for Fuse Online provisioning"
  sleep 30

  oc create -f ./templates/amqonlinequickstart.yaml -n amq-online

  dbpodname=$(oc get pods --field-selector status.phase=Running -o custom-columns=POD:.metadata.name --no-headers -n demo-project)

  #echo ${dbpodname}
  oc rsync ./templates/dbscripts ${dbpodname}:/tmp -n demo-project

  sleep 3
  oc exec $dbpodname -- bash -c "psql -U "$DEMO_USERNAME" -d sampledb -a -f /tmp/dbscripts/seed.sql" -n demo-project

  #oc new-app --docker-image=quay.io/integreatly/fruit-crud-app:1.0.1 -n demo-project
  oc new-app --docker-image=quay.io/cytan/fruit-crud-app:latest --as-deployment-config=true -n demo-project
  oc expose svc fruit-crud-app -n demo-project
  sleep 1
  #oc new-app --docker-image=quay.io/integreatly/nodejs-messaging-work-queue:3.0.1 -n demo-project
  oc new-app --docker-image=quay.io/cytan/nodejs-messaging-work-queue:latest --as-deployment-config=true -n demo-project
  oc expose dc/nodejs-messaging-work-queue --port=8080 -n demo-project
  oc expose svc nodejs-messaging-work-queue -n demo-project
  
  echo_header "Entering 60 sec sleep to wait for AMQ Online core services provisioning"
  sleep 60
  #read -p "Press Enter to confirm to proceed? " CONFIRMED
  oc create -f ./templates/amqonlinenamespace.yaml -n amq-online

  oc adm policy add-cluster-role-to-user system:auth-delegator system:serviceaccount:fuse-online:syndesis-public-oauthproxy -n fuse-online
  oc patch syndesis app --type='json' -p='[{"op": "replace", "path": "/spec/addons/publicApi/routeHostname", "value": "public-syndesis.'$WILDCARD_DOMAIN'" }]' -n fuse-online
  
  echo_header "Entering 160 sec sleep to wait for AMQ Online namespaces provisioning"
  sleep 160
  #read -p "Press Enter to confirm to proceed? " CONFIRMED
  oc create -f ./templates/amqonlineaddress.yaml -n amq-online
  
  echo_header "Entering 80 sec sleep to wait for AMQ Online address services provisioning"
  sleep 80
  #read -p "Press Enter to confirm to proceed? " CONFIRMED
  mqsvcname=$(oc get svc -o custom-columns=SVC:.metadata.name --no-headers -n amq-online | grep messaging-).amq-online.svc
  #echo ${mqsvcname}
  oc create configmap messaging-service --from-literal=MESSAGING_SERVICE_USER=${DEMO_USERNAME} --from-literal=MESSAGING_SERVICE_PASSWORD=${DEMO_PASSWORD} --from-literal=MESSAGING_SERVICE_PORT="5672" --from-literal=MESSAGING_SERVICE_HOST=${mqsvcname} -n demo-project
  oc set env dc/nodejs-messaging-work-queue --from=configmap/messaging-service -n demo-project
  oc create -f ./templates/amqonlinemessaginguser.yaml -n amq-online

  sleep 2

  curl -k -v -L -H "Content-Type: application/json" -H "SYNDESIS-XSRF-TOKEN: awesome" -H 'Authorization: Bearer '$(oc whoami -t) https://public-syndesis.$WILDCARD_DOMAIN/api/v1/public/environments/demo --request POST 
  curl -v -k -L -H "Content-Type: multipart/form-data" -H "SYNDESIS-XSRF-TOKEN: awesome" -H 'Authorization: Bearer '$(oc whoami -t) https://public-syndesis.$WILDCARD_DOMAIN/api/v1/public/integrations -F environment=demo -F data=@demo-assets/demo-export.zip --request POST 

  sleep 1

  curl -v -k -L -H "Content-Type: multipart/form-data" -H "SYNDESIS-XSRF-TOKEN: awesome" -H 'Authorization: Bearer '$(oc whoami -t) https://public-syndesis.$WILDCARD_DOMAIN/api/v1/public/integrations/demo1/deployments --request POST

  sleep 5

  curl -v -k -L -H "Content-Type: multipart/form-data" -H "SYNDESIS-XSRF-TOKEN: awesome" -H 'Authorization: Bearer '$(oc whoami -t) https://public-syndesis.$WILDCARD_DOMAIN/api/v1/public/integrations/demo2/deployments --request POST

  sleep 3

}

#echo "function make_idle"
function make_idle() {
  echo_header "Idling Services"
  oc  idle -n fuse-online --all
  oc  idle -n amq-online --all
  oc  idle -n demo-project --all
  oc  idle -n 3scale-project --all
}

#echo "function make_unidle"
function make_unidle() {
  echo_header "Unidling Services"
  local _DIGIT_REGEX="^[[:digit:]]*$"

  for project in fuse-online amq-online demo-project 3scale-project
  do
    for dc in $(oc  get dc -n $project -o=custom-columns=:.metadata.name); do
      local replicas=$(oc  get dc $dc --template='{{ index .metadata.annotations "idling.alpha.openshift.io/previous-scale"}}' -n $project 2>/dev/null)
      if [[ $replicas =~ $_DIGIT_REGEX ]]; then
        oc  scale --replicas=$replicas dc $dc -n $project
      fi
    done
  done
}

#echo "function set_default_project"
function set_default_project() {
  if [ $LOGGEDIN_USER == 'system:admin' ] ; then
    oc  project default >/dev/null
  fi
}

#echo "function remove_storage_claim"
function remove_storage_claim() {
  local _DC=$1
  local _VOLUME_NAME=$2
  local _CLAIM_NAME=$3
  local _PROJECT=$4
  oc  volumes dc/$_DC --name=$_VOLUME_NAME --add -t emptyDir --overwrite -n $_PROJECT
  oc  delete pvc $_CLAIM_NAME -n $_PROJECT >/dev/null 2>&1
}

#echo "function echo_header"
function echo_header() {
  echo
  echo "########################################################################"
  echo $1
  echo "########################################################################"
}

################################################################################
# MAIN: DEPLOY DEMO                                                            #
################################################################################

if [ "$LOGGEDIN_USER" == 'system:admin' ] && [ -z "$ARG_USERNAME" ] ; then
  # for verify and delete, --project-suffix is enough
  if [ "$ARG_COMMAND" == "delete" ] || [ "$ARG_COMMAND" == "verify" ] && [ -z "$ARG_PROJECT_SUFFIX" ]; then
    echo "--user or --project-suffix must be provided when running $ARG_COMMAND as 'system:admin'"
    exit 255
  # deploy command
  elif [ "$ARG_COMMAND" != "delete" ] && [ "$ARG_COMMAND" != "verify" ] ; then
    echo "--user must be provided when running $ARG_COMMAND as 'system:admin'"
    exit 255
  fi
fi

#pushd ~ >/dev/null
START=`date +%s`

echo_header "OpenShift Agile Integration Demo ($(date))"

case "$ARG_COMMAND" in
    delete)
        echo "Delete demo..."
        oc  delete project dev-$PRJ_SUFFIX stage-$PRJ_SUFFIX cicd-$PRJ_SUFFIX
        echo
        echo "Delete completed successfully!"
        ;;
      
    idle)
        echo "Idling demo..."
        make_idle
        echo
        echo "Idling completed successfully!"
        ;;

    unidle)
        echo "Unidling demo..."
        make_unidle
        echo
        echo "Unidling completed successfully!"
        ;;

    deploy)
        echo "Deploying demo..."
        deploy
        echo
        echo "Provisioning completed successfully!"
        ;;
        
    *)
        echo "Invalid command specified: '$ARG_COMMAND'"
        usage
        ;;
esac

END=`date +%s`
echo "(Completed in $(( ($END - $START)/60 )) min $(( ($END - $START)%60 )) sec)"
echo 
