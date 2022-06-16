#!/bin/bash
CURRENT_TIME=$( date '+%F_%H:%M:%S' )


# Retrieve database details (connection string) and pwd
echo -n "Retrieving Connection String..."
CONNSTRING=$(kubectl get AutonomousDatabase/cloudbankdb -o jsonpath='{.status.allConnectionStrings[?(@.tlsAuthentication=="TLS")].connectionStrings[?(@.tnsName=="cloudbankdb_tp")].connectionString}')
echo "DONE"
if [ -z "$CONNSTRING" ]; then
  echo "Error: Connection String could not be retrieved and the database cannot be initialized."
  exit 1;
fi
echo -n "Retrieving Password..."
password=$(state_get .lab.fixed_demo_user_credential)
echo "DONE"
if [ -z "$password" ]; then
  echo "Error: Database user credentials were not found and the database cannot be initialized."
  exit 1;
fi
echo ''

# Start SQLcl
echo -n "Setting up Lab-related database objects..."
touch $CB_STATE_DIR/logs/$CURRENT_TIME-sql-setup.log
cd $CB_ROOT_DIR/sql
{
  echo "conn admin/$password@$CONNSTRING"
  echo "@AdminCreateUsers.sql"
  echo "conn aquser/$password@$CONNSTRING"
  echo "@AQUserCreateQueues.sql"
  echo "conn bankauser/$password@$CONNSTRING"
  echo "@BankAUser.sql"
  echo "conn bankbuser/$password@$CONNSTRING"
  echo "@BankBUser.sql"
} | sql /nolog 2>&1 | tee -a $CB_STATE_DIR/logs/$CURRENT_TIME-sql-setup.log
cd $LAB_HOME
echo "DONE"