package com.educacion.academico

import com.educacion.enums.examen.TipoExamenEnum
import com.educacion.enums.examen.ModalidadExamenEnum

class CargaExamen {
    Nivel nivel
    AnioLectivo anioLectivo
    Materia materia
    Docente docente
    String titulo

    TipoExamenEnum tipo
    ModalidadExamenEnum modalidad
    
    static constraints = {
        anioLectivo(nullable:false, blank:false)
        materia(nullable:false,blank:false)
        docente(nullable:false,blank:false)
        titulo(nullable:false,blank: false)
    }
}
