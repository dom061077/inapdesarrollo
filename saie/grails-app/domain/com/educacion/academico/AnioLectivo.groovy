package com.educacion.academico

import java.sql.Date

class AnioLectivo {

	Integer anioLectivo
	Integer cupo
	Integer cupoSuplentes
	Double costoMatricula
	Date fechaInicio
	Date fechaFin
	Carrera carrera
	
	static belongsTo=[carrera:Carrera]
	
    static constraints = {
		carrera(unique: 'anioLectivo')
    }
}
