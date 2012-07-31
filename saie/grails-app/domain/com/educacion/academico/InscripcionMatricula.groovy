package com.educacion.academico

import com.educacion.enums.inscripcion.EstadoInscripcionMatriculaEnum

class InscripcionMatricula extends Inscripcion {
	
	EstadoInscripcionMatriculaEnum estado
	
	static hasMany = [inscripcionesmaterias:InscripcionMateria]
	
    static constraints = {
		alumno(validator:{v,obj ->
			if(!obj.id){
				def cantInsc = InscripcionMatricula.createCriteria().get{
					and{
						alumno{
							eq("id",obj.alumno.id)
						}
						carrera{
							eq("id",obj.carrera.id)
						}
						anioLectivo{
							eq("id",obj.anioLectivo.id)
						}
						ne("estado",EstadoInscripcionMatriculaEnum.ESTADOINSMAT_ANULADA)
					}
					projections{
						rowCount()
					}
				}
				if(cantInsc>0)
					return ["unique.error"]
			}
			
		})
        /*
		inscripcionesmaterias (validator:{val,obj ->
			if(!obj.inscripcionesmaterias)
				return ["size.error"]
			if(obj.inscripcionesmaterias?.size()==0)
				return ["size.error"]	
		})*/
    }
	
	
}
