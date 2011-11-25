package com.educacion.academico


import com.educacion.util.GUtilDomainClass 

import java.text.SimpleDateFormat 

import java.text.DateFormat 

import java.text.ParseException 



class ClaseRequisitoController {

	
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
        def claseRequisitoInstance = new ClaseRequisito()
        claseRequisitoInstance.properties = params
        return [claseRequisitoInstance: claseRequisitoInstance]
    }

    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"

        def claseRequisitoInstance = new ClaseRequisito(params)
        if (claseRequisitoInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'claseRequisito.label', default: 'ClaseRequisito'), claseRequisitoInstance.id])}"
            redirect(action: "show", id: claseRequisitoInstance.id)
        }
        else {
			log.debug "ERRORES DE VALIDACION: "+claseRequisitoInstance.errors.allErrors
            render(view: "create", model: [claseRequisitoInstance: claseRequisitoInstance])
        }
    }

    def show = {
		log.info "INGRESANDO AL CLOSURE show"
		log.info "PARAMETROS: $params"

		
        def claseRequisitoInstance = ClaseRequisito.get(params.id)
        if (!claseRequisitoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'claseRequisito.label', default: 'ClaseRequisito'), params.id])}"
            redirect(action: "list")
        }
        else {
            [claseRequisitoInstance: claseRequisitoInstance]
        }
    }

    def edit = {
		log.info "INGRESANDO AL CLOSURE edit"
		log.info "PARAMETROS: $params"

			
        def claseRequisitoInstance = ClaseRequisito.get(params.id)
        if (!claseRequisitoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'claseRequisito.label', default: 'ClaseRequisito'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [claseRequisitoInstance: claseRequisitoInstance]
        }
    }

    def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"
		
        def claseRequisitoInstance = ClaseRequisito.get(params.id)
        if (claseRequisitoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (claseRequisitoInstance.version > version) {
                    
                    claseRequisitoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'claseRequisito.label', default: 'ClaseRequisito')] as Object[], "Another user has updated this ClaseRequisito while you were editing")
                    render(view: "edit", model: [claseRequisitoInstance: claseRequisitoInstance])
                    return
                }
            }
            claseRequisitoInstance.properties = params
            if (!claseRequisitoInstance.hasErrors() && claseRequisitoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'claseRequisito.label', default: 'ClaseRequisito'), claseRequisitoInstance.id])}"
                redirect(controller:'claseRequisito',action: "show", id: claseRequisitoInstance.id)
            }
            else {
                render(view: "edit", model: [claseRequisitoInstance: claseRequisitoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'claseRequisito.label', default: 'ClaseRequisito'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		log.info "INGRESANDO AL CLOSURE delete"
		log.info "PARAMETROS: $params"

		
        def claseRequisitoInstance = ClaseRequisito.get(params.id)
        if (claseRequisitoInstance) {
            try {
                claseRequisitoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'claseRequisito.label', default: 'ClaseRequisito'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'claseRequisito.label', default: 'ClaseRequisito'), params.id])}"
                redirect(controller:"claseRequisito",action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'claseRequisito.label', default: 'ClaseRequisito'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def listjson = {
		log.info "INGRESANDO AL CLOSURE listjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(ClaseRequisito,params,grailsApplication)
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
				
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+(it.codigo==null?"":it.codigo)+'","'+(it.descripcion==null?"":it.descripcion)+'"]}'
			 
			flagaddcomilla=true
		}
		result=result+']}'
		render result

	}
	
	def listjsonautocomplete={
		log.info "INGRESANDO AL CLOSURE listjsonautocomplete"
		log.info "PARAMETROS: ${params}"
		def list = ClaseRequisito.createCriteria().list(){
				like('descripcion','%'+params.term+'%')
		}
		render(contentType:"text/json"){
			array{
				for (obj in list){
					claserequisito id:obj.id,label:obj.descripcion,value:obj.descripcion
				}
			}
			
		}
	}
	
	def listsearchjson = {
		log.info "INGRESANDO AL METODO listsearchjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(ClaseRequisito,params,grailsApplication)
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
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.codigo+'","'+it.descripcion+'"]}'
			 
			flagaddcomilla=true
		}
		result=result+']}'
		render result

	}



	
}
