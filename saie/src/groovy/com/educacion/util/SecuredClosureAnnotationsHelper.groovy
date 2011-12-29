package com.educacion.util


import org.apache.commons.lang.WordUtils
import org.codehaus.groovy.grails.commons.ApplicationHolder as AH
import com.educacion.annotations.SecuredRequest;


class SecuredClosureAnnotationsHelper {
	static def listRequestmap(def grailsApplication_,def log){
		def requests = []
		def clazz
		def returnedMap
		grailsApplication_.controllerClasses.each{
			clazz = it.getClazz()
			returnedMap = findAnnotatedClosures(clazz,log,SecuredRequest)
			if(returnedMap){
				log.debug "URIS: "+it.URIs 
				requests.add(returnedMap)
			}
		}
		return requests
	}
	
	private static Map<String, List<Class>> findAnnotatedClosures(Class clazz,def log, Class annotationClass,def controllerClass) {
		def map = [:]
		for (field in clazz.declaredFields) {
		  def fieldAnnotations = []
		  
		  if (field.isAnnotationPresent(SecuredRequest)) {
			  log.debug "				TIENE UNA ANOTACION"
			  //fieldAnnotations << annotationClass
			  log.debug "				ANOTACION: "+field.getAnnotation(SecuredRequest).requestDesc()				
			  map[field.name]= field
		  }
		  //if (fieldAnnotations) {
		  //	map[field.name] = fieldAnnotations
		  //}
		}
		return map
	}
	
	private static def getRelatedUris(def controllerClass,def searchCriteria){
		controllerClass.
	}
}
