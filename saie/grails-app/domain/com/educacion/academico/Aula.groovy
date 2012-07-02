package com.educacion.academico

import com.educacion.enums.EstadoAulaEnum;

class Aula {

	String nombre
	Integer cupo
	String localizacion
	EstadoAulaEnum estado
	
	static hasMany=[detalle:DetalleAula,divisiones:Division]

	static constraints = {
		nombre(nullable:false,blank:false,size:1..100,unique:true)
	}
	
	static mapping = {
			detalle lazy:false	
	}
	
}
