package com.educacion.enums

public enum EstadoInscripcionMateriaEnum {
	ESTADOINSMAT_INSCRIPTO("Inscripto"),
	ESTADOINSMAT_REGULAR("Regular"),
	ESTADOINSMAT_APROBADA("Aprobada")
	String name
	public EstadoInscripcionMateriaEnum(String name){
		this.name=name
	}
	
	static list(){
		[ESTADOINSMAT_INSCRIPTO,ESTADOINSMAT_REGULAR,ESTADOINSMAT_APROBADA]
	}
}
