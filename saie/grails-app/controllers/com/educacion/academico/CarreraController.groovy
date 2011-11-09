package com.educacion.academico


import com.educacion.util.GUtilDomainClass 

import java.text.SimpleDateFormat 

import java.text.DateFormat 

import java.text.ParseException 



class CarreraController {

	
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
        def carreraInstance = new Carrera()
        carreraInstance.properties = params
        return [carreraInstance: carreraInstance]
    }

    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"

        def carreraInstance = new Carrera(params)
        if (carreraInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'carrera.label', default: 'Carrera'), carreraInstance.id])}"
            redirect(action: "show", id: carreraInstance.id)
        }
        else {
            render(view: "create", model: [carreraInstance: carreraInstance])
        }
    }

    def show = {
		log.info "INGRESANDO AL CLOSURE show"
		log.info "PARAMETROS: $params"

		
        def carreraInstance = Carrera.get(params.id)
        if (!carreraInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'carrera.label', default: 'Carrera'), params.id])}"
            redirect(action: "list")
        }
        else {
            [carreraInstance: carreraInstance]
        }
    }

    def edit = {
		log.info "INGRESANDO AL CLOSURE edit"
		log.info "PARAMETROS: $params"

			
        def carreraInstance = Carrera.get(params.id)
        if (!carreraInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'carrera.label', default: 'Carrera'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [carreraInstance: carreraInstance]
        }
    }

    def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"
		
        def carreraInstance = Carrera.get(params.id)
        if (carreraInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (carreraInstance.version > version) {
                    
                    carreraInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'carrera.label', default: 'Carrera')] as Object[], "Another user has updated this Carrera while you were editing")
                    render(view: "edit", model: [carreraInstance: carreraInstance])
                    return
                }
            }
            carreraInstance.properties = params
            if (!carreraInstance.hasErrors() && carreraInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'carrera.label', default: 'Carrera'), carreraInstance.id])}"
                redirect(action: "show", id: carreraInstance.id)
            }
            else {
                render(view: "edit", model: [carreraInstance: carreraInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'carrera.label', default: 'Carrera'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		log.info "INGRESANDO AL CLOSURE delete"
		log.info "PARAMETROS: $params"

		
        def carreraInstance = Carrera.get(params.id)
        if (carreraInstance) {
            try {
                carreraInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'carrera.label', default: 'Carrera'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'carrera.label', default: 'Carrera'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'carrera.label', default: 'Carrera'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def listjson = {
		log.info "INGRESANDO AL CLOSURE listjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(Carrera,params,grailsApplication)
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
		def list = Carrera.createCriteria().list(){
				like('nombre','%'+params.term+'%')
		}
		render(contentType:"text/json"){
			array{
				for (obj in list){
					carrera id:obj.id,label:obj.nombre,value:obj.nombre
				}
			}
			
		}
	}
	
	def listsearchjson = {
		log.info "INGRESANDO AL METODO listsearchjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(Carrera,params,grailsApplication)
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

	def listrequisitos = {
		def result='{"page":1,"total":"0","records":"0","rows":['
		result=result+']}'
		render result

	}
	
	def editrequisitos = {
		
	}

	
}
