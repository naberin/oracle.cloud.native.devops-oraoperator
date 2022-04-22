
#!/bin/bash

# #########
# Variables
# #########
DB_NAME=$1
DB_OCID=`kubectl get AutonomousDatabase/$DB_NAME -o jsonpath='{.spec.details.autonomousDatabaseOCID}'`;
OCI_CONFIG='oci-config'
OCI_PRIVKEY_SEC='oci-privatekey'

# #############################################
# Terminate
# terminates the previous database if it exists
# by retrieving ADBOCID using the Operator
# #############################################
if [ ! -z "$DB_OCID" ] then
    tmplt =`cat "../templates/adb-terminate.yml" | sed -i -e "s/{{DB_OCID}}/${DB_OCID}/g" -e "s/{{DB_NAME}}/${DB_NAME}/g" -e "s/{{OCI_CONFIG}}/${OCI_CONFIG}/g" -e "s/{{OCI_PRIVKEY_SEC}}/${OCI_PRIVKEY_SEC}/g"`
    echo "$tmplt" # | kubectl apply -f
elif [ -z "$DB_OCID" ] then
    echo "LabError: Database OCID not found for AutonomousDatabase/${DB_NAME}"
fi
