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
state_set '.lab.region |= $VAL' $INP

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

# requires OCIR registry
LAB="$(jq -r .lab.docker_registry $STATE_LOCATION )"
read -p "Enter the OCI Registry to use: [$LAB] " OCID
state_set '.lab.docker_registry |= $VAL' $OCID

# requires Jenkins password
read -s -r -p "Enter the Jenkins credentials to use: " JPWD
state_set '.lab.pwd.jenkins |= $VAL' $JPWD
echo "SET"

