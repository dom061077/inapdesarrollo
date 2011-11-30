package com.educacion.academico

import pl.burningice.plugins.image.ast.FileImageContainer
import org.springframework.web.multipart.commons.CommonsMultipartFile

@FileImageContainer(field = 'imagen')
class DocumentoCarrera {
	String nombreOriginalDocumento
	String documento
	Carrera carrera
	static belongsTo = [carrera:Carrera]
	
    static constraints = {
		documento(nullable:true,blank:true)
		nombreOriginalDocumento(nullable:true,blank:true)
		carrera(nullable:false,blank:false)
		
    }
}
