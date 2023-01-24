package com.maocq.repository.account;

import com.maocq.model.account.Account;
import com.maocq.model.account.gateways.AccountRepository;
import lombok.RequiredArgsConstructor;
import org.reactivecommons.utils.ObjectMapper;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Mono;

@Repository
@RequiredArgsConstructor
public class AccountDataRepository implements AccountRepository {
    private final AccountDataDAO accountDataDAO;
    private final ObjectMapper mapper;

    @Override
    public Mono<Account> getAccount(Integer id) {
        return accountDataDAO.findById(id)
                .map(this::toEntity);
    }

    private Account toEntity(AccountData data) {
        return mapper.map(data, Account.class);
    }
    private AccountData toData(Account data) {
        return mapper.map(data, AccountData.class);
    }
}
