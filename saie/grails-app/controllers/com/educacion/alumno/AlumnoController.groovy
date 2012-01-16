package com.educacion.alumno


import com.educacion.util.GUtilDomainClass 
import com.megatome.grails.RecaptchaService

import java.text.SimpleDateFormat 

import java.text.DateFormat 

import java.text.ParseException 
import org.springframework.transaction.TransactionStatus


class AlumnoController {
	def imageUploadService
	RecaptchaService recaptchaService
	
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
        def alumnoInstance = new Alumno()
        alumnoInstance.properties = params
        return [alumnoInstance: alumnoInstance]
    }

    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"
		def fechaNacimientoError=false
		def recaptchaOK = true
		log.debug "REMOTE ADDRESS: "+request.getRemoteAddr()
		//if (!recaptchaService.verifyAnswer(session, request.getRemoteAddr(), params)) {
		if (!recaptchaService.verifyAnswer(session, "127.0.0.1", params)) {
			 log.debug "INGRESE UN DIGITO VERIFICADOR CORRECTO"
			 recaptchaOK = false
		}
		if (params.fechaNacimiento){
			if (params.fechaNacimiento.length()<10){
				fechaNacimientoError=true
			}else{
				params.fechaNacimiento_year=params.fechaNacimiento.substring(6,10)
				params.fechaNacimiento_month=params.fechaNacimiento.substring(3,5)
				params.fechaNacimiento_day=params.fechaNacimiento.substring(0,2)
				try{
					if(params.fechaNacimiento_month.toInteger()>12)
						fechaNacimientoError=true
					if(params.fechaNacimiento_day.toInteger()>31){
						fechaNacimientoError=true
					}
				}catch(NumberFormatException e){
					fechaNacimientoError=true
				}
			}
		}

		
        def alumnoInstance = new Alumno(params)
		
		if(fechaNacimientoError){
			alumnoInstance.validate()
			alumnoInstance.errors.rejectValue("fechaNacimiento","com.medfire.alumno.Alumno.fechaNacimiento.date.error","Ingrese una fecha correcta, se sugiere una correción")
			render(view: "create", model: [alumnoInstance: alumnoInstance])
			return
		} 

        if (recaptchaOK && alumnoInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'alumno.label', default: 'Alumno'), alumnoInstance.id])}"
			if(!alumnoInstance.photo.isEmpty())
				imageUploadService.save(alumnoInstance)
            redirect(action: "show", id: alumnoInstance.id)
        }
        else {
			log.debug "ERRORES DE VALIDACION: "
			alumnoInstance.errors.allErrors.each{
				log.debug "						  "+it
			}

            render(view: "create", model: [alumnoInstance: alumnoInstance])
        }
    }

    def show = {
		log.info "INGRESANDO AL CLOSURE show"
		log.info "PARAMETROS: $params"

		
        def alumnoInstance = Alumno.get(params.id)
        if (!alumnoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'alumno.label', default: 'Alumno'), params.id])}"
            redirect(action: "list")
        }
        else {
            [alumnoInstance: alumnoInstance]
        }
    }

    def edit = {
		log.info "INGRESANDO AL CLOSURE edit"
		log.info "PARAMETROS: $params"

			
        def alumnoInstance = Alumno.get(params.id)
        if (!alumnoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'alumno.label', default: 'Alumno'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [alumnoInstance: alumnoInstance]
        }
    }

    def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"
		
		def fechaNacimientoError=false
		if (params.fechaNacimiento){
			if (params.fechaNacimiento.length()<10){
				fechaNacimientoError=true
			}else{
				params.fechaNacimiento_year=params.fechaNacimiento.substring(6,10)
				params.fechaNacimiento_month=params.fechaNacimiento.substring(3,5)
				params.fechaNacimiento_day=params.fechaNacimiento.substring(0,2)
				try{
					if(params.fechaNacimiento_month.toInteger()>12)
						fechaNacimientoError=true
					if(params.fechaNacimiento_day.toInteger()>31){
						fechaNacimientoError=true
					}
				}catch(NumberFormatException e){
					fechaNacimientoError=true
				}
			}
		}

		
        def alumnoInstance = Alumno.get(params.id)
        if (alumnoInstance) {
			Alumno.withTransaction{TransactionStatus status->
		            if (params.version) {
		                def version = params.version.toLong()
		                if (alumnoInstance.version > version) {
		                    
		                    alumnoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'alumno.label', default: 'Alumno')] as Object[], "Another user has updated this Alumno while you were editing")
							status.setRollbackOnly()
		                    render(view: "edit", model: [alumnoInstance: alumnoInstance])
		                    return
		                }
		            }
					if(params.localidadDomicilioId)
					alumnoInstance.localidadDomicilio = Localidad.load(params.localidadDomicilioId.toLong())
					else
						alumnoInstance.localidadDomicilio = null
						
					if(params.localidadgGaranteId)
						alumnoInstance.localidadGarante = Localidad.load(params.localidadGaranteId.toLong())
					else
						alumnoInstance.localidadGarante = null
						
					if(params.localidadLaboralId)
						alumnoInstance.localidadLaboral = Localidad.load(params.localidadLaboralId.toLong())
					else
						alumnoInstance.localidadLaboral = null
						
					if(params.localidadNacId)
						alumnoInstance.localidadNac = Localidad.load(params.localidadNacId.toLong())
					else
						alumnoInstance.localidadNac = null
			
						
					if(params.localidadTutorId)
						alumnoInstance.localidadTutor = Localidad.load(params.localidadTutorId.toLong())
					else
						alumnoInstance.localidadTutor = null
		
					
		
					if(fechaNacimientoError){
						alumnoInstance.validate()
						alumnoInstance.errors.rejectValue("fechaNacimiento","com.medfire.alumno.Alumno.fechaNacimiento.date.error","Ingrese una fecha correcta, se sugiere una correción")
						log.debug "ERRORES DE VALIDACION: "
						alumnoInstance.errors.allErrors.each{
							log.debug "						  "+it
						}
						status.setRollbackOnly()
						render(view: "edit", model: [alumnoInstance: alumnoInstance])
						return
					}
					alumnoInstance.properties = params
					
		            if (!alumnoInstance.hasErrors() && alumnoInstance.save(flush: true)) {
						if(!params.photo.isEmpty())
							imageUploadService.save(alumnoInstance)
		                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'alumno.label', default: 'Alumno'), alumnoInstance.id])}"
		                redirect(action: "show", id: alumnoInstance.id)
		            }
		            else {
						alumnoInstance.errors.allErrors.each{
							log.debug "CODE ERROR: "+it
						}
						status.setRollbackOnly()
						
		                render(view: "edit", model: [alumnoInstance: alumnoInstance])
		            }
			}
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'alumno.label', default: 'Alumno'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		log.info "INGRESANDO AL CLOSURE delete"
		log.info "PARAMETROS: $params"

		
        def alumnoInstance = Alumno.get(params.id)
        if (alumnoInstance) {
            try {
                alumnoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'alumno.label', default: 'Alumno'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'alumno.label', default: 'Alumno'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'alumno.label', default: 'Alumno'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def listjson = {
		log.info "INGRESANDO AL CLOSURE listjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(Alumno,params,grailsApplication)
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
				
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+(it.apellidoNombre==null?"":it.apellidoNombre)+'","'+(it.tipoDocumento.name==null?"":it.tipoDocumento.name)+'","'+(it.numeroDocumento==null?"":it.numeroDocumento)+'","'+(it.fechaNacimiento==null?"":g.formatDate(format:'dd/MM/yyyy',date:it.fechaNacimiento))+'"]}'
			 
			flagaddcomilla=true
		}
		result=result+']}'
		render result

	}
	
	def listjsonautocomplete={
		log.info "INGRESANDO AL CLOSURE listjsonautocomplete"
		log.info "PARAMETROS: ${params}"
		def profesionales = Alumno.createCriteria().list(){
				like('nombre','%'+params.term+'%')
		}
		log.debug "PROFESIONALES LISTADOS: "+profesionales.size()
		render(contentType:"text/json"){
			array{
				for (prof in profesionales){
					alumno id:prof.id,label:prof.nombre,value:prof.nombre
				}
			}
			
		}
	}
	
	def listsearchjson = {
		log.info "INGRESANDO AL METODO listsearchjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(Alumno,params,grailsApplication)
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



	
}
