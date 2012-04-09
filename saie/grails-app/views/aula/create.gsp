

<%@ page import="com.educacion.academico.Aula" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'aula.label', default: 'Aula')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
         <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
        
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">
        	$(document).ready(function(){
        		$("#carrerasId").jqGrid({ 
        			url:''
        			,editurl:''
        			,datatype: "json"
        			,width:600
        			,rownumbers:true
        			,colNames:['Id','Id','Denominación']
        			,colModel:[ 
        				{name:'id',index:'id', width:55,editable:false,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
        				, {name:'idid',index:'idid', width:30,hidden:true, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}			
        				, {name:'denominacion',index:'denominacion', width:100, align:"left",editable:true,editoptions:{readOnly:true,size:30},editrules:{required:false}, sortable:false}
        			]
        			//, rowNum:10, rowList:[10,20,30]
        			, pager: '#pagercarrerasId'
        			, sortname: 'id'
        			, viewrecords: true, sortorder: "desc"
        			, caption:"Carreras vinculadas con esta aula"  
        			, height:130
        		}); 

        		jQuery("#carrerasId").jqGrid('navGrid','#pagercarrerasId', {add:true,edit:false,del:true,search:false,refresh:false}, //options 
        				{height:280,width:310,reloadAfterSubmit:false
        					, recreateForm:true
        					,modal:false
        					,editCaption:'Modificar Requisitos'
        					, beforeShowForm:function(form){
        					}
        					,bSubmit:'Modificar'
        				
        				}, // edit options 
        				{height:450,width:450,reloadAfterSubmit:false
        					,recreateForm:true
        					,modal:false
        					,addCaption:'Agregar Materias Regulares para Cursar'
        					,beforeSubmit: function(postData,formId){

        						var gridDataMatregcursar = jQuery("#matregcursarId").getRowData();
        						var retornar=false;
        						var id = $('#tablaBusquedaMateriaMatRegCursarId').jqGrid('getGridParam','selrow');
        						var obj;
        						if(!id){
        							alert('Seleccione un Materia de la Grilla');
        							return [false,''];
        						}else{
        							obj = $('#tablaBusquedaMateriaMatRegCursarId').getRowData(id);
        							$.each( gridDataMatregcursar, function(i, row){
        		   						 if(obj.id==row.idid){
        		   						 	retornar=true;
        		   						 	return;
        		   						 }
        							});
        							if(retornar){
        								alert('Ya agregó esta materia');
        								return [false,'YA EXISTE LA MATERIA AGREGADA'];
        							}
        							
        							postData.idid = obj.id;
        							postData.denominacion = obj.denominacion;
        							postData.nivel = obj.nivel_descripcion;
        							postData.carrera = obj.nivel_carrera_denominacion;						
        							return [true,''];
        						}
        					}
        					,beforeShowForm:function(form){
        						/*$('#tr_codigo').append('<td><a  id="searchlinkformgridId" href="#"><span style="float:left;"  class="ui-icon ui-icon-search"></span></a></td>');
        						$('#searchlinkformgridId').bind('click',function(){
        			            	$('#busquedaRequisitoDialogId').dialog({
        			            		title:'Buscar',
        			            		modal:true,
        			            		resizable:false,
        			            		autoOpen:true,
        			            		width : 600,
        			            		height: 'auto',
        			            		minHeight:350,
        			            		position:'center'
        			            	});
        						});*/
        						$('#TblGrid_matregcursarId').hide();
        						//$('#busquedaRequisitoId').show();
        						$('#FrmGrid_matregcursarId').append('<table id="tablaBusquedaMateriaMatRegCursarId"></table><div id="pagerBusquedaMateriaMatRegCursarId"></div>');
        						initGridBusquedaMaterias('tablaBusquedaMateriaMatRegCursarId','pagerBusquedaMateriaMatRegCursarId');
        					}
        					,bSubmit:'Agregar'
        				
        				}, // add options 
        				{reloadAfterSubmit:false}, // del options 
        				{} // search options 
        			);
        		
        	        		
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
            <g:hasErrors bean="${aulaInstance}">
            <div class="ui-state-error ui-corner-all append-bottom">
                <g:renderErrors bean="${aulaInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
            		<div class="append-bottom">	
                        
							<g:hasErrors bean="${aulaInstance}" field="nombre">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="nombre"><g:message code="aula.nombre.label" default="Nombre" /></label>
							</div>
							<div class="span-5">
								<g:textField id="nombreId" name="nombre" class="ui-widget ui-corner-all ui-widget-content" maxlength="36" value="${aulaInstance?.nombre}" />
							</div>
										
							<g:hasErrors bean="${aulaInstance}" field="nombre">
								<g:renderErrors bean="${aulaInstance}" as="list" field="nombre"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${aulaInstance}" field="cupo">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="cupo"><g:message code="aula.cupo.label" default="Cupo" /></label>
							</div>
							<div class="span-5">
								<g:textField id="cupoId" class="ui-widget ui-corner-all ui-widget-content" name="cupo" value="${fieldValue(bean: aulaInstance, field: 'cupo')}" />
							</div>
										
							<g:hasErrors bean="${aulaInstance}" field="cupo">
								<g:renderErrors bean="${aulaInstance}" as="list" field="cupo"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${aulaInstance}" field="estado">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="estado"><g:message code="aula.estado.label" default="Estado" /></label>
							</div>
							<div class="span-5">
								<g:select id="estadoId" class="ui-widget ui-corner-all ui-widget-content" name="estado" from="${com.educacion.enums.EstadoAulaEnum?.values()}" keys="${com.educacion.enums.EstadoAulaEnum?.values()*.name()}" value="${aulaInstance?.estado?.name()}"  optionValue="name"/>
							</div>
										
							<g:hasErrors bean="${aulaInstance}" field="estado">
								<g:renderErrors bean="${aulaInstance}" as="list" field="estado"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${aulaInstance}" field="localizacion">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="localizacion"><g:message code="aula.localizacion.label" default="Localizacion" /></label>
							</div>
							<div class="span-5">
								<g:textField id="localizacionId" name="localizacion" class="ui-widget ui-corner-all ui-widget-content" value="${aulaInstance?.localizacion}" />
							</div>
										
							<g:hasErrors bean="${aulaInstance}" field="localizacion">
								<g:renderErrors bean="${aulaInstance}" as="list" field="localizacion"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>
						   
						   <fieldset>
						   		<legend>Carreras del Aula</legend>
						   		<g:hiddenField id="carrerasSerializedId" name="carrerasSerialized"/>
						   		<table id="carrerasId"></table>
						   		<div id="pagercarrerasId"></div>
						   </fieldset>

																	
                        
				</div>                        
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
