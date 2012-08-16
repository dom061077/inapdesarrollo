package com.educacion.alumno


import com.educacion.util.GUtilDomainClass 

import java.text.SimpleDateFormat 

import java.text.DateFormat 

import java.text.ParseException 



class AsistenciaController {

	
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
        def asistenciaInstance = new Asistencia(params)

        //asistenciaInstance.fecha= new java.sql.Date(new java.util.Date().getTime())
        //asistenciaInstance.properties = params

        return [asistenciaInstance: asistenciaInstance]
    }

    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"

        def asistenciaInstance = new Asistencia(params)
        if (asistenciaInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'asistencia.label', default: 'Asistencia'), asistenciaInstance.id])}"
            redirect(action: "show", id: asistenciaInstance.id)
        }
        else {
            render(view: "create", model: [asistenciaInstance: asistenciaInstance])
        }
    }

    def show = {
		log.info "INGRESANDO AL CLOSURE show"
		log.info "PARAMETROS: $params"

		
        def asistenciaInstance = Asistencia.get(params.id)
        if (!asistenciaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'asistencia.label', default: 'Asistencia'), params.id])}"
            redirect(action: "list")
        }
        else {
            [asistenciaInstance: asistenciaInstance]
        }
    }

    def edit = {
		log.info "INGRESANDO AL CLOSURE edit"
		log.info "PARAMETROS: $params"

			
        def asistenciaInstance = Asistencia.get(params.id)
        if (!asistenciaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'asistencia.label', default: 'Asistencia'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [asistenciaInstance: asistenciaInstance]
        }
    }

    def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"
		
        def asistenciaInstance = Asistencia.get(params.id)
        if (asistenciaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (asistenciaInstance.version > version) {
                    
                    asistenciaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'asistencia.label', default: 'Asistencia')] as Object[], "Another user has updated this Asistencia while you were editing")
                    render(view: "edit", model: [asistenciaInstance: asistenciaInstance])
                    return
                }
            }
            asistenciaInstance.properties = params
            if (!asistenciaInstance.hasErrors() && asistenciaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'asistencia.label', default: 'Asistencia'), asistenciaInstance.id])}"
                redirect(action: "show", id: asistenciaInstance.id)
            }
            else {
                render(view: "edit", model: [asistenciaInstance: asistenciaInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'asistencia.label', default: 'Asistencia'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		log.info "INGRESANDO AL CLOSURE delete"
		log.info "PARAMETROS: $params"

		
        def asistenciaInstance = Asistencia.get(params.id)
        if (asistenciaInstance) {
            try {
                asistenciaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'asistencia.label', default: 'Asistencia'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'asistencia.label', default: 'Asistencia'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'asistencia.label', default: 'Asistencia'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def listjson = {
		log.info "INGRESANDO AL CLOSURE listjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(Asistencia,params,grailsApplication)
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
		def list = Asistencia.createCriteria().list(){
				like('nombre','%'+params.term+'%')
		}
		render(contentType:"text/json"){
			array{
				for (obj in list){
					asistencia id:obj.id,label:obj.nombre,value:obj.nombre
				}
			}
			
		}
	}
	
	def listsearchjson = {
		log.info "INGRESANDO AL METODO listsearchjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(Asistencia,params,grailsApplication)
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

    def listjsonalumnos = {
        log.info "INGRESANDO AL METODO listjsonalumnos"
        log.info "PARAMETROS: ${params}"

        def gud=new GUtilDomainClass(Alumno,params,grailsApplication)
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


            result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+(it.apellido==null?"":it.apellido)+'","'+(it.nombre==null?"":it.nombre)+'","'+(it.tipoDocumento.name==null?"":it.tipoDocumento.name)+'","'+(it.numeroDocumento==null?"":it.numeroDocumento)+'"]}'

            flagaddcomilla=true
        }
        result=result+']}'
        render result

    }

	
}
