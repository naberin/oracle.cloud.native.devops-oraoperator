#!/bin/bash
CURRENT_TIME=$( date '+%F_%H:%M:%S' )


# Retrieve database details (connection string) and pwd
CONNSTRING=$(kubectl get AutonomousDatabase/cloudbankdb -o jsonpath='{.status.allConnectionStrings[?(@.tlsAuthentication=="TLS")].connectionStrings[?(@.tnsName=="cloudbankdb_tp")].connectionString}')
if [ -z $CONNSTRING ]; then
  echo "Error: Connection String could not be retrieved and the database cannot be initialized."
  exit 1;
fi
PWD=$(state_get .lab.fixed_demo_user_credential)
if [ -z $PWD ]; then
  echo "Error: Database user credentials were not found and the database cannot be initialized."
  exit 1;
fi


# Start SQLcl
echo -n "Setting up Lab-related database objects..."
touch $CB_STATE_DIR/logs/$CURRENT_TIME-sql-setup.log
cd $CB_ROOT_DIR/sql
{
  echo "conn admin/$PWD@$CONNSTRING"
  echo "@AdminCreateUsers.sql"
  echo "conn aquser/$PWD@$CONNSTRING"
  echo "@AQUserCreateQueues.sql"
  echo "conn bankauser/$PWD@$CONNSTRING"
  echo "@BankAUser.sql"
  echo "conn bankbuser/$PWD@$CONNSTRING"
  echo "@BankBUser.sql"
} | sql /nolog 2>&1 | tee -a $CB_STATE_DIR/logs/$CURRENT_TIME-sql-setup.log
cd $LAB_HOME
echo "DONE"