package com.educacion.enums.inscripcion


public enum EstadoInscripcionMateriaEnum {
    ESTADOINSMAT_CREADA("Creada"),
	ESTADOINSMAT_ACTIVA("Confirmada"),
	ESTADOINSMAT_ANULADA("Anulada")
	
	String name
	public EstadoInscripcionMateriaEnum(String name){
		this.name=name
	}
	
	static list(){
		[ESTADOINSMAT_ACTIVA,ESTADOINSMAT_ANULADA]
	}
}
