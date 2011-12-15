package com.educacion.academico


import com.educacion.util.GUtilDomainClass

import java.text.SimpleDateFormat

import java.text.DateFormat

import java.text.ParseException
import org.springframework.transaction.TransactionStatus
import java.text.SimpleDateFormat;


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
		if(Requisito.count()==0){
			redirect(controller:"carrera",action:"list")
			return
		}
		def carreraInstance = new Carrera()
		carreraInstance.properties = params
		return [carreraInstance: carreraInstance]
	}

	def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"
		
		def requisitosJson
		def nivelesJson
		def aniosJson
		if(params.requisitosSerialized)
			requisitosJson = grails.converters.JSON.parse(params.requisitosSerialized)
		if(params.nivelesSerialized)
			nivelesJson = grails.converters.JSON.parse(params.nivelesSerialized)
		if(params.aniosSerialized)
			aniosJson = grails.converters.JSON.parse(params.aniosSerialized)

			
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
			java.sql.Date fechaInicio
			java.sql.Date fechaFin
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")
			aniosJson.each{
				fechaInicio = new java.sql.Date(sdf.parse(it.fechaInicio).getTime())
				fechaFin = new java.sql.Date(sdf.parse(it.fechaFin).getTime())
				carreraInstance.addToAnios(new AnioLectivo(anioLectivo:it.anioLectivo
					,cupo:it.cupo,cupoSuplentes:it.cupoSuplentes,costoMatricula:it.costoMatricula,fechaInicio:fechaInicio,fechaFin:fechaFin))
			}
			if (carreraInstance.save(flush: true)) {
				flash.message = "${message(code: 'default.created.message', args: [message(code: 'carrera.label', default: 'Carrera'), carreraInstance.id])}"
				redirect(controller:'carrera',action: "show", id: carreraInstance?.id)
			}
			else {
				status.setRollbackOnly()
				render(view: "create", model: [carreraInstance: carreraInstance,requisitosSerialized:params.requisitosSerialized
						,nivelesSerialized:params.nivelesSerialized,aniosSerialized:params.aniosSerialized])
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
		def aniosSerialized="["
		def flagcoma=false
			
		if (!carreraInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'carrera.label', default: 'Carrera'), params.id])}"
			redirect(action: "list")
		}
		else {
			carreraInstance.requisitos.each{
				if(flagcoma){
					requisitosSerialized = requisitosSerialized+','+ '{"id":'+it.id+',"idid":'+it.id+',"descripcion":"'+it.descripcion+'","claseRequisito_descripcion":"'+it.claseRequisito?.descripcion+'"}'
				}else{
					requisitosSerialized = requisitosSerialized+ '{"id":'+it.id+',"idid":'+it.id+',"descripcion":"'+it.descripcion+'","claseRequisito_descripcion":"'+it.claseRequisito?.descripcion+'"}'
					flagcoma=true
				}
			}
			flagcoma=false
			carreraInstance.niveles.each{
				if(flagcoma){
					nivelesSerialized  = nivelesSerialized +','+ '{"id":'+it.id+',"idNivel":'+it.id+',"descripcion":"'+it.descripcion+'"}'
				}else{
					nivelesSerialized = nivelesSerialized+ '{"id":'+it.id+',"idNivel":'+it.id+',"descripcion":"'+it.descripcion+'"}'
					flagcoma=true
				}
			}
			flagcoma = false
			carreraInstance.anios.each{
				if(flagcoma){
					aniosSerialized = aniosSerialized +','+ '{"id":'+it.id+',"idid":'+it.id+',"anioLectivo":"'+it.anioLectivo+'","cupo":"'+it.cupo+'","cupoSuplentes":"'+it.cupoSuplentes+'","costoMatricula":"'+it.costoMatricula+'","fechaInicio":"'+g.formatDate(format:'dd/MM/yyyy',date:it.fechaInicio)+'","fechaFin":"'+g.formatDate(format:'dd/MM/yyyy',date:it.fechaFin)+'"}'
				}else{
					aniosSerialized = aniosSerialized+ '{"id":'+it.id+',"idid":'+it.id+',"anioLectivo":"'+it.anioLectivo+'","cupo":"'+it.cupo+'","cupoSuplentes":"'+it.cupoSuplentes+'","costoMatricula":"'+it.costoMatricula+'","fechaInicio":"'+g.formatDate(format:'dd/MM/yyyy',date:it.fechaInicio)+'","fechaFin":"'+g.formatDate(format:'dd/MM/yyyy',date:it.fechaFin)+'"}'
					flagcoma=true
				}
			}

			
			requisitosSerialized = requisitosSerialized+"]"
			nivelesSerialized = nivelesSerialized+"]"
			aniosSerialized=aniosSerialized+"]"

			return [carreraInstance: carreraInstance,requisitosSerialized:requisitosSerialized,nivelesSerialized:nivelesSerialized,aniosSerialized:aniosSerialized]
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
		def aniosJson
		def aniosSerialized = params.aniosSerialized
		def aniosDeletedJson
		
		def flagcoma=false
		
		if(params.requisitosSerialized)
			requisitosJson = grails.converters.JSON.parse(params.requisitosSerialized)
		if(params.nivelesSerialized)
			nivelesJson = grails.converters.JSON.parse(params.nivelesSerialized)
		if(params.nivelesDeletedSerialized)
			nivelesDeletedJson= grails.converters.JSON.parse(params.nivelesDeletedSerialized)
		if(params.aniosSerialized)
			aniosJson = grails.converters.JSON.parse(params.aniosSerialized)
		if(params.aniosDeletedSerialized)
			aniosDeletedJson = grails.converters.JSON.parse(params.aniosDeletedSerialized)	
		
		def carreraInstance = Carrera.get(params.idCarrera)
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

				//--------niveles--------------------------------
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

				//--------anios lectivos--------------------------------
				def anioLectivoInstance
				aniosDeletedJson.each{
					try{
						anioLectivoInstance = AnioLectivo.load(it.id.toLong())
						carreraInstance.removeFromAnios(anioLectivoInstance)
						anioLectivoInstance.delete()
						log.debug "ANIO LECTIVO ELIMINADO: "+it
					}catch(org.hibernate.ObjectNotFoundException e){
						log.debug "NO SE PUDO ELIMINAR EL ANIO LECTIVO "+it
					}
				}
				java.sql.Date fechaInicio
				java.sql.Date fechaFin
				SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")

				aniosJson.each {
					 anioLectivoInstance = AnioLectivo.get(it.idid)
					 fechaInicio = new java.sql.Date(sdf.parse(it.fechaInicio).getTime())
					 fechaFin = new java.sql.Date(sdf.parse(it.fechaFin).getTime())
					 if(anioLectivoInstance){
						anioLectivoInstance.anioLectivo=it.anioLectivo.toInteger()
						anioLectivoInstance.cupo=it.cupo.toInteger()
						anioLectivoInstance.cupoSuplentes=it.cupoSuplentes.toInteger()
						anioLectivoInstance.costoMatricula=it.costoMatricula.toDouble()
						anioLectivoInstance.fechaInicio=fechaInicio
						anioLectivoInstance.fechaFin=fechaFin
						anioLectivoInstance.save()
						log.debug "ENCUENTRA EL ANIO LECTIVO Y LO MODIFICA"
					 }else{
		 
						 carreraInstance.addToAnios(new AnioLectivo(anioLectivo:it.anioLectivo,cupo:it.cupo,cupoSuplentes:it.cupoSuplentes,costoMatricula:it.costoMatricula,fechaInicio:fechaInicio,fechaFin:fechaFin))
						 log.debug "NO ENCUENTRA EL ANIO LECTIVO Y LO AGREGA"
					 }
				}

								
				carreraInstance.properties = params
				if (!carreraInstance.hasErrors() && carreraInstance.save(flush: true)) {
					flash.message = "${message(code: 'default.updated.message', args: [message(code: 'carrera.label', default: 'Carrera'), carreraInstance.id])}"
					redirect(controller:'carrera',action: "show", id: carreraInstance.id)
				}
				else {
					status.setRollbackOnly()
					render(view: "edit", model: [carreraInstance: carreraInstance,requisitosSerialized:requisitosSerialized,nivelesSerialized:nivelesSerialized,aniosSerialized:aniosSerialized])
				}
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'carrera.label', default: 'Carrera'), params.idCarrera])}"
			redirect(action: "list")
		}
	}

	def delete = {
		log.info "INGRESANDO AL CLOSURE delete"
		log.info "PARAMETROS: $params"

		
		def carreraInstance = Carrera.get(params.idCarrera)
		if (carreraInstance) {
			Carrera.withTransaction{TransactionStatus status ->
				try {
					def requisitos = []
					carreraInstance.requisitos.each{
						requisitos.add(it)
					}
					
					requisitos.each {
						carreraInstance.removeFromRequisitos(it) 
					}
					carreraInstance.delete(flush: true)
					flash.message = "${message(code:'default.record.label',args:[message(code: 'default.deleted.message', args: [message(code: 'carrera.label', default: 'Carrera'), params.idCarrera])])}"
					redirect(action: "list")
				}
				catch (org.springframework.dao.DataIntegrityViolationException e) {
					status.setRollbackOnly()
					log.info "ERROR DE INTEGRIDAD"
					flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'carrera.label', default: 'Carrera'), params.idCarrera])}"
					redirect(action: "show", id: params.id)
				}
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
				like('denominacion','%'+params.term+'%')
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
				 
				 result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.id+'","'+it.descripcion+'"]}'
				  
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
	
	def listanios ={
		log.info "INGREANDO AL CLOSURE listanios"
		log.info "PARAMETROS: $params"
		def carreraInstance
		
		def result
		def flagaddcomilla
		def totalpaginas
		def totalregistros

		if(params.id){
			carreraInstance = Carrera.load(params.id.toLong())
			 result='{"page":1,"total":"'+1+'","records":"'+carreraInstance.anios.size()+'","rows":['
			 flagaddcomilla=false
			 carreraInstance.anios.each{
				 
				 if (flagaddcomilla)
					 result=result+','
				 
				 result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.id+'","'+it.anioLectivo+'","'+it.cupo+'","'+it.cupoSuplentes+'","'+it.costoMatricula+'","'+it.fechaInicio+'","'+it.fechaFin+'"]}'
				  
				 flagaddcomilla=true
			 }
	 
			 result=result+']}'
			 render result
		 }else{
			 render '{page:0,"total":"0","records":0,"rows":[]}'
		 }

	}

	def editanios = {
		render(contentType:"text/json"){
			array{
				
			}
		}

	}

	def listdocumentos ={
		log.info "INGRESANDO AL CLOSURE listdocumentos"
		log.info "PARAMETROS: $params"
		def carreraInstance
		
		def result
		def flagaddcomilla
		def totalpaginas
		def totalregistros

		if(params.id){
			carreraInstance = Carrera.load(params.id.toLong())
			 result='{"page":1,"total":"'+1+'","records":"'+carreraInstance.documentos.size()+'","rows":['
			 flagaddcomilla=false
			 def urlimg
			 def urllargeimg
			 def urlDocPdf
			 def nameDocPdf
			 carreraInstance.documentos.each{
				 urlimg = bi.resource(size:'small',bean:it)
				 urllargeimg = bi.resource(size:'large',bean:it)
				  if(urlimg.contains(".null")){
					 urlimg = g.resource(dir:'images',file:'noDisponible.jpg')
					 urllargeimg = g.resource(dir:'images',file:'noDisponibleLarge.jpg')
				 }
				 if (flagaddcomilla)
					 result=result+','
				 urlDocPdf=	 grailsApplication.config.documentocarrerafolder+'/'+it.id.toString()+'.pdf'
				 if (grailsApplication.mainContext.getResource(urlDocPdf).exists()){
				 	urlDocPdf = g.resource(dir:grailsApplication.config.documentocarrerafolder,file:it.id.toString()+'.pdf')
					nameDocPdf = it.nombreOriginalDocumento   
				 }else{
				 	urlDocPdf = ""
					nameDocPdf = ""
				 }
				 result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+nameDocPdf+'","'+urlDocPdf+'","'+urlimg+'","'+urllargeimg+'"]}'
				  
				 flagaddcomilla=true
			 }
	 
			 result=result+']}'
			 render result
		 }else{
			 render '{page:0,"total":"0","records":0,"rows":[]}'
		 }

	}
	
	
}
