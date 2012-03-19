package com.educacion.academico

import com.educacion.enums.inscripcion.*;
import com.educacion.academico.exceptions.InscripcionMateriaException;


class InscripcionMateriaService {

    static transactional = true
	
	def updateInscripcionMateria(def inscripcionMateriaInstance,def params){
		log.info "INGRESANDO AL METODO: updateInscripcionMateria"
		log.info "PARAMETROS: $params"

		def materiasSerializedJson
		def materiasDeletedJson
		
		if(params.materiasSerialized){
			materiasSerializedJson = grails.converters.JSON.parse(params.materiasSerialized)
		}
		
		if(params.materiasDeletedSerialized){
			materiasDeletedJson = grails.converters.JSON.parse(materiasDeletedSerialized)
		}
		
		

		def inscripcionMateriaDetalleInstance
		def materiaInstance
		materiasDeletedJson.each{
			try{
				inscripcionMateriaDetalleInstance = InscripcionMateriaDetalle.load(it.id.toLong())
				inscripcionMateriaInstance.removeFromDetalleMateria(inscripcionMateriaDetalleInstance)
				inscripcionMateriaInstance.delete(flush:true)
			}catch(org.hibernate.ObjectNotFoundException e){
			}catch (org.springframework.dao.DataIntegrityViolationException e){
				//i must raise exception here
			}
		}
		
		materiasSerializedJson.each {
			 inscripcionMateriaDetalleInstance = InscripcionMateriaDetalle.get(it.id)
			 materiaInstance = Materia.load(it.idid.toLong())
			 if(inscripcionMateriaDetalleInstance){
			 	inscripcionMateriaDetalleInstance.materia = materiaInstance
				inscripcionMateriaDetalleInstance.estado = EstadoInscripcionMateriaDetalleEnum."${it.estadovalue}"
				inscripcionMateriaDetalleInstance.tipo = TipoInscripcionMateria."${it.tipovalue}"
				inscripcionMateriaDetalleInstance.nota = it.nota.toFloat()
			 }else{
			 	inscripcionMateriaDetalleInstance = new InscripcionMateriaDetalle(materia:materiaInstance
					 ,estado:EstadoInscripcionMateriaDetalleEnum."${it.estadovalue}"
					 ,tipo:TipoInscripcionMateria."${it.tipovalue}"
					 ,nota:it.nota.toFloat())
			 }
			 inscripcionMateriaInstance.addToDetalleMateria(inscripcionMateriaDetalleInstance)
		}

				
		if(!inscripcionMateriaInstance.hasErrors() && inscripcionMateriaInstance.save(flush:true)){
			
		}else{
			throw new InscripcionMateriaException(message:"Errores de validacion",inscripcionMateriaInstance)
		}
	}

}
