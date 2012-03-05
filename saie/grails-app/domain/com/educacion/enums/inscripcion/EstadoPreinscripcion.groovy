package com.educacion.enums.inscripcion


public enum EstadoPreinscripcion {
	ESTADO_PREINSCRIPTO("Preinscripto"),
	ESTADO_PREINSCRIPTOSUPLENTE("Preinscripto como suplente"),
	ESTADO_INSCRIPTO("INSCRIPTO")
	String name
	public EstadoPreinscripcion(String name){
		this.name=name
	}
	
	static list(){
		[ESTADO_PREINSCRIPTO,ESTADO_PREINSCRIPTOSUPLENTE,ESTADO_INSCRIPTO]
	}
}
