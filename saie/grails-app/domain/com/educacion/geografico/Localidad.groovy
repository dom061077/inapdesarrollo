package com.educacion.geografico



class Localidad {
	String nombre
	Integer codigoPostal
	
	Provincia provincia
	static belongsTo= [provincia:Provincia]

    static constraints = {
    }
}
