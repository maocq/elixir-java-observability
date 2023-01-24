package com.maocq.usecase.account;

import java.util.UUID;

import com.maocq.model.account.Account;
import com.maocq.model.account.gateways.AccountInfo;
import com.maocq.model.account.gateways.AccountRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;
import reactor.core.publisher.Mono;

@Log
@RequiredArgsConstructor
public class AccountUseCase {
    private final AccountRepository accountRepository;
    private final AccountInfo accountInfo;

    public Mono<Account> account(String status) {
        log.info("Account UseCase " + UUID.randomUUID());

        return accountInfo.get("200")
                .flatMap(x -> accountInfo.get(status))
                .flatMap(y -> accountRepository.getAccount(4000));
    }
}
