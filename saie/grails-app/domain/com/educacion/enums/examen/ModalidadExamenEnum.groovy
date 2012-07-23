package com.educacion.enums.examen

public enum ModalidadExamenEnum {
    MODALIDADEXAMEN_ORAL("Oral"),
    MODALIDADEXAMEN_ESCRITO("Escrito"),
    MODALIDADEXAMEN_MIXTO("Mixto")

    String name

    public ModalidadExamenEnum(String name){
        this.name=name
    }

    static list(){
        [MODALIDADEXAMEN_ORAL,MODALIDADEXAMEN_ESCRITO,MODALIDADEXAMEN_MIXTO]
    }

}