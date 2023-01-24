package com.maocq.model.exceptions;

import com.maocq.model.exceptions.messages.ErrorMessage;
import lombok.Getter;

@Getter
public class TechnicalException extends RuntimeException {
    private final ErrorMessage errorMessage;

    public TechnicalException(ErrorMessage errorMessage) {
        super(errorMessage.getMessage());
        this.errorMessage = errorMessage;
    }

    public TechnicalException(ErrorMessage errorMessage, Throwable cause) {
        super(errorMessage.getMessage(), cause);
        this.errorMessage = errorMessage;
    }
}