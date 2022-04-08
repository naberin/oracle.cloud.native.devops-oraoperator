package com.cloudbank.springboot.accounts;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/account")
public class AccountController {

    @Autowired
    private AccountService accountService;

    @GetMapping
    public List<Object> handleGetAccounts(@RequestParam(defaultValue = "false") String list) {
        boolean withoutBalance = list.equals("true");
        return accountService.getListOfAccounts(withoutBalance);
    }

    @GetMapping("/transfer")
    public Map<String, Object> handleTransfer() {
        return accountService.getAccountsForTransfer();

    }

}
