package com.cloudbank.springboot.accounts;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.jms.JMSException;
import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@Service
public class AccountService {

    Logger logger = LoggerFactory.getLogger(AccountService.class);

    @Autowired
    private DataSource dataSource;

    /**
     *
     * @return
     */
    public Map<String, Object> getAccountsForTransfer() {

        Map<String, Object> response = new HashMap<String, Object>();

        try {
            ArrayList<Account> user_accounts = new AccountRepository(dataSource).getListOfAccounts();
            logger.debug("{} accounts retrieved", user_accounts.size());
            response.put("sources", user_accounts);
        } catch (SQLException | JMSException e) {
            logger.error(e.toString());
            response.put("sources", new ArrayList<>());
        }

        try {
            ArrayList<Account> external_accounts = new AccountRepository(dataSource).getListOfExternalAccounts();
            response.put("destinations", external_accounts);
        } catch (SQLException | JMSException e) {
            logger.error(e.toString());
            response.put("sources", new ArrayList<>());
        }

        return response;
    }

    /**
     *
     * @return
     */
    public ArrayList<Object> getListOfAccounts(boolean withoutBalance) {
        ArrayList<Object> response = new ArrayList<>();
        try {

            if (withoutBalance) {
                response.addAll(new AccountRepository(dataSource).getListOfAccounts());
            }
            else {
                response.addAll(new AccountRepository(dataSource).getAccounts());
            }
            logger.debug("{} accounts retrieved", response.size());


        } catch (SQLException | JMSException e) {
            logger.error(e.toString());
            e.printStackTrace();
        }
        return response;
    }


}
