package com.educacion.academico

import com.educacion.enums.inscripcion.EstadoDetalleInscripcionRequisito

class InscripcionDetalleRequisito {

	Inscripcion inscripcion
	Requisito requisito
	EstadoDetalleInscripcionRequisito estado
	
	
	static belongsTo = [inscripcion:Inscripcion]
	
	
    static constraints = {
    }
}
