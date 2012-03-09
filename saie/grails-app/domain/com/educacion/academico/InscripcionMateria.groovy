package com.educacion.academico


class InscripcionMateria extends Inscripcion{
	
	
	static hasMany = [detalle:InscripcionMateriaDetalle]
	
    static constraints = {
    }
}
