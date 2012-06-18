package com.educacion.academico

import com.educacion.enums.inscripcion.EstadoInscripcionMateriaDetalleEnum;
import com.educacion.enums.inscripcion.TipoInscripcionMateriaEnum
import com.educacion.enums.inscripcion.EstadoInscripcionMateriaEnum

class InscripcionMateriaDetalle {
	Materia materia
	EstadoInscripcionMateriaDetalleEnum estado = EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_INSCRIPTO
	TipoInscripcionMateriaEnum tipo
	Float nota = new Float(0)

	InscripcionMateria inscripcionMateria
	
	static belongsTo = [inscripcionMateria:InscripcionMateria]
	
    static constraints = {
		materia(unique:'inscripcionMateria',validator:{v,obj->
			if(!obj.id){
				def cantDet = InscripcionMateriaDetalle.createCriteria().get{
					and{
						inscripcionMateria{	
							alumno{
								eq("id",obj.inscripcionMateria.alumno.id)
							}
							carrera{
								eq("id",obj.inscripcionMateria.carrera.id)
							}
							anioLectivo{
								eq("id",obj.inscripcionMateria.anioLectivo.id)
							}
							ne("estado",EstadoInscripcionMateriaEnum.ESTADOINSMAT_ANULADA)
						}
						materia{
							eq("id",obj.materia.id)
						}
					}
					projections{
						rowCount()
					}
				}
				if(cantDet>0)
					return ["xxx.error"]
			}
		})
		
    }
	
}
