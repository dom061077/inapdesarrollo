package com.educacion.academico


import com.educacion.util.GUtilDomainClass
import com.educacion.util.FilterUtils;

import java.text.SimpleDateFormat

import java.text.DateFormat

import java.text.ParseException
import org.springframework.transaction.TransactionStatus
import java.text.SimpleDateFormat;
import com.educacion.academico.Carrera;
import grails.converters.JSON
import com.educacion.enums.inscripcion.EstadoPreinscripcion

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
			flash.message = "Antes de cargar carreras debe cargar los requisitos"
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
				carreraInstance.addToNiveles(new Nivel(descripcion:it.descripcion,esprimernivel:it.esprimernivelvalue.toBoolean()))
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
					nivelesSerialized  = nivelesSerialized +','+ '{"id":'+it.id+',"idNivel":'+it.id+',"descripcion":"'+it.descripcion+'","esprimernivel":"'+(it.esprimernivel?"Es el Primer Nivel":"No es el Primer Nivel")+'"}'
				}else{
					nivelesSerialized = nivelesSerialized+ '{"id":'+it.id+',"idNivel":'+it.id+',"descripcion":"'+it.descripcion+'","esprimernivel":"'+(it.esprimernivel?"Es el Primer Nivel":"No es el Primer Nivel")+'"}'
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
			
			Carrera.withTransaction(){TransactionStatus status ->
				if (params.version) {
					def version = params.version.toLong()
					if (carreraInstance.version > version) {
						
						carreraInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'carrera.label', default: 'Carrera')] as Object[], "Another user has updated this Carrera while you were editing")
						render(view: "edit", model: [carreraInstance: carreraInstance,requisitosSerialized:requisitosSerialized,nivelesSerialized:nivelesSerialized])
						status.setRollbackOnly()
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
						nivelInstance.delete(flush:true)
						log.debug "NIVEL ELIMINADO: "+it
					}catch(org.hibernate.ObjectNotFoundException e){
						log.debug "NO SE PUDO ELIMINAR EL NIVEL "+it
					}catch (org.springframework.dao.DataIntegrityViolationException e){
						flash.message="Uno de los niveles no pudo eliminarse por favor edite de nuevo la carrera"
						render(view: "edit", model: [carreraInstance: carreraInstance,requisitosSerialized:requisitosSerialized,nivelesSerialized:nivelesSerialized,aniosSerialized:aniosSerialized])
						status.setRollbackOnly()
					}
				}
				
				nivelesJson.each {
					 nivelInstance = Nivel.get(it.idNivel)
					 if(nivelInstance){
						 nivelInstance.descripcion=it.descripcion
						 nivelInstance.esprimernivel = it.esprimernivelvalue.toBoolean()
						nivelInstance.save()
						log.debug "ENCUENTRA EL NIVEL Y LO MODIFICA"
					 }else{
						 carreraInstance.addToNiveles(new Nivel(descripcion:it.descripcion,esprimernivel:it.esprimernivelvalue.toBoolean()))
						log.debug "NO ENCUENTRA EL NIVEL Y LO AGREGA"
					 }
				}

				//--------anios lectivos--------------------------------
				def anioLectivoInstance
				aniosDeletedJson.each{
					if(!it.id.equals(""))
					try{
						anioLectivoInstance = AnioLectivo.load(it.id.toLong())
						carreraInstance.removeFromAnios(anioLectivoInstance)
							anioLectivoInstance.delete(flush:true)
						
					}catch (org.springframework.dao.DataIntegrityViolationException e){
						return
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
						
						if(!anioLectivoInstance.save()){
							status.setRollbackOnly()
							render(view: "edit", model: [carreraInstance: carreraInstance,requisitosSerialized:requisitosSerialized,nivelesSerialized:nivelesSerialized,aniosSerialized:aniosSerialized])
							return
						}
						log.debug "ENCUENTRA EL ANIO LECTIVO Y LO MODIFICA"
					 }else{
		 
						 carreraInstance.addToAnios(new AnioLectivo(anioLectivo:it.anioLectivo,cupo:it.cupo,cupoSuplentes:it.cupoSuplentes,costoMatricula:it.costoMatricula,fechaInicio:fechaInicio,fechaFin:fechaFin))
						 log.debug "NO ENCUENTRA EL ANIO LECTIVO Y LO AGREGA"
					 }
				}

								
				carreraInstance.properties = params
				try{
					if (!carreraInstance.hasErrors() && carreraInstance.save(flush: true)) {
						flash.message = "${message(code: 'default.updated.message', args: [message(code: 'carrera.label', default: 'Carrera'), carreraInstance.id])}"
						redirect(controller:'carrera',action: "show", id: carreraInstance.id)
					}
					else {
						status.setRollbackOnly()
						render(view: "edit", model: [carreraInstance: carreraInstance,requisitosSerialized:requisitosSerialized,nivelesSerialized:nivelesSerialized,aniosSerialized:aniosSerialized])
					}
				}catch(org.springframework.dao.DataIntegrityViolationException e){
						log.debug "EXCEPTION ATRAPADA DE NUEVO"
						status.setRollbackOnly()
						flash.message = "Algun registro eliminado en las grillas de registros, niveles o Años Lectivos esta referenciado en otros datos. Verifique antes de eliminar y vuelva a intentar la modificacion "
						redirect(action:"list")
						return 
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
					redirect(action: "show", id: params.idCarrera)
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
				 
				 result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.id+'","'+it.descripcion+'","'+it.esprimernivel+'","'+(it.esprimernivel?"Nivel Introductorio":"No es Nivel Introductorio")+'"]}'
				  
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
		
		def aniosList

		if(params.id){
			carreraInstance = Carrera.load(params.id.toLong())
			aniosList = carreraInstance.anios.sort{it.anioLectivo}.reverse()
			 result='{"page":1,"total":"'+1+'","records":"'+aniosList.size()+'","rows":['
			 flagaddcomilla=false
			 aniosList?.each{
				 
				 if (flagaddcomilla)
					 result=result+','
				 
				 result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.id+'","'+it.anioLectivo+'","'+it.cupo+'","'+it.cupoSuplentes+'","'+it.costoMatricula+'","'+g.formatDate(format:'dd/MM/yyyy',date:it.fechaInicio)+'","'+g.formatDate(format:'dd/MM/yyyy',date:it.fechaFin)+'"]}'
				  
				 flagaddcomilla=true
			 }
	 
			 result=result+']}'
			 render result
		 }else{
			 render '{page:0,"total":"0","records":0,"rows":[]}'
		 }

	}

	def editanios = {
		log.debug "INGRESANDO AL CLOSURE editanios"
		log.debug "PARAMETROS: $params"
		if(params.idid){
			def inscriptos = Preinscripcion.createCriteria().get{
				projections{
					count('id')
				}	
				and{
					ne("estado",EstadoPreinscripcion.ESTADO_PREINSCIRPTOANULADO)
					carrera{
						eq("id",params.carreraId.toLong())
					}
					anioLectivo{
						eq("id",params.idid.toLong())
					}
				}
			}
			def totalcupo = params.cupo.toInteger() + params.cupoSuplentes.toInteger()
			if(totalcupo<inscriptos)
				render '{"success":"false","message":"La cantidad actual de inscriptos ( en total '+inscriptos +' ) en la carrera supera la suma del cupo titulares y suplentes"}'
			else	
				render '{"success":"true","message":""}'
			
		}else 
			render '{"success":"true","message":""}' //datosCarrera as JSON
		

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
	
	def correlatividadesreport = {
		log.debug "INGREANDO AL CLOSURE correlativadesreport"
		log.debug "PARAMETROS: $params"
		
		if(params.id){
			def carreraInstance = Carrera.load(params.id.toLong())
			/*carreraInstance.niveles?.each{niv->
				log.debug "Nivel: $niv"
				niv.materias?.each{mat->
					mat.matregcursar?.each{matregcur->
						log.debug "Materias: $matregcur"
					}
					mat.mataprobcursar?.each{mataprobcursar->
						log.debug "Materias: $mataprobcursar"
					}
					mat.matregrendir?.each{matregrendir->
						log.debug "Materias: $matregrendir"
					}
					mat.mataprobrendir?.each{
						log.deubg "Materias: $mataprobrendir"
					}

				}
				
			}*/
			params.put("SUBREPORT_DIR",servletContext.getRealPath("/reports/"))
			params.put("carrera",carreraInstance.denominacion)
			params.put("_format","PDF")
			params.put("_name","correlatividades")
			params.put("_file","correlatividades")
			def listCarreras = new ArrayList()
			listCarreras.add(carreraInstance)
			chain(controller:'jasper',action:'index',model:[data:listCarreras],params:params)
		}else{
			flash.message=flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'nivel.label', default: 'Carrera no encontrada'), params.carreraId])}"
			redirect(controller:"nivel",action:"list")
		}

	}

	def cascadeniveles = {
		log.info "INGRESANDO AL CLOSURE autocomplete"
		log.info "PARAMETROS: $params"
		def carreraInstance = Carrera.get(params.selected)
		render(contentType:"text/json"){
			array{
				for(n in carreraInstance?.niveles){
					nivel label:n.descripcion, value:n.id
				}
			}
		}
		
	}
	
	def preinslistjson = {
		log.info "INGRESANDO AL CLOSURE preinslistjson"
		log.info "PARAMETROS: $params"
		//def gud=new GUtilDomainClass(Carrera,params,grailsApplication)
		//def list=gud.listrefactor(false)
		def hqlstr = "SELECT c.id,c.denominacion,c.duracion,c.titulo,c.validezTitulo,(SELECT max(a.anioLectivo) ";
		hqlstr = hqlstr +" FROM AnioLectivo a WHERE a.carrera.id=c.id)";
		hqlstr = hqlstr 	+",(SELECT acup.cupo FROM AnioLectivo acup";
		hqlstr = hqlstr		+" WHERE acup.anioLectivo=(SELECT MAX(anioLectivo) FROM AnioLectivo suba WHERE suba.carrera.id=c.id GROUP BY suba.carrera.id)";
		hqlstr = hqlstr		+" AND acup.carrera.id=c.id";
		hqlstr = hqlstr		+")";
		hqlstr = hqlstr	+",(SELECT acup.cupoSuplentes FROM AnioLectivo acup";
		hqlstr = hqlstr	+" WHERE acup.anioLectivo=(SELECT MAX(anioLectivo) FROM AnioLectivo suba WHERE suba.carrera.id=c.id GROUP BY suba.carrera.id)";
		hqlstr = hqlstr	+" AND acup.carrera.id=c.id";
		hqlstr = hqlstr	+")";
		hqlstr = hqlstr	+"  ,(SELECT";
		hqlstr = hqlstr	+"	COUNT(pre.id) FROM Preinscripcion pre WHERE pre.estado<>'ESTADO_PREINSCIRPTOANULADO' AND pre.carrera.id=c.id AND pre.anioLectivo.anioLectivo=";
		hqlstr = hqlstr	+"(SELECT MAX(anioLectivo) FROM AnioLectivo a WHERE a.carrera.id=c.id)";
		hqlstr = hqlstr	+"  )";
		hqlstr = hqlstr	+" FROM Carrera c";
		def filtersJson
		def parameters=[:]
		parameters["max"]=Integer.parseInt(params.rows)
		parameters["offset"]=Integer.parseInt(params.page)-1

		if(Boolean.parseBoolean(params._search )){
			if(params.filters){
				def searchOper
				def metaProperty
				def searchValue
				filtersJson = JSON.parse(params.filters)
				filtersJson?.rules?.each{
					//searchOper = GUtilDomainClass.operationSearch(it.op)
					//metaProperty = FilterUtils.getNestedMetaProperty(grailsApplication,Carrera.class,it.field)
					//searchValue = GUtilDomainClass.parseValue(it.data,metaProperty,params)
					hqlstr = hqlstr + " WHERE c.denominacion LIKE :denominacion"
					parameters["denominacion"]="%"+it.data.toUpperCase()+"%"
					
				}
			}
		}
		
		hqlstr = hqlstr+" GROUP BY c.id";
		def list =  Carrera.executeQuery(hqlstr,parameters)
		
		list?.each{
			log.debug  "LIST RESULT: "+it
		}
		
		def totalregistros = Carrera.count()
		
		def totalpaginas=new Float(totalregistros/Integer.parseInt(params.rows))
		if (totalpaginas>0 && totalpaginas<1)
			totalpaginas=1;
		totalpaginas=totalpaginas.intValue()

		
		
		def result='{"page":'+params.page+',"total":"'+totalpaginas+'","records":"'+totalregistros+'","rows":['
		def flagaddcomilla=false
		def insctitulares = 0 
		def inscsuplentes=0
		list.each{
			
			if (flagaddcomilla)
				result=result+','
			if( it[6] && it[8]){	
				inscsuplentes = it[6] - it[8]
				if(inscsuplentes<0  )
					inscsuplentes = inscsuplentes*(-1)
				else
					inscsuplentes = 0
			}	
			insctitulares = it[8] - inscsuplentes
			result=result+'{"id":"'+it[0]+'","cell":["'+it[0]+'","'+(it[1]==null?"":it[1])+'","'/*+(it[2]==null?"":it[2])+'","'+(it[3]==null?"":it[3])+'","'+(it[4]==null?"":it[4])+'","'*/+(it[5]==null?"":it[5])+'","'+(it[6]==null?"0":it[6])+'","'+(it[7]==null?"0":it[7])+'","'+insctitulares+'","'+inscsuplentes+'"]}'
			 
			flagaddcomilla=true
		}
		result=result+']}'
		render result

	}
	
	def carrerasreporte = {
		log.info "INGRESANDO AL CLOSURE carrerasreporte"
		log.info "PARAMETROS: $params"
		params.put("SUBREPORT_DIR",servletContext.getRealPath("/reports/carrera/"))
		params.put("_format","PDF")
		params.put("_name","reportecarreras")
		params.put("_file","carrera/carrerasreporte")
		//params.put("encoding","UTF-8")
		def listCarreras = Carrera.list()
		listCarreras.each{
			
			it.requisitos.each{ r->
					r.claseRequisito
			}
			it.niveles.each{ l->
				log.debug "NIVEL: "+ l.descripcion
			}
			it.anios.each{
				
			}
		}
		chain(controller:'jasper',action:'index',model:[data:listCarreras],params:params)

	}
	
}
