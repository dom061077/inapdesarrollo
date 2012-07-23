package com.educacion.academico

import java.sql.Date
import com.educacion.enums.examen.TipoExamenEnum
import com.educacion.enums.examen.ModalidadExamenEnum

class Examen {

    Date fecha
    String titulo
    TipoExamenEnum tipo
    ModalidadExamenEnum moddalidad
    Docente docente

    static constraints = {
        titulo nullable: false,blank: false

    }
}
