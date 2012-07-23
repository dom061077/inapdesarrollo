package com.educacion.enums.examen

public enum TipoExamenEnum {
    TIPOEXAMEN_TEORICO("Teórico"),
    TIPOEXAMEN_PRACTICO("Práctico"),
    TIPOEXAMEN_MIXTO("Mixto")

    String name

    public TipoExamenEnum(String name){
        this.name=name
    }

    static list(){
        [TIPOEXAMEN_TEORICO,TIPOEXAMEN_PRACTICO,TIPOEXAMEN_MIXTO]
    }

}