package com.educacion.academico

import org.jfree.util.Log;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import java.util.StringTokenizer

class UploadDocService implements ApplicationContextAware{
	
	ApplicationContext applicationContext
	def imageUploadService
 
    boolean transactional = true
	
	def updatedocimg(def grailsApplication, def params){
		log.info "INGRESANDO AL METODO updatedocimg"
		def documentoCarreraInstance = DocumentoCarrera.get(params.id)
		if (documentoCarreraInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (documentoCarreraInstance.version > version) {
					
					documentoCarreraInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'documentoCarrera.label', default: 'DocumentoCarrera')] as Object[], "Another user has updated this DocumentoCarrera while you were editing")
					return documentoCarreraInstance
				}
			}

		}else
			return "${message(code: 'default.not.found.message', args: [message(code: 'documentoCarrera.label', default: 'DocumentoCarrera'), params.id])}"	
		
		def uploadedDocument = params.archivodocumento
	}
	
	def savedocimg(def documentoCarreraInstance,def grailsApplication, def params){
		log.info("INGRESANDO AL METODO savedoc")
		def uploadedDocument = params.archivodocumento
		log.debug("ContentType: "+uploadedDocument.contentType)
		log.debug("fileName: "+uploadedDocument.originalFilename)
		log.debug("Tama�o: "+uploadedDocument.size)
		StringTokenizer tokenizer = new StringTokenizer(uploadedDocument.contentType,"/")
		def token
		while(tokenizer.hasMoreTokens()){
			token = tokenizer.nextToken() 
		}
		documentoCarreraInstance.nombreOriginalDocumento = uploadedDocument.originalFilename
		if(!token.toUpperCase().equals('PDF')){
			log.debug "TOKEN COMPARADO: $token"
			documentoCarreraInstance.errors.rejectValue("documento", "documentoCarrera.documento.error","Tipo de archivo incorrecto para la documentación. Solo pueden ser archivos .PDF")
			return documentoCarreraInstance
		}
		
		if(uploadedDocument.size>1024*500){
			documentoCarreraInstance.errors.rejectValue("documento","documentoCarrera.documento.sizeerror","El tamaño máximo del PDF es de 500 Kb")
			return documentoCarreraInstance
		}
		def documentoCarreraInstanceSaved = documentoCarreraInstance.save()
		if(documentoCarreraInstanceSaved){ 
			if(moveFile(uploadedDocument,grailsApplication.config.documentocarrerafolder,documentoCarreraInstanceSaved.id.toString()+".pdf"))
				documentoCarreraInstance.errors.rejectValue("documento","documentoCarrera.documento.error","Error al subir el archivo intente más tarde")
			if(!params.photo.isEmpty())
				imageUploadService.save(documentoCarreraInstance)
			documentoCarreraInstanceSaved.documento = documentoCarreraInstanceSaved.id.toString()+".pdf" 	
		}else{
			return documentoCarreraInstance
		}
		
		
		
		
		return documentoCarreraInstanceSaved.id

	}
 
    private def moveFile(file, folderRelativePath, fileName) {
		/*con este codigo debo detectar el tipo de archivo y se trata de imagen usar el burning image
		 * pero si se trata de otro tipo de archivo como un pdf, usar este service UploadDocService y almacenarlo de otra manera
		 * 
		 * def CommonsMultipartFile uploadedFile = params.fileInputName
		def contentType = uploadedFile.contentType
		def fileName = uploadedFile.originalFilename
		
		*/
		
		
		//def size = uploadedFile.size
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
