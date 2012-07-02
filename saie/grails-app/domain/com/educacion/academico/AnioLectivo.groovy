package com.educacion.academico

import java.sql.Date
import com.educacion.enums.inscripcion.EstadoPreinscripcion

class AnioLectivo {

	Integer anioLectivo
	Integer cupo
	Integer cupoSuplentes
	Double costoMatricula
	Date fechaInicio
	Date fechaFin
	Carrera carrera
	
	static belongsTo=[carrera:Carrera]
	
    static constraints = {
		carrera(unique: 'anioLectivo')
		cupo validator : {val,obj ->
			def hql = """
                       SELECT COUNT(pre.id) as cantidad FROM Preinscripcion pre WHERE pre.estado<>:estado 
						AND pre.carrera= :carrera AND pre.anioLectivo=:aniolectivo
			"""
			def parameters = [estado:EstadoPreinscripcion.ESTADO_PREINSCIRPTOANULADO,anioLectivo:obj,carrera:obj.carrera]
			def list = Carrera.executeQuery(hql)
			def row = list.get(0)
			if(list.size()>0){
				if(obj.cupo+obj.cupoSuplentes<row["cantidad"])
				return false
			}
			return true
		}
    }
}
