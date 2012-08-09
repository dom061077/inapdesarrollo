package com.educacion.academico

import java.sql.Date
import com.educacion.enums.examen.TipoExamenEnum
import com.educacion.enums.examen.ModalidadExamenEnum

class Examen {

    Date fecha = new Date(new java.util.Date().getTime())
    String titulo
    TipoExamenEnum tipo
    ModalidadExamenEnum modalidad
    Docente docente
    InscripcionMateriaDetalle inscripcionMateriaDetalle

    static belongsTo = [inscripcionMateriaDetalle:InscripcionMateriaDetalle]

    static constraints = {
        titulo nullable: false,blank: false

    }
}
