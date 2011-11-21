package com.educacion.enums

public enum TipoMateriaEnum {
	TIPOMATERIA_CURRICULAR("Curricular"),
	TIPOMATERIA_ELECTIVA("Electiva")
	String name
	public TipoMateriaEnum(String name){
		this.name=name
	}
	
	static list(){
		[TIPOMATERIA_CURRICULAR,TIPOMATERIA_ELECTIVA]
	}
}
