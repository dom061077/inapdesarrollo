package com.educacion.enums.inscripcion


public enum EstadoPreinscripcion {
	ESTADO_ASPIRANTE("Aspirante"),
    ESTADO_ASPIRANTESUPLENTE("Aspirante Suplente"),
	ESTADO_PREINSCRIPTO("Preinscripto"),
	ESTADO_PREINSCRIPTOSUPLENTE("Preinscripto Suplente"),
    //------estados para tener rastreo del estado anterior en el caso de eliminacion de matricula --
	ESTADO_INSCRIPTO("Confirmada"),//estado anterior ESTADO_PREINSCRIPTO
    ESTADO_INSCRIPTOSUPLENTE("Confirmada"),//estado anterior, ESTADO_PREINSCRIPTOSUPLENTE
    ESTADO_INSCRIPTOASPIRANTE("Confirmada"),//estado anterior: ESTADO_ASPIRANTE
    ESTADO_INSCRIPTOASPIRANTESUPLENTE("Confirmada"),//estado anteriror:  ESTADO_ASPIRANTESUPLENTE
    //-----------------------------------------------------------
	ESTADO_PREINSCRIPTOANULADO("Anulado")
	String name
	public EstadoPreinscripcion(String name){
		this.name=name
	}
	
	static list(){
		[ESTADO_ASPIRANTE,ESTADO_PREINSCRIPTO,ESTADO_PREINSCRIPTOSUPLENTE,ESTADO_INSCRIPTO,ESTADO_INSCRIPTOSUPLENTE,ESTADO_PREINSCRIPTOANULADO]
	}
}
