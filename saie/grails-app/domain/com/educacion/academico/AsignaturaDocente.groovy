package com.educacion.academico

import java.sql.Date

class AsignaturaDocente {
    Date fechaAlta = new Date(new java.util.Date().getTime())
    Carrera carrera
    AnioLectivo anioLectivo
    Docente docente

    static hasMany = [materias:Materia]

    static constraints = {
        carrera nullable: false,blank:false
        anioLectivo nullable: false, blank:false
        docente nullable: false, blank:false
    }
}
