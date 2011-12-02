// locations to search for config files that get merged into the main config
// config files can either be Java properties files or ConfigSlurper scripts

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if(System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }
import pl.burningice.plugins.image.engines.scale.ScaleType

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [ html: ['text/html','application/xhtml+xml'],
                      xml: ['text/xml', 'application/xml'],
                      text: 'text/plain',
                      js: 'text/javascript',
                      rss: 'application/rss+xml',
                      atom: 'application/atom+xml',
                      css: 'text/css',
                      csv: 'text/csv',
                      all: '*/*',
                      json: ['application/json','text/json'],
                      form: 'application/x-www-form-urlencoded',
                      multipartForm: 'multipart/form-data'
                    ]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// whether to install the java.util.logging bridge for sl4j. Disable for AppEngine!
grails.logging.jul.usebridge = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []

// set per-environment serverURL stem for creating absolute links
environments {
    production {
        grails.serverURL = "http://www.changeme.com"
    }
    development {
        grails.serverURL = "http://localhost:8080/${appName}"
    }
    test {
        grails.serverURL = "http://localhost:8080/${appName}"
    }

}

documentocarrerafolder = 'documentocarrera'

// Added by the Spring Security Core plugin:
grails.plugins.springsecurity.userLookup.userDomainClassName = 'com.educacion.seguridad.User'
grails.plugins.springsecurity.userLookup.authorityJoinClassName = 'com.educacion.seguridad.UserRole'
grails.plugins.springsecurity.authority.className = 'com.educacion.seguridad.Role'
grails.plugins.springsecurity.requestMap.className = 'com.educacion.seguridad.Requestmap'
grails.plugins.springsecurity.securityConfigType = 'Requestmap'


grails.plugins.springsecurity.useSecurityEventListener = true

grails.plugins.springsecurity.onInteractiveAuthenticationSuccessEvent = { e, appCtx -> 
	// handle InteractiveAuthenticationSuccessEvent 
}
	
grails.plugins.springsecurity.onAbstractAuthenticationFailureEvent = { e, appCtx -> 
	// handle AbstractAuthenticationFailureEvent
	System.out.println "Error en autenticacion: "+e.getAuthentication().getPrincipal().properties
	System.out.println "Propiedades: "+e.getAuthentication().properties
	System.out.println "EXCEPTION: "+e.getException().getMessage()
}

grails.plugins.springsecurity.onAuthenticationSuccessEvent = { e, appCtx -> 
	// handle AuthenticationSuccessEvent 
}
	
grails.plugins.springsecurity.onAuthenticationSwitchUserEvent = { e, appCtx -> 
	// handle AuthenticationSwitchUserEvent 
}
	
grails.plugins.springsecurity.onAuthorizationEvent = { e, appCtx -> 
	// handle AuthorizationEvent 
}



bi.Alumno = [
	outputDir: 'alumnosimg',
	//prefix: 'mySuperImage',
	images: ['large':[scale:[width:700, height:500, type:ScaleType.APPROXIMATE]
					  //,watermark:[sign:'images/watermark.png', offset:[top:10, left:10]]
					  ],
			 'small':[scale:[width:25, height:25, type:ScaleType.ACCURATE]
					  //,watermark:[sign:'images/watermark.png', offset:[top:10, left:10]]
					  ],
				  ],
			  
	constraints:[
		nullable:true,
		maxSize:1024*250,
		contentType:['image/gif', 'image/png' , 'image/jpg', 'image/jpeg', 'image/pjpeg', 'image/x-png']
	]
]

bi.DocumentoCarrera = [
	outputDir: 'carreradocumentacionimg',
	images: ['large':[scale:[width:700, height:500, type:ScaleType.APPROXIMATE]
					  //,watermark:[sign:'images/watermark.png', offset:[top:10, left:10]]
					  ],
			 'small':[scale:[width:25, height:25, type:ScaleType.ACCURATE]
					  //,watermark:[sign:'images/watermark.png', offset:[top:10, left:10]]
					  ],
				  ],
	constraints:[
		nullable:true,
		maxSize:1024*250,
		contentType:['image/gif', 'image/png' , 'image/jpg', 'image/jpeg', 'image/pjpeg', 'image/x-png']
	]
] 
