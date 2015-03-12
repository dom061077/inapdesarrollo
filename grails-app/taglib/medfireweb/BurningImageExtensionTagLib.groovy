package medfireweb

import pl.burningice.plugins.image.container.ContainerWorkerFactory

class BurningImageExtensionTagLib {
	ContainerWorkerFactory containerWorkerFactory
	def springSecurityService
	
	def resourceimgext = { attrs ->
		def tamanio = attrs.size
		if(containerWorkerFactory.produce(attrs.bean).hasImage()){
			out << bi.resource(bean:attrs.bean,size:attrs.size)
		}else{
			if(tamanio.equals("small"))
				out << g.resource(dir:'images',file:'noDisponible.jpg');
			if(tamanio.equals("large"))	
				out << g.resource(dir:'images',file:'noDisponibleLarge.jpg');
		}
	}
	
	
	def institucionimg = { attrs ->
		//<bi:img size="large" bean="${imageContainer}" />
		def institucionInstance = springSecurityService.getCurrentUser().institucion

		out << bi.img(size:"large",bean:institucionInstance)

		
	}
	
	def institucioninfo = { attrs ->
		out << "<CENTER>"
		out << "<p>"+springSecurityService.userDomain().institucion.nombre+"</p>"+"<p>"+(springSecurityService.userDomain().institucion.direccion?springSecurityService.userDomain().institucion.direccion:"")+"</p>"
		out << "<p><a href='${(springSecurityService.userDomain().institucion.web?springSecurityService.userDomain().institucion.web:"")}'>"+(springSecurityService.userDomain().institucion.web?springSecurityService.userDomain().institucion.web:"")+"</a>"
		out << "</CENTER>"
	}

	
}
