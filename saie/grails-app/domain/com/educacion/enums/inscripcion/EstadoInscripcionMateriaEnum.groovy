package com.educacion.enums.inscripcion


public enum EstadoInscripcionMateriaEnum {
	ESTADOINSMAT_INSCRIPTO("Inscripto"),
	ESTADOINSMAT_REGULAR("Regular"),
	ESTADOINSMAT_APROBADA("Aprobada"),
	ESTADOINSMAT_DESAPROBADA("Desaprobada"),
	ESTADOINSMAT_AUSENTE("Ausente")
	String name
	public EstadoInscripcionMateriaEnum(String name){
		this.name=name
	}
	
	static list(){
		[ESTADOINSMAT_INSCRIPTO,ESTADOINSMAT_REGULAR,ESTADOINSMAT_APROBADA,ESTADOINSMAT_DESAPROBADA,ESTADOINSMAT_AUSENTE]
	}
}
