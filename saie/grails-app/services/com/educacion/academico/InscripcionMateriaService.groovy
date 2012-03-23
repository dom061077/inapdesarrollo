package com.educacion.academico

import com.educacion.enums.inscripcion.*;
import com.educacion.academico.exceptions.InscripcionMateriaException;
import com.educacion.enums.inscripcion.TipoInscripcionMateria
import com.educacion.enums.inscripcion.EstadoInscripcionMateriaDetalleEnum;


class InscripcionMateriaService {

    static transactional = true
	
	private def validarCorrelatividades(Long idMat,def tipoInscripcion,def idAlu,def inscripcionMateriaInstance){
		def flagvalidacion = false //si le falta alguna materia la bandera sera true
		def materiaInstance = Materia.load(idMat)
		def list
		if(tipoInscripcion.equals(TipoInscripcionMateria.TIPOINSMATERIA_CURSAR)){
			materiaInstance.matregcursar.each {matreg->
				list = InscripcionMateriaDetalle.createCriteria().list{
					and{
						inscripcionMateria{
							alumno{
								eq("id",idAlu)
							}
						}
						eq("estado",EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_REGULAR)
						materia{
							eq("id",matreg.id)
						}
					}
				} 
				if(list.size()==0){
					flagvalidacion = true
					inscripcionMateriaInstance.errors.rejectValue("detalleMateria"
						, "com.educacion.academico.InscripcionMateriaDetalle.materia.blank.error"
						,[EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_REGULAR.name,matreg.denominacion] as Object[],"Error de validacion de correlatividad")
				}
				if(list.size()>1){
					flagvalidacion = true
					inscripcionMateriaInstance.errors.rejectValue("detalleMateria", "com.educacion.academico.InscripcionMateriaDetalle.inscripcion.maxsize"
						,[EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_REGULAR.name,matreg.denominacion] as Object[],"Error de validacion de correlatividad")
				}
			}
			
			materiaInstance.mataprobcursar.each{mataprob->
				list = InscripcionMateriaDetalle.createCriteria().list{
					and{
						inscripcionMateria{
							alumno{
								eq("id",idAlu)
							}
						}
						eq("estado",EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_APROBADA)
						materia{
							eq("id",mataprob.id)
						}
					}
				}
				if(list.size()==0){
					flagvalidacion = true
					inscripcionMateriaInstance.errors.rejectValue("detalleMateria", "com.educacion.academico.InscripcionMateriaDetalle.materia.blank.error"
						,[EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_APROBADA.name,mataprob.denominacion] as Object[],"Error de validacion de correlatividad")
				}
				if(list.size()>1){
					flagvalidacion = true
					inscripcionMateriaInstance.errors.rejectValue("detalleMateria", "com.educacion.academico.InscripcionMateriaDetalle.inscripcion.maxsize"
						,[EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_APROBADA.name,mataprob.denominacion] as Object[],"Error de validacion de correlatividad")
				}
			}
		}
		
		
		if(tipoInscripcion.equals(TipoInscripcionMateria.TIPOINSMATERIA_RENDIRFINAL) || tipoInscripcion.equals(TipoInscripcionMateria.TIPOINSMATERIA_RENDIRLIBRE)){
			materiaInstance.matregrendir.each {matreg->
				list = InscripcionMateriaDetalle.createCriteria().list{
					and{
						inscripcionMateria{
							alumno{
								eq("id",idAlu)
							}
						}
						eq("estado",EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_REGULAR)
						materia{
							eq("id",matreg.id)
						}
					}
				}
				if(list.size()==0){
					flagvalidacion = true
					inscripcionMateriaInstance.errors.rejectValue("detalleMateria", "com.educacion.academico.InscripcionMateriaDetalle.materia.blank.error"
						,[EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_REGULAR.name,matreg.denominacion] as Object[],"Error de validacion de correlatividad")
				}
				if(list.size()>1){
					flagvalidacion = true
					inscripcionMateriaInstance.errors.rejectValue("detalleMateria", "com.educacion.academico.InscripcionMateriaDetalle.inscripcion.maxsize"
						,[EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_REGULAR.name,matreg.denominacion] as Object[],"Error de validacion de correlatividad")
				}
			}
			
			
			materiaInstance.mataprobrendir.each{mataprob->
				list = InscripcionMateriaDetalle.createCriteria().list{
					and{
						inscripcionMateria{
							alumno{
								eq("id",idAlu)
							}
						}
						eq("estado",EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_APROBADA)
						materia{
							eq("id",mataprob.id)
						}
					}
				}
				if(list.size()==0){
					flagvalidacion = true
					inscripcionMateriaInstance.errors.rejectValue("detalleMateria", "com.educacion.academico.InscripcionMateriaDetalle.materia.blank.error"
						,[EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_APROBADA.name,mataprob.denominacion] as Object[],"Error de validacion de correlatividad")
				}
				if(list.size()>1){
					flagvalidacion = true
					inscripcionMateriaInstance.errors.rejectValue("detalleMateria", "com.educacion.academico.InscripcionMateriaDetalle.inscripcion.maxsize"
						,[EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_APROBADA.name,mataprob.denominacion] as Object[],"Error de validacion de correlatividad")
				}
			}
		}
		return flagvalidacion
	}
	
