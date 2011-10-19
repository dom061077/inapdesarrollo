package com.educacion.geografico



class Localidad {
	String nombre
	Provincia provincia
	Integer codigoPostal
	static belongsTo= [provincia:Provincia]

    static constraints = {
    }
}
