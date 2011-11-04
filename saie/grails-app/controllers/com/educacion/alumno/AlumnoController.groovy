package com.educacion.alumno


import com.educacion.util.GUtilDomainClass 

import java.text.SimpleDateFormat 

import java.text.DateFormat 

import java.text.ParseException 



class AlumnoController {

	
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
			log.debug "ERRORES DE VALIDACION: "
			alumnoInstance.errors.allErrors.each{
				log.debug "						  "+it
			}
			render(view: "create", model: [alumnoInstance: alumnoInstance])
			return
		}

        if (alumnoInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'alumno.label', default: 'Alumno'), alumnoInstance.id])}"
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
		
        def alumnoInstance = Alumno.get(params.id)
        if (alumnoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (alumnoInstance.version > version) {
                    
                    alumnoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'alumno.label', default: 'Alumno')] as Object[], "Another user has updated this Alumno while you were editing")
                    render(view: "edit", model: [alumnoInstance: alumnoInstance])
                    return
                }
            }
            alumnoInstance.properties = params
            if (!alumnoInstance.hasErrors() && alumnoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'alumno.label', default: 'Alumno'), alumnoInstance.id])}"
                redirect(action: "show", id: alumnoInstance.id)
            }
            else {
                render(view: "edit", model: [alumnoInstance: alumnoInstance])
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
				
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+(it.nombre==null?"":it.nombre)+'"]}'
			 
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
