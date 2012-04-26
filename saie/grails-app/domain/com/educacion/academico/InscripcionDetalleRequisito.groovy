package com.educacion.academico

import com.educacion.enums.inscripcion.EstadoDetalleInscripcionRequisito
import java.util.Date

class InscripcionDetalleRequisito {

	Inscripcion inscripcion
	Requisito requisito
	EstadoDetalleInscripcionRequisito estado
	Date fechaCumplido
	
	
	
	static belongsTo = [inscripcion:Inscripcion]
	
	
    static constraints = {
    }
}
