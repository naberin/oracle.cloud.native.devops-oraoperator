database=$1
password=$2


{
  echo "alter session set container=XEPDB1;"
  echo "connect sys/$password@$CONNSERVICE as sysdba"
  cat AdminCreateUsers-SIDBXE.sql
  echo "conn aquser/$password@$CONNSERVICE"
  cat AQUserCreateQueues.sql
  echo "conn bankauser/$password@$CONNSERVICE"
  cat BankAUser.sql
  echo "conn bankbuser/$password@$CONNSERVICE"
  cat BankBUser.sql
} | kubectl exec -i $(kubectl get pods | grep $database) -- sqlplus / as sysdba > $CB_STATE_DIR/logs/$CURRENT_TIME-sql-setup.log