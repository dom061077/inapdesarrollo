package com.educacion.alumno

import com.educacion.enums.AsistenciaEnum
import com.educacion.academico.InscripcionMateriaDetalle

class Asistencia {
    java.sql.Date fechaAsistencia
    AsistenciaEnum asistencia
    InscripcionMateriaDetalle inscripcionMateriaDetalle

    static belongsTo = [inscripcionMateriaDetalle:InscripcionMateriaDetalle]

    static constraints = {

    }
}
