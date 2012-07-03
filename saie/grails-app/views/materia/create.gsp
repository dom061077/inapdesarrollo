

<%@ page import="com.educacion.academico.Materia" %>


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
        <script type="text/javascript" src="${resource(dir:'js/script/academico/materia',file:'createmateria.js')}"></script>
        <script type="text/javascript">
        	var locmateria = '<%out << createLink(controller:"materia",action:"listjson")%>';
        	var locmatregcursar = '<%out << createLink(controller:"materia",action:"listmatregcursar")%>';
        	var loceditmateria = '<%out << createLink(controller:"materia",action:"editmat")%>';
        	$(document).ready(function(){
		

        		$('#carreraId').lookupfield({source:'<%out<<createLink(controller:'carrera',action:'listsearchjson')%>',
    				 title:'Búsqueda de Carreras' 
	   				,colNames:['Id','Denominación'] 
	   				,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
    				,{name:'denominacion',index:'denominacion', width:100,  sortable:true,search:true}
    				]  
    				,hiddenid:'carreraIdId' 
    				,descid:'carreraId' 
    				,hiddenfield:'id' 
    				,descfield:['denominacion']
					,onShowgrid:function(){
							if(($("#matregcursarId").getRowData().length>0)
									 || 
									   ($("#mataprobcursarId").getRowData().length>0)||
									   ($("#matregrendirId").getRowData().length>0) ||
									   ($("#mataprobcursarId").getRowData().length>0)
								){
					   			$("<div>Recuerde de que si cargo algunas materias en alguna grilla de abajo al cambiar de carrera se limpiaran dichas grillas</div>").dialog({
					   				resizable: false,
					   				height:140,
					   				modal: true,
					   				buttons: {
					   					Ok: function() {
					   						$( this ).dialog( "close" );
					   					}
					   				}
					   			});
					   		}
						}
        			,onSelected:function(){
    					var filter = { groupOp: "AND", rules: []};
	    				filter.rules.push({field:"carrera_id",op:"eq",data:$('#carreraIdId').val()});
	    				var grid = $('#nivelIdtablesearchId') 
	    				grid[0].p.search = filter.rules.length>0;
	    				$.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
	    				grid.trigger("reloadGrid",[{page:1}]);
	    				$('#nivelId').val('');
						$('#nivelIdId').val('');
						$('#matregcursarId').clearGridData();
						$('#mataprobcursarId').clearGridData();
						$('#matregrendirId').clearGridData();
						$('#mataprobrendirId').clearGridData();						
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

		   		$('#carreraId' ).autocomplete({source: '<%out<<createLink(controller:'carrera',action:'listjsonautocomplete')%>',
    				 minLength: 2, 
     				 select: function( event, ui ) {
    					 if(ui.item){ 
    						 $('#carreraIdId').val(ui.item.id) 
    						 
							var filter = { groupOp: "AND", rules: []};
							filter.rules.push({field:"carrera_id",op:"eq",data:ui.item.id});
							var grid = $('#nivelIdtablesearchId') 
							grid[0].p.search = filter.rules.length>0;
							$.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
							grid.trigger("reloadGrid",[{page:1}]);
							$('#nivelId').val('');
							$('#nivelIdId').val('');
							$('#matregcursarId').clearGridData();
							$('#mataprobcursarId').clearGridData();
							$('#matregrendirId').clearGridData();
							$('#mataprobrendirId').clearGridData();						
							
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
				,colNames:['Id','Descripcion','Carrera','Es primer nivel'] 
				,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
 				,{name:'descripcion',index:'descripcion', width:100,  sortable:true,search:true}
 				,{name:'carrera',index:'carrear',hidden:false}
				,{name:'esprimernivel',index:'esprimernivel',width:100,sortable:false,search:false} ]
 				,hiddenid:'nivelIdId' 
 				,descid:'nivelId' 
 				,hiddenfield:'id' 
 				,descfield:['descripcion']
				,onShowgrid:function(){
					if(($("#matregcursarId").getRowData().length>0)
							 || 
							   ($("#mataprobcursarId").getRowData().length>0)||
							   ($("#matregrendirId").getRowData().length>0) ||
							   ($("#mataprobcursarId").getRowData().length>0)
						){
			   			$("<div>Recuerde de que si cargo algunas materias en alguna grilla de abajo al cambiar de carrera se limpiaran dichas grillas</div>").dialog({
			   				resizable: false,
			   				height:140,
			   				modal: true,
			   				buttons: {
			   					Ok: function() {
			   						$( this ).dialog( "close" );
			   					}
			   				}
			   			});
			   		}
				}
				,onSelected:function(){
					$('#matregcursarId').clearGridData();
					$('#mataprobcursarId').clearGridData();
					$('#matregrendirId').clearGridData();
					$('#mataprobrendirId').clearGridData();						
				}
		
			
 				}); 

		$('#nivelId' ).autocomplete({
				source: function( request, response ) {
							$.ajax({
								url: '<%out<<createLink(controller:'nivel',action:'listjsonautocomplete')%>',
								//dataType: "jsonp",
								data: {
									carreraId:$('#carreraIdId').val(),
									term: request.term
								},
								success: function( data ) {
									response( $.map( data, function( item ) {
										return {
											label: item.label,
											value: item.value,
											id: item.id
										}
									}));
								},
								error:function(jqXHR, textStatus, errorThrown){
									alert('ERROR');									
								}
							});
						}
				,
 				 minLength: 2,
  				 select: function( event, ui ) {
 					 if(ui.item){ 
 					 	$('#nivelIdId').val(ui.item.id);
 						$('#matregcursarId').clearGridData();
						$('#mataprobcursarId').clearGridData();
						$('#matregrendirId').clearGridData();
						$('#mataprobrendirId').clearGridData();						
 						  
					 } 
					}, 
 				 open: function() { 
 					$( this ).removeClass( 'ui-corner-all' ).addClass( 'ui-corner-top' ); 
 				 }, 
 				 close: function() {
 					 $( this ).removeClass( 'ui-corner-top' ).addClass( 'ui-corner-all' ); 
 				 } 
  				}); 
		

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
            <g:form onSubmit="initsubmit();return true;" action="save" >
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
								<label for="duracion"><g:message code="materia.duracion.label" default="Duracion (días)" /></label>
							</div>
							<div class="span-5">
								<g:textField id="duracion" name="duracion" class="ui-widget ui-corner-all ui-widget-content" value="${materiaInstance?.duracion}" />
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
								<g:textField class="ui-widget ui-corner-all ui-widget-content" id="carreraId" name="carreraDesc"  value="${materiaInstance?.nivel?.carrera?.denominacion}" /> 
 								<g:hiddenField id="carreraIdId" name="carreraId" value="${materiaInstance?.nivel?.carrera?.id}" />
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

								
							<g:hasErrors bean="${materiaInstance}" field="promocional">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="promocional"><g:message code="materia.promocional.label" default="Promocional" /></label>
							</div>
							<div class="span-5 spanlabel">
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

						   <div id="tabs">
						   		<ul>
						   			<li><a href="#tabs-matregcursar">Mat. Regulares para Cursar</a></li>
						   			<li><a href="#tabs-mataprobcursar">Mat. Aprobadas para Cursar</a></li>
						   			<li><a href="#tabs-matregrendir">Mat. Regulares para Rendir</a></li>
						   			<li><a href="#tabs-mataprobrendir">Mat. Aprobadas para Rendir</a></li>
						   		</ul>
						   		<div id="tabs-matregcursar">
						   			<g:hiddenField id="matregcursarSerializedId" name="matregcursarSerialized" value="${matregcursarSerialized}"/>
						   			<table id="matregcursarId"></table>
						   			<div id="pagermatregcursarId"></div>
						   		</div>

						   		<div id="tabs-mataprobcursar"> 
						   			<g:hiddenField id="mataprobcursarSerializedId" name="mataprobcursarSerialized" value="${mataprobcursarSerialized}"/>
						   			<table id="mataprobcursarId"></table>
						   			<div id="pagermataprobcursarId"></div>
						   		</div>

						   		
						   		<div id="tabs-matregrendir">
						   			<g:hiddenField id="matregrendirSerializedId" name="matregrendirSerialized" value="${matregrendirSerialized}"/>
						   			<table id="matregrendirId"></table>
						   			<div id="pagermatregrendirId"></div>
						   		</div>
						   		
						   		
						   		<div id="tabs-mataprobrendir">
						   			<g:hiddenField id="mataprobrendirSerializedId" name="mataprobrendirSerialized" value="${mataprobrendirSerialized}"/>
						   			<table id="mataprobrendirId"></table>
						   			<div id="pagermataprobrendirId"></div>
						   		</div>
						   		
						   </div>
<!--						   <table id="tablaBusquedaMateriaId"></table>-->
<!--						   <div id="pagerBusquedaMateriaId"></div>	-->
						   										
                        
				</div>                        
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
