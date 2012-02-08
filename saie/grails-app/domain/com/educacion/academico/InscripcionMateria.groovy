package com.educacion.academico

import com.educacion.enums.EstadoInscripcionMateriaEnum

class InscripcionMateria extends Inscripcion{
	Materia materia
	EstadoInscripcionMateriaEnum estado
	
    static constraints = {
    }
}
