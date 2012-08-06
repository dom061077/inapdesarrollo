
<%@ page import="com.educacion.academico.AsignaturaDocente" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'asignaturaDocente.label', default: 'AsignaturaDocente')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>

        <script type="text/javascript">
            $(document).ready(function(){
                $('#materiasId').jqGrid({
                    url:'<%out << createLink(controller:"asignaturaDocente",action:"materiasjson",params:[id:asignaturaDocenteInstance.id]) %>',
                    datatype: "json",
                    width:680,
                    colNames:['Id','Código','Nombre','Nivel','Carrera'],
                    colModel:[

                        {name:'id',index:'id', width:40,hidden:true},
                        {name:'codigo',index:'codigo',width:40},
                        {name:'denominacion',index:'denominacion', width:92,sortable:false},
                        {name:'nivel_descripcion',index:'nivel_descripcion', width:100,search:true},
                        {name:'nivel_carrera_denominacion',index:'nivel_carrera_denominacion', width:100,search:true}
                    ],

                    rowNum:10,
                    //rownumbers:true,
                    rowList:[10,20,30],
                    pager: '#pagerMateriasId',
                    sortname: 'id',
                    viewrecords: true,
                    sortorder: "desc",
                    caption:"Listado de ${message(code: 'materia.label', default: 'Materia')}"
                });
                jQuery("#materiasId").jqGrid('navGrid','#pagerMateriasId',{search:false,edit:false,add:false,del:false,pdf:true});

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
            <div class="dialog">


                            <div class="span-4 spanlabel"><g:message code="asignaturaDocente.carrera.label" default="Carrera" /></div>
                            
                            <div class="span-4 spanlabel"><g:link controller="carrera" action="show" id="${asignaturaDocenteInstance?.carrera?.id}">${asignaturaDocenteInstance?.carrera?.denominacion?.encodeAsHTML()}</g:link></div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="asignaturaDocente.anioLectivo.label" default="Anio Lectivo" /></div>
                            
                            <div class="span-4 spanlabel">${asignaturaDocenteInstance?.anioLectivo?.anioLectivo?.encodeAsHTML()}</div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="asignaturaDocente.docente.label" default="Docente" /></div>
                            
                            <div class="span-4 spanlabel">
                                <g:link controller="docente" action="show" id="${asignaturaDocenteInstance?.id}">
                                    ${(asignaturaDocenteInstance?.docente?.apellido+"-"+asignaturaDocenteInstance?.docente?.nombre).encodeAsHTML()}
                                </g:link>
                            </div>
                            
							<div class="clear"></div>
                    
                            <div class="span-4 spanlabel"><g:message code="asignaturaDocente.fechaAlta.label" default="Fecha Alta" /></div>
                            
                            <div class="span-4 spanlabel"><g:formatDate date="${asignaturaDocenteInstance?.fechaAlta}" format="dd/MM/yyyy" /></div>
                            
							<div class="clear"></div>
                
                            <fieldset>
                                <legend>Materias</legend>
                                <table id="materiasId"></table>
                                <div id="pagerMateriasId"></div>
                            </fieldset>
                    
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${asignaturaDocenteInstance?.id}" />
                    <span class="button"><g:actionSubmit class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
