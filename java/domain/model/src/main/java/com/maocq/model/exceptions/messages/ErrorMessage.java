package com.maocq.model.exceptions.messages;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ErrorMessage {
    ACCOUNT_INFO_FIND_ERROR("SFB0001", "Error consultando información de la cuenta"),

    TECHNICAL_RESTCLIENT_ERROR("SCT0010","Ha ocurrido un error en el cliente rest"),
    EXTERNAR_MESSAGE_ERROR("SFB9999", "Error");


    private final String code;
    private final String message;
}
