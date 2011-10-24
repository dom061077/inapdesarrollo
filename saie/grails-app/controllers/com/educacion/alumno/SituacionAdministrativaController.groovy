package com.educacion.alumno


import com.educacion.util.GUtilDomainClass 

import java.text.SimpleDateFormat 

import java.text.DateFormat 

import java.text.ParseException 



class SituacionAdministrativaController {

	
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
        def situacionAdministrativaInstance = new SituacionAdministrativa()
        situacionAdministrativaInstance.properties = params
        return [situacionAdministrativaInstance: situacionAdministrativaInstance]
    }

    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"

        def situacionAdministrativaInstance = new SituacionAdministrativa(params)
        if (situacionAdministrativaInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'situacionAdministrativa.label', default: 'SituacionAdministrativa'), situacionAdministrativaInstance.id])}"
            redirect(action: "show", id: situacionAdministrativaInstance.id)
        }
        else {
            render(view: "create", model: [situacionAdministrativaInstance: situacionAdministrativaInstance])
        }
    }

    def show = {
		log.info "INGRESANDO AL CLOSURE show"
		log.info "PARAMETROS: $params"

		
        def situacionAdministrativaInstance = SituacionAdministrativa.get(params.id)
        if (!situacionAdministrativaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'situacionAdministrativa.label', default: 'SituacionAdministrativa'), params.id])}"
            redirect(action: "list")
        }
        else {
            [situacionAdministrativaInstance: situacionAdministrativaInstance]
        }
    }

    def edit = {
		log.info "INGRESANDO AL CLOSURE edit"
		log.info "PARAMETROS: $params"

			
        def situacionAdministrativaInstance = SituacionAdministrativa.get(params.id)
        if (!situacionAdministrativaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'situacionAdministrativa.label', default: 'SituacionAdministrativa'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [situacionAdministrativaInstance: situacionAdministrativaInstance]
        }
    }

    def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"
		
        def situacionAdministrativaInstance = SituacionAdministrativa.get(params.id)
        if (situacionAdministrativaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (situacionAdministrativaInstance.version > version) {
                    
                    situacionAdministrativaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'situacionAdministrativa.label', default: 'SituacionAdministrativa')] as Object[], "Another user has updated this SituacionAdministrativa while you were editing")
                    render(view: "edit", model: [situacionAdministrativaInstance: situacionAdministrativaInstance])
                    return
                }
            }
            situacionAdministrativaInstance.properties = params
            if (!situacionAdministrativaInstance.hasErrors() && situacionAdministrativaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'situacionAdministrativa.label', default: 'SituacionAdministrativa'), situacionAdministrativaInstance.id])}"
                redirect(action: "show", id: situacionAdministrativaInstance.id)
            }
            else {
                render(view: "edit", model: [situacionAdministrativaInstance: situacionAdministrativaInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'situacionAdministrativa.label', default: 'SituacionAdministrativa'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		log.info "INGRESANDO AL CLOSURE delete"
		log.info "PARAMETROS: $params"

		
        def situacionAdministrativaInstance = SituacionAdministrativa.get(params.id)
        if (situacionAdministrativaInstance) {
            try {
                situacionAdministrativaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'situacionAdministrativa.label', default: 'SituacionAdministrativa'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'situacionAdministrativa.label', default: 'SituacionAdministrativa'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'situacionAdministrativa.label', default: 'SituacionAdministrativa'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def listjson = {
		log.info "INGRESANDO AL CLOSURE listjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(SituacionAdministrativa,params,grailsApplication)
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
		def list = SituacionAdministrativa.createCriteria().list(){
				like('nombre','%'+params.term+'%')
		}
		render(contentType:"text/json"){
			array{
				for (obj in list){
					situacionadministrativa id:obj.id,label:obj.descripcion,value:obj.descripcion
				}
			}
			
		}
	}
	
	def listsearchjson = {
		log.info "INGRESANDO AL METODO listsearchjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(SituacionAdministrativa,params,grailsApplication)
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
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.descripcion+'"]}'
			 
			flagaddcomilla=true
		}
		result=result+']}'
		render result

	}



	
}
