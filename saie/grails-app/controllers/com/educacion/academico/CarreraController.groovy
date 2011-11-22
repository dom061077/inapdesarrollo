package com.educacion.academico


import com.educacion.util.GUtilDomainClass

import java.text.SimpleDateFormat

import java.text.DateFormat

import java.text.ParseException
import org.springframework.transaction.TransactionStatus



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
		
		def requisitosJson
		def nivelesJson
		if(params.requisitosSerialized)
			requisitosJson = grails.converters.JSON.parse(params.requisitosSerialized)
		if(params.nivelesSerialized)
			nivelesJson = grails.converters.JSON.parse(params.nivelesSerialized)
			
		def carreraInstance = new Carrera(params)
		
		Carrera.withTransaction{TransactionStatus status ->
			def requisitoInstance
			requisitosJson.each{
				requisitoInstance = Requisito.load(it.idid.toLong())
				carreraInstance.addToRequisitos(requisitoInstance)
			}
			nivelesJson.each{
				carreraInstance.addToNiveles(new Nivel(descripcion:it.descripcion))
			}
			if (carreraInstance.save(flush: true)) {
				flash.message = "${message(code: 'default.created.message', args: [message(code: 'carrera.label', default: 'Carrera'), carreraInstance.id])}"
				redirect(action: "show", id: carreraInstance?.id)
			}
			else {
				render(view: "create", model: [carreraInstance: carreraInstance,requisitosSerialized:params.requisitosSerialized,nivelesSerialized:params.nivelesSerialized])
			}
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
		def requisitosSerialized="["
		def nivelesSerialized="["
		def flagcoma=false
			
		if (!carreraInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'carrera.label', default: 'Carrera'), params.id])}"
			redirect(action: "list")
		}
		else {
			carreraInstance.requisitos.each{
				if(flagcoma){
					requisitosSerialized = requisitosSerialized+','+ '{"id":'+it.id+',"idid":'+it.id+',"codigo":"'+it.codigo+'","descripcion":"'+it.descripcion+'"}'
				}else{
					requisitosSerialized = requisitosSerialized+ '{"id":'+it.id+',"idid":'+it.id+',"codigo":"'+it.codigo+'","descripcion":"'+it.descripcion+'"}'
					flagcoma=true
				}
			}
			flagcoma=false
			carreraInstance.niveles.each{
				if(flagcoma){
					nivelesSerialized = nivelesSerialized+','+ '{"id":'+it.id+',"idNivel":'+it.id+',"descripcion":"'+it.descripcion+'"}'
				}else{
					nivelesSerialized = nivelesSerialized+ '{"id":'+it.id+',"idNivel":'+it.id+',"descripcion":"'+it.descripcion+'"}'
					flagcoma=true
				}
			}
			
			requisitosSerialized = requisitosSerialized+"]"
			nivelesSerialized = nivelesSerialized+"]"

			return [carreraInstance: carreraInstance,requisitosSerialized:requisitosSerialized,nivelesSerialized:nivelesSerialized]
		}
	}

	def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"
		
		
		def requisitosJson
		def requisitosSerialized=params.requisitosSerialized
		def nivelesJson
		def nivelesSerialized = params.nivelesSerialized
		def nivelesDeletedJson
		def flagcoma=false
		
		if(params.requisitosSerialized)
			requisitosJson = grails.converters.JSON.parse(params.requisitosSerialized)
		if(params.nivelesSerialized)
			nivelesJson = grails.converters.JSON.parse(params.nivelesSerialized)
		if(params.nivelesDeletedSerialized)
			nivelesDeletedJson= grails.converters.JSON.parse(params.nivelesDeletedSerialized)
		
		
		def carreraInstance = Carrera.get(params.carrerId)
		if (carreraInstance) {
			
			/*if(!requisitosSerialized){
				requisitosSerialized="["
				carreraInstance.requisitos.each{
					if(flagcoma){
						requisitosSerialized = requisitosSerialized+','+ '{"id":'+it.id+',"idid":"'+it.id+',"codigo":"'+it.codigo+'","descripcion":"'+it.descripcion+'"}'
					}else{
						requisitosSerialized = requisitosSerialized+ '{"id":'+it.id+',"idid":"'+it.id+',"codigo":"'+it.codigo+'","descripcion":"'+it.descripcion+'"}'
						flagcoma=true
					}
				}
				requisitosSerialized=requisitosSerialized+"]"
			}*/
			


			Carrera.withTransaction(){TransactionStatus status ->
				if (params.version) {
					def version = params.version.toLong()
					if (carreraInstance.version > version) {
						
						carreraInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'carrera.label', default: 'Carrera')] as Object[], "Another user has updated this Carrera while you were editing")
						render(view: "edit", model: [carreraInstance: carreraInstance,requisitosSerialized:requisitosSerialized,nivelesSerialized:nivelesSerialized])
						return
					}
				}
				//-------requisitos.----------
				def arrayRequisitos = []
				carreraInstance.requisitos.each{
					arrayRequisitos.add(it.id)
				}
				def requisitoInstance
				arrayRequisitos.each {
					requisitoInstance = Requisito.load(it)
					carreraInstance.removeFromRequisitos(requisitoInstance)
				}
				requisitosJson.each{
					requisitoInstance = Requisito.load(it.id.toLong())
					carreraInstance.addToRequisitos(requisitoInstance)
				}

				//--------niveles------------
				def nivelInstance
				nivelesDeletedJson.each{
					try{
						nivelInstance = Nivel.load(it.id.toLong())
						carreraInstance.removeFromNiveles(nivelInstance)
						nivelInstance.delete()
						log.debug "NIVEL ELIMINADO: "+it
					}catch(org.hibernate.ObjectNotFoundException e){
						log.debug "NO SE PUDO ELIMINAR EL NIVEL "+it
					}
				}
				
				nivelesJson.each {
					 nivelInstance = Nivel.get(it.idNivel)
					 if(nivelInstance){
						 nivelInstance.descripcion=it.descripcion
						nivelInstance.save()
						log.debug "ENCUENTRA EL NIVEL Y LO MODIFICA"
					 }else{
						 carreraInstance.addToNiveles(new Nivel(descripcion:it.descripcion))
						log.debug "NO ENCUENTRA EL NIVEL Y LO AGREGA"
					 }
				}
				
				carreraInstance.properties = params
				if (!carreraInstance.hasErrors() && carreraInstance.save(flush: true)) {
					flash.message = "${message(code: 'default.updated.message', args: [message(code: 'carrera.label', default: 'Carrera'), carreraInstance.id])}"
					redirect(action: "show", id: carreraInstance.id)
				}
				else {
					status.setRollbackOnly()
					render(view: "edit", model: [carreraInstance: carreraInstance,requisitosSerialized:requisitosSerialized,nivelesSerialized:nivelesSerialized])
				}
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

		
		def carreraInstance = Carrera.get(params.idCarrera)
		if (carreraInstance) {
			try {
				carreraInstance.delete(flush: true)
				flash.message = "${message(code:'default.record.label',args:[message(code: 'default.deleted.message', args: [message(code: 'carrera.label', default: 'Carrera'), params.idCarrera])])}"
				redirect(action: "list")
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'carrera.label', default: 'Carrera'), params.idCarrera])}"
				redirect(action: "show", id: params.idCarrera)
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'carrera.label', default: 'Carrera'), params.idCarrera])}"
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
				
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+(it.denominacion==null?"":it.denominacion)+'","'+(it.campoOcupacional==null?"":it.campoOcupacional)+'"]}'
			 
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
					carrera id:obj.id,label:obj.denominacion,value:obj.denominacion
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
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.denominacion+'"]}'
			 
			flagaddcomilla=true
		}
		result=result+']}'
		render result

	}

	def listrequisitos = {
		log.info "INGRESANDO AL CLOSURE listrequisitos"
		log.info "PARAMETROS: $params"
		def carreraInstance
		
		def result
		def flagaddcomilla
		def totalpaginas
		def totalregistros

		if(params.id){
			carreraInstance = Carrera.load(params.id.toLong())
			 result='{"page":1,"total":"'+1+'","records":"'+carreraInstance.requisitos.size()+'","rows":['
			 flagaddcomilla=false
			 carreraInstance.requisitos.each{
				 
				 if (flagaddcomilla)
					 result=result+','
				 
				 result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.id+'","'+it.codigo+'","'+it.descripcion+'"]}'
				  
				 flagaddcomilla=true
			 }
	 
			 result=result+']}'
			 render result
		 }else{
			 render '{page:0,"total":"0","records":0,"rows":[]}'
		 }

	}
	
	def editrequisitos = {
		render(contentType:"text/json"){
			array{
				
			}
		}

	}

	def listniveles = {
		log.info "INGRESANDO AL CLOSURE listniveles"
		log.info "PARAMETROS: $params"
		def carreraInstance
		
		def result
		def flagaddcomilla
		def totalpaginas
		def totalregistros

		if(params.id){
			carreraInstance = Carrera.load(params.id.toLong())
			 result='{"page":1,"total":"'+1+'","records":"'+carreraInstance.requisitos.size()+'","rows":['
			 flagaddcomilla=false
			 carreraInstance.niveles.each{
				 
				 if (flagaddcomilla)
					 result=result+','
				 
				 result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.id+'","'+it.descripcion+'"]}'
				  
				 flagaddcomilla=true
			 }
	 
			 result=result+']}'
			 render result
		 }else{
			 render '{page:0,"total":"0","records":0,"rows":[]}'
		 }

	}
	
	def editniveles = {
		render(contentType:"text/json"){
			array{
				
			}
		}

	}

	
	
}