	def saveInscripcionMateria(def inscripcionMateriaInstance,def params){
		log.info "INGRESANDO AL METODO: saveInscripcionMateria"
		log.info ("PARAMETROS: $params")
		def materiasSerializedJson
		def materiaInstance
		def inscripcionMateriaDetalleInstance
		
		if(params.materiasSerialized){
			materiasSerializedJson = grails.converters.JSON.parse(params.materiasSerialized)
		}
		
		def materiaAntInstance
		materiasSerializedJson.each {
			if(!validarCorrelatividades(it.idid.toLong(),TipoInscripcionMateria."${it.tipovalue}",inscripcionMateriaInstance.alumno.id,inscripcionMateriaInstance)){
				 materiaInstance = Materia.load(it.idid.toLong())
				 if(materiaInstance.equals(materiaAntInstance)){
					 inscripcionMateriaInstance.errors.rejectValue("detalleMateria", "com.educacion.academico.InscripcionMateriaDetalle.materia.unique.error"
						 ,[materiaInstance.denominacion] as Object[],"Error de validacion materia repetida")
				 }else{
					 inscripcionMateriaDetalleInstance = new InscripcionMateriaDetalle(materia:materiaInstance
						 ,estado:EstadoInscripcionMateriaDetalleEnum."${it.estadovalue}"
						 ,tipo:TipoInscripcionMateria."${it.tipovalue}"
						 )
					 inscripcionMateriaInstance.addToDetalleMateria(inscripcionMateriaDetalleInstance)
				 }
				 
			}
			materiaAntInstance=materiaInstance
		}

				
		if(!inscripcionMateriaInstance.hasErrors() && inscripcionMateriaInstance.save()){
			
		}else{
			throw new InscripcionMateriaException("Errores de validacion",inscripcionMateriaInstance)
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
			materiasDeletedJson = grails.converters.JSON.parse(params.materiasDeletedSerialized)
		}
		
		

		def inscripcionMateriaDetalleInstance
		def materiaInstance
		materiasDeletedJson.each{
			try{
				inscripcionMateriaDetalleInstance = InscripcionMateriaDetalle.load(it.id.toLong())
				inscripcionMateriaInstance.removeFromDetalleMateria(inscripcionMateriaDetalleInstance)
				inscripcionMateriaDetalleInstance.delete()
			}catch(org.hibernate.ObjectNotFoundException e){
			}catch (org.springframework.dao.DataIntegrityViolationException e){
				log.debug "Error de integridad "+e.message
			}
		}
		def materiaAntInstance
		materiasSerializedJson.each {
			if(!validarCorrelatividades(it.idid.toLong(),TipoInscripcionMateria."${it.tipovalue}",inscripcionMateriaInstance.alumno.id,inscripcionMateriaInstance)){
				 inscripcionMateriaDetalleInstance = InscripcionMateriaDetalle.get(it.idDet)
				 materiaInstance = Materia.load(it.idid.toLong())
				 if(materiaInstance.equals(materiaAntInstance)){
					 
				 }else{
					 if(inscripcionMateriaDetalleInstance){
					 	inscripcionMateriaDetalleInstance.materia = materiaInstance
						inscripcionMateriaDetalleInstance.estado = EstadoInscripcionMateriaDetalleEnum."${it.estadovalue}"
						inscripcionMateriaDetalleInstance.tipo = TipoInscripcionMateria."${it.tipovalue}"
						inscripcionMateriaDetalleInstance.save()
					 }else{
					 	inscripcionMateriaDetalleInstance = new InscripcionMateriaDetalle(materia:materiaInstance
							 ,estado:EstadoInscripcionMateriaDetalleEnum."${it.estadovalue}"
							 ,tipo:TipoInscripcionMateria."${it.tipovalue}"
							 )
						inscripcionMateriaInstance.addToDetalleMateria(inscripcionMateriaDetalleInstance)
					 }
				 }
			}
			materiaAntInstance = materiaInstance
		}

				
		if(!inscripcionMateriaInstance.hasErrors() && inscripcionMateriaInstance.save(flush:true)){
			
		}else{
			throw new InscripcionMateriaException("Errores de validacion",inscripcionMateriaInstance) 
		}
	}

}
