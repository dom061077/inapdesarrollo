package com.educacion.enums.inscripcion


public enum TipoInscripcionMateriaEnum {
	TIPOINSMATERIA_CURSAR("Cursar"),
	TIPOINSMATERIA_RENDIRLIBRE("Rendir Libre"),
	TIPOINSMATERIA_RENDIRFINAL("Rendir Final")
	String name
	public TipoInscripcionMateriaEnum(String name){
		this.name=name
	}
	
	static list(){
		[TIPOINSMATERIA_CURSAR,TIPOINSMATERIA_RENDIRLIBRE,TIPOINSMATERIA_RENDIRFINAL]
	}
    
    static def listforselectview(){
        //value:"FE:FedEx;IN:InTime;TN:TNT;AR:ARAMEX"
        def result=""
        list().each {
            if(!result.equals(""))
                result+=";"
            result+="$it:"+it.name
        }
        return result
    }
}
