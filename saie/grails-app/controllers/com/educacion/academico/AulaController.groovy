package com.educacion.academico


import com.educacion.util.GUtilDomainClass 

import java.text.SimpleDateFormat 

import java.text.DateFormat 

import java.text.ParseException 
import org.springframework.transaction.TransactionStatus


class AulaController {

	
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
        def aulaInstance = new Aula()
        aulaInstance.properties = params
        return [aulaInstance: aulaInstance]
    }

    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"
		
		def carrerasJson
		
		
				  
		if(params.carrerasSerialized)
			carrerasJson = grails.converters.JSON.parse(params.carrerasSerialized)

        def aulaInstance = new Aula(params)
		def carreraInstanceSearch
		
		Aula.withTransaction{TransactionStatus status ->
			carrerasJson.each{
				carreraInstanceSearch = Carrera.load(it.idid.toLong())
				aulaInstance.addToCarreras(carreraInstanceSearch)
			}
			if (aulaInstance.save(flush: true)) {
				flash.message = "${message(code: 'default.created.message', args: [message(code: 'aula.label', default: 'Aula'), aulaInstance.id])}"
				redirect(action: "show", id: aulaInstance.id)
			}
			else {
				status.setRollbackOnly()
				render(view: "create", model: [aulaInstance: aulaInstance,carrerasSerialized:params.carrerasSerialized])
			}
	
			
		}
		
    }

    def show = {
		log.info "INGRESANDO AL CLOSURE show"
		log.info "PARAMETROS: $params"

		
        def aulaInstance = Aula.get(params.id)
        if (!aulaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'aula.label', default: 'Aula'), params.id])}"
            redirect(action: "list")
        }
        else {
            [aulaInstance: aulaInstance]
        }
    }

    def edit = {
		log.info "INGRESANDO AL CLOSURE edit"
		log.info "PARAMETROS: $params"

			
        def aulaInstance = Aula.get(params.id)
        if (!aulaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'aula.label', default: 'Aula'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [aulaInstance: aulaInstance]
        }
    }

    def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"
		
        def aulaInstance = Aula.get(params.id)
        if (aulaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (aulaInstance.version > version) {
                    
                    aulaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'aula.label', default: 'Aula')] as Object[], "Another user has updated this Aula while you were editing")
                    render(view: "edit", model: [aulaInstance: aulaInstance])
                    return
                }
            }
            aulaInstance.properties = params
            if (!aulaInstance.hasErrors() && aulaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'aula.label', default: 'Aula'), aulaInstance.id])}"
                redirect(action: "show", id: aulaInstance.id)
            }
            else {
                render(view: "edit", model: [aulaInstance: aulaInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'aula.label', default: 'Aula'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		log.info "INGRESANDO AL CLOSURE delete"
		log.info "PARAMETROS: $params"

		
        def aulaInstance = Aula.get(params.id)
        if (aulaInstance) {
            try {
                aulaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'aula.label', default: 'Aula'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'aula.label', default: 'Aula'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'aula.label', default: 'Aula'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def listjson = {
		log.info "INGRESANDO AL CLOSURE listjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(Aula,params,grailsApplication)
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
		def list = Aula.createCriteria().list(){
				like('nombre','%'+params.term+'%')
		}
		render(contentType:"text/json"){
			array{
				for (obj in list){
					aula id:obj.id,label:obj.nombre,value:obj.nombre
				}
			}
			
		}
	}
	
	def listsearchjson = {
		log.info "INGRESANDO AL METODO listsearchjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(Aula,params,grailsApplication)
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

	def editcarreras = {
		render(contentType :"text/json"){
			array{
				
			}
		}
	}


	
}
