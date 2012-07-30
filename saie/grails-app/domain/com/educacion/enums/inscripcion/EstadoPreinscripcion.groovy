package com.educacion.enums.inscripcion


public enum EstadoPreinscripcion {
	ESTADO_ASPIRANTE("Aspirante"),
    ESTADO_ASPIRANTESUPLENTE("Aspirante Suplente"),
	ESTADO_PREINSCRIPTO("Preinscripto"),
	ESTADO_PREINSCRIPTOSUPLENTE("Preinscripto Suplente"),
	ESTADO_INSCRIPTO("Confirmada"),
	ESTADO_PREINSCRIPTOANULADO("Anulado")
	String name
	public EstadoPreinscripcion(String name){
		this.name=name
	}
	
	static list(){
		[ESTADO_ASPIRANTE,ESTADO_PREINSCRIPTO,ESTADO_PREINSCRIPTOSUPLENTE,ESTADO_INSCRIPTO,ESTADO_PREINSCRIPTOANULADO]
	}
}
