#!/bin/bash
CURRENT_TIME=$( date '+%F_%H:%M:%S' )


# mark start
state_set '.state.dbsetup|= $VAL' STARTED

# Check which database kind will be provisioned
DBKIND=$(state_get .lab.database.selected)
echo -n "Initializing $DBKIND..."


# For ADB
# Without TLS enabled and with wallet
if [[ $DBKIND == ADB ]]; then
location="$CB_STATE_DIR/generated/wallet.zip"
CONNSERVICE=cloudbankdb_tp
$CB_STATE_DIR/download-adb-wallet.sh
elif [[ $DBKIND == SIDB ]]; then
CONNSERVICE=XEPDB1
fi

# For ADB
# Retrieve Password
password=$(state_get .lab.fixed_demo_user_credential)
if [ -z "$password" ]; then
  echo "Error: Database user credentials were not found and the database cannot be initialized."
  exit 1;
fi
echo ''

# Navigate to SQL directory
touch $CB_STATE_DIR/logs/$CURRENT_TIME-sql-setup.log
cd $CB_ROOT_DIR/sql


# For ADB
# Without TLS enabled and with wallet
if [[ $DBKIND == ADB ]]; then

{
  echo "set cloudconfig $location"
  echo "conn admin/$password@$CONNSERVICE"
  echo "@AdminCreateUsers.sql"
  echo "conn aquser/$password@$CONNSERVICE"
  echo "@AQUserCreateQueues.sql"
  echo "conn bankauser/$password@$CONNSERVICE"
  echo "@BankAUser.sql"
  echo "conn bankbuser/$password@$CONNSERVICE"
  echo "@BankBUser.sql"
} | sql /nolog > $CB_STATE_DIR/logs/$CURRENT_TIME-sql-setup.log

elif [[ $DBKIND == SIDB ]]; then
./tasks/configure-sidb "cloudbankdb"

fi

# completed
cd $LAB_HOME
echo "DONE"

# mark completed
state_set '.state.dbsetup|= $VAL' DONE