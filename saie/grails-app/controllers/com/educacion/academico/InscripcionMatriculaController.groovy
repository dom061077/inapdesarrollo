package com.educacion.academico


import com.educacion.util.GUtilDomainClass 

import java.text.SimpleDateFormat 

import java.text.DateFormat 

import java.text.ParseException 
import com.educacion.academico.util.AcademicoUtil
import org.springframework.transaction.TransactionStatus
import com.educacion.enums.inscripcion.TipoInscripcionMateriaEnum
import com.educacion.academico.util.AcademicoUtil
import com.educacion.enums.inscripcion.EstadoInscripcionMateriaDetalleEnum
import com.educacion.enums.inscripcion.EstadoInscripcionMatriculaEnum
import com.educacion.enums.inscripcion.TipoInscripcionMateriaEnum
import com.educacion.enums.inscripcion.OrigenInscripcionMateriaEnum



class InscripcionMatriculaController {

	
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
		log.info "INGRESANDO AL CLOSURE list"
		log.info "PARAMETROS: $params"
     }

    def create = {
		log.info "INGRESANDO AL CLOSURE create"
		log.info "PARAMETROS: $params"
		def preinscripcionInstance = Preinscripcion.get(params.id.toLong())
		
		log.debug("PREINSCRIPCIONINSTANCE: "+preinscripcionInstance.id)
		
		def anioLectivoInstance = AcademicoUtil.getAnioLectivoCarrera(preinscripcionInstance.carrera.id)
		
		def materiasCursar = AcademicoUtil.getMateriasCursarDisponibles(preinscripcionInstance?.carrera?.id,preinscripcionInstance?.alumno?.id)
		
		log.debug "MATERIAS CURSAR: "+materiasCursar
		
		def flagcomilla = false
		def materiasSerialized = "["
		materiasCursar.each{
			if(flagcomilla)
				materiasSerialized = materiasSerialized + ","
			materiasSerialized = materiasSerialized + '{"id":'+it.id+',"idid":'+it.id+',"denominacion":"'+it.denominacion+'","seleccion":"Yes"}'
			flagcomilla = true
		}
		materiasSerialized += "]"

		
        def inscripcionMatriculaInstance = new InscripcionMatricula(anioLectivo:anioLectivoInstance,carrera:preinscripcionInstance.carrera
					,alumno:preinscripcionInstance.alumno)
		
        inscripcionMatriculaInstance.properties = params
		
		log.debug "MATERIAS SERIALIZADAS: "+materiasSerialized
		
        return [inscripcionMatriculaInstance: inscripcionMatriculaInstance,materiasSerialized:materiasSerialized]
    }

	def listmateriasjson = {
		log.info "INGRESANDO AL CLOSURE listmateriasjson"
		log.info "PARAMETROS: $params"
		def inscripcionMateriaInstance = InscripcionMateria.get(params.id)
		def result='{"page":1,"total":"1","records":"'+inscripcionMateriaInstance.detalleMateria.size()+'","rows":['
		def flagaddcomilla=false
		inscripcionMateriaInstance.detalleMateria.each{
			
			if (flagaddcomilla)
				result=result+','
				
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+(it.materia.denominacion==null?"":it.materia.denominacion)+'"]}'
			 
			flagaddcomilla=true
		}
		result=result+']}'
		render result

		
	}
	
    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"
		def materiasSerializedJson
		
		if(params.materiasSerialized)
			materiasSerializedJson = grails.converters.JSON.parse(params.materiasSerialized);
			
		
        def inscripcionMatriculaInstance = new InscripcionMatricula(params)
		inscripcionMatriculaInstance.estado = EstadoInscripcionMatriculaEnum.ESTADOINSMAT_GENERADA
		
		if(!materiasSerializedJson || materiasSerializedJson.size()==0){
			inscripcionMateriaInstance.errors.rejectValue("inscripcionesmaterias", "com.educacion.academico.InscripcionMateria.materias.blank.error")
			render(view:"create",model:[inscripcionMatriculaInstance:inscripcionMatriculaInstance,materiasSerialized:params.materiasSerialized])
			return
		}
			
		
		InscripcionMatricula.withTransaction{TransactionStatus status ->
			
			
			def materiaAntInstance
			def materiaInstance
			def inscripcionMateriaDetalleInstance
			def inscripcionMateriaInstance = new InscripcionMateria(carrera:inscripcionMatriculaInstance.carrera
					,origen: OrigenInscripcionMateriaEnum.ORIGENINSCMATERIA_ENMATRICULA
					,anioLectivo:inscripcionMatriculaInstance.anioLectivo,alumno:inscripcionMatriculaInstance.alumno)
			materiasSerializedJson?.each {
				if(it.seleccion.toUpperCase().equals("YES")){
					
					if(AcademicoUtil.validarCorrelatividades(it.idid.toLong(),TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR,inscripcionMateriaInstance.alumno.id)){
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
			
			inscripcionMatriculaInstance.addToInscripcionesmaterias(inscripcionMateriaInstance)	
		
	        if (inscripcionMatriculaInstance.save(flush: true)) {
				log.debug "INSCRIPCION MATRICULA SALVADA, INSCRIPCIONMATERIA.ID:"+inscripcionMateriaInstance.id
	            flash.message = "${message(code: 'default.created.message', args: [message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula'), inscripcionMatriculaInstance.id])}"
	            redirect(action: "show", id: inscripcionMatriculaInstance.id,params:[idinscmateria: inscripcionMateriaInstance.id ])
	        }
	        else {
				log.debug "ERRORES: "+inscripcionMatriculaInstance.errors.allErrors
	            render(view:"create",model:[inscripcionMatriculaInstance:inscripcionMatriculaInstance,materiasSerialized:params.materiasSerialized])
	        }
		}
    }

    def show = {
		log.info "INGRESANDO AL CLOSURE show"
		log.info "PARAMETROS: $params"
		def idinscmateria 
		

		
        def inscripcionMatriculaInstance = InscripcionMatricula.get(params.id)

        if (!inscripcionMatriculaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula'), params.id])}"
            redirect(action: "list")
        }
        else {
			if(params.idinscmateria){
				idinscmateria = params.idinscmateria
			}else{
				def inscripcionMateriaInstance
				inscripcionMatriculaInstance.inscripcionesmaterias.each{
					if(it.origen == OrigenInscripcionMateriaEnum.ORIGENINSCMATERIA_ENMATRICULA)
						idinscmateria = it.id
				}
			}
			if(idinscmateria)
            	[inscripcionMatriculaInstance: inscripcionMatriculaInstance,idinscmateria:idinscmateria]
			else{
				flash.message = g.message(code:"com.educacion.inscripcion.InscripcionMatricula.error.inscripcionmateria")
				redirect(action:"list")
			}	
        }
    }
	

    def edit = {
		log.info "INGRESANDO AL CLOSURE edit"
		log.info "PARAMETROS: $params"

			
        def inscripcionMatriculaInstance = InscripcionMatricula.get(params.id)
        if (!inscripcionMatriculaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula'), params.id])}"
            redirect(action: "list")
        }
        else {
			def materiasCursar = AcademicoUtil.getMateriasCursarDisponibles(inscripcionMatriculaInstance?.carrera?.id,inscripcionMatriculaInstance?.alumno?.id)
			
			def flagcomilla = false
			def flagseleccionado
			def idinscmatdetalle
			def materiasSerialized = "["
			materiasCursar.each{ matcursar->
				if(flagcomilla)
					materiasSerialized = materiasSerialized + ","
				flagseleccionado="No"
				idinscmatdetalle = 0
				inscripcionMatriculaInstance.inscripcionesmaterias.each{inscmateria ->
					if (inscmateria.origen == OrigenInscripcionMateriaEnum.ORIGENINSCMATERIA_ENMATRICULA){
						inscmateria.detalleMateria.each{detinsc->  
							if(detinsc.materia.id==matcursar.id){
								flagseleccionado="Si"
								idinscmatdetalle = detinsc.id
								return
							}
						}
						return
					}
				}	
				materiasSerialized = materiasSerialized + '{"id":'+matcursar.id+',"idid":'+idinscmatdetalle+',"idmateria":'+matcursar.id+',"denominacion":"'+matcursar.denominacion+'","seleccion":"'+flagseleccionado+'"}'
				flagcomilla = true
			}
			materiasSerialized += "]"

            return [inscripcionMatriculaInstance: inscripcionMatriculaInstance,materiasSerialized:materiasSerialized]
        }
    }

    def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"
		def materiasSerializedJson
		
		if(params.materiasSerialized)
			materiasSerializedJson = grails.converters.JSON.parse(params.materiasSerialized);

		
        def inscripcionMatriculaInstance = InscripcionMatricula.get(params.id)
        if (inscripcionMatriculaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (inscripcionMatriculaInstance.version > version) {
                    
                    inscripcionMatriculaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula')] as Object[], "Another user has updated this InscripcionMatricula while you were editing")
                    render(view: "edit", model: [inscripcionMatriculaInstance: inscripcionMatriculaInstance])
                    return
                }
            }
			InscripcionMatricula.withTransaction{TransactionStatus status ->
	            inscripcionMatriculaInstance.properties = params
				
				//------modificacion del detalle de la inscripcion de materias dentro de la matricula--
				
				def materiaAntInstance
				def materiaInstance
				def inscripcionMateriaDetalleInstance
				def inscripcionMateriaInstance 
				inscripcionMatriculaInstance.inscripcionesmaterias.each{inscmat->
					if(inscmat.origen == OrigenInscripcionMateriaEnum.ORIGENINSCMATERIA_ENMATRICULA)
						inscripcionMateriaInstance = inscmat
				}
				materiasSerializedJson?.each {
					if(it.seleccion.toUpperCase().equals("YES")){
						/*if(!inscripcionMateriaInstance){
							inscripcionMateriaInstance = new InscripcionMateria(carrera:inscripcionMatriculaInstance.carrera
								,alumno:inscripcionMatriculaInstance.alumno,anioLectivo:inscripcionMatriculaInstance.anioLectivo
								,origen:OrigenInscripcionMateriaEnum.ORIGENINSCMATERIA_POSMATRICULA)
							inscripcionMatriculaInstance.addToInscripcionesmaterias(inscripcionMateriaInstance)
						}*/
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
	
				
	            if (!inscripcionMatriculaInstance.hasErrors() && inscripcionMatriculaInstance.save() /*&& 
					!inscripcionMateriaInstance.hasErrors() && inscripcionMateriaInstance.save(flush:true)*/) {
	                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula'), inscripcionMatriculaInstance.id])}"
	                redirect(action: "show", id: inscripcionMatriculaInstance.id)
	            }
	            else {
					status.setRollbackOnly()
	                render(view: "edit", model: [inscripcionMatriculaInstance: inscripcionMatriculaInstance,materiasSerialized:params.materiasSerialized,inscripcionMateriaInstance:inscripcionMateriaInstance])
	            }
			}
				
        }
        else {
			log.debug "SALE POR LA VALIDACION DE SI ENCUENTRA LA MATRICULA"
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		log.info "INGRESANDO AL CLOSURE delete"
		log.info "PARAMETROS: $params"

		
        def inscripcionMatriculaInstance = InscripcionMatricula.get(params.id)
        if (inscripcionMatriculaInstance) {
            try {
                inscripcionMatriculaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def listjson = {
		log.info "INGRESANDO AL CLOSURE listjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(InscripcionMatricula,params,grailsApplication)
		def list=gud.listrefactor(false)
		def totalregistros=gud.listrefactor(true)
		
		def totalpaginas=new Float(totalregistros/Integer.parseInt(params.rows))
		if (totalpaginas>0 && totalpaginas<1)
			totalpaginas=1;
		totalpaginas=totalpaginas.intValue()

		
		
		def result='{"page":'+params.page+',"total":"'+totalpaginas+'","records":"'+totalregistros+'","rows":['
		def flagaddcomilla=false
		list.each{
			
			if (flagaddcomilla)
				result=result+','
				
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.alumno.apellido+'","'+it.alumno.nombre+'","'+g.formatDate(date:it.fechaAlta,format:"dd/MM/yyyy")+'","'+it.carrera.denominacion+'","'+it.anioLectivo.anioLectivo+'","'+it.estado.name+'"]}'
			 
			flagaddcomilla=true
		}
		result=result+']}'
		render result

	}
	
	def listjsonautocomplete={
		log.info "INGRESANDO AL CLOSURE listjsonautocomplete"
		log.info "PARAMETROS: ${params}"
		def list = InscripcionMatricula.createCriteria().list(){
				like('nombre','%'+params.term+'%')
		}
		render(contentType:"text/json"){
			array{
				for (obj in list){
					inscripcionmatricula id:obj.id,label:obj.nombre,value:obj.nombre
				}
			}
			
		}
	}
	
	def listsearchjson = {
		log.info "INGRESANDO AL METODO listsearchjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(InscripcionMatricula,params,grailsApplication)
		list=gud.listrefactor(false)
		def totalregistros=gud.listrefactor(true)
		
		def totalpaginas=new Float(totalregistros/Integer.parseInt(params.rows))
		if (totalpaginas>0 && totalpaginas<1)
			totalpaginas=1;
		totalpaginas=totalpaginas.intValue()

		
		 
		def result='{"page":'+params.page+',"total":"'+totalpaginas+'","records":"'+totalregistros+'","rows":['
		def flagaddcomilla=false
		list.each{
			
			if (flagaddcomilla)
				result=result+','
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.nombre+'"]}'
			 
			flagaddcomilla=true
		}
		result=result+']}'
		render result

	}
	
 
	
	def seleccionalumno = {
		log.info "INGRESANDO AL CLOSURE seleccionalumno"
		log.info("PARAMETROS: $params")
		
		
	}
	
	
	

	
}
