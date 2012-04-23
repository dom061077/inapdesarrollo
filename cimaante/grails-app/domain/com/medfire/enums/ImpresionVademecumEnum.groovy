package com.medfire.enums

public enum ImpresionVademecumEnum{
	IMPRIME_GENERICO("Nombre generico"),
	IMPRIME_COMERCIAL("Nombre Comercial"),
	IMPRIME_AMBOS("Ambos")
	
	String name
	
	public ImpresionVademecumEnum(String name){
		this.name=name
	}
	
	
	static list(){
		[IMPRIME_GENERICO,IMPRIME_COMERCIAL,IMPRIME_AMBOS]
	}
	
}