

import pl.burningice.plugins.image.container.ContainerWorkerFactory
import pl.burningice.plugins.image.container.ContainerUtils

class BurningImageExtensionTagLib {
	ContainerWorkerFactory containerWorkerFactory
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

    def realresourceimgext = { attrs ->
        def tamanio = attrs.size
        def config = ContainerUtils.getConfig(attrs.bean)
        if(containerWorkerFactory.produce(attrs.bean).hasImage()){
            if (!config){
                throw new IllegalArgumentException("There is no config for ${attrs.bean.class.name}")
            }
            out << config.outputDir+"/"+ContainerUtils.getFullName(tamanio, attrs.bean, config)
        }else{
            out <<""
        }
    }
	

	
}