
#!/bin/bash

# #########
# Variables
# #########
ADBNAME=$1
ADBOCID=`kubectl get AutonomousDatabase/$ADBNAME -o jsonpath='{.spec.details.autonomousDatabaseOCID}'`;


# #############################################
# Terminate
# terminates the previous database if it exists
# by retrieving ADBOCID using the Operator
# #############################################
if [ ! -z "$ADBOCID" ] then
    tmplt =`cat "../templates/adb-terminate.yml" | sed -i -e "s/{{ADBOCID}}/$ADBOCID/g" -e "s/{{ADBNAME}}/$ADBNAME/g"`
    echo "$tmplt" # | kubectl apply -f
fi
