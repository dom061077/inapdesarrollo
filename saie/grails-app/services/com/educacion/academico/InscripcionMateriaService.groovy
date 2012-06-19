package com.educacion.academico

import com.educacion.enums.inscripcion.*;
import com.educacion.academico.exceptions.InscripcionMateriaException;
import com.educacion.enums.inscripcion.TipoInscripcionMateriaEnum
import com.educacion.enums.inscripcion.EstadoInscripcionMateriaDetalleEnum;
import com.educacion.util.GUtilDomainClass
import com.educacion.enums.inscripcion.OrigenInscripcionMateriaEnum
import com.educacion.academico.util.AcademicoUtil


class InscripcionMateriaService {

    static transactional = true
	
	private def validarCorrelatividades(Long idMat,def tipoInscripcion,def idAlu,def inscripcionMateriaInstance){
		def flagvalidacion = false //si le falta alguna materia la bandera sera true
		def materiaInstance = Materia.load(idMat)
		def list
		if(tipoInscripcion.equals(TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR)){
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
		
		
		if(tipoInscripcion.equals(TipoInscripcionMateriaEnum.TIPOINSMATERIA_RENDIRFINAL) || tipoInscripcion.equals(TipoInscripcionMateriaEnum.TIPOINSMATERIA_RENDIRLIBRE)){
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
			if(it.seleccion.toUpperCase().equals("YES")){
				
				if(!validarCorrelatividades(it.idid.toLong(),TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR,inscripcionMateriaInstance.alumno.id,inscripcionMateriaInstance)){
					 materiaInstance = Materia.load(it.idid.toLong())
					 if(materiaInstance.equals(materiaAntInstance)){
						 inscripcionMateriaInstance.errors.rejectValue("detalleMateria", "com.educacion.academico.InscripcionMateriaDetalle.materia.unique.error"
							 ,[materiaInstance.denominacion] as Object[],"Error de validacion materia repetida")
					 }else{
						 inscripcionMateriaDetalleInstance = new InscripcionMateriaDetalle(materia:materiaInstance
							 ,estado:EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_INSCRIPTO
							 ,tipo:TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR
							 )
						 inscripcionMateriaInstance.addToDetalleMateria(inscripcionMateriaDetalleInstance)
					 }
					 
				}
			}
			materiaAntInstance=materiaInstance
		}
		
		//def anioLectivo = GUtilDomainClass.getAnioLectivoCarrera(inscripcionMateriaInstance.carrera.id)
		
		 
		inscripcionMateriaInstance.origen = OrigenInscripcionMateriaEnum .ORIGENINSCMATERIA_POSMATRICULA		
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
		

		def inscripcionMateriaDetalleInstance
		def materiaInstance
		
		materiasSerializedJson.each {
			if(it.seleccion.toUpperCase().equals("YES")){
				materiaInstance = Materia.load(it.idmateria.toLong())
				if(AcademicoUtil.validarCorrelatividades(it.idmateria.toLong(),TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR,inscripcionMateriaInstance.alumno.id)){
					 
					 if(materiaInstance.equals(materiaAntInstance)){
						 inscripcionMateriaInstance.errors.rejectValue("detalleMateria", "com.educacion.academico.InscripcionMateriaDetalle.materia.unique.error"
							 ,[materiaInstance.denominacion] as Object[],"Error de validacion materia repetida")
					 }else{
						  if(it.idid.toInteger()==0){
							 inscripcionMateriaDetalleInstance = new InscripcionMateriaDetalle(materia:materiaInstance
								 ,estado:EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_INSCRIPTO
								 ,tipo:TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR
								 )
							 inscripcionMateriaInstance.addToDetalleMateria(inscripcionMateriaDetalleInstance)
						  }
					 }
					 materiaAntInstance=materiaInstance
				}else{
					inscripcionMateriaInstance.errors.rejectValue("detalleMateria","Error de correlatividad en la materia "+materiaInstance.denominacion)
				}
			}else{
				if(it.idid.toInteger()>0){
					inscripcionMateriaDetalleInstance = InscripcionMateriaDetalle.get(it.idid);
					inscripcionMateriaInstance.removeFromDetalleMateria(inscripcionMateriaDetalleInstance)
					inscripcionMateriaDetalleInstance.delete()
				}
			}
		}

				
		if(!inscripcionMateriaInstance.hasErrors() && inscripcionMateriaInstance.save(flush:true)){
			
		}else{
			throw new InscripcionMateriaException("Errores de validacion",inscripcionMateriaInstance) 
		}
	}

}
