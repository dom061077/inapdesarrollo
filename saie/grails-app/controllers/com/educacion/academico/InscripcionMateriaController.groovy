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
import com.educacion.enums.inscripcion.OrigenInscripcionMateriaEnum
import com.educacion.enums.inscripcion.EstadoInscripcionMateriaEnum


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
		def materias = getMateriasCursarDisponibles(params.carreraId.toLong(),params.alumnoId.toLong(),0)
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
		
		def matriculas
		def inscripcionMatriculaInstance
		if(params.id){
			
			inscripcionMatriculaInstance = InscripcionMatricula.get(params.id)

			
			def materiasSerialized
			def materiasCursar = AcademicoUtil.getMateriasCursarDisponibles(inscripcionMatriculaInstance.carrera.id,inscripcionMatriculaInstance.alumno.id,0)
			
			def flagcomilla = false
			materiasSerialized = "["
			materiasCursar.each{
				if(flagcomilla)
					materiasSerialized = materiasSerialized + ","
				materiasSerialized = materiasSerialized + '{"id":'+it.id+',"idid":'+it.id+',"nivel":"'+it.nivel.descripcion+'","codigomateria":"'+it.codigo+'","denominacion":"'+it.denominacion+'","tipo":"'+TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR.name+'","tipovalue":"'+TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR+'","seleccion":"Yes"}'
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
				if(inscripcionMatriculaInstance){
                   if (inscripcionMatriculaInstance.estado!=EstadoInscripcionMatriculaEnum.ESTADOINSMAT_CONFIRMADA &&
                        inscripcionMatriculaInstance.estado!=EstadoInscripcionMatriculaEnum.ESTADOINSMAT_PAGADA ){
                       flash.message = "No puede realizar la operación, la matrícula debe estar "+EstadoInscripcionMatriculaEnum.ESTADOINSMAT_CONFIRMADA.name+" o "+" "+EstadoInscripcionMatriculaEnum.ESTADOINSMAT_PAGADA.name
                       render(view:"alumnosinscripcion",model:[])
                       return
                   }
			       def inscripcionMateriaInstance = new InscripcionMateria(alumno:inscripcionMatriculaInstance.alumno
					   		,carrera:inscripcionMatriculaInstance.carrera      
							,anioLectivo:inscripcionMatriculaInstance.anioLectivo   
							,inscripcionMatricula:inscripcionMatriculaInstance                                                     
							//,preinscripcion:preinscripcionInstance,anioLectivo:preinscripcionInstance.anioLectivo
							)
			        return [inscripcionMateriaInstance: inscripcionMateriaInstance,materiasSerialized: materiasSerialized]
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
		
		def inscripcionMatriculaInstance = InscripcionMatricula.get(params.inscripcionMatricula.id)
		if(params.incripcionMatriculaVersion)
			if(inscripcionMatriculaInstance.version>params.incripcionMatriculaVersion.toLong()){
				inscripcionMateriaInstance.preinscripcion = inscripcionMatriculaInstance
				inscripcionMateriaInstance.carrera = inscripcionMatriculaInstance.carrera
				inscripcionMateriaInstance.alumno = inscripcionMatriculaInstance.alumno
				inscripcionMateriaInstance.anioLectivo = inscripcionMatriculaInstance.anioLectivo
				inscripcionMateriaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'inscripcionMateria.label', default: 'InscripcionMateria')] as Object[], "Another user has updated this InscripcionMateria while you were editing")
				render(view:"create",model:[inscripcionMateriaInstance:inscripcionMateriaInstance])
				return
			}
			
				
		
		//if(preinscripciones){
		
		
			
			try{
				inscripcionMateriaService.saveInscripcionMateria(inscripcionMateriaInstance,params)
				flash.message = "${message(code: 'default.created.message', args: [message(code: 'inscripcionMateria.label', default: 'Inscripcion Materia'), inscripcionMateriaInstance.id])}"
				render(view:"show",model:[inscripcionMateriaInstance:inscripcionMateriaInstance])
				return
			}catch(InscripcionMateriaException e){
				log.debug("ERROR DE VALIDACION: "+inscripcionMateriaInstance.errors.allErrors)
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
		
		def inscripcionMateriaInstance = InscripcionMateria.get(params.id)
        if (!inscripcionMateriaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'inscripcionMateria.label', default: 'InscripcionMateria'), params.id])}"
            redirect(action: "list")
        }
        else {
			
            if (inscripcionMateriaInstance.estado!=EstadoInscripcionMateriaEnum.ESTADOINSMAT_CREADA){
                flash.message = "${message(code: 'com.educacion.academico.inscripcionMateria.estado.confirmada.error')}"
                redirect(action: list)
                return 
            }

			def materiasSerialized
			def materiasCursar = AcademicoUtil.getMateriasCursarDisponibles(inscripcionMateriaInstance.carrera.id,inscripcionMateriaInstance.alumno.id,1)
			
			def flagcomilla = false
			def flagseleccionado
			def idinscmatdetalle
            def tipo
            def tipovalue

			materiasSerialized = "["
			materiasCursar.each{matcursar->
				if(flagcomilla)
					materiasSerialized = materiasSerialized + ","
				flagseleccionado="No"
				idinscmatdetalle = 0
                tipo = TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR.name
                tipovalue = TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR
				inscripcionMateriaInstance.detalleMateria.each{detinsc->
					if(detinsc.materia.id==matcursar.id){
						flagseleccionado="Yes"
						idinscmatdetalle = detinsc.id
                        tipo = detinsc.tipo.name
                        tipovalue = detinsc.tipo
						return
					}
				}

				//materiasSerialized = materiasSerialized + '{"id":'+it.id+',"idid":'+it.id+',"denominacion":"'+it.denominacion+'","seleccion":"Yes"}'
				materiasSerialized = materiasSerialized + '{"id":'+matcursar.id+',"idid":'+idinscmatdetalle+',"idmateria":'+matcursar.id+',"nivel":"'+matcursar.nivel.descripcion+'","codigomateria":"'+matcursar.codigo+'","denominacion":"'+matcursar.denominacion+'","tipo":"'+tipo+'","tipovalue":"'+tipovalue+'","seleccion":"'+flagseleccionado+'"}'
				flagcomilla = true
			}
			materiasSerialized += "]"
			
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
            /*try {
                inscripcionMateriaInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'inscripcionMateria.label', default: 'InscripcionMateria'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'inscripcionMateria.label', default: 'InscripcionMateria'), params.id])}"
                redirect(action: "show", id: params.id)
            } */

            //TODO agregar la validacion de integridad antes de anular
            /*def cantInscMaterias = InscripcionMateria.createCriteria().get {
                    inscripcionMatricula{
                        eq("id",inscripcionMateriaInstance.inscripcionMatricula.id)
                    }
                    ne("estado",EstadoInscripcionMateriaEnum.ESTADOINSMAT_ANULADA)
                    projection{
                        rowCount()
                    }
                }
                if (cantInscMaterias>1)
                    inscripcionMateriaInstance.errors.rejectValue("origen", "com.educacion.academico.InscripcionMateriaInstance.origen.anular.error")
            */
            inscripcionMateriaInstance.estado = EstadoInscripcionMateriaEnum.ESTADOINSMAT_ANULADA
            if (!inscripcionMateriaInstance.hasErrors() && inscripcionMateriaInstance.save()){
                flash.message = "${message(code: 'default.anulado.message', args: [message(code: 'inscripcionMateria.label', default: 'InscripcionMateria'), params.id])}"
                redirect(action: "list")
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

        params.altfilters = '{"groupOp":"AND","rules":[{"field":"inscripcionMatricula_estado","op":"ne","data":"ESTADOINSMAT_INICIADA"},{"field":"inscripcionMatricula_estado","op":"ne","data":"ESTADOINSMAT_GENERADA"},{"field":"estado","op":"ne","data":"ESTADOINSMAT_ANULADA"}]}'
        params._search = "true"

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
				
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.alumno.apellido+'","'+it.alumno.nombre+'","'+it.carrera.denominacion+'","'+it.anioLectivo.anioLectivo+'","'+it.inscripcionMatricula.estado.name+'","'+it.estado.name+'"]}'
			 
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
						
					
					result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.id+'","'+it.materia.nivel.descripcion+'","'+it.materia.codigo+'","'+it.materia.denominacion+'","'+it.estado.name+'","'+it.tipo.name+'","'+it.nota+'"]}'
					 
					flagaddcomilla=true
				}
				result=result+']}'
			}else{
				result="[]"
			}
		}
		render result

		
	}

    def listdetalleinscripcion = {
        log.info "INGRESANDO AL CLOSURE listdetalleinscripcion"
        log.info "PARAMETROS: $params"
        if(params.carrera){
            def anioLectivoInstance = AcademicoUtil.getAnioLectivoCarrera(params.carrera.toLong())
            def list = InscripcionMateriaDetalle.createCriteria().list{
                 inscripcionMateria{
                     anioLectivo{
                         eq("id",anioLectivoInstance.id)
                     }
                     carrera{
                         eq("id",params.carrera.toLong())
                     }
                 }
                 materia{
                     nivel{
                         eq("id",params.nivel.toLong())
                     }
                 }
            }

            def totalregistros=list.size()

            def totalpaginas=1

            result='{"page":'+params.page+',"total":"'+totalpaginas+'","records":"'+totalregistros+'","rows":['
            def flagaddcomilla=false
            list.each{

                if (flagaddcomilla)
                    result=result+','


                result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.id+'","'+it.materia.nivel.descripcion+'","'+it.materia.codigo+'","'+it.materia.denominacion+'","'+it.estado.name+'","'+it.tipo.name+'","'+it.nota+'"]}'

                flagaddcomilla=true
            }
            result=result+']}'
        }else
            render "[]"
    }

    def editmaterias = {
        render ""
    }


    def reportepreinscripcion = {
        log.info "INGRESANDO AL CLOSURE reportepreinscripcion"
        log.info "PARAMETROS $params"

        params.put("provincianombre", g.message(code:"caratula.institucion.provincia"))

        def inscripcionMateriaInstance = InscripcionMateria.get(params.id)
        def list = new ArrayList()

        if (inscripcionMateriaInstance) {
            def materias = new ArrayList()
            materias.addAll(inscripcionMateriaInstance.detalleMateria)
            def materiasIz
            def materiasDer
            if (materias?.size()>7){
                materiasIz = materias.subList(0,7)
                materiasDer = materias.subList(8,materias.size()-1)
            }else
                materiasIz = materias
            inscripcionMateriaInstance.alumno.apellido
            list.add([inscripcionMateriaInstance,materiasIz,materiasDer])

            params.put("SUBREPORT_DIR",servletContext.getRealPath("/reports/preinscripcion/"))
            params.put("_format","PDF")

            params.put("_name","reportepreinscripcion")
            params.put("_file","preinscripcion/reportepreinscripcion")
            chain(controller:'jasper', action:'index', model:[data:list], params:params)


        } else {
            redirect(action: "list")
        }

    }

	
}
