

<%@ page import="com.educacion.academico.Materia" %>
<%@ page import="com.educacion.academico.DuracionMateria" %>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'materia.label', default: 'Materia')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
         <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
        
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">
        	$(document).ready(function(){
		

        		$('#carreraId').lookupfield({source:'<%out<<createLink(controller:'carrera',action:'listsearchjson')%>',
    				 title:'Búsqueda de Carreras' 
	   				,colNames:['Id','Denominación'] 
	   				,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
    				,{name:'denominacion',index:'denominacion', width:100,  sortable:true,search:true}] 
    				,hiddenid:'carreraIdId' 
    				,descid:'carreraId' 
    				,hiddenfield:'id' 
    				,descfield:['denominacion']
        			,onSelected:function(){
    					var filter = { groupOp: "AND", rules: []};
	    				filter.rules.push({field:"carrera_id",op:"eq",data:$('#carreraIdId').val()});
	    				var grid = $('#nivelIdtablesearchId') 
	    				grid[0].p.search = filter.rules.length>0;
	    				$.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
	    				grid.trigger("reloadGrid",[{page:1}]);
    				}
					,onKeyup:function(){
						if($.trim($('#carreraId').val())==""){
							var filter = { groupOp: "AND", rules: []};
		    				filter.rules.push({field:"carrera_id",op:"eq",data:0});
		    				var grid = $('#nivelIdtablesearchId') 
		    				grid[0].p.search = filter.rules.length>0;
		    				$.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
		    				grid.trigger("reloadGrid",[{page:1}]);
		    				$('#nivelId').val('');
		    				$('#nivelIdId').val('');
	                	}
					}
				}); 

		   		$('#carreraId' ).autocomplete({source: '<%out<<createLink(controller:'carrera',action:'listautocomplejson')%>',
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
            	
		$('#nivelId').lookupfield({source:'<%out<<createLink(controller:'nivel',action:'listsearchjson')%>',
 				 title:'Búsqueda de niveles' 
				,colNames:['Id','Descripcion'] 
				,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
 				,{name:'descripcion',index:'descripcion', width:100,  sortable:true,search:true}] 
 				,hiddenid:'nivelIdId' 
 				,descid:'nivelId' 
 				,hiddenfield:'id' 
 				,descfield:['descripcion']}); 

		$('#nivelId' ).autocomplete({source: '<%out<<createLink(controller:'nivel',action:'listautocomplejson')%>',
 				 minLength: 2, 
  				 select: function( event, ui ) {
 					 if(ui.item){ 
 						 $('#nivelIdId').val(ui.item.id) 
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
		$('#pcaId').lookupfield({source:'<%out<< createLink(controller:'materia',action:'listsearchjson')%>',
 				 title:'Materia aprobada para Cursar' 
				,colNames:['Id','Denominación','Descripción'] 
				,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
 				,{name:'denominacion',index:'denominacion', width:100,  sortable:true,search:true}
 				,{name:'descripcion',index:'descripcion', width:100,  sortable:true,search:true}] 
 				,hiddenid:'pcaIdId' 
 				,descid:'pcaId' 
 				,hiddenfield:'id' 
 				,descfield:['denominacion']}); 

		$('#pcaId' ).autocomplete({source: '<%out<< createLink(controller:'materia',action:'listautocompletejson')%>',
 				 minLength: 2, 
  				 select: function( event, ui ) {
 					 if(ui.item){ 
 						 $('#pcaIdId').val(ui.item.id) 
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
		$('#pcrId').lookupfield({source:'<%out<< createLink(controller:'materia',action:'listsearchjson')%>',
			 title:'Materia aprobada para Cursar' 
					,colNames:['Id','Denominación','Descripción'] 
					,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
	 				,{name:'denominacion',index:'denominacion', width:100,  sortable:true,search:true}
	 				,{name:'descripcion',index:'descripcion', width:100,  sortable:true,search:true}] 
	 				,hiddenid:'pcaIdId' 
	 				,descid:'pcaId' 
	 				,hiddenfield:'id' 
	 				,descfield:['denominacion']}); 

		$('#pcrId' ).autocomplete({source: '<%out<< createLink(controller:'materia',action:'listautocompletejson')%>',
 				 minLength: 2, 
  				 select: function( event, ui ) {
 					 if(ui.item){ 
 						 $('#pcrIdId').val(ui.item.id) 
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
		$('#praId').lookupfield({source:'<%out<< createLink(controller:'materia',action:'listsearchjson')%>',
			 title:'Materia aprobada para Cursar' 
					,colNames:['Id','Denominación','Descripción'] 
					,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
	 				,{name:'denominacion',index:'denominacion', width:100,  sortable:true,search:true}
	 				,{name:'descripcion',index:'descripcion', width:100,  sortable:true,search:true}] 
	 				,hiddenid:'pcaIdId' 
	 				,descid:'pcaId' 
	 				,hiddenfield:'id' 
	 				,descfield:['denominacion']});  

		$('#praId' ).autocomplete({source: '<%out<< createLink(controller:'materia',action:'listautocompletejson')%>',
 				 minLength: 2, 
  				 select: function( event, ui ) {
 					 if(ui.item){ 
 						 $('#praIdId').val(ui.item.id) 
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
		$('#prrId').lookupfield({source:'<%out<< createLink(controller:'materia',action:'listsearchjson')%>',
			 title:'Materia aprobada para Cursar' 
					,colNames:['Id','Denominación','Descripción'] 
					,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
	 				,{name:'denominacion',index:'denominacion', width:100,  sortable:true,search:true}
	 				,{name:'descripcion',index:'descripcion', width:100,  sortable:true,search:true}] 
	 				,hiddenid:'pcaIdId' 
	 				,descid:'pcaId' 
	 				,hiddenfield:'id' 
	 				,descfield:['denominacion']});  

		$('#prrId' ).autocomplete({source: '<%out<< createLink(controller:'materia',action:'listautocompletejson')%>',
 				 minLength: 2, 
  				 select: function( event, ui ) {
 					 if(ui.item){ 
 						 $('#prrIdId').val(ui.item.id) 
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
            <g:hasErrors bean="${materiaInstance}">
            <div class="ui-state-error ui-corner-all append-bottom">
                <g:renderErrors bean="${materiaInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
            		<div class="append-bottom">	
                        
							<g:hasErrors bean="${materiaInstance}" field="codigo">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="codigo"><g:message code="materia.codigo.label" default="Codigo" /></label>
							</div>
							<div class="span-5">
								<g:textField id="codigoId" name="codigo" class="ui-widget ui-corner-all ui-widget-content" value="${materiaInstance?.codigo}" />
							</div>
										
							<g:hasErrors bean="${materiaInstance}" field="codigo">
								<g:renderErrors bean="${materiaInstance}" as="list" field="codigo"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${materiaInstance}" field="denominacion">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="denominacion"><g:message code="materia.denominacion.label" default="Denominacion" /></label>
							</div>
							<div class="span-5">
								<g:textField id="denominacionId" name="denominacion" class="ui-widget ui-corner-all ui-widget-content" value="${materiaInstance?.denominacion}" />
							</div>
										
							<g:hasErrors bean="${materiaInstance}" field="denominacion">
								<g:renderErrors bean="${materiaInstance}" as="list" field="denominacion"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${materiaInstance}" field="descripcion">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="descripcion"><g:message code="materia.descripcion.label" default="Descripcion" /></label>
							</div>
							<div class="span-5">
								<g:textField id="descripcionId" name="descripcion" class="ui-widget ui-corner-all ui-widget-content" value="${materiaInstance?.descripcion}" />
							</div>
										
							<g:hasErrors bean="${materiaInstance}" field="descripcion">
								<g:renderErrors bean="${materiaInstance}" as="list" field="descripcion"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${materiaInstance}" field="duracion">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="duracion"><g:message code="materia.duracion.label" default="Duracion" /></label>
							</div>
							<div class="span-5">
								<g:select name="user.company.id" from="${DuracionMateria.list()}"	value="${materiaInstance?.duracion?.id}"
								optionKey="id" optionValue="descripcion" />
							</div>
										
							<g:hasErrors bean="${materiaInstance}" field="duracion">
								<g:renderErrors bean="${materiaInstance}" as="list" field="duracion"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${materiaInstance}" field="estado">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="estado"><g:message code="materia.estado.label" default="Estado" /></label>
							</div>
							<div class="span-5">
								<g:select id="estadoId" class="ui-widget ui-corner-all ui-widget-content" name="estado" from="${com.educacion.enums.EstadoMateriaEnum?.values()}" keys="${com.educacion.enums.EstadoMateriaEnum?.values()*.name()}" value="${materiaInstance?.estado?.name()}"  optionValue="name"/>
							</div>
										
							<g:hasErrors bean="${materiaInstance}" field="estado">
								<g:renderErrors bean="${materiaInstance}" as="list" field="estado"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

									
							<div class="span-3 spanlabel">
								<label for="carreraDesc"><g:message code="materia.carrera.label" default="Carrera" /></label>
							</div>
							<div class="span-5">
								<g:textField class="ui-widget ui-corner-all ui-widget-content" id="carreraId" name="carreraDesc"  value="${materiaInstance?.nivel?.carrera?.descripcion}" /> 
 								<g:hiddenField id="carreraIdId" name="carrera.id" value="${materiaInstance?.nivel?.carrera?.id}" />
							</div>
						   <div class="clear"></div>
									
																	
                        
							<g:hasErrors bean="${materiaInstance}" field="nivel">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="nivel"><g:message code="materia.nivel.label" default="Nivel" /></label>
							</div>
							<div class="span-5">
								<g:textField class="ui-widget ui-corner-all ui-widget-content" id="nivelId" name="nivelDesc"  value="${materiaInstance?.nivel?.descripcion}" /> 
 								<g:hiddenField id="nivelIdId" name="nivel.id" value="${materiaInstance?.nivel?.id}" />
							</div>
										
							<g:hasErrors bean="${materiaInstance}" field="nivel">
								<g:renderErrors bean="${materiaInstance}" as="list" field="nivel"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${materiaInstance}" field="pca">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="pca"><g:message code="materia.pca.label" default="Pca" /></label>
							</div>
							<div class="span-5">
								<g:textField class="ui-widget ui-corner-all ui-widget-content" id="pcaId" name="pcaDesc"  value="${materiaInstance?.pca?.denominacion}" /> 
 								<g:hiddenField id="pcaIdId" name="pca.id" value="${materiaInstance?.pca?.id}" />
							</div>
										
							<g:hasErrors bean="${materiaInstance}" field="pca">
								<g:renderErrors bean="${materiaInstance}" as="list" field="pca"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${materiaInstance}" field="pcr">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="pcr"><g:message code="materia.pcr.label" default="Pcr" /></label>
							</div>
							<div class="span-5">
								<g:textField class="ui-widget ui-corner-all ui-widget-content" id="pcrId" name="pcrDesc"  value="${materiaInstance?.pcr?.denominacion}" /> 
 								<g:hiddenField id="pcrIdId" name="pcr.id" value="${materiaInstance?.pcr?.id}" />
							</div>
										
							<g:hasErrors bean="${materiaInstance}" field="pcr">
								<g:renderErrors bean="${materiaInstance}" as="list" field="pcr"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${materiaInstance}" field="pra">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="pra"><g:message code="materia.pra.label" default="Pra" /></label>
							</div>
							<div class="span-5">
								<g:textField class="ui-widget ui-corner-all ui-widget-content" id="praId" name="praDesc"  value="${materiaInstance?.pra?.denominacion}" /> 
 								<g:hiddenField id="praIdId" name="pra.id" value="${materiaInstance?.pra?.id}" />
							</div>
										
							<g:hasErrors bean="${materiaInstance}" field="pra">
								<g:renderErrors bean="${materiaInstance}" as="list" field="pra"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        

																	
                        
							<g:hasErrors bean="${materiaInstance}" field="prr">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="prr"><g:message code="materia.prr.label" default="Prr" /></label>
							</div>
							<div class="span-5">
								<g:textField class="ui-widget ui-corner-all ui-widget-content" id="prrId" name="prrDesc"  value="${materiaInstance?.prr?.denominacion}" /> 
								<g:hiddenField id="prrIdId" name="prr.id" value="${prr?.id}" />
							</div>
										
							<g:hasErrors bean="${materiaInstance}" field="prr">
								<g:renderErrors bean="${materiaInstance}" as="list" field="prr"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

								
							<g:hasErrors bean="${materiaInstance}" field="promocional">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="promocional"><g:message code="materia.promocional.label" default="Promocional" /></label>
							</div>
							<div class="span-5">
								<g:checkBox name="promocional" value="${materiaInstance?.promocional}" />
							</div>
										
							<g:hasErrors bean="${materiaInstance}" field="promocional">
								<g:renderErrors bean="${materiaInstance}" as="list" field="promocional"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>
																	
                        
							<g:hasErrors bean="${materiaInstance}" field="tipo">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="tipo"><g:message code="materia.tipo.label" default="Tipo" /></label>
							</div>
							<div class="span-5">
								<g:select id="tipoId" class="ui-widget ui-corner-all ui-widget-content" name="tipo" from="${com.educacion.enums.TipoMateriaEnum?.values()}" keys="${com.educacion.enums.TipoMateriaEnum?.values()*.name()}" value="${materiaInstance?.tipo?.name()}"  optionValue="name"/>
							</div>
										
							<g:hasErrors bean="${materiaInstance}" field="tipo">
								<g:renderErrors bean="${materiaInstance}" as="list" field="tipo"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
				</div>                        
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
