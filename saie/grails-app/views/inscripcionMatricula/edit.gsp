

<%@ page import="com.educacion.academico.InscripcionMatricula" %>
<%@ page import="com.educacion.enums.inscripcion.TipoInscripcionMateriaEnum"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
         <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
        
        
        <script type="text/javascript">
            var tiposinscripcion = '<%out << TipoInscripcionMateriaEnum.listforselectview()%>';

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
	        	    griddata[i]["idmateria"] = data[i].idmateria;
                    griddata[i]["nivel"] = data[i].nivel;
                    griddata[i]["codigomateria"] = data[i].codigomateria;
	        	    griddata[i]["denominacion"] = data[i].denominacion;
                    griddata[i]["tipo"] = data[i].tipo;
                    griddata[i]["tipovalue"] = data[i].tipovalue;
	        	    griddata[i]["seleccion"] = data[i].seleccion	        	    	        	    
	        	}
	
	        	for (var i = 0; i <= griddata.length; i++) {
	        	    jQuery("#materiasId").jqGrid('addRowData', i + 1, griddata[i]);
	        	}
	        }

        	
        	$(document).ready(function(){
            	var lastsel;
	        	$('#materiasId').jqGrid({
	               	datatype:'local'
                    ,editurl:'<%out << createLink(controller:"inscripcionMatricula",action:"editmaterias")%>'
	                ,width:600
	                ,colNames:['Id','IdId','IdMateria','Nivel','Código Materia','Denominación','Tipo','Tipo Value','Select']
	            	,colModel:[
	                       	{name:'id',index:'id',width:50,editable:false,hidden:true}
	                       	,{name:'idid',index:'idid',width:50,hidden:true,sortable:false,editable:false,editoptions:{readOnly:true,size:10},editrules:{required:false}}
	                       	,{name:'idmateria',index:'idmateria',width:50,hidden:true,sortable:false,editable:false,editoptions:{readOnly:true,size:10},editrules:{required:false}}
                            ,{name:'nivel',index:'nivel',sortable:false,width:120,editable:false,editoptions:{readOnly:true,size:40},editrules:{required:true}}
                            ,{name:'codigomateria',index:'codigomateria',sortable:false,width:120,editable:false,editoptions:{readOnly:true,size:40},editrules:{required:true}}
	                       	,{name:'denominacion',index:'denominacion',sortable:false,width:120,editable:false,editoptions:{readOnly:true,size:40},editrules:{required:true}}
                            ,{name:'tipo',index:'tipo',sortable:false,width:120,editable:true,edittype:"select"
                                ,editoptions:{value:tiposinscripcion,readOnly:false,size:40},editrules:{required:true}}
                            ,{name:'tipovalue',index:'tipovalue',hidden:true,editable:true}
	                       	,{ name: 'seleccion', index: 'seleccion',width:60,  formatter: "checkbox", formatoptions: { disabled: false }, editable: true, edittype: "checkbox" }
               				
	                ]
	            	,sortname:'denominacion'
	                //,pager: '#pagermateriasId'
	            	,sortorder:'asc'
	                //,caption: 'Materias Inscriptas'
	                ,onSelectRow: function(id){ 
		                if(id && id!==lastsel){ 
			                jQuery('#materiasId').jqGrid('restoreRow',lastsel); 
			                jQuery('#materiasId').jqGrid('editRow',id,true);
                            lastsel=id;
			            }
                        return true;
			        },
                    serializeRowData: function (postData) {
                        //postData.name = postData.name.toUpperCase();
                        postData.tipovalue = postData.tipo;
                        return postData;
                    }

	            });
	

	        	bindmaterias();
            		
        	});
		</script>
        
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="seleccionalumno"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all append-bottom"><H2>${flash.message}</H2></div>
            </g:if>
            
            <g:hasErrors bean="${inscripcionMatriculaInstance}">
            <div class="ui-state-error ui-corner-all">
                <g:renderErrors bean="${inscripcionMatriculaInstance}" as="list" />
            </div>
            </g:hasErrors>
            
            <g:hasErrors bean="${inscripcionMateriaInstance}">
            <div class="ui-state-error ui-corner-all">
                <g:renderErrors bean="${inscripcionMateriaInstance}" as="list" />
            </div>
            </g:hasErrors>
            
            
            <g:form onSubmit="initsubmit()" method="post" >
            	<div class="append-bottom">
			                <g:hiddenField name="id" value="${inscripcionMatriculaInstance?.id}" />
			                <g:hiddenField name="version" value="${inscripcionMatriculaInstance?.version}" />
		                
							<div class="span-3 spanlabel">
								<label for="alumno"><g:message code="inscripcionMatricula.alumno.label" default="Alumno" /></label>
							</div>
							<div class="span-5 spanlabel">
								${inscripcionMatriculaInstance?.alumno?.apellido+"-"+inscripcionMatriculaInstance?.alumno?.nombre} 
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
								<label><g:message code="inscripcionMatricula.anioLectivo.label" default="Anio Lectivo" /></label>
							</div>
							<div class="span-5 spanlabel">
								${inscripcionMatriculaInstance?.anioLectivo?.anioLectivo} 
 								<g:hiddenField id="anioLectivoIdId" name="anioLectivo.id" value="${inscripcionMatriculaInstance?.anioLectivo?.id}" />
							</div>
						   <div class="clear"></div>
						   
						   <div class="span-3 spanlabel">
						   		<label for="estado"><g:message code="inscripcionMatricula.estado.label" default="Estado" /></label>
						   </div>
						   <div class="span-5 spanlabel">
						   		<%--g:select id="estadoId" class="ui-widget ui-corner-all ui-widget-content" name="estado"
						   		from="${com.educacion.enums.inscripcion.EstadoInscripcionMatriculaEnum?.values()}" 
						   		keys="${com.educacion.enums.inscripcion.EstadoInscripcionMatriculaEnum?.values()*.name()}" 
						   		value="${inscripcionMatriculaInstance?.estado?.name()}"  optionValue="name"/ --%>
                                ${inscripcionMatriculaInstance?.estado?.name}
						   </div>
						   <div class="clear"></div>
						   <fieldset>
						   		<g:hiddenField id="materiasSerializedId" name="materiasSerialized" value="${materiasSerialized}"/>
						   		<legend>Materias a Confirmar</legend>
						   		<table id="materiasId"></table>
						   		<div id="pagermateriasId"></div>
						   </fieldset>	
		            
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" action="update" value="${message(code: 'inscripcionMatricula.confirmar.button')}" /></span>
                    <%-- span class="button"><g:actionSubmit class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span --%>
                </div>
            </g:form>
        </div>
    </body>
</html>
