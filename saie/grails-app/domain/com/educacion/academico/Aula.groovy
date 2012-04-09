package com.educacion.academico

import com.educacion.enums.EstadoAulaEnum;

class Aula {

	String nombre
	Integer cupo
	String localizacion
	EstadoAulaEnum estado
	
	static belongsTo =[Carrera]
	
	static hasMany = [carreras:Carrera]
	
    static constraints = {
		nombre(nullable:false,blank:false,size:1..36,unique:true)
	}
}
