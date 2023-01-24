package com.maocq.model.account.gateways;

import com.maocq.model.account.Account;
import reactor.core.publisher.Mono;

public interface AccountRepository {

    Mono<Account> getAccount(Integer id);
}
