package com.educacion.enums.inscripcion


public enum EstadoPreinscripcion {
	ESTADO_ASPIRANTE("Aspirante"),
	ESTADO_PREINSCRIPTO("Preinscripto"),
	ESTADO_PREINSCRIPTOSUPLENTE("Preinscripto como suplente"),
	ESTADO_INSCRIPTO("Matriculado"),
	ESTADO_PREINSCIRPTOANULADO("Anulado")
	String name
	public EstadoPreinscripcion(String name){
		this.name=name
	}
	
	static list(){
		[ESTADO_ASPIRANTE,ESTADO_PREINSCRIPTO,ESTADO_PREINSCRIPTOSUPLENTE,ESTADO_INSCRIPTO]
	}
}
