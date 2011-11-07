<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
	    <link rel="stylesheet" href="${resource(dir:'css/blueprint',file:'screen.css')}" type="text/css" media="screen, projection">
    	<link rel="stylesheet" href="${resource(dir:'css/blueprint',file:'print.css')}" media="print">
    	<!--[if lt IE 9]><link rel="stylesheet" href="${resource(dir:'css/blueprint',file:'ie.css')}" type="text/css" media="screen, projection"><![endif]-->
        
         <link rel="stylesheet" href="${resource(dir:'css/pepper-grinder',file:'jquery-ui-1.8.16.custom.css')}" />
         <link rel="stylesheet" href="${resource(dir:'css',file:'custom.css')}" />
         <link rel="stylesheet" href="${resource(dir:'css/menu/flickr',file:'helper.css')}" /> 
         <link rel="stylesheet" href="${resource(dir:'css/menu/flickr',file:'default.ultimate.linear.css')}" />         
         <link rel="stylesheet" href="${resource(dir:'css/menu',file:'dropdown.linear.css')}" />    
         
        
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery-1.6.2.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'json2.js')}"></script>
        <script type="text/javascript" src="${resource(dir:'js/jquery-ui',file:'jquery-ui-1.8.16.custom.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir:'js/jquery-ui',file:'jquery-ui-i18n.js')}"></script>
        
		<script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.dropdown.js')}"></script>


        
         
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
    		<div  class="span-24">
			        <div class="span-24 prepend-top append-bottom">
			            <img src="${resource(dir:'images',file:'cabecera1.png')}" alt="${message(code:'spinner.alt',default:'Loading...')}" />
			        </div>
			        <div class="clear"></div>
			        <div style="height:50"  class="span-22">

							<ul id="nav" class="dropdown dropdown-linear">
								<li><span class="dir">Ayuda</span>
							
									<ul>
										<li><a href="./">Acerca de...</a></li>
									</ul>
								</li>
								<li><span class="dir">Alumnos</span>
									<ul>
										<li><a href="${createLink(controller:'alumno',action:'create')}">Alta de Alumno</a></li>
										<li><a href="${createLink(controller:'alumno')}">Listado de Alumnos</a></li>
									</ul>
								</li>
								<li><span class="dir">Materias</span>
									<ul>
										<li><a href="${createLink(controller:'materia',action:'create')}">Alta de Materia</a></li>
										<li><a href="${createLink(controller:'materia')}">Listado de Materias</a></li>
										<li class="divider last"><a href="./">Mas...</a></li>
							
									</ul>
								</li>
								<li><a href="./">Docentes</a></li>
								<li><a href="./">Cuotas</a></li>
								<li><a href="./" class="dir">Contactenos</a>
									<ul>
							
										<li><a href="./">Incidencias</a></li>
										<li class="divider last"><a href="./">Mas...</a></li>
									</ul>
								</li>
							
							</ul>


    
					</div>
			        <div class="clear"></div>
			        <div class="span-20 prepend-2">
			        	<g:layoutBody />
			        </div>
			        <div class="clear"></div>
		
					<div style="padding-top:5px;height:25px;background:url(${resource(dir:"images",file:"footer1.png")}) no-repeat"  class="span-24 last prepend-top">
		        		<p style="text-align:center">
		           		 &copy; Copyright 2011 &lt;INAP&gt; | Design by: Marca Registrada
		            	</p>
		        	</div><!-- end footer -->
			</div>		        		        	
	    </div>    
    </body>
</html>