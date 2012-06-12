package com.educacion.academico

import com.educacion.academico.Materia
import com.educacion.academico.InscripcionMatricula

class InscripcionMatriculaService {
	static transactional = true
	
	
	
	def save(def params){
		log.info "INGRESANDO AL METODO DE SERVICIO, save"
		log.info "PARAMETROS: $params"
		def inscripcionMatriculaInstance = new InscripcionMatricula(params)
		
		def materiasSerializedJson
		if(params.materiasSerialized)
			materiasSerializedJson = grails.converters.JSON.parse(params.materiasSerialized)
			
		materiasSerializedJson.each {
			if(it.seleccion.toUpperCase().equals("YES")){
				
			}
		}
	}
}
