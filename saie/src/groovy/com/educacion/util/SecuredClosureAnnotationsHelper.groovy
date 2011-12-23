package com.educacion.util


import org.apache.commons.lang.WordUtils
import org.codehaus.groovy.grails.commons.ApplicationHolder as AH
import com.educacion.annotations.SecuredRequest;


class SecuredClosureAnnotationsHelper {
	static def listRequestmap(def grailsApplication_,def log){
		log.info "INGRESANDO AL METODO: listRequestmap"
		def requests = []
		grailsApplication_.controllerClasses.each{
			def clazz = it.getClazz()
			if(findAnnotatedClosures(clazz,log,SecuredRequest))
				requests.add(findAnnotatedClosures(com.educacion.academico.RequisitoController.class,log,SecuredRequest.class))
		}
		log.debug "CANTIDAD DE REQUESTS: "+requests.size()
		return requests
	}
	
	private static Map<String, List<Class>> findAnnotatedClosures(Class clazz,def log, Class annotationClass) {
		def map = [:]
		for (field in clazz.declaredFields) {
		  log.debug "DENTRO DEL FOR field in clazz.declaredFields"
		  def fieldAnnotations = []
		  log.debug "	Field Nombre: "+field
		  
		  if (field.isAnnotationPresent(SecuredRequest)) {
			  log.debug "				TIENE UNA ANOTACION"
			  fieldAnnotations << annotationClass
		  }
		  if (fieldAnnotations) {
			map[field.name] = fieldAnnotations
		  }
		}
	}
}
