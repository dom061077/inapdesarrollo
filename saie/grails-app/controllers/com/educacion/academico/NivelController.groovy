package com.educacion.academico


import com.educacion.util.GUtilDomainClass 

import java.text.SimpleDateFormat 

import java.text.DateFormat 

import java.text.ParseException 
import grails.converters.JSON


class NivelController {

	
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
        def nivelInstance = new Nivel()
        nivelInstance.properties = params
        return [nivelInstance: nivelInstance]
    }

    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"

        def nivelInstance = new Nivel(params)
        if (nivelInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'nivel.label', default: 'Nivel'), nivelInstance.id])}"
            redirect(action: "show", id: nivelInstance.id)
        }
        else {
            render(view: "create", model: [nivelInstance: nivelInstance])
        }
    }

    def show = {
		log.info "INGRESANDO AL CLOSURE show"
		log.info "PARAMETROS: $params"

		
        def nivelInstance = Nivel.get(params.id)
        if (!nivelInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'nivel.label', default: 'Nivel'), params.id])}"
            redirect(action: "list")
        }
        else {
            [nivelInstance: nivelInstance]
        }
    }

    def edit = {
		log.info "INGRESANDO AL CLOSURE edit"
		log.info "PARAMETROS: $params"

			
        def nivelInstance = Nivel.get(params.id)
        if (!nivelInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'nivel.label', default: 'Nivel'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [nivelInstance: nivelInstance]
        }
    }

    def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"
		
        def nivelInstance = Nivel.get(params.id)
        if (nivelInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (nivelInstance.version > version) {
                    
                    nivelInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'nivel.label', default: 'Nivel')] as Object[], "Another user has updated this Nivel while you were editing")
                    render(view: "edit", model: [nivelInstance: nivelInstance])
                    return
                }
            }
            nivelInstance.properties = params
            if (!nivelInstance.hasErrors() && nivelInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'nivel.label', default: 'Nivel'), nivelInstance.id])}"
                redirect(action: "show", id: nivelInstance.id)
            }
            else {
                render(view: "edit", model: [nivelInstance: nivelInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'nivel.label', default: 'Nivel'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		log.info "INGRESANDO AL CLOSURE delete"
		log.info "PARAMETROS: $params"

		
        def nivelInstance = Nivel.get(params.id)
        if (nivelInstance) {
            try {
                nivelInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'nivel.label', default: 'Nivel'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'nivel.label', default: 'Nivel'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'nivel.label', default: 'Nivel'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def listjson = {
		log.info "INGRESANDO AL CLOSURE listjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(Nivel,params,grailsApplication)
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
				
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+(it.descripcion==null?"":it.descripcion)+'"]}'
			 
			flagaddcomilla=true
		}
		result=result+']}'
		render result

	}
	
	def listjsonautocomplete={
		log.info "INGRESANDO AL CLOSURE listjsonautocomplete"
		log.info "PARAMETROS: ${params}"
		def list = Nivel.createCriteria().list(){
				like('descripcion','%'+params.term+'%')
				if(params.carreraId){
					//carrera{
					//	eq("id",params.carreraId.toLong())
					//}
				}
		}
		log.debug "CANTIDAD DE NIVELES: "+list.size()
		render(contentType:"text/json"){
			array{
				for (obj in list){
					nivel id:obj.id,label:obj.descripcion,value:obj.descripcion
				}
			}
			
		}
	}
	
	def listsearchjson = {
		log.info "INGRESANDO AL METODO listsearchjson"
		log.info "PARAMETROS: ${params}"
		if(params.altfilters){
			def filtersJson = JSON.parse(params.altfilters)
			if(filtersJson.rules?.size()==0){
				render '{"page":1,"total":0,"records":0,"rows":[]}'
				return
			}
		}
		
		def gud=new GUtilDomainClass(Nivel,params,grailsApplication)
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
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.descripcion+'","'+it.carrera.denominacion+'"]}'
			 
			flagaddcomilla=true
		}
		log.debug "RESULT RENDERED"
		result=result+']}'
		render result

	}



	
}
