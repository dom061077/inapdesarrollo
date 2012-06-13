

<%@ page import="com.educacion.academico.InscripcionMatricula" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
         <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
        
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">
	        function initsubmit(){
	            var gridDataMaterias = $('#materiasId').getRowData();
	            var postDataMaterias = JSON.stringify(gridDataMaterias);
	            $('#materiasSerializedId').val(postDataMaterias);
	        }
        
	        function bindmaterias(){
	        	var griddata = [];
	        	
	        	var data = jQuery.parseJSON($("#materiasSerializedId").val());
	        	if(data==null)
		        		data=[];
	        	for (var i = 0; i < data.length; i++) {
	        	    griddata[i] = {};
	        	    /*for (var j = 0; j < data[i].length; j++) {
	        	        griddata[i][names[j]] = data[i][j];
	        	    }*/
	        	    griddata[i]["id"] = data[i].id;
	        	    griddata[i]["idid"] = data[i].idid;	        	    
	        	    griddata[i]["denominacion"] = data[i].denominacion;
	        	    griddata[i]["seleccion"] = data[i].seleccion	        	    	        	    
	        	}
	
	        	for (var i = 0; i <= griddata.length; i++) {
	        	    jQuery("#materiasId").jqGrid('addRowData', i + 1, griddata[i]);
	        	}
	        }

        
        	$(document).ready(function(){
	        	$('#materiasId').jqGrid({
	               	datatype:'local'
	                ,width:500
	                ,colNames:['Id','IdId','Denominación','Select']
	            	,colModel:[
	                       	{name:'id',index:'id',width:50,editable:false,hidden:true}
	                       	,{name:'idid',index:'idid',width:50,hidden:true,sortable:false,editable:true,editoptions:{readOnly:true,size:10},editrules:{required:false}}
	                       	,{name:'denominacion',index:'denominacion',sortable:false,width:120,editable:true,editoptions:{readOnly:true,size:40},editrules:{required:true}}
	                       	,{ name: 'seleccion', index: 'seleccion',width:10,  formatter: "checkbox", formatoptions: { disabled: false }, editable: true, edittype: "checkbox" }
               				
	                ]
	            	,sortname:'denominacion'
	                //,pager: '#pagermateriasId'
	            	,sortorder:'asc'
	                ,caption: 'Materias Inscriptas'
	            });
	

	        	bindmaterias();
            		
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
            <g:hasErrors bean="${inscripcionMatriculaInstance}">
            <div class="ui-state-error ui-corner-all append-bottom">
                <g:renderErrors bean="${inscripcionMatriculaInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form onSubmit="initsubmit()" action="save">
            		<div class="append-bottom">	
                        
							
							<div class="span-3 spanlabel">
								<label for="alumno"><g:message code="inscripcionMatricula.alumno.label" default="Alumno" /></label>
							</div>
							<div class="span-5 spanlabel">
								${inscripcionMatriculaInstance?.alumno?.apellidoNombre} 
 								<g:hiddenField id="alumnoIdId" name="alumno.id" value="${inscripcionMatriculaInstance?.alumno?.id}" />
							</div>
						   <div class="clear"></div>


							<div class="span-3 spanlabel">
								<label for="carrera"><g:message code="inscripcionMatricula.carrera.label" default="Carrera" /></label>
							</div>
							<div class="span-5 spanlabel">
								${inscripcionMatriculaInstance?.carrera?.denominacion} 
 								<g:hiddenField id="carreraIdId" name="carrera.id" value="${inscripcionMatriculaInstance?.carrera?.id}" />
							</div>
						   <div class="clear"></div>

																	
							<div class="span-3 spanlabel">
								<label for="anioLectivo"><g:message code="inscripcionMatricula.anioLectivo.label" default="Anio Lectivo" /></label>
							</div>
							<div class="span-5 spanlabel">
								${inscripcionMatriculaInstance?.anioLectivo?.anioLectivo} 
 								<g:hiddenField id="anioLectivoIdId" name="anioLectivo.id" value="${inscripcionMatriculaInstance?.anioLectivo?.id}" />
							</div>
						   <div class="clear"></div>
						   <fieldset>
						   		<g:hiddenField id="materiasSerializedId" name="materiasSerialized" value="${materiasSerialized}"/>
						   		<legend>Materias Disponibles para la Inscripción</legend>
						   		<table id="materiasId"></table>
						   		<div id="pagermateriasId"></div>
						   </fieldset>	
                        
					</div>                        
	                <div class="buttons">
	                    <span class="button"><g:submitButton name="create" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
	                </div>
            </g:form>
        </div>
    </body>
</html>
