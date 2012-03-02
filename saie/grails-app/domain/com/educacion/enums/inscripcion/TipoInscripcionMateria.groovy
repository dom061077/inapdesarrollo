package com.educacion.enums.inscripcion


public enum TipoInscripcionMateria {
	TIPOINSMATERIA_CURSAR("Cursar"),
	TIPOINSMATERIA_RENDIRLIBRE("Rendir Libre"),
	TIPOINSMATERIA_RENDIRFINAL("Rendir Final")
	String name
	public TipoInscripcionMateria(String name){
		this.name=name
	}
	
	static list(){
		[TIPOINSMATERIA_CURSAR,TIPOINSMATERIA_RENDIRLIBRE,TIPOINSMATERIA_RENDIRFINAL]
	}
}
