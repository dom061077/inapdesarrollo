package com.educacion.academico

import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

class UploadDocService implements ApplicationContextAware{

	ApplicationContext applicationContext
 
    boolean transactional = false
 
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
