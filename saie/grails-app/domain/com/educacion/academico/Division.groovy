package com.educacion.academico

class Division {
	String descripcion
	String letra
	String turno
	String descripcionTurno
	Integer cupoComision
	Nivel nivel
    Aula aula
	
	static belongsTo=[nivel:Nivel,aula:Aula]
	
    static constraints = {
		descripcion(nullable:false,blank:false,size:1..50)
		letra(nullable:false,blank:false,size:1..2)
    }
}
