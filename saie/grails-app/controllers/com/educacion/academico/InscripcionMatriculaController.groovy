package com.educacion.academico


import com.educacion.util.GUtilDomainClass 

import java.text.SimpleDateFormat 

import java.text.DateFormat 

import java.text.ParseException 
import com.educacion.academico.util.AcademicoUtil



class InscripcionMatriculaController {

	
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
		def preinscripcionInstance = Preinscripcion.get(params.id.toLong())
		def anioLectivoInstance = AcademicoUtil.getAnioLectivoCarrera(preinscripcionInstance.carrera.id)
		
		def materiasCursar = AcademicoUtil.getMateriasCursarDisponibles(preinscripcionInstance?.carrera?.id,preinscripcionInstance?.alumno?.id)
		
		def flagcomilla = false
		def materiasSerialized = "["
		materiasCursar.each{
			if(flagcomilla)
				materiasSerialized = materiasSerialized + ","
			materiasSerialized = materiasSerialized + '{"id":'+it.id+',"idid":'+it.id+',"denominacion":"'+it.denominacion+'","seleccion":"Yes"}'
			flagcomilla = true
		}
		materiasSerialized += "]"

		log.debug "MATERIAS SERIALIZED: "+materiasSerialized
		
        def inscripcionMatriculaInstance = new InscripcionMatricula(anioLectivo:anioLectivoInstance,carrera:preinscripcionInstance.carrera
					,alumno:preinscripcionInstance.alumno)
		
        inscripcionMatriculaInstance.properties = params
        return [inscripcionMatriculaInstance: inscripcionMatriculaInstance,materiasSerialized:materiasSerialized]
    }

    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"

        def inscripcionMatriculaInstance = new InscripcionMatricula(params)
        if (inscripcionMatriculaInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula'), inscripcionMatriculaInstance.id])}"
            redirect(action: "show", id: inscripcionMatriculaInstance.id)
        }
        else {
            render(view: "create", model: [inscripcionMatriculaInstance: inscripcionMatriculaInstance])
        }
    }

    def show = {
		log.info "INGRESANDO AL CLOSURE show"
		log.info "PARAMETROS: $params"

		
        def inscripcionMatriculaInstance = InscripcionMatricula.get(params.id)
        if (!inscripcionMatriculaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula'), params.id])}"
            redirect(action: "list")
        }
        else {
            [inscripcionMatriculaInstance: inscripcionMatriculaInstance]
        }
    }

    def edit = {
		log.info "INGRESANDO AL CLOSURE edit"
		log.info "PARAMETROS: $params"

			
        def inscripcionMatriculaInstance = InscripcionMatricula.get(params.id)
        if (!inscripcionMatriculaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [inscripcionMatriculaInstance: inscripcionMatriculaInstance]
        }
    }

    def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"
		
        def inscripcionMatriculaInstance = InscripcionMatricula.get(params.id)
        if (inscripcionMatriculaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (inscripcionMatriculaInstance.version > version) {
                    
                    inscripcionMatriculaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula')] as Object[], "Another user has updated this InscripcionMatricula while you were editing")
                    render(view: "edit", model: [inscripcionMatriculaInstance: inscripcionMatriculaInstance])
                    return
                }
            }
            inscripcionMatriculaInstance.properties = params
            if (!inscripcionMatriculaInstance.hasErrors() && inscripcionMatriculaInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula'), inscripcionMatriculaInstance.id])}"
                redirect(action: "show", id: inscripcionMatriculaInstance.id)
            }
            else {
                render(view: "edit", model: [inscripcionMatriculaInstance: inscripcionMatriculaInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		log.info "INGRESANDO AL CLOSURE delete"
		log.info "PARAMETROS: $params"

		
        def inscripcionMatriculaInstance = InscripcionMatricula.get(params.id)
        if (inscripcionMatriculaInstance) {
            try {
                inscripcionMatriculaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def listjson = {
		log.info "INGRESANDO AL CLOSURE listjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(InscripcionMatricula,params,grailsApplication)
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
		def list = InscripcionMatricula.createCriteria().list(){
				like('nombre','%'+params.term+'%')
		}
		render(contentType:"text/json"){
			array{
				for (obj in list){
					inscripcionmatricula id:obj.id,label:obj.nombre,value:obj.nombre
				}
			}
			
		}
	}
	
	def listsearchjson = {
		log.info "INGRESANDO AL METODO listsearchjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(InscripcionMatricula,params,grailsApplication)
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
	
 
	
	def seleccionalumno = {
		log.info "INGRESANDO AL CLOSURE seleccionalumno"
		log.info("PARAMETROS: $params")
		
	}
	
	

	
}
