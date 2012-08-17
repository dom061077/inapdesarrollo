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
                        or{
                            eq("estado",EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_INSCRIPTO)
                            eq("estado",EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_REGULAR)
                            eq("estado",EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_APROBADA)
                        }
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
				/*if(list.size()==0){
					flagvalidacion = true
					inscripcionMateriaInstance.errors.rejectValue("detalleMateria", "com.educacion.academico.InscripcionMateriaDetalle.materia.blank.error"
						,[EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_REGULAR.name,matreg.denominacion] as Object[],"Error de validacion de correlatividad")
				}
				if(list.size()>1){
					flagvalidacion = true
					inscripcionMateriaInstance.errors.rejectValue("detalleMateria", "com.educacion.academico.InscripcionMateriaDetalle.inscripcion.maxsize"
						,[EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_REGULAR.name,matreg.denominacion] as Object[],"Error de validacion de correlatividad")
				}*/
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
				/*if(list.size()==0){
					flagvalidacion = true
					inscripcionMateriaInstance.errors.rejectValue("detalleMateria", "com.educacion.academico.InscripcionMateriaDetalle.materia.blank.error"
						,[EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_APROBADA.name,mataprob.denominacion] as Object[],"Error de validacion de correlatividad")
				}
				if(list.size()>1){
					flagvalidacion = true
					inscripcionMateriaInstance.errors.rejectValue("detalleMateria", "com.educacion.academico.InscripcionMateriaDetalle.inscripcion.maxsize"
						,[EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_APROBADA.name,mataprob.denominacion] as Object[],"Error de validacion de correlatividad")
				}*/
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

        if(list)
            return list?.get(0)
        else
            null
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

	
	private static def  getMateriasCursarDisponibles(def idCarrera,def idAlumno,def mostrarinscriptas){
		log.info("INGRESANDO AL METODO PRIVADO getMateriasCursarDisponibles")
		log.info("INGRESANDO CARRERA: "+idCarrera+" alumno: "+idAlumno)
        def cantMaxInsc

        if(mostrarinscriptas)
            cantMaxInsc=1
        else
            cantMaxInsc=0

		def materiasDisponibles = new ArrayList();
		def materias = Materia.createCriteria().list{
			and{
				nivel{
					carrera{
							eq("id",idCarrera)
					}
                    //eq("esprimernivel",false)
				}
			}
		}
		materias.each{mat ->
			log.debug "Materias: "+mat.denominacion
			if(validarCorrelatividades(mat.id,idAlumno,TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR)){
                //----si la validacion de correlatividades pasa, el siguiente paso es determinar ya existe una inscripcion-----------
                def list = InscripcionMateriaDetalle.createCriteria().list{
                    and{
                        inscripcionMateria{
                            and{
                                alumno{
                                    eq("id",idAlumno)
                                }
                                ne("estado",EstadoInscripcionMateriaEnum.ESTADOINSMAT_ANULADA)
                            }
                        }
                        eq("tipo",TipoInscripcionMateriaEnum.TIPOINSMATERIA_CURSAR)
                        ne("estado",EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_DESAPROBADA)
                        ne("estado",EstadoInscripcionMateriaDetalleEnum.ESTADOINSMAT_AUSENTE)
                        materia{
                            eq("id",mat.id)
                        }
                    }
                }
                if(list?.size()>cantMaxInsc){
                }
                else
    				materiasDisponibles.add(mat)
            }
		}
		return materiasDisponibles
	}

    public static def formatDateParms(def field,def params){
        if (params."$field"){
            if (params."$field".length()<10){
                params."${field+"_year"}"="0"
                params."${field+"_month"}"="0"
                params."${field+"_day"}"="0"
            }else{
                params."${field+"_year"}"=params."${field}".substring(6,10)
                params."${field+"_month"}"=params."${field}".substring(3,5)
                params."${field+"_day"}"=params."${field}".substring(0,2)
            }
            try{
                if(params.fechaNacimiento_month.toInteger()>12)
                    params."${field+"_month"}"="0"
                if(params.fechaNacimiento_day.toInteger()>31){
                    params."${field+"_day"}"="0"
                }
            }catch(NumberFormatException e){
                params."${field+"_year"}"="0"
                params."${field+"_month"}"="0"
                params."${field+"_day"}"="0"

            }

        }

    }



	
}
