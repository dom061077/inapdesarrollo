package com.educacion.enums

public enum ModalidadFormacionEnum {
	MODALIDADFORMACION_PRESENCIAL("Presencial"),
	MODALIDADFORMACION_DISTANCIA("a Distancia")
	
	String name
	
	public ModalidadFormacionEnum(String name){
		this.name=name
	}
	
	static list(){
		[MODALIDADFORMACION_PRESENCIAL,MODALIDADFORMACION_DISTANCIA]
	}
	
	
}
