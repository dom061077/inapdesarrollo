package com.educacion.enums

public enum EstadoPreinscripcion {
	PREINS_HABILITADO("Habilitado"),
	PREINS_INHABILITADO("Inhabilitado")
	String name
	public EstadoPreinscripcion(String name){
		this.name=name
	}
	
	static list(){
		[PREINS_HABILITADO,PREINS_INHABILITADO]
	}
}
