#!/bin/bash
# This script is called by setup.sh and initializes the state-file's state values
# This script will require the user to enter the following:
# - Database Password
# - Frontend Login Password
# - Region
# - Compartment OCID
# - Tenancy OCID
# - Fingerprint
# - Setup Config
STATE_LOCATION=$CB_STATE_DIR/state.json


# requires Database Password
echo -n "Retreiving set database credentials..."
DBVAL="$(jq -e .lab.pwd.db $STATE_LOCATION)"
if [[ $DBVAL = null ]]; then
  echo "NOT FOUND"
  read -s -r -p "Enter the Database password to use: " DBPWD

  echo "$(jq --arg VAL $DBPWD '.lab.pwd.db |= $VAL' $STATE_LOCATION)" > $STATE_LOCATION
  echo "$(jq --arg VAL $DBPWD '.lab.pwd.db_wallet |= $VAL' $STATE_LOCATION)" > $STATE_LOCATION
  echo "SET"
elif [[ ! $DBVAL = null ]]; then
  echo "DONE"
fi
echo ''

# requires Frontend login Password
echo -n "Retreiving set frontend credentials..."
LOGINVAL="$(jq -e .lab.pwd.login $STATE_LOCATION)"
if [[ $LOGINVAL = null ]]; then
  echo "NOT FOUND"
  read -s -r -p "Enter the Frontend Login password to use: " PWD

  echo "$(jq --arg VAL $PWD '.lab.pwd.login |= $VAL' $STATE_LOCATION)" > $STATE_LOCATION
  echo "SET"
elif [ ! $LOGINVAL = null ]; then
  echo "DONE"
fi
echo ''


# requires Reqion
echo -n "Retreiving set region..."
REGIONVAL="$(jq -e .lab.region $STATE_LOCATION )"
if [[ $REGIONVAL = null ]]; then
  echo "NOT FOUND"
  read -p "Enter the region to use (e.g. us-phoenix-1): " INP

  echo "$(jq --arg VAL $INP '.lab.region |= $VAL' $STATE_LOCATION)" > $STATE_LOCATION
  echo "SET"
elif [[ ! $REGIONVAL = null ]]; then
  echo "DONE"
fi
echo ""


# requires compartment OCID
echo -n "Retreiving Compartment OCID..."
COMPVAL="$(jq -e .lab.ocid.compartment $STATE_LOCATION)"
if [[ $COMPVAL = null ]]; then
  echo "NOT FOUND"
  read -p "Enter the compartment OCID to provision resources in: " OCID

  echo "$(jq --arg VAL $OCID '.lab.ocid.compartment |= $VAL' $STATE_LOCATION)" > $STATE_LOCATION
elif [[ ! $COMPVAL = null ]]; then
  echo 'DONE'
fi
echo ""


# requires tenancy OCID
echo -n "Retreiving Tenancy OCID..."
TENANCYVAL="$(jq -e .lab.ocid.tenancy $STATE_LOCATION)"
if [[ $TENANCYVAL = null ]]; then
  echo "NOT FOUND"
  read -p "Enter the tenancy OCID to provision resources in: " OCID

  echo "$(jq --arg VAL $OCID '.lab.ocid.tenancy |= $VAL' $STATE_LOCATION)" > $STATE_LOCATION
elif [[ ! $TENANCYVAL = null ]]; then
  echo "DONE"
fi
echo ""


# requires Fingerprint
echo -n "Retreiving user fingerprint..."
FPRINTVAL="$(jq -e .lab.sk.fingerprint $STATE_LOCATION)"
if [[ $FPRINTVAL = null ]]; then
  echo "NOT FOUND"
  read -p "Enter user fingerprint to provision resources in: " FPRINTVAL

  echo "$(jq --arg VAL FPRINTVAL '.lab.sk.fingerprint |= $VAL' $STATE_LOCATION)" > $STATE_LOCATION
elif [[ ! $TENANCYVAL = null ]]; then
  echo "DONE"
fi
echo ""


# requires OCIR registry
echo "Setting Docker Registry..."
LAB="$(jq -r .lab.docker_registry $STATE_LOCATION )"
read -p "Enter the OCI Registry to use: [$LAB] " OCID

if [ -n "$OCID" ]; then
  echo "$(jq --arg VAL $OCID '.lab.docker_registry |= $VAL' $STATE_LOCATION)" > $STATE_LOCATION
fi
echo ""

