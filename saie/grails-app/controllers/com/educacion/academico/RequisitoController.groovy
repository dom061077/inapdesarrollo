package com.educacion.academico


import com.educacion.util.GUtilDomainClass 

import java.text.SimpleDateFormat 

import java.text.DateFormat 

import java.text.ParseException 



class RequisitoController {

	
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
        def requisitoInstance = new Requisito()
        requisitoInstance.properties = params
        return [requisitoInstance: requisitoInstance]
    }

    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"

        def requisitoInstance = new Requisito(params)
        if (requisitoInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'requisito.label', default: 'Requisito'), requisitoInstance.id])}"
            redirect(action: "show", id: requisitoInstance.id)
        }
        else {
            render(view: "create", model: [requisitoInstance: requisitoInstance])
        }
    }

    def show = {
		log.info "INGRESANDO AL CLOSURE show"
		log.info "PARAMETROS: $params"

		
        def requisitoInstance = Requisito.get(params.id)
        if (!requisitoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'requisito.label', default: 'Requisito'), params.id])}"
            redirect(action: "list")
        }
        else {
            [requisitoInstance: requisitoInstance]
        }
    }

    def edit = {
		log.info "INGRESANDO AL CLOSURE edit"
		log.info "PARAMETROS: $params"

			
        def requisitoInstance = Requisito.get(params.id)
        if (!requisitoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'requisito.label', default: 'Requisito'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [requisitoInstance: requisitoInstance]
        }
    }

    def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"
		
        def requisitoInstance = Requisito.get(params.id)
        if (requisitoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (requisitoInstance.version > version) {
                    
                    requisitoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'requisito.label', default: 'Requisito')] as Object[], "Another user has updated this Requisito while you were editing")
                    render(view: "edit", model: [requisitoInstance: requisitoInstance])
                    return
                }
            }
            requisitoInstance.properties = params
            if (!requisitoInstance.hasErrors() && requisitoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'requisito.label', default: 'Requisito'), requisitoInstance.id])}"
                redirect(action: "show", id: requisitoInstance.id)
            }
            else {
                render(view: "edit", model: [requisitoInstance: requisitoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'requisito.label', default: 'Requisito'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		log.info "INGRESANDO AL CLOSURE delete"
		log.info "PARAMETROS: $params"

		
        def requisitoInstance = Requisito.get(params.id)
        if (requisitoInstance) {
            try {
                requisitoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'requisito.label', default: 'Requisito'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'requisito.label', default: 'Requisito'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'requisito.label', default: 'Requisito'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def listjson = {
		log.info "INGRESANDO AL CLOSURE listjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(Requisito,params,grailsApplication)
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
		def list = Requisito.createCriteria().list(){
				like('nombre','%'+params.term+'%')
		}
		render(contentType:"text/json"){
			array{
				for (obj in list){
					requisito id:obj.id,label:obj.nombre,value:obj.nombre
				}
			}
			
		}
	}
	
	def listsearchjson = {
		log.info "INGRESANDO AL METODO listsearchjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(Requisito,params,grailsApplication)
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
