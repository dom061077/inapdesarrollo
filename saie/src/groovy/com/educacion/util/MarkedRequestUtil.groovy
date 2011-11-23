package com.educacion.util

import com.educacion.annotations.Requestmark

class MarkedRequestUtil {
	static def listRequestmap(def grailsApplication_,def log){
		log.info "INGRESANDO AL METODO: listRequestmap"
		def requests = []
		grailsApplication_.controllerClasses.each{
			def clazz = it.getClazz()
			Requestmark requestmark = it.getClass().getAnnotation(Requestmark.class)
			if(requestmark != null){
				log.debug "clase con metodos para hacer un requestmap: "+it.name
				requests.add(it.name)
			}	
		}
		log.debug "CANTIDAD DE REQUESTS: "+requests.size()
		return requests
	}
}
