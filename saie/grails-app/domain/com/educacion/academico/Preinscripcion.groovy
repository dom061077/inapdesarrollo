package com.educacion.academico


import com.educacion.enums.inscripcion.EstadoPreinscripcion;

class Preinscripcion extends Inscripcion {
	
	EstadoPreinscripcion estado
	InscripcionMatricula inscripcionMatricula
	static constraints = {
		inscripcionMatricula(nullable:true)
		alumno(validator:{v,obj ->
			if(!obj.id){
				def cantInsc = Preinscripcion.createCriteria().get{
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
						ne("estado",EstadoPreinscripcion.ESTADO_PREINSCIRPTOANULADO)
					}
					projections{
						rowCount()
					}
				}
				if(cantInsc>0)
					return ["unique.error"]
			}
			
			
		})

	}

    static mapping = {
        alumno cascade: "save-update"
    }
	

	
	
	
	
}
