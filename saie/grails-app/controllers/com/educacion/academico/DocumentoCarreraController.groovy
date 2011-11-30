package com.educacion.academico


import com.educacion.util.GUtilDomainClass 

import java.text.SimpleDateFormat 

import java.text.DateFormat 

import java.text.ParseException 



class DocumentoCarreraController {

	def uploadDocService
	def imageUploadService
	
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
        def documentoCarreraInstance = new DocumentoCarrera()
        documentoCarreraInstance.properties = params
        return [documentoCarreraInstance: documentoCarreraInstance]
    }

    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"

        def documentoCarreraInstance = new DocumentoCarrera(params)
		def retorno = uploadDocService.savedocimg(documentoCarreraInstance,grailsApplication,params)
        if (retorno instanceof Long) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'documentoCarrera.label', default: 'DocumentoCarrera'), documentoCarreraInstance.id])}"
            redirect(action: "show", id: retorno)
        }
        else {
			log.debug "ERRORES EN DOCUMENTO CARRERA: "+documentoCarreraInstance.errors.allErrors
            render(view: "create", model: [documentoCarreraInstance: retorno])
        }
    }

    def show = {
		log.info "INGRESANDO AL CLOSURE show"
		log.info "PARAMETROS: $params"

		
        def documentoCarreraInstance = DocumentoCarrera.get(params.id)
        if (!documentoCarreraInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'documentoCarrera.label', default: 'DocumentoCarrera'), params.id])}"
            redirect(action: "list")
        }
        else {
            [documentoCarreraInstance: documentoCarreraInstance]
        }
    }

    def edit = {
		log.info "INGRESANDO AL CLOSURE edit"
		log.info "PARAMETROS: $params"

			
        def documentoCarreraInstance = DocumentoCarrera.get(params.id)
        if (!documentoCarreraInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'documentoCarrera.label', default: 'DocumentoCarrera'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [documentoCarreraInstance: documentoCarreraInstance]
        }
    }

    def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"
		
        def documentoCarreraInstance = DocumentoCarrera.get(params.id)
        if (documentoCarreraInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (documentoCarreraInstance.version > version) {
                    
                    documentoCarreraInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'documentoCarrera.label', default: 'DocumentoCarrera')] as Object[], "Another user has updated this DocumentoCarrera while you were editing")
                    render(view: "edit", model: [documentoCarreraInstance: documentoCarreraInstance])
                    return
                }
            }
            documentoCarreraInstance.properties = params
            if (!documentoCarreraInstance.hasErrors() && documentoCarreraInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'documentoCarrera.label', default: 'DocumentoCarrera'), documentoCarreraInstance.id])}"
                redirect(action: "show", id: documentoCarreraInstance.id)
            }
            else {
                render(view: "edit", model: [documentoCarreraInstance: documentoCarreraInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'documentoCarrera.label', default: 'DocumentoCarrera'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		log.info "INGRESANDO AL CLOSURE delete"
		log.info "PARAMETROS: $params"

		
        def documentoCarreraInstance = DocumentoCarrera.get(params.id)
        if (documentoCarreraInstance) {
            try {
                documentoCarreraInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'documentoCarrera.label', default: 'DocumentoCarrera'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'documentoCarrera.label', default: 'DocumentoCarrera'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'documentoCarrera.label', default: 'DocumentoCarrera'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def listjson = {
		log.info "INGRESANDO AL CLOSURE listjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(DocumentoCarrera,params,grailsApplication)
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
		def list = DocumentoCarrera.createCriteria().list(){
				like('nombre','%'+params.term+'%')
		}
		render(contentType:"text/json"){
			array{
				for (obj in list){
					documentocarrera id:obj.id,label:obj.nombre,value:obj.nombre
				}
			}
			
		}
	}
	
	def listsearchjson = {
		log.info "INGRESANDO AL METODO listsearchjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(DocumentoCarrera,params,grailsApplication)
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
