package com.cloudbank.springboot.accounts;

public class Account {
    private String accountId;
    private String accountName;

    public Account(String accountId, String accountName) {
        this.accountId = accountId;
        this.accountName = accountName;
    }

    public String getAccountId() {
        return accountId;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }
}

class AccountWithBalance {
    private String accountId;
    private String accountName;
    private Double accountBalance;

    public AccountWithBalance(String accountId, String accountName, Double accountBalance) {
        this.accountId = accountId;
        this.accountName = accountName;
        this.accountBalance = accountBalance;
    }

    public String getAccountName() {
        return accountName;
    }

    public String getAccountId() {
        return accountId;
    }

    public Double getAccountBalance() {
        return accountBalance;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public void setAccountBalance(Double accountBalance) {
        this.accountBalance = accountBalance;
    }
}
