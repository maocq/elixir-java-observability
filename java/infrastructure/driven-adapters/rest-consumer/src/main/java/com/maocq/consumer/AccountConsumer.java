package com.maocq.consumer;

import com.maocq.model.account.gateways.AccountInfo;
import com.maocq.model.exceptions.BusinessException;
import com.maocq.model.exceptions.TechnicalException;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import static com.maocq.model.exceptions.messages.ErrorMessage.*;

@Service
@RequiredArgsConstructor
public class AccountConsumer implements AccountInfo {

    private final WebClient client;

    public Mono<String> get(String status) {
        return client
            .get()
            .uri("/{status}", status)
            .retrieve()
            .onStatus(HttpStatus::is4xxClientError, clientResponse -> Mono.error(new BusinessException(ACCOUNT_INFO_FIND_ERROR)))
            .onStatus(HttpStatus::is5xxServerError, clientResponse -> Mono.error(new TechnicalException(TECHNICAL_RESTCLIENT_ERROR)))
            .bodyToMono(String.class);
    }
}