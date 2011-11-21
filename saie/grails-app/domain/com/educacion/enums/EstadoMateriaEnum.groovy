package com.educacion.enums

public enum EstadoMateriaEnum {
	ESTADOMATERIA_HABILITADA("Habilitada"),
	ESTADOMATERIA_INAHABILITADA("Inhabilitada")
	String name
	public EstadoMateriaEnum(String name){
		this.name=name
	}
	
	static list(){
		[ESTADOMATERIA_HABILITADA,ESTADOMATERIA_INAHABILITADA]
	}
}
