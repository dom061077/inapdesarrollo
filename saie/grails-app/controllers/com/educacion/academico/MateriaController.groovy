package com.educacion.academico


import com.educacion.util.GUtilDomainClass 

import java.text.SimpleDateFormat 

import java.text.DateFormat 

import java.text.ParseException 

import org.springframework.transaction.TransactionStatus



class MateriaController {

	
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
        def materiaInstance = new Materia()
        materiaInstance.properties = params
        return [materiaInstance: materiaInstance]
    }

    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"
		
		def matregcursarJson
		def mataprobcursarJson
		def matregrendirJson
		def mataprobrendirJson
		
		if(params.matregcursarSerialized)
			matregcursarJson = grails.converters.JSON.parse(params.matregcursarSerialized)
			
		if(params.mataprobcursarSerialized)
			mataprobcursarJson = grails.converters.JSON.parse(params.mataprobcursarSerialized)

		if(params.matregrendirSerialized)
			matregrendirJson = grails.converters.JSON.parse(params.matregrendirSerialized)

		if(params.mataprobrendirSerialized)
			mataprobrendirJson = grails.converters.JSON.parse(params.mataprobrendirSerialized)

		
		def materiaInstance = new Materia(params)
		def materiaInstanceSearch
			
		Materia.withTransaction{TransactionStatus status ->
			
			matregcursarJson.each{
				materiaInstanceSearch = Materia.load(it.idid.toLong())
				materiaInstance.addToMatregcursar(materiaInstanceSearch)
			}
			mataprobcursarJson.each{
				materiaInstanceSearch = Materia.load(it.idid.toLong())
				materiaInstance.addToMataprobcursar(materiaInstanceSearch)
			}
			matregrendirJson.each{
				materiaInstanceSearch = Materia.load(it.idid.toLong())
				materiaInstance.addToMatregrendir(materiaInstanceSearch)
				
			}
			mataprobrendirJson.each{
				materiaInstanceSearch = Materia.load(it.idid.toLong())
				materiaInstance.addToMataprobrendir(materiaInstanceSearch)
			}

			materiaInstance.validate()
	        if (!materiaInstance.hasErrors() && materiaInstance.save(flush: true)) {
				materiaInstanceSearch = Materia.load(materiaInstance.id)
				materiaInstance.addToMatregrendir(materiaInstanceSearch)
				materiaInstance.save()
	            flash.message = "${message(code: 'default.created.message', args: [message(code: 'materia.label', default: 'Materia'), materiaInstance.id])}"
	            redirect(controller:'materia',action: "show", id: materiaInstance.id)
	        }
	        else {
				status.setRollbackOnly()
	            render(view: "create", model: [materiaInstance: materiaInstance, matregcursarSerialized:params.matregcursarSerialized
						,mataprobcursarSerialized:params.mataprobcursarSerialized
						,matregrendirSerialized:params.matregrendirSerialized
						,mataprobrendirSerialized:params.mataprobrendirSerialized
						])
	        }
		}
    }

    def show = {
		log.info "INGRESANDO AL CLOSURE show"
		log.info "PARAMETROS: $params"

		
        def materiaInstance = Materia.get(params.id)
        if (!materiaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'materia.label', default: 'Materia'), params.id])}"
            redirect(action: "list")
        }
        else {
            [materiaInstance: materiaInstance]
        }
    }

    def edit = {
		log.info "INGRESANDO AL CLOSURE edit"
		log.info "PARAMETROS: $params"
		
		def matregcursarSerialized="["
		def mataprobcursarSerialized="["
		def matregrendirSerialized="["
		def mataprobrendirSerialized="["
		def flagaddcomilla=false
		
			
        def materiaInstance = Materia.get(params.id)
        if (!materiaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'materia.label', default: 'Materia'), params.id])}"
            redirect(action: "list")
        }
        else {
			materiaInstance.matregcursar.each{
				if (flagaddcomilla)
					matregcursarSerialized=matregcursarSerialized+','
				matregcursarSerialized=matregcursarSerialized+ '{"id":'+it.id+',"idid":'+it.id+',"denominacion":"'+it.denominacion+'","nivel":"'+it.nivel?.descripcion+'","carrera":"'+it.nivel?.carrera?.denominacion+'"}'
				flagaddcomilla=true
			}
			flagaddcomilla=false
			materiaInstance.mataprobcursar.each{
				if (flagaddcomilla)
					mataprobcursarSerialized=mataprobcursarSerialized+','
				mataprobcursarSerialized=mataprobcursarSerialized+ '{"id":'+it.id+',"idid":'+it.id+',"denominacion":"'+it.denominacion+'","nivel":"'+it.nivel?.descripcion+'","carrera":"'+it.nivel?.carrera?.denominacion+'"}'
				flagaddcomilla=true
			}

			flagaddcomilla=false
			materiaInstance.matregrendir.each{
				if (flagaddcomilla)
					matregrendirSerialized=matregrendirSerialized+','
				matregrendirSerialized=matregrendirSerialized+ '{"id":'+it.id+',"idid":'+it.id+',"denominacion":"'+it.denominacion+'","nivel":"'+it.nivel?.descripcion+'","carrera":"'+it.nivel?.carrera?.denominacion+'"}'
				flagaddcomilla=true
			}

			flagaddcomilla=false
			materiaInstance.mataprobrendir.each{
				if (flagaddcomilla)
					mataprobrendirSerialized=mataprobrendirSerialized+','
				mataprobrendirSerialized=mataprobrendirSerialized+ '{"id":'+it.id+',"idid":'+it.id+',"denominacion":"'+it.denominacion+'","nivel":"'+it.nivel?.descripcion+'","carrera":"'+it.nivel?.carrera?.denominacion+'"}'
				flagaddcomilla=true
			}

			
			matregcursarSerialized=matregcursarSerialized+"]"
			mataprobcursarSerialized=mataprobcursarSerialized+"]"
			matregrendirSerialized=matregrendirSerialized+"]"
			mataprobrendirSerialized=mataprobrendirSerialized+"]"
	
            return [materiaInstance: materiaInstance,matregcursarSerialized:matregcursarSerialized
				,mataprobcursarSerialized:mataprobcursarSerialized
				,matregrendirSerialized:matregrendirSerialized
				,mataprobrendirSerialized:mataprobrendirSerialized]
        }
    }

    def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"
		def matregcursarJson
		def mataprobcursarJson
		def matregrendirJson
		def mataprobrendirJson
		
		if(params.matregcursarSerialized)
			matregcursarJson = grails.converters.JSON.parse(params.matregcursarSerialized)
			
		if(params.mataprobcursarSerialized)
			mataprobcursarJson = grails.converters.JSON.parse(params.mataprobcursarSerialized)

		if(params.matregrendirSerialized)
			matregrendirJson = grails.converters.JSON.parse(params.matregrendirSerialized)

		if(params.mataprobrendirSerialized)
			mataprobrendirJson = grails.converters.JSON.parse(params.mataprobrendirSerialized)

		
		
        def materiaInstance = Materia.get(params.id)
		def materiaInstanceSearch
        if (materiaInstance) {
			Materia.withTransaction(){status->
		            if (params.version) {
		                def version = params.version.toLong()
		                if (materiaInstance.version > version) {
		                    
		                    materiaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'materia.label', default: 'Materia')] as Object[], "Another user has updated this Materia while you were editing")
		                    render(view: "edit", model: [materiaInstance: materiaInstance])
		                    return
		                }
		            }
					if(params.nivelId){
						def nivelInstance=Nivel.load(params.nivelId.toLong())
						materiaInstance.nivel=nivelInstance
					}else{
						materiaInstance.nivel=null
					}
		            materiaInstance.properties = params
					materiaInstance.matregcursar.clear()
					materiaInstance.mataprobcursar.clear()
					materiaInstance.matregrendir.clear()
					materiaInstance.mataprobrendir.clear()
					
					matregcursarJson.each{
						materiaInstanceSearch = Materia.load(it.idid.toLong())
						materiaInstance.addToMatregcursar(materiaInstanceSearch)
					}
					mataprobcursarJson.each{
						materiaInstanceSearch = Materia.load(it.idid.toLong())
						materiaInstance.addToMataprobcursar(materiaInstanceSearch)
					}
					matregrendirJson.each{
						materiaInstanceSearch = Materia.load(it.idid.toLong())
						materiaInstance.addToMatregrendir(materiaInstanceSearch)
						
					}
					mataprobrendirJson.each{
						materiaInstanceSearch = Materia.load(it.idid.toLong())
						materiaInstance.addToMataprobrendir(materiaInstanceSearch)
					}
		
					
		            if (!materiaInstance.hasErrors() && materiaInstance.save(flush: true)) {
		                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'materia.label', default: 'Materia'), materiaInstance.id])}"
		                redirect(controller:'materia',action: "show", id: materiaInstance.id)
		            }
		            else {
						status.setRollbackOnly()
		                render(view: "edit", model: [materiaInstance: materiaInstance])
		            }
			}
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'materia.label', default: 'Materia'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		log.info "INGRESANDO AL CLOSURE delete"
		log.info "PARAMETROS: $params"

		
        def materiaInstance = Materia.get(params.id)
        if (materiaInstance) {
            try {
                materiaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'materia.label', default: 'Materia'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'materia.label', default: 'Materia'), params.id])}"
                redirect(controller:"materia",action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'materia.label', default: 'Materia'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def listjson = {
		log.info "INGRESANDO AL CLOSURE listjson"
		log.info "PARAMETROS: ${params}"
		if(params.nivel_id){
			params._search="true"
			params.altfilters='{"groupOp":"AND","rules":[{"field":"nivel_id","op":"eq","data":"'+params.nivel_id+'"}]}'
		}
		
		def gud=new GUtilDomainClass(Materia,params,grailsApplication)
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
				
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+(it.denominacion==null?"":it.denominacion)+'","'+(it.nivel?.descripcion==null?"":it.nivel?.descripcion)+'","'+(it.nivel?.carrera?.denominacion==null?"":it.nivel?.carrera?.denominacion)+'"]}'
			 
			flagaddcomilla=true
		}
		result=result+']}'
		render result

	}
	
	def listjsonautocomplete={
		log.info "INGRESANDO AL CLOSURE listjsonautocomplete"
		log.info "PARAMETROS: ${params}"
		def list = Materia.createCriteria().list(){
				like('nombre','%'+params.term+'%')
		}
		render(contentType:"text/json"){
			array{
				for (obj in list){
					materia id:obj.id,label:obj.nombre,value:obj.nombre
				}
			}
			
		}
	}
	
	def listsearchjson = {
		log.info "INGRESANDO AL METODO listsearchjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(Materia,params,grailsApplication)
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
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+(it.denominacion==null?"":it.denominacion)+'","'+(it.nivel?.descripcion==null?"":it.nivel?.descripcion)+'","'+(it.nivel?.carrera?.denominacion==null?"":it.nivel?.carrera?.denominacion)+'"]}'
			 
			flagaddcomilla=true
		}
		result=result+']}'
		render result

	}
	
	def editmat = {//dummy closure para la materia
		render(contentType:"text/json"){
			array{
				
			}
		}
	}
	
	def listmatregcursar = {
		log.debug "INGRESANDO AL CLOSURE listmatregcursar"
		log.debug "PARAMETROS: $params"
		def result
		def flagaddcomilla
		def totalpaginas
		def totalregistros
		
		
		if(params.id){
			def materiaInstance = Materia.load(params.id.toString())
			result='{"page":1,"total":"'+1+'","records":"'+materiaInstance.matregcursar?.size()+'","rows":['
			materiaInstance.matregcursar.each{
				if (flagaddcomilla)
					result=result+','
				result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+(it.denominacion==null?"":it.denominacion)+'","'+(it.nivel?.descripcion==null?"":it.nivel?.descripcion)+'","'+(it.nivel?.carrera?.denominacion==null?"":it.nivel?.carrera?.denominacion)+'"]}'
				flagaddcomilla=true
			}
			result=result+']}'
			render result
		}else{
			render '{page:0,"total":"0","records":0,"rows":[]}'
		}
	}


	def listmataprobcursar = {
		log.debug "INGRESANDO AL CLOSURE listmatregcursar"
		log.debug "PARAMETROS: $params"
		def result
		def flagaddcomilla
		def totalpaginas
		def totalregistros
		
		
		if(params.id){
			def materiaInstance = Materia.load(params.id.toString())
			result='{"page":1,"total":"'+1+'","records":"'+materiaInstance.mataprobcursar?.size()+'","rows":['
			materiaInstance.mataprobcursar.each{
				if (flagaddcomilla)
					result=result+','
				result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+(it.denominacion==null?"":it.denominacion)+'","'+(it.nivel?.descripcion==null?"":it.nivel?.descripcion)+'","'+(it.nivel?.carrera?.denominacion==null?"":it.nivel?.carrera?.denominacion)+'"]}'
				flagaddcomilla=true
			}
			result=result+']}'
			render result
		}else{
			render '{page:0,"total":"0","records":0,"rows":[]}'
		}
	}

	def listmatregrendir = {
		log.debug "INGRESANDO AL CLOSURE listmatregcursar"
		log.debug "PARAMETROS: $params"
		def result
		def flagaddcomilla
		def totalpaginas
		def totalregistros
		
		
		if(params.id){
			def materiaInstance = Materia.load(params.id.toString())
			result='{"page":1,"total":"'+1+'","records":"'+materiaInstance.matregrendir?.size()+'","rows":['
			materiaInstance.matregrendir.each{
				if (flagaddcomilla)
					result=result+','
				result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+(it.denominacion==null?"":it.denominacion)+'","'+(it.nivel?.descripcion==null?"":it.nivel?.descripcion)+'","'+(it.nivel?.carrera?.denominacion==null?"":it.nivel?.carrera?.denominacion)+'"]}'
				flagaddcomilla=true
			}
			result=result+']}'
			render result
		}else{
			render '{page:0,"total":"0","records":0,"rows":[]}'
		}
	}

	def listmataprobrendir = {
		log.debug "INGRESANDO AL CLOSURE listmatregcursar"
		log.debug "PARAMETROS: $params"
		def result
		def flagaddcomilla
		def totalpaginas
		def totalregistros
		
		
		if(params.id){
			def materiaInstance = Materia.load(params.id.toString())
			result='{"page":1,"total":"'+1+'","records":"'+materiaInstance.mataprobrendir?.size()+'","rows":['
			materiaInstance.mataprobrendir.each{
				if (flagaddcomilla)
					result=result+','
				result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+(it.denominacion==null?"":it.denominacion)+'","'+(it.nivel?.descripcion==null?"":it.nivel?.descripcion)+'","'+(it.nivel?.carrera?.denominacion==null?"":it.nivel?.carrera?.denominacion)+'"]}'
				flagaddcomilla=true
			}
			result=result+']}'
			render result
		}else{
			render '{page:0,"total":"0","records":0,"rows":[]}'
		}
	}

	def listasistencia = {
		
	}	
	
	def reporteasistencia = {
		log.info "INGRESANDO AL CLOSURE reporteasistencia"
		log.info "PARAMETROS: $params"
		params.put("SUBREPORT_DIR",servletContext.getRealPath("/reports/materia/"))
		params.put("_format","PDF")
		params.put("_name","reporteasistencia")
		params.put("_file","materia/asistenciareporte")
		//params.put("encoding","UTF-8")
		def listAlumnos = Materia.list()
		chain(controller:'jasper', action:'index', model:[data:listAlumnos], params:params)
	}
	
}
