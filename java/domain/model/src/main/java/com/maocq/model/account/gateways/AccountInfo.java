package com.maocq.model.account.gateways;

import reactor.core.publisher.Mono;

public interface AccountInfo {

     Mono<String> get(String status);
}
