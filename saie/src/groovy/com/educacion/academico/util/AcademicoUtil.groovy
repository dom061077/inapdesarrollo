package com.educacion.academico.util

import org.apache.log4j.Logger;
import com.educacion.academico.*
import com.educacion.enums.inscripcion.*

class AcademicoUtil {
	private static Logger log = Logger.getLogger(AcademicoUtil.class)
	
	private static def validarCorrelatividades(Long idMat,def idAlu,def tipoInscripcion){
		def flagvalidacion = true //si le falta alguna materia la bandera sera false
		def materiaInstance = Materia.load(idMat)
		def list
		if(tipoInscripcion.equals(TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR)){
			materiaInstance.matregcursar.each {matreg->
				list = InscripcionMateriaDetalle.createCriteria().list{
					and{
						inscripcionMateria{
							alumno{
								eq("id",idAlu)
							}
						}
						eq("estado",EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_REGULAR)
						materia{
							eq("id",matreg.id)
						}
					}
				}
				if(list.size()==0){
					flagvalidacion = false
				}
				if(list.size()>1){
					flagvalidacion = false
				}
			}
			
			materiaInstance.mataprobcursar.each{mataprob->
				list = InscripcionMateriaDetalle.createCriteria().list{
					and{
						inscripcionMateria{
							alumno{
								eq("id",idAlu)
							}
						}
						eq("estado",EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_APROBADA)
						materia{
							eq("id",mataprob.id)
						}
					}
				}
				if(list.size()==0){
					flagvalidacion = false
				}
				if(list.size()>1){
					flagvalidacion = false
				}
			}
		}
		
		
		if(tipoInscripcion.equals(TipoInscripcionMateriaEnum.TIPOINSMATERIA_RENDIRFINAL) || tipoInscripcion.equals(TipoInscripcionMateriaEnum.TIPOINSMATERIA_RENDIRLIBRE)){
			materiaInstance.matregrendir.each {matreg->
				list = InscripcionMateriaDetalle.createCriteria().list{
					and{
						inscripcionMateria{
							alumno{
								eq("id",idAlu)
							}
						}
						eq("estado",EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_REGULAR)
						materia{
							eq("id",matreg.id)
						}
					}
				}
				if(list.size()==0){
					flagvalidacion = true
					inscripcionMateriaInstance.errors.rejectValue("detalleMateria", "com.educacion.academico.InscripcionMateriaDetalle.materia.blank.error"
						,[EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_REGULAR.name,matreg.denominacion] as Object[],"Error de validacion de correlatividad")
				}
				if(list.size()>1){
					flagvalidacion = true
					inscripcionMateriaInstance.errors.rejectValue("detalleMateria", "com.educacion.academico.InscripcionMateriaDetalle.inscripcion.maxsize"
						,[EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_REGULAR.name,matreg.denominacion] as Object[],"Error de validacion de correlatividad")
				}
			}
			
			
			materiaInstance.mataprobrendir.each{mataprob->
				list = InscripcionMateriaDetalle.createCriteria().list{
					and{
						inscripcionMateria{
							alumno{
								eq("id",idAlu)
							}
						}
						eq("estado",EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_APROBADA)
						materia{
							eq("id",mataprob.id)
						}
					}
				}
				if(list.size()==0){
					flagvalidacion = true
					inscripcionMateriaInstance.errors.rejectValue("detalleMateria", "com.educacion.academico.InscripcionMateriaDetalle.materia.blank.error"
						,[EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_APROBADA.name,mataprob.denominacion] as Object[],"Error de validacion de correlatividad")
				}
				if(list.size()>1){
					flagvalidacion = true
					inscripcionMateriaInstance.errors.rejectValue("detalleMateria", "com.educacion.academico.InscripcionMateriaDetalle.inscripcion.maxsize"
						,[EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_APROBADA.name,mataprob.denominacion] as Object[],"Error de validacion de correlatividad")
				}
			}
		}
		return flagvalidacion
	}


	public static def getAnioLectivoCarrera(def id){
		def hql = """
				FROM AnioLectivo a WHERE a.anioLectivo = (SELECT MAX(anioLectivo) FROM AnioLectivo anio WHERE anio.carrera.id = :carrera )
		"""
		def list
		if(id!=null)
			list = AnioLectivo.executeQuery(hql,["carrera":id]);
		else{
			
		}
				
		def anioLectivoInstance = list?.get(0)
	}
	
	private static def validaMateriaCursar(def materiaInstance,def idAlu){
		log.info("INGRESANDO AL METODO PRIVADO validaCur                                                                                                                                                                                     sar")
		def flagvalidacion = false //si le falta alguna materia la bandera sera true
		def list
		materiaInstance.matregcursar.each {matreg->
			list = InscripcionMateriaDetalle.createCriteria().list{
				and{
					inscripcionMateria{
						alumno{
							eq("id",idAlu)
						}
					}
					eq("estado",EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_REGULAR)
					materia{
						eq("id",matreg.id)
					}
				}
			}
			if(list.size()==0){
				flagvalidacion = true
			}
			if(list.size()>1){
				flagvalidacion = true
			}
		}
		
		materiaInstance.mataprobcursar.each{mataprob->
			list = InscripcionMateriaDetalle.createCriteria().list{
				and{
					inscripcionMateria{
						alumno{
							eq("id",idAlu)
						}
					}
					eq("estado",EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_APROBADA)
					materia{
						eq("id",mataprob.id)
					}
				}
			}
			if(list.size()==0){
				flagvalidacion = true
			}
			if(list.size()>1){
				flagvalidacion = true
			}
		}
		
		if(materiaInstance.matregcursar.size()==0 && materiaInstance.mataprobcursar.size()==0 )
			flagvalidacion=true
		
		return flagvalidacion

	}

	
	private static def  getMateriasCursarDisponibles(def idCarrera,def idAlumno){
		log.info("INGRESANDO AL METODO PRIVADO getMateriasCursarDisponibles")
		log.info("INGRESANDO CARRERA: "+idCarrera+" alumno: "+idAlumno)
		def materiasDisponibles = new ArrayList();
		def materias = Materia.createCriteria().list{
			and{
				nivel{
					carrera{
							eq("id",idCarrera)
					}
				}
			}
		}
		materias.each{mat ->
			log.debug "Materias: "+mat.denominacion
			if(validarCorrelatividades(mat.id,idAlumno,TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR))
				materiasDisponibles.add(mat)
		}
		return materiasDisponibles
	}

	

	
}
