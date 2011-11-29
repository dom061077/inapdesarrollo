package com.educacion.academico

import org.jfree.util.Log;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import java.util.StringTokenizer

class UploadDocService implements ApplicationContextAware{
	
	ApplicationContext applicationContext
	def imageUploadService
 
    boolean transactional = true
	
	def savedocimg(def documentoCarreraInstance,def grailsApplication){
		log.info("INGRESANDO AL METODO savedoc")
		def uploadedDocument = documentoCarreraInstance.documento
		log.debug("ContentType: "+uploadedDocument.contentType)
		log.debug("fileName: "+uploadedDocument.originalFilename)
		log.debug("Tamaño: "+uploadedDocument.size)
		StringTokenizer tokenizer = new StringTokenizer(uploadedDocument.contentType)
		def token
		while(tokenizer.hasMoreTokens()){
			token = tokenizer.nextToken() 
		}
		
		if(!token.toUpperCase().equals('PDF')){
			documentoCarreraInstance.errors.rejectValue("documento", "documentoCarrera.documento.error","Tipo de archivo incorrecto para la documentaciÃ³n. Solo pueden ser archivos .PDF")
			return documentoCarreraInstance
		}

		def documentoCarreraInstanceSaved = documentoCarreraInstance.save()
		if(documentoCarreraInstanceSaved){ 
			moveFile(uploadedDocument,grailsApplication.config.documentocarrerafolder,documentoCarreraInstanceSaved.id.toString()+".pdf")
			if(!documentoCarreraInstance.photo?.isEmpty()){
				imageUploadService.save(documentoCarreraInstance)
			}
		}else{
			return documentoCarreraInstanceSaved
		}
		
		
		
		
		return documentoCarreraInstanceSaved.id

	}
 
    def moveFile(file, folderRelativePath, fileName) {
		/*con este codigo debo detectar el tipo de archivo y se trata de imagen usar el burning image
		 * pero si se trata de otro tipo de archivo como un pdf, usar este service UploadDocService y almacenarlo de otra manera
		 * 
		 * def CommonsMultipartFile uploadedFile = params.fileInputName
		def contentType = uploadedFile.contentType
		def fileName = uploadedFile.originalFilename
		
		*/
		
		
		def size = uploadedFile.size
        try {
            file.transferTo(new File(getAbsolutePath(folderRelativePath, fileName)))
            return true
         }catch(Exception exception){
             log.error "File move error, ${exception}"
         }
        return false
    }
 
    private String getAbsolutePath(folderPath, fileName){
        "${applicationContext.getResource(folderPath).getFile()}${File.separatorChar}${fileName}"
    }
}
