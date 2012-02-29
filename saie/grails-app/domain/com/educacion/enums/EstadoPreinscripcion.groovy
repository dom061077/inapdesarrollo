package com.educacion.enums

public enum EstadoPreinscripcion {
	ESTADO_PREINSCRIPTO("Preinscripto"),
	ESTADO_PREINSCRIPTOSUPLENTE("Preinscripto como suplente")
	String name
	public EstadoPreinscripcion(String name){
		this.name=name
	}
	
	static list(){
		[ESTADO_PREINSCRIPTO,ESTADO_PREINSCRIPTOSUPLENTE]
	}
}
