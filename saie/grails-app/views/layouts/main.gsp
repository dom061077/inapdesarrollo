<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
	    <link rel="stylesheet" href="${resource(dir:'css/blueprint',file:'screen.css')}" type="text/css" media="screen, projection">
    	<link rel="stylesheet" href="${resource(dir:'css/blueprint',file:'print.css')}" media="print">
    	<!--[if lt IE 8]><link rel="stylesheet" href="${resource(dir:'css/blueprint',file:'ie.css')}" type="text/css" media="screen, projection"><![endif]-->
        
         <link rel="stylesheet" href="${resource(dir:'css/pepper-grinder',file:'jquery-ui-1.8.16.custom.css')}" />
        
        
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery-1.6.2.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir:'js/jquery-ui',file:'jquery-ui-1.8.16.custom.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir:'js/jquery-ui',file:'jquery-ui-i18n.js')}"></script>
         
        <g:layoutHead />
        <g:javascript library="application" />
        <style type="text/css">
        	body{
        		font-size:65%
        	}
        </style>
    </head>
    <body>
    	<div class="container">
	        <div id="spinner" class="spinner" style="display:none;">
	            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="${message(code:'spinner.alt',default:'Loading...')}" />
	        </div>
	        <div id="grailsLogo"><a href="http://grails.org"><img src="${resource(dir:'images',file:'grails_logo.png')}" alt="Grails" border="0" /></a></div>
	        <g:layoutBody />
	    </div>    
    </body>
</html>