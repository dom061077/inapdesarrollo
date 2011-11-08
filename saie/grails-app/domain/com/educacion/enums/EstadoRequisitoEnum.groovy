package com.educacion.enums

public enum EstadoRequisitoEnum {
	ESTADOREQUISITO_ACTIVO("Activo"),
	ESTADOREQUISITO_INACTIVO("Inactivo")
	String name
	public EstadoRequisitoEnum(String name){
		this.name=name
	}
	
	static list(){
		[ESTADOREQUISITO_ACTIVO,ESTADOREQUISITO_INACTIVO]
	}
}
