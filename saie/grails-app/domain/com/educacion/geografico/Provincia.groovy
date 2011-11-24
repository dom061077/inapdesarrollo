package com.educacion.geografico



class Provincia {
	String nombre
	Pais pais
	static belongsTo = [pais:Pais]
    static constraints = {
    }
	
	static mapping = {
		pais lazy:false
	}
}
