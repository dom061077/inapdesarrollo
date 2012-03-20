package com.educacion.academico

import com.educacion.enums.inscripcion.*;
import com.educacion.academico.exceptions.InscripcionMateriaException;
import com.educacion.enums.inscripcion.TipoInscripcionMateria
import com.educacion.enums.inscripcion.EstadoInscripcionMateriaDetalleEnum;


class InscripcionMateriaService {

    static transactional = true
	
	private def validarCorrelatividades(Long idMat,def tipoInscripcion,def idAlu){
		def flagvalidacion = false //si le falta alguna materia la bandera sera true
		def materiaInstance = Materia.load(idMat)
		def list
		if(tipoInscripcion.equals(TipoInscripcionMateria.TIPOINSMATERIA_CURSAR)){
			materiaInstance.matregcursar.each {
				list = InscripcionMateriaDetalle.createCriteria().list{
					and{
						alumno{
							eq("id",idAlu)
						}
						eq("estado",EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_REGULAR)
						materia{
							eq("id",it.id)
						}
					}
				} 
				if(list.size()==0)
				
			}
			materiaInstance.mataprobcursar.each{
				
			}
		}
		if(tipoInscripcion.equals(TipoInscripcionMateria.TIPOINSMATERIA_RENDIRFINAL)){
			 
		}
		if(tipoInscripcion.equals(TipoInscripcionMateria.TIPOINSMATERIA_RENDIRLIBRE)){
		
		}


		
	}
	
	def saveInscripcionMateria(def inscripcionMateriainstance,def params){
		log.info "INGRESANDO AL METODO: saveInscripcionMateria"
		log.info ("PARAMETROS: $params")
		def materiasSerializedJson
		
		if(params.materiasSerialized){
			materiasSerializedJson = grails.converters.JSON.parse(params.materiasSerialized)
		}
		
		def inscripcionMateriaInstance = new InscripcionMateria(params)
		if (inscripcionMateriaInstance.save(flush: true)) {
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'inscripcionMateria.label', default: 'InscripcionMateria'), inscripcionMateriaInstance.id])}"
			redirect(action: "show", id: inscripcionMateriaInstance.id)
		}else {
			render(view: "create", model: [inscripcionMateriaInstance: inscripcionMateriaInstance])
		}
	}
	
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
