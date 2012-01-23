package com.educacion.seguridad


import com.educacion.util.GUtilDomainClass 

import java.text.SimpleDateFormat 

import java.text.DateFormat 

import java.text.ParseException 
import org.springframework.transaction.TransactionStatus



class RequestmapGroupController {

	
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
        def requestmapGroupInstance = new RequestmapGroup()
        requestmapGroupInstance.properties = params
        return [requestmapGroupInstance: requestmapGroupInstance]
    }

    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"
		def requestsJson
		
		if (params.requestsSerialized){
			requestsJson = grails.converters.JSON.parse(params.requestsSerialized)
		}
        def requestmapGroupInstance = new RequestmapGroup(params)
		
		RequestmapGroup.withTransaction{TransactionStatus status ->
			def requestmapInstance
			requestsJson.each{
				requestmapInstance = new Requestmap(url:it.url,descripcion:it.descripcion,configAttribute:"ROLE_ADMIN")
				requestmapGroupInstance.addToRequests(requestmapInstance)
			}
			if (requestmapGroupInstance.save(flush: true)) {
				flash.message = "${message(code: 'default.created.message', args: [message(code: 'requestmapGroup.label', default: 'RequestmapGroup'), requestmapGroupInstance.id])}"
				redirect(action: "show", id: requestmapGroupInstance.id)
			}
			else {
				render(view: "create", model: [requestmapGroupInstance: requestmapGroupInstance,requestsSerialized:params.requestsSerialized])
			}
	
		}
		
    }

    def show = {
		log.info "INGRESANDO AL CLOSURE show"
		log.info "PARAMETROS: $params"

		
        def requestmapGroupInstance = RequestmapGroup.get(params.id)
        if (!requestmapGroupInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'requestmapGroup.label', default: 'RequestmapGroup'), params.id])}"
            redirect(action: "list")
        }
        else {
            [requestmapGroupInstance: requestmapGroupInstance]
        }
    }

    def edit = {
		log.info "INGRESANDO AL CLOSURE edit"
		log.info "PARAMETROS: $params"

			
        def requestmapGroupInstance = RequestmapGroup.get(params.id)
        if (!requestmapGroupInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'requestmapGroup.label', default: 'RequestmapGroup'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [requestmapGroupInstance: requestmapGroupInstance]
        }
    }

    def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"
		
        def requestmapGroupInstance = RequestmapGroup.get(params.id)
        if (requestmapGroupInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (requestmapGroupInstance.version > version) {
                    
                    requestmapGroupInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'requestmapGroup.label', default: 'RequestmapGroup')] as Object[], "Another user has updated this RequestmapGroup while you were editing")
                    render(view: "edit", model: [requestmapGroupInstance: requestmapGroupInstance])
                    return
                }
            }
            requestmapGroupInstance.properties = params
            if (!requestmapGroupInstance.hasErrors() && requestmapGroupInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'requestmapGroup.label', default: 'RequestmapGroup'), requestmapGroupInstance.id])}"
                redirect(action: "show", id: requestmapGroupInstance.id)
            }
            else {
                render(view: "edit", model: [requestmapGroupInstance: requestmapGroupInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'requestmapGroup.label', default: 'RequestmapGroup'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		log.info "INGRESANDO AL CLOSURE delete"
		log.info "PARAMETROS: $params"

		
        def requestmapGroupInstance = RequestmapGroup.get(params.id)
        if (requestmapGroupInstance) {
            try {
                requestmapGroupInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'requestmapGroup.label', default: 'RequestmapGroup'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'requestmapGroup.label', default: 'RequestmapGroup'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'requestmapGroup.label', default: 'RequestmapGroup'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def listjson = {
		log.info "INGRESANDO AL CLOSURE listjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(RequestmapGroup,params,grailsApplication)
		def list=gud.listrefactor(false)
		def totalregistros=gud.listrefactor(true)
		
		def totalpaginas=new Float(totalregistros/Integer.parseInt(params.rows))
		if (totalpaginas>0 && totalpaginas<1)
			totalpaginas=1;
		totalpaginas=totalpaginas.intValue()

		
		
		def result='{"page":"'+params.page+'","total":"'+totalpaginas+'","records":"'+totalregistros+'","rows":['
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
		def list = RequestmapGroup.createCriteria().list(){
				like('nombre','%'+params.term+'%')
		}
		render(contentType:"text/json"){
			array{
				for (obj in list){
					requestmapgroup id:obj.id,label:obj.descripcion,value:obj.descripcion
				}
			}
			
		}
	}
	
	def listsearchjson = {
		log.info "INGRESANDO AL METODO listsearchjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(RequestmapGroup,params,grailsApplication)
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

	def listrequest = {
		log.info "INGRESANDO AL CLOSURE listrequest"
		log.info "PARAMETROS: $params"
		
	}
		
	def editrequests = {
		log.info "INGRESANDO AL CLOSURE editrequests"
		log.info "PARAMETROS: $params"
		render ""
	}
	
}
