package com.educacion.academico

import pl.burningice.plugins.image.ast.FileImageContainer
import org.springframework.web.multipart.commons.CommonsMultipartFile

@FileImageContainer(field = 'imagen')
class DocumentoCarrera {
	CommonsMultipartFile documento
	
	static belongsTo = [carrera:Carrera]
	
    static constraints = {
		documento(nullable:true,blank:true)
    }
}
