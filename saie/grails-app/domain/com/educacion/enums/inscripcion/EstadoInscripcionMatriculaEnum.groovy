package com.educacion.enums.inscripcion


public enum EstadoInscripcionMatriculaEnum {
	ESTADOINSMAT_GENERADA("Generada"),
	ESTADOINSMAT_PAGADA("Pagada"),
	ESTADOINSMAT_ANULADA("Anulada")
	
	String name
	public EstadoInscripcionMatriculaEnum(String name){
		this.name=name
	}
	
	static list(){
		[ESTADOINSMAT_GENERADA,ESTADOINSMAT_PAGADA,ESTADOINSMAT_ANULADA]
	}
}
