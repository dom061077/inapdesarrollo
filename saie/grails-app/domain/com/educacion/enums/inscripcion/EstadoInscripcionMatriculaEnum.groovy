package com.educacion.enums.inscripcion


public enum EstadoInscripcionMatriculaEnum {
    ESTADOINSMAT_INICIADA("Iniciada"),
	ESTADOINSMAT_GENERADA("Generada"),
    ESTADOINSMAT_CONFIRMADA("Matriculado"),
	ESTADOINSMAT_PAGADA("Pagada"),
	ESTADOINSMAT_ANULADA("Anulada")
	
	String name
	public EstadoInscripcionMatriculaEnum(String name){
		this.name=name
	}
	
	static list(){
		[ESTADOINSMAT_INICIADA,ESTADOINSMAT_GENERADA,ESTADOINSMAT_CONFIRMADA,ESTADOINSMAT_PAGADA,ESTADOINSMAT_ANULADA]
	}
}
