package com.educacion.academico


import com.educacion.util.GUtilDomainClass 

import java.text.SimpleDateFormat 

import java.text.DateFormat 

import java.text.ParseException 
import grails.converters.JSON
import org.springframework.transaction.TransactionStatus
import com.educacion.academico.exceptions.InscripcionMateriaException
import com.educacion.alumno.Alumno;
import com.educacion.enums.inscripcion.EstadoPreinscripcion;
import com.educacion.enums.inscripcion.EstadoInscripcionMateriaDetalleEnum
import com.educacion.enums.inscripcion.TipoInscripcionMateriaEnum
import com.educacion.enums.inscripcion.EstadoPreinscripcion
import com.educacion.enums.inscripcion.EstadoInscripcionMatriculaEnum
import com.educacion.academico.util.AcademicoUtil

 
class InscripcionMateriaController {

	def inscripcionMateriaService
	
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
		log.info "INGRESANDO AL CLOSURE list"
		log.info "PARAMETROS: $params"
     }
	
	def listjsonmateriasadd = {
		log.info "INGRESANDO AL CLOSURE listjsonmateriasadd"
		log.info "PARAMETROS $params"
		//-----------------------en esta seccion se detecta las materias en las que se puede inscribir el alumno------------
		
		
		def materias = Materia.executeQuery("""
				FROM Materia m 
				LEFT JOIN m.inscmatdetalle  inscd with inscd.estado = :estado
				LEFT JOIN inscd.inscripcionMateria insc  
				LEFT JOIN insc.alumno alu with alu.id = :alumnoId 
			""",[alumnoId:params.alumnoId.toLong(),estado:EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_AUSENTE])
		//, m.nivel.carrera.id= :carreraId
		//, isNull(insc.id)
		def materiasInscripcion=[]
		def flagCursarMateria
		def flagCursarMateriaRendir
		def cantidadConsulta
		materias.each{ mat ->
			flagCursarMateria = false
			flagCursarMateriaRendir = false
			mat[0].matregcursar.each{ matreg ->
				cantidadConsulta = InscripcionMateriaDetalle.createCriteria().get{
					materia{
						eq("id",matreg.id)
					}
					eq("estado",EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_REGULAR)
					projections{
						rowCount()
					}
				}
				if(cantidadConsulta>0)
					flagCursarMateria=true
					
			}
			if(mat[0].matregcursar.size()==0){
				flagCursarMateria = true
			}
			mat[0].mataprobcursar.each{ mataprob ->
				cantidadConsulta = InscripcionMateriaDetalle.createCriteria().get{
					materia{
						eq("id",mataprob.id)
					}
					eq("estado",EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_APROBADA)
					projections{
						rowCount()
					}
				}
				if(cantidadConsulta>0)
					flagCursarMateriaRendir=true
			}
			if(mat[0].mataprobcursar.size()==0)
				flagCursarMateriaRendir = true
				
			if(flagCursarMateria && flagCursarMateriaRendir ){
				materiasInscripcion.add([materia:mat[0],tipo:TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR])
			}
				

		}
		
		//------------------------------------------------------------------------------------------------------------------
		def totalregistros=materiasInscripcion.size()
		
		def totalpaginas=new Float(totalregistros/Integer.parseInt(params.rows))
		if (totalpaginas>0 && totalpaginas<1)
			totalpaginas=1;
		totalpaginas=totalpaginas.intValue()

		log.debug "MATERIAS: "+materiasInscripcion
		
		def result='{"page":'+params.page+',"total":"'+totalpaginas+'","records":"'+totalregistros+'","rows":['
		def flagaddcomilla=false

		materiasInscripcion.each{
			log.debug "materia inscripcion: "+it
			if (flagaddcomilla)
				result=result+','
			result=result+'{"id":"'+it["materia"].id+'","cell":["'+it["materia"].id+'","'+it["materia"].id+'","'+it["materia"].denominacion+'","'+'NO'+'"]}'
			flagaddcomilla=true
		}
		result=result+']}'
		render result
		
	}
	
	
	
	

	def anioscascade = {
		def matriculas = InscripcionMatricula.createCriteria().list{
			alumno{
				eq("id",params.selected.toLong())
			}
			carrera{
				eq("id",params.selected.toLong())
			}
			ne("estado",EstadoInscripcionMatriculaEnum.ESTADOINSMAT_ANULADA)
		}

		
		render(contentType:"text/json"){
			array{
				matriculas.each{mat ->
					nivel label:mat.anioLectivo.anioLectivo, value:mat.anioLectivo.id
				}
			}
		}
		
	}
	
	def anioscascadedata = {
		log.info "INGREANDO AL CLOSURE: anioscascade"
		log.info "PARAMETROS: $params"
		//para recuperar los datos que son: anolectivo id ,carrera id, inscripcion Matricula Id e inscripcion de matricula
		def matriculaInstance = Matricula.find("""
					from InscripcionMatricula mat 
						where mat.anioLectivo.id = :aniolectivo 
						and mat.carrera.id = :carrera 
						and mat.alumno.id = :alumno 
					
					"""
					,[aniolectivo:params.anioLectivoId.toLong(),carrera:params.carreraId,alumno:params.alumnoId.toLong()]) 
		def materias = getMateriasCursarDisponibles(params.carreraId.toLong(),params.alumnoId.toLong())
		render(contentType:"text/json"){
			matricula matriculaInstance.id
			array{
				materias?.each{
					materia id:it.id, denominacion: it.denominacion
				}
			}
		}

	}
	
    def create = {
		log.info "INGRESANDO AL CLOSURE create"
		log.info "PARAMETROS: $params"
		def primerAnioLectivoInstance
		def alumnoInstance
		def preinscripciones
		def carrerasInsc = new ArrayList()
		
		def matriculas
		def aniosLectivos = new ArrayList()
		if(params.id){
			
			preinscripciones = Preinscripcion.createCriteria().list{
				alumno{
					eq("id",params.id.toLong())
				}
				eq("estado",EstadoPreinscripcion.ESTADO_INSCRIPTO)
				isNotNull("inscripcionMatricula")
				carrera{
					order("denominacion","asc")
				}
			} 
			 
			preinscripciones.each{
				carrerasInsc.add(it.inscripcionMatricula.carrera)
			}
			
			//obtengo la primera carrear que se mostrará en el combo de las carreras inscriptas
			def primeraCarreraInstance
			if(carrerasInsc.size()>0) 
				primeraCarreraInstance = carrerasInsc.get(0)
			
			if(primeraCarreraInstance){
					matriculas = InscripcionMatricula.createCriteria().list{
						alumno{
							eq("id",params.id.toLong())
						}
						carrera{
							eq("id",primeraCarreraInstance?.id)
						}
						ne("estado",EstadoInscripcionMatriculaEnum.ESTADOINSMAT_ANULADA)
					}
			}
			
			def primeraInscripcionMatriculaInstance
			
			matriculas?.each{
				if(!primeraInscripcionMatriculaInstance)
					primeraInscripcionMatriculaInstance = it
				aniosLectivos.add(it.anioLectivo)
			}
			
			if(aniosLectivos.size()>0)
				primerAnioLectivoInstance = aniosLectivos.get(0) 
			
			alumnoInstance = Alumno.get(params.id)
			
			
			def materiasSerialized
			def materiasCursar = AcademicoUtil.getMateriasCursarDisponibles(primeraCarreraInstance?.id,alumnoInstance.id)
			
			def flagcomilla = false
			materiasSerialized = "["
			materiasCursar.each{
				if(flagcomilla)
					materiasSerialized = materiasSerialized + ","
				materiasSerialized = materiasSerialized + '{"id":'+it.id+',"idid":'+it.id+',"denominacion":"'+it.denominacion+'","seleccion":"Yes"}'
				flagcomilla = true
			}
			materiasSerialized += "]"
	
			
			
			
			/*def hqlstr = "FROM Preinscripcion pre WHERE pre.estado=:estado AND pre.id = "
			hqlstr = hqlstr + " (SELECT max(id) FROM Preinscripcion pre2 WHERE pre2.alumno.id = :alumno )"
			def preinscripciones = Preinscripcion.executeQuery(hqlstr,["alumno":params.id.toLong(),"estado":EstadoPreinscripcion.ESTADO_INSCRIPTO])*/
				
//			if(preinscripciones){
//			   def preinscripcionInstance = preinscripciones.get(0)
//			   if(!preinscripcionInstance){
//					flash.message = "${message(code:'com.educacion.academico.InscripcionMateria.preinscripcion.blank.error')}"
//					render(view:"alumnosinscripcion",model:[])
//					return
//			   }else{
				if(carrerasInsc.size()>0){
			       def inscripcionMateriaInstance = new InscripcionMateria(alumno:alumnoInstance
					   		,carrera:primeraCarreraInstance      
							,anioLectivo:primerAnioLectivoInstance   
							,inscripcionMatricula:primeraInscripcionMatriculaInstance                                                     
							//,preinscripcion:preinscripcionInstance,anioLectivo:preinscripcionInstance.anioLectivo
							)
			        return [inscripcionMateriaInstance: inscripcionMateriaInstance,carrerasInsc: carrerasInsc
							,materiasSerialized: materiasSerialized,aniosLectivos:aniosLectivos]
				}else{
								flash.message = "${message(code:'com.educacion.academico.InscripcionMateria.materias.blank.error')}"
								render(view:"alumnosinscripcion",model:[])
				}
			
//			   }
//			}else{
//				flash.message = "${message(code:'com.educacion.academico.InscripcionMateria.preinscripcion.blank.error')}"
//				render(view:"alumnosinscripcion",model:[])
//				return
//			}
		}else{
			flash.message = "Seleccione un alumno para inscribir en las materias correspondientes"
			render(view:"alumnosinscripcion",model:[])
			return
		}
    }

    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"
		
		//def hqlstr = "FROM Preinscripcion pre WHERE pre.estado=:estado AND pre.id = "
		//hqlstr = hqlstr + " (SELECT max(id) FROM Preinscripcion pre2 WHERE pre2.alumno.id = :alumno )"
		
		def inscripcionMateriaInstance = new InscripcionMateria(params)
		
		//def preinscripciones = Preinscripcion.executeQuery(hqlstr,["alumno":inscripcionMateriaInstance.alumno.id,"estado":EstadoPreinscripcion.ESTADO_INSCRIPTO])
		
		def preinscripcionInstance = Preinscripcion.get(params.preinscripcion.id)
		if(params.preinsversion)
			if(preinscripcionInstance.version>params.preinsversion.toLong()){
				inscripcionMateriaInstance.preinscripcion = preinscripcionInstance
				inscripcionMateriaInstance.carrera = preinscripcionInstance.carrera
				inscripcionMateriaInstance.alumno = preinscripcionInstance.alumno
				inscripcionMateriaInstance.anioLectivo = preinscripcionInstance.anioLectivo
				inscripcionMateriaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'inscripcionMateria.label', default: 'InscripcionMateria')] as Object[], "Another user has updated this InscripcionMateria while you were editing")
				render(view:"create",model:[inscripcionMateriaInstance:inscripcionMateriaInstance,preinscripcionInstance:preinscripcionInstance])
				return
			}
			
				
		
		//if(preinscripciones){
		
		
			
			try{
				inscripcionMateriaService.saveInscripcionMateria(inscripcionMateriaInstance,params)
				flash.message = "${message(code: 'default.created.message', args: [message(code: 'inscripcionMateria.label', default: 'Inscripcion Materia'), inscripcionMateriaInstance.id])}"
				render(view:"show",model:[inscripcionMateriaInstance:inscripcionMateriaInstance])
				return
			}catch(InscripcionMateriaException e){
				log.debug "ERRORES: "+inscripcionMateriaInstance.errors.allErrors
				render (view:"create", model:[inscripcionMateriaInstance:e.inscripcionMateria,materiasSerialized:params.materiasSerialized])
				return
			}

		//}else{
		//	flash.message = "${message(code:'com.educacion.academico.InscripcionMateria.preinscripcion.blank.error')}"
		//	render(view:"create",model:[inscripcionMateriaInstace:inscripcionMateriaInstance])
		//}


    }

    def show = {
		log.info "INGRESANDO AL CLOSURE show"
		log.info "PARAMETROS: $params"

		
        def inscripcionMateriaInstance = InscripcionMateria.get(params.id)
        if (!inscripcionMateriaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'inscripcionMateria.label', default: 'InscripcionMateria'), params.id])}"
            redirect(action: "list")
        }
        else {
            [inscripcionMateriaInstance: inscripcionMateriaInstance]
        }
    }

    def edit = {
		log.info "INGRESANDO AL CLOSURE edit"
		log.info "PARAMETROS: $params"
		def materiasSerialized="["
		def flagcoma=false
		
		def inscripcionMateriaInstance = InscripcionMateria.get(params.id)
        if (!inscripcionMateriaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'inscripcionMateria.label', default: 'InscripcionMateria'), params.id])}"
            redirect(action: "list")
        }
        else {
			inscripcionMateriaInstance.detalleMateria.each{
				if(flagcoma){
					materiasSerialized  = materiasSerialized +','+ '{"id":"'+it.id+'","idid":"'+it.materia.id+'","denominacion":"'+it.materia.denominacion+'","estadovalue":"'+it.estado+'","estado":"'+it.estado.name+'","tipovalue":"'+it.tipo+'","tipo":"'+it.tipo.name+'","nota":"'+it.nota+'"}'
				}else{
					materiasSerialized = materiasSerialized + '{"id":"'+it.id+'","idid":"'+it.materia.id+'","denominacion":"'+it.materia.denominacion+'","estadovalue":"'+it.estado+'","estado":"'+it.estado.name+'","tipovalue":"'+it.tipo+'","tipo":"'+it.tipo.name+'","nota":"'+it.nota+'"}'
					flagcoma=true
				}

			}
			materiasSerialized = materiasSerialized + "]"
            return [inscripcionMateriaInstance: inscripcionMateriaInstance,materiasSerialized:materiasSerialized]
        }
    }

    def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"
		
        def inscripcionMateriaInstance = InscripcionMateria.get(params.id)
																	   
        if (inscripcionMateriaInstance) {
	            if (params.version) {
	                def version = params.version.toLong()
	                if (inscripcionMateriaInstance.version > version) {
	                    inscripcionMateriaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'inscripcionMateria.label', default: 'InscripcionMateria')] as Object[], "Another user has updated this InscripcionMateria while you were editing")
	                    render(view: "edit", model: [inscripcionMateriaInstance: inscripcionMateriaInstance])
	                    return 
	                }
	            }
				try{
						inscripcionMateriaService.updateInscripcionMateria(inscripcionMateriaInstance,params)
						flash.message = "${message(code: 'default.updated.message', args: [message(code: 'inscripcionmateria.label', default: 'InscripcionMateria'), inscripcionMateriaInstance.id])}"
						render(view:"show",model:[inscripcionMateriaInstance:inscripcionMateriaInstance])
						return
				}catch(InscripcionMateriaException e){
					log.debug "ERRORES DE VALIDACION: "+e.inscripcionMateria.errors.allErrors
					render (view:"edit", model:[inscripcionMateriaInstance:e.inscripcionMateria,materiasSerialized:params.materiasSerialized])
					return
				}
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'inscripcionMateria.label', default: 'InscripcionMateria'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		log.info "INGRESANDO AL CLOSURE delete"
		log.info "PARAMETROS: $params"

		
        def inscripcionMateriaInstance = InscripcionMateria.get(params.id)
        if (inscripcionMateriaInstance) {
            try {
                inscripcionMateriaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'inscripcionMateria.label', default: 'InscripcionMateria'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'inscripcionMateria.label', default: 'InscripcionMateria'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'inscripcionMateria.label', default: 'InscripcionMateria'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def listjson = {
		log.info "INGRESANDO AL CLOSURE listjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(InscripcionMateria,params,grailsApplication)
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
				
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+(it.alumno.apellidoNombre)+'","'+it.carrera.denominacion+'"]}'
			 
			flagaddcomilla=true
		}
		result=result+']}'
		render result

	}
	
	def listjsonautocomplete={
		log.info "INGRESANDO AL CLOSURE listjsonautocomplete"
		log.info "PARAMETROS: ${params}"
		def list = InscripcionMateria.createCriteria().list(){
				like('nombre','%'+params.term+'%')
		}
		render(contentType:"text/json"){
			array{
				for (obj in list){
					inscripcionmateria id:obj.id,label:obj.nombre,value:obj.nombre
				}
			}
			
		}
	}
	
	def listsearchjson = {
		log.info "INGRESANDO AL METODO listsearchjson"
		log.info "PARAMETROS: ${params}"
		def gud=new GUtilDomainClass(InscripcionMateria,params,grailsApplication)
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
	
	def alumnosinscripcion = {
		log.info "INGRESANDO AL CLOSURE alumnosinscripcion"
		log.info "PARAMETROS: $params"
		
	}
	
	def editjsonmaterias = {
		render ""
	}

	def listjsonmaterias = {
		log.info "INGRESANDO AL CLOSURE listjsonmaterias"
		log.info "PARAMETROS: $params"
		def result="[]"
		
		if(params.id){
			def inscripcionMateriaInstance = InscripcionMateria.load(params.id.toLong())
			if(inscripcionMateriaInstance){
				def list=inscripcionMateriaInstance.detalleMateria
				def totalregistros=list.size()
				
				def totalpaginas=1
				
				result='{"page":'+params.page+',"total":"'+totalpaginas+'","records":"'+totalregistros+'","rows":['
				def flagaddcomilla=false
				list.each{
					
					if (flagaddcomilla)
						result=result+','
						
					
					result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.id+'","'+(it.materia.denominacion)+'","'+it.estado.name+'","'+it.tipo.name+'","'+it.nota+'"]}'
					 
					flagaddcomilla=true
				}
				result=result+']}'
			}else{
				result="[]"
			}
		}
		render result

		
	}

	
}
