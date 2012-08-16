package com.educacion.enums

public enum AsistenciaEnum {
    p("Presente"),
    a("Ausente")
    String name
    public AsistenciaEnum(String name){
        this.name=name
    }

    static list(){
        [p,a]
    }
}

