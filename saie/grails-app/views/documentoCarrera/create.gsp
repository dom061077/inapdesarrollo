

<%@ page import="com.educacion.academico.DocumentoCarrera" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'documentoCarrera.label', default: 'DocumentoCarrera')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
         <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
<!--        <sfu:generateConfiguration />-->
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">
        	$(document).ready(function(){
        		$('#carreraId').lookupfield({source:'<%out<<createLink(controller:"carrera",action:"listsearchjson")%>',
 				 title:'Búsqueda de Carrera' 
				,colNames:['Id','Denominación'] 
				,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
 				,{name:'denominacion',index:'denominacion', width:100,  sortable:true,search:true}] 
 				,hiddenid:'carreraIdId' 
 				,descid:'carreraId' 
 				,hiddenfield:'id' 
 				,descfield:['denominacion']}); 

		$('#carreraId' ).autocomplete({source: '<%out<<createLink(controller:"carrera",action:"listjsonautocomplete")%>',
 				 minLength: 2, 
  				 select: function( event, ui ) {
 					 if(ui.item){ 
 						 $('#carreraIdId').val(ui.item.id) 
					 } 
					}, 
 				 open: function() { 
 					$( this ).removeClass( 'ui-corner-all' ).addClass( 'ui-corner-top' ); 
 				 }, 
 				 close: function() {
 					 $( this ).removeClass( 'ui-corner-top' ).addClass( 'ui-corner-all' ); 
 				 } 
  				}); 
//---------------------------------- 

        	});
		</script>
		
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all"><H2>${flash.message}</H2></div>
            </g:if>
            <g:hasErrors bean="${documentoCarreraInstance}">
            <div class="ui-state-error ui-corner-all append-bottom">
                <g:renderErrors bean="${documentoCarreraInstance}" as="list" />
            </div>
            </g:hasErrors>
            <form  action="save" method="post" enctype="multipart/form-data" >
            		<div class="append-bottom">	
                        
							<g:hasErrors bean="${documentoCarreraInstance}" field="documento">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							<div class="span-3 spanlabel">
								<label for="documento"><g:message code="documentoCarrera.documento.label" default="Documento" /></label>
							</div>
							<div class="span-5">
								<input class="ui-widget ui-corner-all ui-widget-content" type="file" id="documentoId" name="documento" class="ui-widget ui-corner-all ui-widget-content" value="${documentoCarreraInstance?.documento}" />
							</div>
							<g:hasErrors bean="${documentoCarreraInstance}" field="documento">
								<g:renderErrors bean="${documentoCarreraInstance}" as="list" field="documento"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>
						   
						   

							
							<div class="span-3 spanlabel">
								<label for="photo"><g:message code="documentoCarrera.photo.label" default="Imagen" /></label>
							</div>
							<div class="span-5">
								<input class="ui-widget ui-corner-all ui-widget-content" type="file" id="photoId" name="photo" class="ui-widget ui-corner-all ui-widget-content" />
							</div>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${documentoCarreraInstance}" field="carrera">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="carrera"><g:message code="documentoCarrera.carrera.label" default="Carrera" /></label>
							</div>
							<div class="span-5">
								<g:textField class="ui-widget ui-corner-all ui-widget-content" id="carreraId" name="carreraDesc"  value="${documentoCarreraInstance?.carrera?.denominacion}" /> 
 								<g:hiddenField id="carreraIdId" name="carrera.id" value="${documentoCarreraInstance?.carrera?.id}" />
							</div>
										
							<g:hasErrors bean="${documentoCarreraInstance}" field="carrera">
								<g:renderErrors bean="${documentoCarreraInstance}" as="list" field="carrera"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
				</div>                        
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </form>
        </div>
    </body>
</html>
