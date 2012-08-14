package com.educacion.alumno


import com.educacion.util.GUtilDomainClass 
import com.megatome.grails.RecaptchaService
import org.springframework.transaction.TransactionStatus
import com.educacion.geografico.Localidad
import com.educacion.academico.util.AcademicoUtil



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

	def register = {
		log.info "INGRESANDO AL CLOSURE register"
		log.info "PARAMETROS: $params"
		def alumnoInstance = new Alumno()
		alumnoInstance.properties = params
		return [alumnoInstance: alumnoInstance]
	}
	
    def create = {
		log.info "INGRESANDO AL CLOSURE create"
		log.info "PARAMETROS: $params"
        def alumnoInstance = new Alumno()
        alumnoInstance.properties = params
        return [alumnoInstance: alumnoInstance,carreraId:params.carreraId]
    }

	def saveregister = {
		log.info "INGRESANDO AL CLOSURE saveregister"
		log.info "PARAMETROS: $params"
		def fechaNacimientoError=false
		def recaptchaOK = true
		log.debug "REMOTE ADDRESS: "+request.getRemoteAddr()
		if (!recaptchaService.verifyAnswer(session, request.getRemoteAddr(), params)) {
		//if (!recaptchaService.verifyAnswer(session, "127.0.0.1", params)) {
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
			alumnoInstance.errors.rejectValue("fechaNacimiento","com.educacion.alumno.Alumno.fechaNacimiento.date.error","Ingrese una fecha correcta, se sugiere una correción")
			render(view: "register", model: [alumnoInstance: alumnoInstance])
			return
		}

		if (recaptchaOK && alumnoInstance.save(flush: true)) {
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'alumno.label', default: 'Alumno'), alumnoInstance.id])}"
			if(!alumnoInstance.photo.isEmpty())
				imageUploadService.save(alumnoInstance)
			redirect(action: "showregister", id: alumnoInstance.id , method:'post')
		}
		else {
			if(!recaptchaOK)
				alumnoInstance.errors.rejectValue("id","com.educacion.alumno.Alumno.captcha.error","Ingrese un c�digo de pueba correcto al pie de la p�gina")
			render(view: "register", model: [alumnoInstance: alumnoInstance])
		}
	}

	
    def save = {
		log.info "INGRESANDO AL CLOSURE save"
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

		
        def alumnoInstance = new Alumno(params)
		
		if(fechaNacimientoError){
			alumnoInstance.validate()
			alumnoInstance.errors.rejectValue("fechaNacimiento","com.educacion.alumno.Alumno.fechaNacimiento.date.error","Ingrese una fecha correcta, se sugiere una correción")
			render(view: "create", model: [alumnoInstance: alumnoInstance])
			return
		} 

        if (alumnoInstance.save(flush: true)) {
            
			if(!alumnoInstance.photo.isEmpty())
				imageUploadService.save(alumnoInstance)
			if(params.carreraId){
				redirect(controller:"preinscripcion",action:"create",id:params.carreraId,params:[alumnoId:alumnoInstance.id])
			}else{
				flash.message = "${message(code: 'default.created.message', args: [message(code: 'alumno.label', default: 'Alumno'), alumnoInstance.id])}"
            	redirect(action: "show", id: alumnoInstance.id)
			}
        }
        else {
            render(view: "create", model: [alumnoInstance: alumnoInstance,carreraId:params.carreraId])
        }
    }
	
	def showregister = {
		log.info "INGRESANDO AL CLOSURE showregister"
		log.info "PARAMETROS: $params"
		def alumnoInstance = Alumno.get(params.id)
		if(!alumnoInstance){
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'alumno.label', default: 'Alumno'), params.id])}"
		}else{
			flash.message = "${message(code: 'educacion.alumno.registracion.completa')}"
			[alumnoInstance:alumnoInstance]
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
						
					if(params.localidadGaranteId)
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
		
                    if(params.localidadGaranteId)
                        alumnoInstance.localidadGarante = Localidad.load(params.localidadGaranteId.toLong())
                    else
                        alumnoInstance.localidadGarante = null
					
		            if(params.situacionAdministrativaId)
                        alumnoInstance.situacionAdministrativa = SituacionAdministrativa.load(params.situacionAdministrativaId)
                    else
                        alumnoInstance.situacionAdministrativa = null

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
				
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+(it.apellido==null?"":it.apellido)+'","'+(it.nombre==null?"":it.nombre)+'","'+(it.tipoDocumento.name==null?"":it.tipoDocumento.name)+'","'+(it.numeroDocumento==null?"":it.numeroDocumento)+'","'+(it.fechaNacimiento==null?"":g.formatDate(format:'dd/MM/yyyy',date:it.fechaNacimiento))+'"]}'
			 
			flagaddcomilla=true
		}
		result=result+']}'
		render result

	}
	
	def listjsonautocomplete={
		log.info "INGRESANDO AL CLOSURE listjsonautocomplete"
		log.info "PARAMETROS: ${params}"
		def alumnos = Alumno.createCriteria().list(){
			or{
				ilike('apellido','%'+params.term+'%')
				ilike('nombre','%'+params.term+'%')
			}
		}
		render(contentType:"text/json"){
			array{
				for (alu in alumnos){
					alumno id:alu.id,label:alu.apellido+'-'+alu.nombre,value:alu.apellido+'-'+alu.nombre
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
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.numeroDocumento+'","'+it.apellido+'"]}'
			 
			flagaddcomilla=true
		}
		result=result+']}'
		render result

	}

	def mindatajson= {
		log.info "INGRESANDO AL CLOSURE mindatajson"
		log.info "PARAMETROS: $params"
		def alumnoInstance = Alumno.get(params.id)
		render(contentType:"text/json"){
			alumno apellidoNombre:alumnoInstance.apellido,documento:alumnoInstance?.numeroDocumento,tipoDocumento:alumnoInstance?.tipoDocumento?.name,sexo:alumnoInstance.sexo.name,fechaNacimiento:g.formatDate(format:'dd/MM/yyyy',date:alumnoInstance?.fechaNacimiento)
		}
	}


    def validatedocexistente = {
        log.info "INGRESANDO AL CLOSURE validate"
        log.info "PARAMETROS: $params"
        render true
    }

    def getalumnobydocumento = {
        def documento
        def carreraId
        try{
            documento = Long.parseLong(params.value)
        }catch(NumberFormatException e){
            render "false"
            return
        }
        try{
            carreraId = Long.parseLong(params.carreraId)
        }catch(NumberFormatException e){
            carreraId= new Long(0)
        }

        def alumnoInstance = Alumno.find("from Alumno where numeroDocumento = :numeroDocumento",["numeroDocumento":documento])
        def arrayJson = new ArrayList()
        arrayJson.add(alumnoInstance)
        //TODO CONTINUAR AQUI
        def materiasCursarDisponibles = AcademicoUtil.getMateriasCursarDisponibles(carreraId,alumnoInstance?.id)
        arrayJson.add(materiasCursarDisponibles)
        if(alumnoInstance){
            render arrayJson as grails.converters.deep.JSON
        }else{
            render "false"
        }

    }

    def reportealumno = {
        log.info "INGRESANDO AL CLOSURE reportealumno"
        log.info "PARAMETROS: $params"

        params.put("nombreinstitucion", g.message(code:"caratula.institucion.nombre"))
        params.put("direccioninstitucion", g.message(code:"caratula.institucion.direccion"))
        params.put("telefonoinstitucion", g.message(code:"caratula.institucion.telefono"))

        params.put("SUBREPORT_DIR",servletContext.getRealPath("/reports/alumno/"))
        params.put("_format","PDF")
        params.put("_name","reporteralumno")
        params.put("_file","alumno/reporteralumno")

        def alumnoInstance = Alumno.get(params.id)

        //TODO: Colocar una parametrización para el nombre de imágen no disponible
        if(realresourceimgext(size:"large",bean:alumnoInstance).equals(""))
            params.put("paramsFoto", servletContext.getRealPath("images/noDisponibleLarge.jpg"))
        else
            params.put("paramsFoto", servletContext.getRealPath(realresourceimgext(size:"large",bean:alumnoInstance).readAsString()))

        def listAlumno = new ArrayList()
        listAlumno.add(alumnoInstance)

        listAlumno.each {
            it.localidadNac?.nombre
            it.localidadDomicilio?.nombre
            it.localidadLaboral?.nombre
            it.situacionAdministrativa?.descripcion
            it.localidadGarante?.nombre
            it.localidadLaboral?.nombre
            it.localidadTutor?.nombre
        }

        chain(controller:'jasper', action:'index', model:[data:listAlumno], params:params)

    }


    def reportealumnos = {
        log.info "INGRESANDO AL CLOSURE reportealumnos"
        log.info "PARAMETROS: $params"

        params.put("nombreinstitucion", g.message(code:"caratula.institucion.nombre"))
        params.put("direccioninstitucion", g.message(code:"caratula.institucion.direccion"))
        params.put("telefonoinstitucion", g.message(code:"caratula.institucion.telefono"))

        params.put("SUBREPORT_DIR",servletContext.getRealPath("/reports/alumno/"))
        params.put("_format","PDF")
        params.put("_name","reporteralumnos")
        params.put("_file","alumno/reporteralumnos")
        def listAlumnos = Alumno.createCriteria().list {
            order("apellido", "asc")
            order("nombre", "asc")
        }

        chain(controller:'jasper', action:'index', model:[data:listAlumnos], params:params)
    }


}
