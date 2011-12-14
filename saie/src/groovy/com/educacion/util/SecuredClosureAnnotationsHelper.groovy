package com.educacion.util


import org.apache.commons.lang.WordUtils
import org.codehaus.groovy.grails.commons.ApplicationHolder as AH
import com.educacion.annotations.SecuredRequest;


class SecuredClosureAnnotationsHelper {
	static def listRequestmap(def grailsApplication_,def log){
		log.info "INGRESANDO AL METODO: listRequestmap"
		def requests = []
		def map
		grailsApplication_.controllerClasses.each{
			def clazz = it.getClazz()
			map = findAnnotatedClosures(clazz,SecuredRequest)
			log.debug "MAP DEVUELTO PARA INDAGAR SUS ANOTACIONES"
			if(map)
				requests.add(map)
		}
		log.debug "CANTIDAD DE REQUESTS: "+requests.size()
		return requests
	}
	
	private static Map<String, List<Class>> findAnnotatedClosures(Class clazz, Class... annotationClasses) {
		def map = [:]
		for (field in clazz.declaredFields) {
		  def fieldAnnotations = []
		  for (annotationClass in annotationClasses) {
			if (field.isAnnotationPresent(annotationClass)) {
			  fieldAnnotations << annotationClass
			}
		  }
		  if (fieldAnnotations) {
			map[field.name] = fieldAnnotations
		  }
		}
	}
}
