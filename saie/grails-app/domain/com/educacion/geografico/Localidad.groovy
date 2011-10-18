package com.educacion.geografico



class Localidad {
	String nombre
	Provincia provincia
	static belongsTo= [provincia:Provincia]

    static constraints = {
    }
}
