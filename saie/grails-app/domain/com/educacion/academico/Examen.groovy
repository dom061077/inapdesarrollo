package com.educacion.academico

import java.sql.Date
import com.educacion.enums.examen.TipoExamenEnum
import com.educacion.enums.examen.ModalidadExamenEnum

class Examen {

    InscripcionMateriaDetalle inscripcionMateriaDetalle
    CargaExamen cargaExamen

    static belongsTo = [inscripcionMateriaDetalle:InscripcionMateriaDetalle,cargaExamen: CargaExamen]

    static constraints = {


    }
}
