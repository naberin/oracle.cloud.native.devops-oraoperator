#!/bin/bash

# #########
# Variables
# #########
DBNAME=$1
DBCONNECTIONOCID=$2
DBSCRIPTLOCATION=$3

# #############################################
# Recreate
# Recreates the expected database objects
# such as the CloudBank schema and test data
# using sqlcl
# #############################################
env {
    echo "oci profile DEFAULT"
    echo "conn ${DBCONNECTIONOCID}"
    echo "script ${DBSCRIPTLOCATION}"
    echo "exit"
} | sql /nolog
