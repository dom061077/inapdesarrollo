package com.educacion.academico


import com.educacion.util.GUtilDomainClass
import com.educacion.enums.inscripcion.EstadoPreinscripcion


import java.text.ParseException 
import com.educacion.academico.util.AcademicoUtil
import org.springframework.transaction.TransactionStatus
import com.educacion.enums.inscripcion.TipoInscripcionMateriaEnum
import com.educacion.academico.util.AcademicoUtil
import com.educacion.enums.inscripcion.EstadoInscripcionMateriaDetalleEnum
import com.educacion.enums.inscripcion.EstadoInscripcionMatriculaEnum
import com.educacion.enums.inscripcion.TipoInscripcionMateriaEnum
import com.educacion.enums.inscripcion.OrigenInscripcionMateriaEnum
import com.educacion.enums.SituacionAcademicaEnum
import com.educacion.enums.inscripcion.EstadoInscripcionMateriaEnum



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
		
		log.debug("PREINSCRIPCIONINSTANCE: "+preinscripcionInstance.id)
		
		def anioLectivoInstance = AcademicoUtil.getAnioLectivoCarrera(preinscripcionInstance.carrera.id)
		
		def materiasCursar = AcademicoUtil.getMateriasCursarDisponibles(preinscripcionInstance?.carrera?.id,preinscripcionInstance?.alumno?.id)
		
		log.debug "MATERIAS CURSAR: "+materiasCursar
		
		def flagcomilla = false
		def materiasSerialized = "["
		materiasCursar.each{
			if(flagcomilla)
				materiasSerialized = materiasSerialized + ","
			materiasSerialized = materiasSerialized + '{"id":'+it.id+',"idid":'+it.id+',"nivel":"'+it.nivel.descripcion+'","codigomateria":"'+it.codigo+'","denominacion":"'+it.denominacion+'","tipo":"'+TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR.name+'","tipovalue":"'+TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR+'","seleccion":"Yes"}'
			flagcomilla = true
		}
		materiasSerialized += "]"

		
        def inscripcionMatriculaInstance = new InscripcionMatricula(anioLectivo:anioLectivoInstance,carrera:preinscripcionInstance.carrera
					,alumno:preinscripcionInstance.alumno)
		
        inscripcionMatriculaInstance.properties = params
		
		log.debug "MATERIAS SERIALIZADAS: "+materiasSerialized
		
        return [inscripcionMatriculaInstance: inscripcionMatriculaInstance,materiasSerialized:materiasSerialized]
    }

	def listmateriasjson = {
		log.info "INGRESANDO AL CLOSURE listmateriasjson"
		log.info "PARAMETROS: $params"
		def inscripcionMatriculaInstance = InscripcionMatricula.get(params.id)
        def totalregistros = 0
        inscripcionMatriculaInstance.inscripcionesmaterias.each {inscmateria ->
            if (inscmateria.estado!=EstadoInscripcionMateriaEnum.ESTADOINSMAT_ANULADA)
                inscmateria.detalleMateria.each{detmat ->
                    totalregistros += 1
                }
        }
		def result='{"page":1,"total":"1","records":"'+totalregistros+'","rows":['
		def flagaddcomilla=false
        inscripcionMatriculaInstance.inscripcionesmaterias.each {inscmateria ->
            if (inscmateria.estado!=EstadoInscripcionMateriaEnum.ESTADOINSMAT_ANULADA)
                inscmateria.detalleMateria.each{detmat ->
                            if (flagaddcomilla)
                                result=result+','
                            result=result+'{"id":"'+detmat.id+'","cell":["'+detmat.id+'","'+(detmat.materia.denominacion==null?"":detmat.materia.denominacion)+'"]}'
                            flagaddcomilla=true
                }
        }

		result=result+']}'
		render result
	}
	
    def save = {
		log.info "INGRESANDO AL CLOSURE save"
		log.info "PARAMETROS: $params"
		def materiasSerializedJson
		
		if(params.materiasSerialized)
			materiasSerializedJson = grails.converters.JSON.parse(params.materiasSerialized);
			
		
        def inscripcionMatriculaInstance = new InscripcionMatricula(params)
		inscripcionMatriculaInstance.estado = EstadoInscripcionMatriculaEnum.ESTADOINSMAT_GENERADA
		
		if(!materiasSerializedJson || materiasSerializedJson.size()==0){
            inscripcionMatriculaInstance.errors.rejectValue("inscripcionesmaterias", "com.educacion.academico.InscripcionMateria.materias.blank.error")
			render(view:"create",model:[inscripcionMatriculaInstance:inscripcionMatriculaInstance,materiasSerialized:params.materiasSerialized])
			return
		}
			
		
		InscripcionMatricula.withTransaction{TransactionStatus status ->
			
			
			def materiaAntInstance
			def materiaInstance
			def inscripcionMateriaDetalleInstance
            def flagInsMatRegular=false
			def inscripcionMateriaInstance = new InscripcionMateria(carrera:inscripcionMatriculaInstance.carrera
					,origen: OrigenInscripcionMateriaEnum.ORIGENINSCMATERIA_ENMATRICULA
					,anioLectivo:inscripcionMatriculaInstance.anioLectivo,alumno:inscripcionMatriculaInstance.alumno)
			materiasSerializedJson?.each {
				if(it.seleccion.toUpperCase().equals("YES")){
					if(TipoInscripcionMateriaEnum."${it.tipovalue}"==TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR)
                            flagInsMatRegular = true
					if(AcademicoUtil.validarCorrelatividades(it.idid.toLong(),TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR,inscripcionMateriaInstance.alumno.id)){
						 materiaInstance = Materia.load(it.idid.toLong())
						 if(materiaInstance.equals(materiaAntInstance)){
							 inscripcionMateriaInstance.errors.rejectValue("detalleMateria", "com.educacion.academico.InscripcionMateriaDetalle.materia.unique.error"
								 ,[materiaInstance.denominacion] as Object[],"Error de validacion materia repetida")
						 }else{
							 inscripcionMateriaDetalleInstance = new InscripcionMateriaDetalle(materia:materiaInstance
								 ,estado:EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_INSCRIPTO
								 ,tipo:TipoInscripcionMateriaEnum."${it.tipovalue}"
								 )
							 inscripcionMateriaInstance.addToDetalleMateria(inscripcionMateriaDetalleInstance)
						 }
						 
					}
				}
				materiaAntInstance=materiaInstance
			}
			
			inscripcionMatriculaInstance.addToInscripcionesmaterias(inscripcionMateriaInstance)	
            if (flagInsMatRegular)
               inscripcionMatriculaInstance.alumno.estadoAcademico = SituacionAcademicaEnum.SITACADE_REGULAR
		
	        if (inscripcionMatriculaInstance.save(flush: true)) {
	            flash.message = "${message(code: 'default.created.message', args: [message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula'), inscripcionMatriculaInstance.id])}"
	            redirect(action: "show", id: inscripcionMatriculaInstance.id,params:[idinscmateria: inscripcionMateriaInstance.id ])
	        }
	        else {
	            render(view:"create",model:[inscripcionMatriculaInstance:inscripcionMatriculaInstance,materiasSerialized:params.materiasSerialized])
	        }
		}
    }

    def show = {
		log.info "INGRESANDO AL CLOSURE show"
		log.info "PARAMETROS: $params"
		def idinscmateria
		

		
        def inscripcionMatriculaInstance = InscripcionMatricula.get(params.id)

        if (!inscripcionMatriculaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula'), params.id])}"
            redirect(action: "list")
        }
        else {
			//if(params.idinscmateria){
			//	idinscmateria = params.idinscmateria
			//}else{
				def inscripcionMateriaInstance
				inscripcionMatriculaInstance.inscripcionesmaterias.each{
					if(it.origen == OrigenInscripcionMateriaEnum.ORIGENINSCMATERIA_ENMATRICULA)
						idinscmateria = it.id
				}
			//}
			//if(idinscmateria)
            	[inscripcionMatriculaInstance: inscripcionMatriculaInstance,idinscmateria:idinscmateria]
			//else{
			//	flash.message = g.message(code:"com.educacion.inscripcion.InscripcionMatricula.error.inscripcionmateria")
			//	redirect(action:"list")
			//}
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
			def materiasCursar = AcademicoUtil.getMateriasCursarDisponibles(inscripcionMatriculaInstance?.carrera?.id,inscripcionMatriculaInstance?.alumno?.id)
			
			def flagcomilla = false
			def flagseleccionado
			def idinscmatdetalle
            def tipo
            def tipovalue
			def materiasSerialized = "["
			materiasCursar.each{ matcursar->
				if(flagcomilla)
					materiasSerialized = materiasSerialized + ","
				flagseleccionado="No"
				idinscmatdetalle = 0
				inscripcionMatriculaInstance.inscripcionesmaterias.each{inscmateria ->
					if (inscmateria.origen == OrigenInscripcionMateriaEnum.ORIGENINSCMATERIA_ENMATRICULA){
						inscmateria.detalleMateria.each{detinsc->  
							if(detinsc.materia.id==matcursar.id){
								flagseleccionado="Yes"
								idinscmatdetalle = detinsc.id
                                tipo = detinsc.tipo.name
                                tipovalue = detinsc.tipo
								return
							}
						}
						return
					}
				}	
				materiasSerialized = materiasSerialized + '{"id":'+matcursar.id+',"idid":'+idinscmatdetalle+',"idmateria":'+matcursar.id+',"nivel":"'+matcursar.nivel.descripcion+'","codigomateria":"'+matcursar.codigo+'","denominacion":"'+matcursar.denominacion+'","tipo":"'+(tipo!=null?tipo:TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR.name)+'","tipovalue":"'+(tipovalue!=null?tipovalue:TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR)+'","seleccion":"'+flagseleccionado+'"}'
				flagcomilla = true
			}
			materiasSerialized += "]"

            return [inscripcionMatriculaInstance: inscripcionMatriculaInstance,materiasSerialized:materiasSerialized]
        }
    }

    def update = {
		log.info "INGRESANDO AL CLOSURE update"
		log.info "PARAMETROS: $params"
		def materiasSerializedJson
		
		if(params.materiasSerialized)
			materiasSerializedJson = grails.converters.JSON.parse(params.materiasSerialized);

		
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
			InscripcionMatricula.withTransaction{TransactionStatus status ->
	            //inscripcionMatriculaInstance.properties = params
                inscripcionMatriculaInstance.estado = EstadoInscripcionMatriculaEnum.ESTADOINSMAT_CONFIRMADA
				
				//------modificacion del detalle de la inscripcion de materias dentro de la matricula--
				/*
				def materiaAntInstance
				def materiaInstance
				def inscripcionMateriaDetalleInstance
				def inscripcionMateriaInstance 
				inscripcionMatriculaInstance.inscripcionesmaterias.each{inscmat->
					if(inscmat.origen == OrigenInscripcionMateriaEnum.ORIGENINSCMATERIA_ENMATRICULA)
						inscripcionMateriaInstance = inscmat
				}


				materiasSerializedJson?.each {
					if(it.seleccion.toUpperCase().equals("YES")){
						materiaInstance = Materia.load(it.idmateria.toLong())
						if(AcademicoUtil.validarCorrelatividades(it.idmateria.toLong(),TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR,inscripcionMateriaInstance.alumno.id)){
							 
							 if(materiaInstance.equals(materiaAntInstance)){
								 inscripcionMateriaInstance.errors.rejectValue("detalleMateria", "com.educacion.academico.InscripcionMateriaDetalle.materia.unique.error"
									 ,[materiaInstance.denominacion] as Object[],"Error de validacion materia repetida")
							 }else{
							 	 if(it.idid.toInteger()==0){
									 inscripcionMateriaDetalleInstance = new InscripcionMateriaDetalle(materia:materiaInstance
										 ,estado:EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_INSCRIPTO
										 ,tipo:TipoInscripcionMateriaEnum."${it.tipovalue}"
										 )
									 inscripcionMateriaInstance.addToDetalleMateria(inscripcionMateriaDetalleInstance)
							 	 }else{
                                     inscripcionMateriaDetalleInstance = InscripcionMateriaDetalle.get(it.idid);
                                     inscripcionMateriaDetalleInstance.tipo=TipoInscripcionMateriaEnum."${it.tipovalue}"

                                 }
							 }
							 materiaAntInstance=materiaInstance
						}else{
							inscripcionMateriaInstance.errors.rejectValue("detalleMateria","Error de correlatividad en la materia "+materiaInstance.denominacion)
						}
					}else{
						if(it.idid.toInteger()>0){
							inscripcionMateriaDetalleInstance = InscripcionMateriaDetalle.get(it.idid);
							inscripcionMateriaInstance.removeFromDetalleMateria(inscripcionMateriaDetalleInstance)
							inscripcionMateriaDetalleInstance.delete()
						}
						
					}
					
				}
	            */
				
	            if (!inscripcionMatriculaInstance.hasErrors() && inscripcionMatriculaInstance.save() /*&& 
					!inscripcionMateriaInstance.hasErrors() && inscripcionMateriaInstance.save(flush:true)*/) {
	                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula'), inscripcionMatriculaInstance.id])}"
	                redirect(action: "show", id: inscripcionMatriculaInstance.id)
	            }
	            else {
					status.setRollbackOnly()
	                render(view: "edit", model: [inscripcionMatriculaInstance: inscripcionMatriculaInstance,materiasSerialized:params.materiasSerialized,inscripcionMateriaInstance:inscripcionMateriaInstance])
	            }
			}
				
        }
        else {
			log.debug "SALE POR LA VALIDACION DE SI ENCUENTRA LA MATRICULA"
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
		log.info "INGRESANDO AL CLOSURE delete"
		log.info "PARAMETROS: $params"

		
        def inscripcionMatriculaInstance = InscripcionMatricula.get(params.id)
        if (inscripcionMatriculaInstance) {
            inscripcionMatriculaInstance.inscripcionesmaterias.each { insmat ->
                if (insmat.estado!=EstadoInscripcionMateriaEnum.ESTADOINSMAT_ANULADA){
                    flash.message = "${message(code: "default.not.anulado.message",args: ["Matrícula","Tiene inscripciones sin anular"])}"
                    render(view: "show",model:[inscripcionMatriculaInstance])
                    return
                }
            }
            InscripcionMatricula.withTransaction {TransactionStatus status ->
                //TODO agregar la validacion de integridad con los examenes asinados a los detalles de la inscripcion de materia
                /*inscripcionMatriculaInstance.inscripcionesmaterias.each{
                    it.estado = EstadoInscripcionMateriaEnum.ESTADOINSMAT_ANULADA
                }*/
                if(inscripcionMatriculaInstance.primeraMatricula){
                    def listInscMatriculas = InscripcionMatricula.createCriteria().list{
                        anioLectivo{
                            eq("id",inscripcionMatriculaInstance.anioLectivo.id)
                        }
                        carrera{
                            eq("id",inscripcionMatriculaInstance.carrera.id)
                        }
                        alumno{
                            eq("id",inscripcionMatriculaInstance.alumno.id)
                        }
                        ne("estado",EstadoInscripcionMatriculaEnum.ESTADOINSMAT_ANULADA)
                    }
                    inscripcionMatriculaInstance.estado = EstadoInscripcionMatriculaEnum.ESTADOINSMAT_GENERADA
                }else{
                    inscripcionMatriculaInstance.estado = EstadoInscripcionMatriculaEnum.ESTADOINSMAT_INICIADA
                }


                def preinscripcionInstance = Preinscripcion.find("from Preinscripcion where inscripcionMatricula.id=:id",[id:inscripcionMatriculaInstance.id])
                if (preinscripcionInstance.estado==EstadoPreinscripcion.ESTADO_INSCRIPTO)
                    preinscripcionInstance.estado = EstadoPreinscripcion.ESTADO_PREINSCRIPTO
                if (preinscripcionInstance.estado==EstadoPreinscripcion.ESTADO_INSCRIPTOSUPLENTE)
                    preinscripcionInstance.estado = EstadoPreinscripcion.ESTADO_PREINSCRIPTOSUPLENTE
                if (preinscripcionInstance.estado==EstadoPreinscripcion.ESTADO_INSCRIPTOASPIRANTE)
                    preinscripcionInstance.estado = EstadoPreinscripcion.ESTADO_ASPIRANTE
                if (preinscripcionInstance.estado==EstadoPreinscripcion.ESTADO_INSCRIPTOASPIRANTESUPLENTE)
                    preinscripcionInstance.estado = EstadoPreinscripcion.ESTADO_ASPIRANTESUPLENTE
                
                
                inscripcionMatriculaInstance.save()  
                preinscripcionInstance.save()
                flash.message = "${message(code: 'default.anulado.message', args: [message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula'), params.id])}"
                redirect(action: "list")


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

        params._search="true"
        params.altfilters='{"groupOp":"AND","rules":[{"field":"estado","op":"ne","data":"ESTADOINSMAT_INICIADA"}]}'
        //params.altfilters='{"groupOp":"AND","rules":[{"field":"estado","op":"eq","data":"ESTADOINSMAT_CONFIRMADA"}]}'

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
				
			
			result=result+'{"id":"'+it.id+'","cell":["'+it.id+'","'+it.alumno.apellido+'","'+it.alumno.nombre+'","'+g.formatDate(date:it.fechaAlta,format:"dd/MM/yyyy")+'","'+it.carrera.denominacion+'","'+it.anioLectivo.anioLectivo+'","'+it.estado.name+'"]}'
			 
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


    def private requisitospendientes(def preinscripcionId){
        def requisitosCumplidos
        return null
    }


    def editmaterias ={
        render ""
    }
	

	
}
