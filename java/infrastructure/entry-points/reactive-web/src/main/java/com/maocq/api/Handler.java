package com.maocq.api;

import com.maocq.model.account.Account;
import com.maocq.usecase.account.AccountUseCase;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.server.ServerRequest;
import org.springframework.web.reactive.function.server.ServerResponse;
import reactor.core.publisher.Mono;

import java.time.Duration;

@Component
@RequiredArgsConstructor
public class Handler {

    private final AccountUseCase accountUseCase;

    public Mono<ServerResponse> listenGETHello(ServerRequest serverRequest) {
        return ServerResponse.ok().bodyValue("Hello");
    }

    public Mono<ServerResponse> listenGETUseCase(ServerRequest serverRequest) {
        var status = serverRequest.queryParam("status")
                .orElse("200");

        return ServerResponse.ok().body(accountUseCase.account(status), Account.class);
    }

    public Mono<ServerResponse> listenGETLatency(ServerRequest serverRequest) {
        var latency = serverRequest.queryParam("delay")
                .orElse("0");

        var response = Mono.fromSupplier(() -> Integer.valueOf(latency))
                .flatMap(time -> Mono.delay(Duration.ofMillis(time)))
                .map(x -> "Ok");
        return ServerResponse.ok().body(response, String.class);
    }
}
