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
# - Setup Config
STATE_LOCATION=$CB_STATE_DIR/state.json


# requires Database Password
echo -n "Retreiving database credentials..."
read -s -r -p "Enter the Database password to use: " DBPWD
echo "$(jq --arg VAL $DBPWD '.lab.pwd.db |= $VAL' $STATE_LOCATION)" > $STATE_LOCATION
echo "$(jq --arg VAL $DBPWD '.lab.pwd.db_wallet |= $VAL' $STATE_LOCATION)" > $STATE_LOCATION
echo "SET"
echo ""

# requires Frontend login Password
echo -n "Retreiving frontend credentials..."
read -s -r -p "Enter the Frontend Login password to use: " FEPWD
echo "$(jq --arg VAL $FEPWD '.lab.pwd.login |= $VAL' $STATE_LOCATION)" > $STATE_LOCATION
echo "SET"
echo ''

# requires Reqion
echo -n "Retreiving set region..."
read -p "Enter the region to use (e.g. us-phoenix-1): " INP
echo "$(jq --arg VAL $INP '.lab.region |= $VAL' $STATE_LOCATION)" > $STATE_LOCATION
echo "SET"
echo ''

# requires compartment OCID
echo -n "Retreiving Compartment OCID..."
read -p "Enter the compartment OCID to provision resources in: " OCID
echo "$(jq --arg VAL $OCID '.lab.ocid.compartment |= $VAL' $STATE_LOCATION)" > $STATE_LOCATION
echo "SET"
echo ''

# requires tenancy OCID
echo -n "Retreiving Tenancy OCID..."
read -p "Enter the tenancy OCID to provision resources in: " tOCID
echo "$(jq --arg VAL $tOCID '.lab.ocid.tenancy |= $VAL' $STATE_LOCATION)" > $STATE_LOCATION
echo "SET"
echo ''

# requires user OCID
echo -n "Retreiving User OCID..."
read -p "Enter the user OCID to provision resources in: " uOCID
echo "$(jq --arg VAL $uOCID '.lab.ocid.user |= $VAL' $STATE_LOCATION)" > $STATE_LOCATION
echo "SET"
echo ''

# requires Fingerprint
echo -n "Retreiving user fingerprint..."
read -p "Enter user fingerprint to provision resources in: " fPRINTVAL
echo "$(jq --arg VAL $fPRINTVAL '.lab.apikey.fingerprint |= $VAL' $STATE_LOCATION)" > $STATE_LOCATION
echo "SET"
echo ''

# requires OCIR registry
echo "Setting Docker Registry..."
LAB="$(jq -r .lab.docker_registry $STATE_LOCATION )"
read -p "Enter the OCI Registry to use: [$LAB] " OCID
echo "$(jq --arg VAL $OCID '.lab.docker_registry |= $VAL' $STATE_LOCATION)" > $STATE_LOCATION
echo "SET"
echo ''
