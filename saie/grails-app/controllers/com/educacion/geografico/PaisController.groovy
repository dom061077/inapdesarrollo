package com.educacion.geografico


import com.educacion.util.GUtilDomainClass 

import java.text.SimpleDateFormat 

import java.text.DateFormat 

import java.text.ParseException 



class PaisController {

	
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
        def paisInstance = new Pais()
        paisInstance.properties = params
        return [paisInstance: paisInstance]
    }

    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"

        def paisInstance = new Pais(params)
        if (paisInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'pais.label', default: 'Pais'), paisInstance.id])}"
            redirect(action: "show", id: paisInstance.id)
        }
        else {
            render(view: "create", model: [paisInstance: paisInstance])
        }
    }

    def show = {
		log.info "INGRESANDO AL CLOSURE show"
		log.info "PARAMETROS: $params"

		
        def paisInstance = Pais.get(params.id)
        if (!paisInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'pais.label', default: 'Pais'), params.id])}"
            redirect(action: "list")
        }
        else {
            [paisInstance: paisInstance]
        }
    }

    def edit = {
		log.info "INGRESANDO AL CLOSURE edit"
		log.info "PARAMETROS: $params"

			
        def paisInstance = Pais.get(params.id)
        if (!paisInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'pais.label', default: 'Pais'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [paisInstance: paisInstance]
        }
    }

    def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"
		
        def paisInstance = Pais.get(params.id)
        if (paisInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (paisInstance.version > version) {
                    
                    paisInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'pais.label', default: 'Pais')] as Object[], "Another user has updated this Pais while you were editing")
                    render(view: "edit", model: [paisInstance: paisInstance])
                    return
                }
            }
            paisInstance.properties = params
            if (!paisInstance.hasErrors() && paisInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'pais.label', default: 'Pais'), paisInstance.id])}"
                redirect(action: "show", id: paisInstance.id)
            }
            else {
                render(view: "edit", model: [paisInstance: paisInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'pais.label', default: 'Pais'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		log.info "INGRESANDO AL CLOSURE delete"
		log.info "PARAMETROS: $params"

		
        def paisInstance = Pais.get(params.id)
        if (paisInstance) {
            try {
                paisInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'pais.label', default: 'Pais'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'pais.label', default: 'Pais'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'pais.label', default: 'Pais'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def listjson = {
		log.info "INGRESANDO AL CLOSURE listjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(Pais,params,grailsApplication)
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
		def list = Pais.createCriteria().list(){
				like('nombre','%'+params.term+'%')
		}
		log.debug "PROFESIONALES LISTADOS: "+profesionales.size()
		render(contentType:"text/json"){
			array{
				for (prof in list){
					pais id:prof.id,label:prof.nombre,value:prof.nombre
				}
			}
			
		}
	}
	
	def listsearchjson = {
		log.info "INGRESANDO AL METODO listsearchjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(Pais,params,grailsApplication)
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
