package com.educacion.academico

class DetalleAula {

	String descripcion
	Aula aula
	Carrera carrera
	
	static belongTo= [aula:Aula]
	
    static constraints = {
    }
}
