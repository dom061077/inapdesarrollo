package com.educacion.academico


import com.educacion.alumno.Alumno;
import java.util.Date;
import com.educacion.academico.Nivel

class Inscripcion {
	Alumno alumno
	Carrera carrera
	AnioLectivo anioLectivo

	Date fechaAlta = new Date()
	
	static hasMany = [detalle:InscripcionDetalleRequisito]
	
	static belongsTo = [Carrera,AnioLectivo]
    static constraints = {
		alumno (nullable:false,blank:false)
		carrera(nullable:false,blank:false)
		anioLectivo(nullable:false,blank:false)
		
    }
	
	static mapping = {
		carrera lazy:false
		anioLectivo lazy:false
	}
}
