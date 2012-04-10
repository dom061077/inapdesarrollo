

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
			function bindcarreras(){
		    	var griddata = [];
		    	
		    	var data = jQuery.parseJSON($("#carrerasSerializedId").val());
		    	if(data==null)
		        		data=[];
		    	for (var i = 0; i < data.length; i++) {
		    	    griddata[i] = {};
		    	    griddata[i]["id"] = data[i].id;
		    	    griddata[i]["idid"] = data[i].idid;	        	    
		    	    griddata[i]["denominacion"] = data[i].denominacion;	        	    	        	    
		    	}

		    	for (var i = 0; i <= griddata.length; i++) {
		    	    jQuery("#carrerasId").jqGrid('addRowData', i + 1, griddata[i]);
		    	}
				
			}
        
	        function initsubmit(){
	    		var gridDataCarreras = jQuery("#carrerasId").getRowData();
	        	var postDataCarreras = JSON.stringify(gridDataCarreras);
	        	$("#carrerasSerializedId").val(postDataCarreras);
	        	
	        }

        
	    	function initGridBusquedaCarreras(tabid,pagerid){
	    		//---------------inicializacion de la grilla de busqueda de Materias para sugerir las Materias
	    		var tablaId ='#'+tabid;
	    		var pagerId ='#'+pagerid; 
	    		$(tablaId).jqGrid({
	    			caption:'Búsqueda de Carreras',
	    			url:'<% out << createLink(controller:"carrera",action:"listjson") %>',
	    		mtype:'POST',
	    		//postData:{nivel_id:$('#nivelIdId').val()},
	    		width:400,
	    		rownumbers:true,
	    		pager:pagerId,
	    		datatype:'json',
	    		colNames:['Id','Denominación'],
	    		colModel:[
	    				{name:'id',index:'id',width:10,hidden:true},
	    				{name:'denominacion',index:'denominacion',width:100,sorttype:'text',sortable:true}
	    		]
	    		});
	    		jQuery(tablaId).jqGrid('navGrid',pagerId,{refresh:true,search:false,edit:false,add:false,del:false,pdf:true});
	    		jQuery(tablaId).jqGrid('filterToolbar',{stringResult: true,searchOnEnter : true});
	    		
	    		
	    	}
        
        	$(document).ready(function(){
        		$("#carrerasId").jqGrid({ 
        			url:''
        			,editurl:'<%out << createLink(controller:"aula",action:"editcarreras")%>'
        			,datatype: "json"
        			,width:600
        			,rownumbers:true
        			,colNames:['Id','IdId','Denominación']
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

        						var gridDataMatregcursar = jQuery("#carrerasId").getRowData();
        						var retornar=false;
        						var id = $('#tablaBusquedaCarrerasId').jqGrid('getGridParam','selrow');
        						var obj;
        						if(!id){
        							alert('Seleccione una Carrera de la Grilla');
        							return [false,''];
        						}else{
        							obj = $('#tablaBusquedaCarrerasId').getRowData(id);
        							$.each( gridDataMatregcursar, function(i, row){
        		   						 if(obj.id==row.idid){
        		   						 	retornar=true;
        		   						 	return;
        		   						 }
        							});
        							if(retornar){
        								alert('Ya agregó esta carrera');
        								return [false,'YA EXISTE LA CARRERA AGREGADA'];
        							}
        							
        							postData.idid = obj.id;
        							postData.denominacion = obj.denominacion;
        							return [true,''];
        						}
        					}
        					,beforeShowForm:function(form){
        						$('#TblGrid_carrerasId').hide();
        						$('#FrmGrid_carrerasId').append('<table id="tablaBusquedaCarrerasId"></table><div id="pagerBusquedaCarrerasId"></div>');
        						initGridBusquedaCarreras('tablaBusquedaCarrerasId','pagerBusquedaCarrerasId');
        					}
        					,bSubmit:'Agregar'
        				
        				}, // add options 
        				{reloadAfterSubmit:false}, // del options 
        				{} // search options 
        			);
        		
        	        bindcarreras();  		
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
            <g:form onSubmit="initsubmit();return true;" action="save" >
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
						   		<g:hiddenField id="carrerasSerializedId" name="carrerasSerialized" value="${carrerasSerialized}"/>
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
