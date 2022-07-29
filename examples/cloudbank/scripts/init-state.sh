#!/bin/bash
# This script is called by setup.sh and initializes the state-file's state values
# This script will require the user to enter the following:
# - Database Password
# - Frontend Login Password
# - Region
# - User OCID
# - Compartment OCID
# - Tenancy OCID
# - Fingerprint
# - OCI Registry
# - Jenkins Password
# todo: generate tokens for cicd webhooks
STATE_LOCATION=$CB_STATE_DIR/state.json


# requires Database Password
read -s -r -p "Enter the Database password to use: " DBPWD
state_set '.lab.pwd.db |= $VAL' $DBPWD
state_set '.lab.pwd.db_wallet |= $VAL' $DBPWD
echo "SET"

# requires Frontend login Password"
read -s -r -p "Enter the Frontend Login password to use: " FEPWD
state_set '.lab.pwd.login |= $VAL' $FEPWD
echo "SET"

# requires Reqion
read -p "Enter the region to use (e.g. us-phoenix-1): " INP
state_set '.lab.region.identifier |= $VAL' $INP

# requires Reqion Key
read -p "Enter the region-key to use (e.g. us-phoenix-1): " RKEY
state_set '.lab.region.key |= $VAL' $RKEY

# requires OCIR registry
namespace=$(oci os ns get | jq -r .data)
OCIR="${RKEY}.ocir.io/${namespace}/cloudbank"
state_set '.lab.docker_registry |= $VAL' $OCIR

# requires compartment OCID
read -p "Enter the compartment OCID to provision resources in: " OCID
state_set '.lab.ocid.compartment |= $VAL' $OCID

# requires tenancy OCID
read -p "Enter the tenancy OCID to authenticate provisioning with: " tOCID
state_set '.lab.ocid.tenancy |= $VAL' $tOCID

# requires user OCID
read -p "Enter the user OCID to authenticate provisioning with: " uOCID
state_set '.lab.ocid.user |= $VAL' $uOCID

# requires Fingerprint
read -p "Enter user fingerprint to authenticate provisioning with: " fPRINTVAL
state_set '.lab.apikey.fingerprint |= $VAL' $fPRINTVAL

# requires Jenkins password
read -s -r -p "Enter the Jenkins credentials to use: " JPWD
state_set '.lab.pwd.jenkins |= $VAL' $JPWD
echo "SET"


# Check which database kind will the user go with for the lab
echo ""
echo 'Available Database Options for the Lab'
PS3='Please select the type of Database you plan to use (1 or 2): '
options=("Option 1: Oracle Autonomous Database (ADB)" "Option 2: Oracle Single Instance Database (SIDB)")
select opt in "${options[@]}"
do
    case $opt in
        "Option 1: Oracle Autonomous Database (ADB)")
                CONFIGURATION='ADB'
                echo "You have selected Oracle Autonomous Database (ADB)"
                break
                ;;
        "Option 2: Oracle Single Instance Database (SIDB)")
                    CONFIGURATION='SIDB'
                    echo "You have selected Oracle Single Instance Database (SIDB)"
                    break
                    ;;
        *) echo "You entered an invalid option: $REPLY. Please use the number of the option to decide.";;
    esac
done
state_set '.lab.database.selected |= $VAL' $CONFIGURATION
echo ""

