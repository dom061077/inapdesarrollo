package com.educacion.academico

class Division {
	String descripcion
	String letra
	String turno
	String descripcionTurno
	Integer cupoComision
	Nivel nivel
	
	static belongsTo=[nivel:Nivel]
	
    static constraints = {
		descripcion(nullable:false,blank:false,size:1..50)
		letra(nullable:false,blank:false,size:1..2)
    }
}
