package com.educacion.enums.inscripcion


public enum EstadoInscripcionMateriaEnum {
	ESTADOINSMAT_ACTIVA("Activa"),
	ESTADOINSMAT_ANULADA("Anulada")
	
	String name
	public EstadoInscripcionMateriaEnum(String name){
		this.name=name
	}
	
	static list(){
		[ESTADOINSMAT_ACTIVA,ESTADOINSMAT_ANULADA]
	}
}
