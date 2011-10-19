package com.educacion.geografico


import com.educacion.util.GUtilDomainClass 

import java.text.SimpleDateFormat 

import java.text.DateFormat 

import java.text.ParseException 



class LocalidadController {

	
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
        def localidadInstance = new Localidad()
        localidadInstance.properties = params
        return [localidadInstance: localidadInstance]
    }

    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"

        def localidadInstance = new Localidad(params)
        if (localidadInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'localidad.label', default: 'Localidad'), localidadInstance.id])}"
            redirect(action: "show", id: localidadInstance.id)
        }
        else {
            render(view: "create", model: [localidadInstance: localidadInstance])
        }
    }

    def show = {
		log.info "INGRESANDO AL CLOSURE show"
		log.info "PARAMETROS: $params"

		
        def localidadInstance = Localidad.get(params.id)
        if (!localidadInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'localidad.label', default: 'Localidad'), params.id])}"
            redirect(action: "list")
        }
        else {
            [localidadInstance: localidadInstance]
        }
    }

    def edit = {
		log.info "INGRESANDO AL CLOSURE edit"
		log.info "PARAMETROS: $params"

			
        def localidadInstance = Localidad.get(params.id)
        if (!localidadInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'localidad.label', default: 'Localidad'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [localidadInstance: localidadInstance]
        }
    }

    def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"
		
        def localidadInstance = Localidad.get(params.id)
        if (localidadInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (localidadInstance.version > version) {
                    
                    localidadInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'localidad.label', default: 'Localidad')] as Object[], "Another user has updated this Localidad while you were editing")
                    render(view: "edit", model: [localidadInstance: localidadInstance])
                    return
                }
            }
            localidadInstance.properties = params
            if (!localidadInstance.hasErrors() && localidadInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'localidad.label', default: 'Localidad'), localidadInstance.id])}"
                redirect(action: "show", id: localidadInstance.id)
            }
            else {
                render(view: "edit", model: [localidadInstance: localidadInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'localidad.label', default: 'Localidad'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		log.info "INGRESANDO AL CLOSURE delete"
		log.info "PARAMETROS: $params"

		
        def localidadInstance = Localidad.get(params.id)
        if (localidadInstance) {
            try {
                localidadInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'localidad.label', default: 'Localidad'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'localidad.label', default: 'Localidad'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'localidad.label', default: 'Localidad'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def listjson = {
		log.info "INGRESANDO AL CLOSURE listjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(Localidad,params,grailsApplication)
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
		def list = Localidad.createCriteria().list(){
				like('nombre','%'+params.term+'%')
		}
		log.debug "PROFESIONALES LISTADOS: "+profesionales.size()
		render(contentType:"text/json"){
			array{
				for (prof in list){
					localidad id:prof.id,label:prof.nombre,value:prof.nombre
				}
			}
			
		}
	}
	
	def listsearchjson = {
		log.info "INGRESANDO AL METODO listsearchjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(Localidad,params,grailsApplication)
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
