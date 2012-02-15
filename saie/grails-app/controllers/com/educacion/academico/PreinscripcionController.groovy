package com.educacion.academico


import com.educacion.util.GUtilDomainClass 

import java.text.SimpleDateFormat 

import java.text.DateFormat 

import java.text.ParseException 



class PreinscripcionController {

	
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
        def preinscripcionInstance = new Preinscripcion()
		def niveles
		def carreras = Carrera.listOrderByDenominacion()
		niveles = carreras?.get(0)?.niveles

        preinscripcionInstance.properties = params
        return [preinscripcionInstance: preinscripcionInstance, niveles:niveles]
    }

    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"

        def preinscripcionInstance = new Preinscripcion(params)
        if (preinscripcionInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'preinscripcion.label', default: 'Preinscripcion'), preinscripcionInstance.id])}"
            redirect(action: "show", id: preinscripcionInstance.id)
        }
        else {
			def niveles
			if(params.carrera){
				niveles = Carrera.get(params.carrera)?.niveles
			}
	
            render(view: "create", model: [preinscripcionInstance: preinscripcionInstance,niveles:niveles])
        }
    }

    def show = {
		log.info "INGRESANDO AL CLOSURE show"
		log.info "PARAMETROS: $params"

		
        def preinscripcionInstance = Preinscripcion.get(params.id)
        if (!preinscripcionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'preinscripcion.label', default: 'Preinscripcion'), params.id])}"
            redirect(action: "list")
        }
        else {
            [preinscripcionInstance: preinscripcionInstance]
        }
    }

    def edit = {
		log.info "INGRESANDO AL CLOSURE edit"
		log.info "PARAMETROS: $params"

			
        def preinscripcionInstance = Preinscripcion.get(params.id)
        if (!preinscripcionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'preinscripcion.label', default: 'Preinscripcion'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [preinscripcionInstance: preinscripcionInstance]
        }
    }

    def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"
		
        def preinscripcionInstance = Preinscripcion.get(params.id)
        if (preinscripcionInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (preinscripcionInstance.version > version) {
                    
                    preinscripcionInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'preinscripcion.label', default: 'Preinscripcion')] as Object[], "Another user has updated this Preinscripcion while you were editing")
                    render(view: "edit", model: [preinscripcionInstance: preinscripcionInstance])
                    return
                }
            }
            preinscripcionInstance.properties = params
            if (!preinscripcionInstance.hasErrors() && preinscripcionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'preinscripcion.label', default: 'Preinscripcion'), preinscripcionInstance.id])}"
                redirect(action: "show", id: preinscripcionInstance.id)
            }
            else {
                render(view: "edit", model: [preinscripcionInstance: preinscripcionInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'preinscripcion.label', default: 'Preinscripcion'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		log.info "INGRESANDO AL CLOSURE delete"
		log.info "PARAMETROS: $params"

		
        def preinscripcionInstance = Preinscripcion.get(params.id)
        if (preinscripcionInstance) {
            try {
                preinscripcionInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'preinscripcion.label', default: 'Preinscripcion'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'preinscripcion.label', default: 'Preinscripcion'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'preinscripcion.label', default: 'Preinscripcion'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def listjson = {
		log.info "INGRESANDO AL CLOSURE listjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(Preinscripcion,params,grailsApplication)
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
		def list = Preinscripcion.createCriteria().list(){
				like('nombre','%'+params.term+'%')
		}
		render(contentType:"text/json"){
			array{
				for (obj in list){
					preinscripcion id:obj.id,label:obj.nombre,value:obj.nombre
				}
			}
			
		}
	}
	
	def listsearchjson = {
		log.info "INGRESANDO AL METODO listsearchjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(Preinscripcion,params,grailsApplication)
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
