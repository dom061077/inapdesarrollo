package com.educacion.enums.inscripcion


public enum EstadoDetalleInscripcionRequisito {
	ESTADOINSREQ_SATISFECHO("Satisfecho"),
	ESTADOINSREQ_INSATISFECHO("Insatisfecho")
	String name
	public EstadoDetalleInscripcionRequisito(String name){
		this.name=name
	}
	
	static list(){
		[ESTADOINSREQ_SATISFECHO,ESTADOINSREQ_INSATISFECHO]
	}
}
