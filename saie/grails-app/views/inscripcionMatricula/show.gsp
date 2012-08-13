
<%@ page import="com.educacion.academico.InscripcionMatricula" %>
<%@ page import="com.educacion.enums.inscripcion.TipoInscripcionMateriaEnum"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'inscripcionMatricula.label', default: 'InscripcionMatricula')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
         <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
        
        <script type="text/javascript">
            var tiposinscripcion = '<%out << TipoInscripcionMateriaEnum.listforselectview()%>';
        	$(document).ready(function(){
	        	$('#materiasId').jqGrid({
		        	url:'<%out << createLink(controller:"inscripcionMatricula",action:"listmateriasjson")%>'
	               	,datatype:'json'
		            ,postData:{id:'<%out << inscripcionMatriculaInstance?.id %>'}
	                ,width:600
	                ,colNames:['Id','IdId','IdMateria','Nivel','Código Materia','Denominación','Tipo','TipoValue','Selec']
	            	,colModel:[
	                       	{name:'id',index:'id',width:50,editable:false,hidden:true}
                            ,{name:'idid',index:'idid',width:50,hidden:true,sortable:false,editable:false,editoptions:{readOnly:true,size:10},editrules:{required:false}}
                            ,{name:'idmateria',index:'idmateria',width:50,hidden:true,sortable:false,editable:false,editoptions:{readOnly:true,size:10},editrules:{required:false}}
                            ,{name:'nivel',index:'nivel',sortable:false,width:120,editable:false,editoptions:{readOnly:true,size:40},editrules:{required:true}}
                            ,{name:'codigomateria',index:'codigomateria',sortable:false,width:120,editable:false,editoptions:{readOnly:true,size:40},editrules:{required:true}}
                            ,{name:'denominacion',index:'denominacion',sortable:false,width:120,editable:false,editoptions:{readOnly:true,size:40},editrules:{required:true}}
                            ,{name:'tipo',index:'tipo',hidden:false,sortable:false,width:120,editable:true,edittype:"select"
                                        ,editoptions:{value:tiposinscripcion,readOnly:false,size:40},editrules:{required:true}}
                            ,{name:'tipovalue',index:'tipovalue',hidden:true,editable:true}
                            ,{ name: 'seleccion', index: 'seleccion',width:60,hidden:true,  formatter: "checkbox", formatoptions: { disabled: true }, editable: true, edittype: "checkbox" }

               				
	                ]
	            	,sortname:'denominacion'
	                ,pager: '#pagermateriasId'
	            	,sortorder:'asc'
	                ,caption: 'Materias Inscriptas'
	            });
            	
            });
        	
        </script>
        
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all"><H2>${flash.message}</H2></div>
            </g:if>
            <div class="append-bottom">
                    
                            <div class="span-3 spanlabel"><g:message code="inscripcionMatricula.alumno.label" default="Alumno" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="alumno" action="show" id="${inscripcionMatriculaInstance?.alumno?.id}">${inscripcionMatriculaInstance?.alumno?.apellido?.encodeAsHTML()+"-"+inscripcionMatriculaInstance?.alumno?.nombre?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-3 spanlabel"><g:message code="inscripcionMatricula.anioLectivo.label" default="Anio Lectivo" /></div>
                            
                            <div class="span-3 spanlabel"><g:link controller="anioLectivo" action="show" id="${inscripcionMatriculaInstance?.anioLectivo?.id}">${inscripcionMatriculaInstance?.anioLectivo?.anioLectivo?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-3 spanlabel"><g:message code="inscripcionMatricula.carrera.label" default="Carrera" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="carrera" action="show" id="${inscripcionMatriculaInstance?.carrera?.id}">${inscripcionMatriculaInstance?.carrera?.denominacion?.encodeAsHTML()}</g:link></div>
							<div class="clear"></div>
							
							<div class="span-3 spanlabel"><g:message code="inscripcionMatricula.estado.label" default="Estado" /></div>
							<div class="span-3 spanlabel">${inscripcionMatriculaInstance?.estado.name}</div>
							<div class="clear"></div>
							
                    		<fieldset>
                    			<legend>Materias a Cursar</legend>
						   		<table id="materiasId"></table>
						   		<div id="pagermateriasId"></div>
                    		</fieldset>
                            
                            
                    
            </div>
            <div class="span-5">
                <g:form>
                    <g:hiddenField name="id" value="${inscripcionMatriculaInstance?.id}" />
                    <%-- span class="button"><g:actionSubmit class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span --%>
                    <span class="button"><g:actionSubmit class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" action="delete" value="${message(code: 'default.button.anular.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.anular.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
