package com.educacion.academico

import com.educacion.enums.inscripcion.EstadoInscripcionMateriaEnum;
import com.educacion.enums.inscripcion.TipoInscripcionMateria

class InscripcionMateria extends Inscripcion{
	Materia materia
	
	EstadoInscripcionMateriaEnum estado
	TipoInscripcionMateria tipo
	Integer nota
	
    static constraints = {
    }
}
