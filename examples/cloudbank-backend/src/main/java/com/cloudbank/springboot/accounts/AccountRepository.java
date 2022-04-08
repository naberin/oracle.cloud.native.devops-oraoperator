package com.cloudbank.springboot.accounts;

import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;
import oracle.jms.AQjmsFactory;
import oracle.jms.AQjmsSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.jms.*;
import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

@Repository
public class AccountRepository {

    private final TopicConnection connection;
    private final OracleConnection jdbcConnection;

    @Autowired
    public AccountRepository(DataSource dataSource) throws JMSException {
        TopicConnectionFactory tcf = AQjmsFactory.getTopicConnectionFactory(dataSource);
        connection = tcf.createTopicConnection();
        TopicSession session = connection.createTopicSession(true, Session.CLIENT_ACKNOWLEDGE);
        jdbcConnection = (OracleConnection) ((AQjmsSession) session).getDBConnection();
    }

    /**
     *
     * @return
     * @throws SQLException
     * @throws JMSException
     */
    public ArrayList<Account> getListOfAccounts() throws SQLException, JMSException {
        // create statement and execute
        OraclePreparedStatement p_stmt = (OraclePreparedStatement) jdbcConnection
                .prepareStatement("select ACCOUNT_ID, ACCOUNT_NAME from CB_BANK_ACCOUNTS");
        p_stmt.execute();

        // handle returned results
        ResultSet res = p_stmt.getReturnResultSet();
        ArrayList<Account> accounts = new ArrayList<>();

        // add records
        while(res.next()) {
            accounts.add(new Account(
                    res.getString("ACCOUNT_ID"),
                    res.getString("ACCOUNT_NAME"))
            );
        }
        connection.close();
        return accounts;
    }

    public ArrayList<AccountWithBalance> getAccounts() throws SQLException, JMSException {
        // create statement and execute
        OraclePreparedStatement p_stmt = (OraclePreparedStatement) jdbcConnection
                .prepareStatement("select ACCOUNT_ID, ACCOUNT_NAME, ACCOUNT_BALANCE from CB_BANK_ACCOUNTS");
        p_stmt.execute();

        // handle returned results;
        ResultSet res = p_stmt.getReturnResultSet();
        ArrayList<AccountWithBalance> accounts = new ArrayList<>();

        // add records
        while (res.next()) {
            accounts.add( new AccountWithBalance(
                    res.getString("ACCOUNT_ID"),
                    res.getString("ACCOUNT_NAME"),
                    res.getDouble("ACCOUNT_BALANCE")
            ));
        }
        connection.close();
        return accounts;
    }

    /**
     *
     * @return
     * @throws SQLException
     * @throws JMSException
     */
    public ArrayList<Account> getListOfExternalAccounts() throws SQLException, JMSException {
        // create statement and execute
        OraclePreparedStatement p_stmt = (OraclePreparedStatement) jdbcConnection
                .prepareStatement("select RECORD_ID, ACCOUNT_NAME from CB_EXTERNAL_ACCOUNTS where ACTIVATED=1");
        p_stmt.execute();

        // handle returned results
        ResultSet res = p_stmt.getReturnResultSet();
        ArrayList<Account> accounts = new ArrayList<>();

        // add records
        while(res.next()) {
            accounts.add(new Account(
                    res.getString("RECORD_ID"),
                    res.getString("ACCOUNT_NAME"))
            );
        }
        connection.close();
        return accounts;
    }


}
