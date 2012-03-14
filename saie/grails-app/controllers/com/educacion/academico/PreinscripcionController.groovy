package com.educacion.academico


import com.educacion.util.GUtilDomainClass 

import java.text.SimpleDateFormat 

import java.text.DateFormat 

import java.text.ParseException 

import org.springframework.transaction.TransactionStatus

import com.educacion.enums.inscripcion.EstadoPreinscripcion
import com.educacion.enums.inscripcion.EstadoDetalleInscripcionRequisito
import com.educacion.enums.inscripcion.EstadoInscripcionMateriaDetalleEnum;
import com.educacion.enums.inscripcion.TipoInscripcionMateria


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
		//def carreras = Carrera.listOrderByDenominacion()
		//niveles = carreras?.get(0)?.niveles
		def carreraInstance = Carrera.get(params.id)
		def anioLectivoInstance
		def sortedList= carreraInstance.anios.sort{it.anioLectivo}.reverse()
		if(sortedList.size()>0){
			def cupo= sortedList.get(0).cupo
			def cupoSuplementes = sortedList.get(0).cupoSuplentes
			anioLectivoInstance = sortedList.get(0)
		}
		if(!anioLectivoInstance){
			flash.message = g.message(code:"com.educacion.academico.Carrera.flash.message.aniolectivo",args:[carreraInstance?.denominacion])
			redirect(action:"carrerasdisponibles")
			return
		}
		
        preinscripcionInstance.properties = params
		preinscripcionInstance.carrera = carreraInstance
        return [preinscripcionInstance: preinscripcionInstance]
    }

    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"

		
        def preinscripcionInstance = new Preinscripcion(params)
		
		
		if(preinscripcionInstance.carrera){
			def sortedList= preinscripcionInstance.carrera.anios.sort{it.anioLectivo}.reverse()

			if(sortedList.size()>0){
				def cupo= sortedList.get(0).cupo
				def cupoSuplementes = sortedList.get(0).cupoSuplentes
				preinscripcionInstance.anioLectivo = sortedList.get(0)
			}
			
		}
		if(!preinscripcionInstance.anioLectivo){
			flash.message = g.message(code:"com.educacion.academico.Carrera.flash.message.aniolectivo",args:[preinscripcionInstance?.carrera?.denominacion])
			render(view: "create", model: [preinscripcionInstance: preinscripcionInstance])
			return
		}
		
		//if(carreraInstance.)
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
		hqlstr = hqlstr	+"	COUNT(pre.id) FROM Preinscripcion pre WHERE pre.carrera.id=c.id AND pre.anioLectivo.anioLectivo=";
		hqlstr = hqlstr	+"(SELECT MAX(anioLectivo) FROM AnioLectivo a WHERE a.carrera.id=c.id)";
		hqlstr = hqlstr	+"  )";
		hqlstr = hqlstr	+" FROM Carrera c WHERE c.id=:carrera";
		def list =  Carrera.executeQuery(hqlstr,["carrera":preinscripcionInstance.carrera?.id])
		def datosCarrera = list?.get(0)
		def cupodisponible=0
		def cupo = 0
		def cuposuplentes = 0
		def inscriptos = 0
		
		//el indice 6 es el cupo, el 7 cupo suplente, el 8 la cantidad de preinscripciones
		if((!datosCarrera[6]) || (datosCarrera[6]==0)){
			flash.message = "No hay un cupo cargado para el año lectivo ${preinscripcionInstance.anioLectivo.anioLectivo}"
			render(view: "create", model: [preinscripcionInstance: preinscripcionInstance])
			return
		}
		cupo = preinscripcionInstance.anioLectivo.cupo
		if(datosCarrera[7])  
			cuposuplentes = datosCarrera[7]
		if(datosCarrera[8])
			inscriptos = datosCarrera[8]
			
		if((cupo+cuposuplentes)<(inscriptos+1)){
			flash.message="No hay un cupo para esta inscripciÃ³n"
			render(view:"create",model:[preinscripcionInstance:preinscripcionInstance])
			return
		}		
					
		cupodisponible = datosCarrera[6] - datosCarrera[8] - 1
		if(cupodisponible<0)
			preinscripcionInstance.estado = EstadoPreinscripcion.ESTADO_PREINSCRIPTOSUPLENTE
		else
			preinscripcionInstance.estado = EstadoPreinscripcion.ESTADO_PREINSCRIPTO
																 
		
		
		Preinscripcion.withTransaction{TransactionStatus status ->
			def inscripcionDetalleInstance = new InscripcionDetalleRequisito()
			
			preinscripcionInstance.carrera?.requisitos?.each{
				inscripcionDetalleInstance = new InscripcionDetalleRequisito()
				inscripcionDetalleInstance.requisito = it
				inscripcionDetalleInstance.estado = EstadoDetalleInscripcionRequisito.ESTADOINSREQ_INSATISFECHO
				preinscripcionInstance.addToDetalle(inscripcionDetalleInstance)
			}
			
			if (preinscripcionInstance.save()) {
				flash.message = "${message(code: 'default.created.message', args: [message(code: 'preinscripcion.label', default: 'Preinscripcion'), preinscripcionInstance.id])}"
				redirect(action: "show", id: preinscripcionInstance.id)
			}
			else {
				status.setRollbackOnly()
				render(view: "create", model: [preinscripcionInstance: preinscripcionInstance])
			}
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
				
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+(it.alumno.apellidoNombre==null?"":it.alumno.apellidoNombre)+'","'+(it.carrera.denominacion==null?"":it.carrera.denominacion)+'","'+g.formatDate(date:it.fechaAlta,format:"dd/MM/yyyy")+'","'+(it.anioLectivo.anioLectivo==null?"":it.anioLectivo.anioLectivo)+'","'+it.estado?.name+'"]}'
			 
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

	
	def carrerasdisponibles = {
		log.info "INGRESANDO AL CLOSURE carrerasdisponibles"
		log.info "PARAMETROS: $params"
		
	}

	def inscribir = {
		log.info "INGRESANDO AL CLOSURE inscribir"
		log.info "PARAMETROS $params"
		def preinscripcionInstance = Preinscripcion.get(params.id)
		if(preinscripcionInstance){
			if(preinscripcionInstance.estado.equals(EstadoPreinscripcion.ESTADO_INSCRIPTO)){
				flash.message = g.message(code:"com.educacion.academico.Preinscripcion.estado.inscripto",args:[preinscripcionInstance?.alumno?.apellidoNombre,preinscripcionInstance?.alumno?.numeroDocumento])
				redirect(action:"list")	
			}else
				return [preinscripcionInstance:preinscripcionInstance]	
				
		}else{
			flash.message = g.message(code:"default.not.found.message",args:[g.message(code:"preinscripcion.label"),params.id])
			redirect(action:'list')
		}
	}

	def confirminscripcion = {
		log.info "INGRESANDO AL CLOSURE confirminscripcion"
		log.info "PARAMETROS: $params"
		def preinscripcionInstance = Preinscripcion.get(params.id)
		if (preinscripcionInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (preinscripcionInstance.version > version) {
					
					preinscripcionInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'preinscripcion.label', default: 'Preinscripcion')] as Object[], "Another user has updated this Preinscripcion while you were editing")
					render(view: "inscribir", model: [preinscripcionInstance: preinscripcionInstance])
					return
				}
			}
			Preinscripcion.withTransaction{TransactionStatus status->
				preinscripcionInstance.estado = EstadoPreinscripcion.ESTADO_INSCRIPTO
				def inscripcionMateriaInstance
				preinscripcionInstance.carrera.niveles.each{ nivel->
					if(nivel.esprimernivel){
						inscripcionMateriaInstance = new InscripcionMateria(alumno:preinscripcionInstance.alumno
							,carrera:preinscripcionInstance.carrera,anioLectivo:preinscripcionInstance.anioLectivo)
						nivel.materias.each{ materia->
							inscripcionMateriaInstance.addToDetalleMateria(new InscripcionMateriaDetalle(materia:materia
									,tipo:TipoInscripcionMateria.TIPOINSMATERIA_CURSAR))
						}
					} 
				}
				if (!preinscripcionInstance.hasErrors() && preinscripcionInstance.save(flush: true)) {
					if(!inscripcionMateriaInstance.save()){
						status.setRollbackOnly()
						render(view:"inscribir",model:[preinscripcionInstance:preinscripcionInstance,inscripcionMateriaInstance:inscripcionMateriaInstance])	
					}else{
						flash.message = "${message(code: 'default.updated.message', args: [message(code: 'preinscripcion.label', default: 'Preinscripcion'), preinscripcionInstance.id])}"
						redirect(action: "show", id: preinscripcionInstance.id)
					}
				}
				else {
					status.setRollbackOnly()
					render(view: "inscribir", model: [preinscripcionInstance: preinscripcionInstance])
				}
	
				
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'preinscripcion.label', default: 'Preinscripcion'), params.id])}"
			redirect(action: "list")
		}

	}

	
}
