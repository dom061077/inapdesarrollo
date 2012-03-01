package com.educacion.academico

import com.educacion.enums.EstadoDetalleInscripcionRequisito

class InscripcionDetalleRequisito {

	Inscripcion inscripcion
	Requisito requisito
	EstadoDetalleInscripcionRequisito estado
	
	
	static belongsTo = [inscripcion:Inscripcion]
	
	
    static constraints = {
    }
}
