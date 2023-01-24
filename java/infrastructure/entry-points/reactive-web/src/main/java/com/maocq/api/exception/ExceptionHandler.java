package com.maocq.api.exception;

import com.maocq.model.exceptions.BusinessException;
import com.maocq.model.exceptions.TechnicalException;
import org.springframework.boot.autoconfigure.web.WebProperties;
import org.springframework.boot.autoconfigure.web.reactive.error.AbstractErrorWebExceptionHandler;
import org.springframework.boot.web.reactive.error.ErrorAttributes;
import org.springframework.context.ApplicationContext;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.http.codec.ServerCodecConfigurer;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.server.*;
import org.springframework.web.server.ResponseStatusException;
import reactor.core.publisher.Mono;

import java.util.Map;

@Order(-2)
@Component
public class ExceptionHandler extends AbstractErrorWebExceptionHandler {

    public ExceptionHandler(
            ErrorAttributes errorAttributes,
            WebProperties resources,
            ApplicationContext applicationContext,
            ServerCodecConfigurer serverCodecConfigurer) {
        super(errorAttributes, resources.getResources(), applicationContext);
        this.setMessageWriters(serverCodecConfigurer.getWriters());
    }

    @Override
    protected RouterFunction<ServerResponse> getRoutingFunction(ErrorAttributes errorAttributes) {
        return RouterFunctions.route(RequestPredicates.all(), this::renderErrorResponse);
    }

    private Mono<ServerResponse> renderErrorResponse(ServerRequest request) {

        return Mono.just(getError(request))
                .flatMap(Mono::error)
                .onErrorResume(BusinessException.class, error -> ServerResponse.status(HttpStatus.CONFLICT)
                        .bodyValue(Map.of("code", error.getErrorMessage().getCode())))
                .onErrorResume(TechnicalException.class, error -> ServerResponse.status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .bodyValue(Map.of("code", error.getErrorMessage().getCode())))

                .onErrorResume(ResponseStatusException.class, error -> ServerResponse.status(error.getStatus()).build())
                .onErrorResume(error -> ServerResponse.status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .bodyValue(Map.of("code", "Internal server error")))
                .cast(ServerResponse.class);
    }
}
