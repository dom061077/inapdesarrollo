package com.educacion.enums

public enum SituacionAcademicaEnum {
	SITACADE_INGRESANTE("INGRESANTE"),
	SITACADE_REGULAR("REGULAR"),
	SITACADE_LIBRE("LIBRE"),
	SITACADE_LIBREPOROPCION("LIBRE POR OPCION")
	
	String name
	public SituacionAcademicaEnum(String name){
		this.name=name
	}
	
	static list(){
		[SITACADE_INGRESANTE,SITACADE_REGULAR,SITACADE_LIBRE,SITACADE_LIBREPOROPCION]
	}
	
	
}