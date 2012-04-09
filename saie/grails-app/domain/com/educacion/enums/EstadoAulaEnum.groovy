package com.educacion.enums

public enum EstadoAulaEnum {
	ESTADOAULA_HABILITADA("Habilitada"),
	ESTADOAULA_INAHABILITADA("Inhabilitada")
	String name
	public EstadoAulaEnum(String name){
		this.name=name
	}
	
	static list(){
		[ESTADOAULA_HABILITADA,ESTADOAULA_INAHABILITADA]
	}
}
