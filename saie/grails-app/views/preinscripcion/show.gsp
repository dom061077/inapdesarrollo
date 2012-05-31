
<%@ page import="com.educacion.academico.Preinscripcion" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'preinscripcion.label', default: 'Preinscripcion')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <script type="text/javascript">
        	$(document).ready(function(){
            	$('#matriculamateriasId').jqGrid({
                	url:'materiasmatriculajson'
                    ,datatype:'json'
                    ,with:680
                    ,colNames:['Id','Denominación',,'Nivel']
                	,colModel:[
                           	{name:'id',index:'id',width:40,hidden:true}
                           	,{name:'denominacion',index:'denominacion',width:'200',search:false,sortable:false}
                           	,{name:'nivel',index:'nivel',width:'200',search:false,sortable:false}
                    ]
                	,rowNum:10
                	,pager:'#pagermatriculamateriasId'
                    ,sortname: 'denominacion'	
                ,
                });
            });
        </script>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="carrerasdisponibles"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all"><H2>${flash.message}</H2></div>
            </g:if>
            <div class="append-bottom">
                    
                            <div class="span-4 spanlabel"><g:message code="preinscripcion.id.label" default="Id" /></div>
                            
                            <div class="span-4 spanlabel">${fieldValue(bean: preinscripcionInstance, field: "id")}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="preinscripcion.alumno.label" default="Alumno:" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="alumno" action="show" id="${preinscripcionInstance?.alumno?.id}">${preinscripcionInstance?.alumno?.apellidoNombre?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>

                            <div class="span-4 spanlabel"><g:message code="preinscripcion.carrera.label" default="Carrera:" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="carrera" action="show" id="${preinscripcionInstance?.carrera?.id}">${preinscripcionInstance?.carrera?.denominacion?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="preinscripcion.anioLectivo.label" default="Nivel:" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="carrera" action="show" id="${preinscripcionInstance?.carrera?.id}">${preinscripcionInstance?.anioLectivo?.anioLectivo?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="preinscripcion.estado.label" default="Estado:" /></div>
                            
                            <div class="span-4 spanlabel">${preinscripcionInstance?.estado?.name?.encodeAsHTML()}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="preinscripcion.fechaAlta.label" default="Fecha Alta:" /></div>
                            
                            <div class="span-4 spanlabel"><g:formatDate format='dd/MM/yyyy' date="${preinscripcionInstance?.fechaAlta}" /></div>
                            
							<div class="clear"></div>
							<g:if test="${preinscripcionInstance?.inscripcionMatricula}">
								<fieldset>
									<legend>Matriculación</legend>
									<table id="matriculamateriasId"></table>
									<div id="pagermatriculamateriasId"></div>
								</fieldset>
							</g:if>
							
                    
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${preinscripcionInstance?.id}" />
                    <span class="button"><g:actionSubmit class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
