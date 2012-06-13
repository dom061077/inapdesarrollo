package com.educacion.enums.inscripcion

public enum OrigenInscripcionMateriaEnum {
	ORIGENINSCMATERIA_ENMATRICULA("Origen en Matricula"),
	ORIGENINSCMATERIA_POSMATRICULA("Origen despues de Matricula")
	String name
	
	public OrigenInscripcionMateriaEnum(String name){
		this.name=name
	}
	
	static list(){
		[ORIGENINSCMATERIA_ENMATRICULA,ORIGENINSCMATERIA_POSMATRICULA]
	}

}
