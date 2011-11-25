package com.educacion.academico


import com.educacion.util.GUtilDomainClass 

import java.text.SimpleDateFormat 

import java.text.DateFormat 

import java.text.ParseException 



class DuracionMateriaController {

	
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
        def duracionMateriaInstance = new DuracionMateria()
        duracionMateriaInstance.properties = params
        return [duracionMateriaInstance: duracionMateriaInstance]
    }

    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"

        def duracionMateriaInstance = new DuracionMateria(params)
        if (duracionMateriaInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'duracionMateria.label', default: 'DuracionMateria'), duracionMateriaInstance.id])}"
            redirect(controller:'duracionMateria',action: "show", id: duracionMateriaInstance.id)
        }
        else {
            render(view: "create", model: [duracionMateriaInstance: duracionMateriaInstance])
        }
    }

    def show = {
		log.info "INGRESANDO AL CLOSURE show"
		log.info "PARAMETROS: $params"

		
        def duracionMateriaInstance = DuracionMateria.get(params.id)
        if (!duracionMateriaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'duracionMateria.label', default: 'DuracionMateria'), params.id])}"
            redirect(action: "list")
        }
        else {
            [duracionMateriaInstance: duracionMateriaInstance]
        }
    }

    def edit = {
		log.info "INGRESANDO AL CLOSURE edit"
		log.info "PARAMETROS: $params"

			
        def duracionMateriaInstance = DuracionMateria.get(params.id)
        if (!duracionMateriaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'duracionMateria.label', default: 'DuracionMateria'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [duracionMateriaInstance: duracionMateriaInstance]
        }
    }

    def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"
		
        def duracionMateriaInstance = DuracionMateria.get(params.id)
        if (duracionMateriaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (duracionMateriaInstance.version > version) {
                    
                    duracionMateriaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'duracionMateria.label', default: 'DuracionMateria')] as Object[], "Another user has updated this DuracionMateria while you were editing")
                    render(view: "edit", model: [duracionMateriaInstance: duracionMateriaInstance])
                    return
                }
            }
            duracionMateriaInstance.properties = params
            if (!duracionMateriaInstance.hasErrors() && duracionMateriaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'duracionMateria.label', default: 'DuracionMateria'), duracionMateriaInstance.id])}"
                redirect(controller:'duracionMateria',action: "show", id: duracionMateriaInstance.id)
            }
            else {
                render(view: "edit", model: [duracionMateriaInstance: duracionMateriaInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'duracionMateria.label', default: 'DuracionMateria'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		log.info "INGRESANDO AL CLOSURE delete"
		log.info "PARAMETROS: $params"

		
        def duracionMateriaInstance = DuracionMateria.get(params.id)
        if (duracionMateriaInstance) {
            try {
                duracionMateriaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'duracionMateria.label', default: 'DuracionMateria'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'duracionMateria.label', default: 'DuracionMateria'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'duracionMateria.label', default: 'DuracionMateria'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def listjson = {
		log.info "INGRESANDO AL CLOSURE listjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(DuracionMateria,params,grailsApplication)
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
		def list = DuracionMateria.createCriteria().list(){
				like('nombre','%'+params.term+'%')
		}
		render(contentType:"text/json"){
			array{
				for (obj in list){
					duracionmateria id:obj.id,label:obj.nombre,value:obj.nombre
				}
			}
			
		}
	}
	
	def listsearchjson = {
		log.info "INGRESANDO AL METODO listsearchjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(DuracionMateria,params,grailsApplication)
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
