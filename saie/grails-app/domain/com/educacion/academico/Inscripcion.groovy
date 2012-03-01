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
    }
}
