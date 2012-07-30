

<%@ page import="com.educacion.academico.AsignaturaDocente" %>
<%@ page import="com.educacion.academico.Carrera" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'asignaturaDocente.label', default: 'AsignaturaDocente')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>
        <script type="text/javascript" src="${g.resource(dir:'js/jquery',file:'jquery.extend.ui.js')}"></script>
        <script type="text/javascript" src="${g.resource(dir:'js/jquery',file:'jquery.cascade.lookupfield.js')}"></script>

        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">
        	$(document).ready(function(){
                 $('#carreraId').cascadelookupfield({grid:{
                     colNames:['Id','Denominación']
                     ,colModel:[{name:'id',index:'id', width:40,hidden:true}
                                ,{name:'denominacion',index:'denominacion', width:92,sortable:true}
                                ],
                     url:'<% out << createLink(controller:"carrera",action:"listsearchjson")%>'}
                 });
                jQuery("#materiasId").jqGrid({
                    url:'listjson',
                    datatype: "json",
                    width:680,
                    colNames:['Id','Nº Documento','Apellido','Nombre','Opciones'],
                    colModel:[

                        {name:'id',index:'id', width:40,hidden:true},
                        {name:'numeroDocumento',index:'numeroDocumento', width:92,sortable:false,search:true,searchoptions:{sopt:['eq']}},
                        {name:'apellido',index:'apellido', width:92,sortable:true},
                        {name:'nombre',index:'nombre', width:100,search:true},
                        {name:'operaciones',index:'operaciones', width:55,search:false,sortable:false}
                    ],

                    rowNum:10,
                    rownumbers:true,
                    rowList:[10,20,30],
                    pager: '#pagermateriasId',
                    sortname: 'id',
                    viewrecords: true,
                    sortorder: "desc",
                    gridComplete: function(){
                        var ids = jQuery("#list").jqGrid('getDataIDs');
                        var obj;
                        for(var i=0;i < ids.length;i++){
                            var cl = ids[i];
                            obj = jQuery("#list").getRowData(ids[i]);
                            be = "<a title='Editar' href='edit/"+ids[i]+"'><span class='ui-icon ui-icon-pencil' style='float:left;margin: 3px 3px 3px 5px'  ></span></a>";
                            var se = "<a title='Ver' href='show/"+ids[i]+"'><span class='ui-icon ui-icon-search' style='float:left;margin: 3px 3px 3px 5px'  ></span></a>";
                            jQuery("#list").jqGrid('setRowData',ids[i],{operaciones:be+se});
                        }
                    },
                   // caption:"Listado de ${message(code: 'docente.label', default: 'Docente')}"
                });
                //jQuery("#list").jqGrid('navGrid','#pagermateriasId',{search:false,edit:false,add:false,del:false,pdf:true});

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
            <g:hasErrors bean="${asignaturaDocenteInstance}">
            <div class="ui-state-error ui-corner-all append-bottom">
                <g:renderErrors bean="${asignaturaDocenteInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
            		<div class="append-bottom">	
                        
							<g:hasErrors bean="${asignaturaDocenteInstance}" field="carrera">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3">
								<label for="carreraDesc"><g:message code="asignaturaDocente.carrera.label" default="Carrera" /></label>
							</div>
							<div class="span-5">
								<g:textField class="ui-widget ui-corner-all ui-widget-content" id="carreraId" name="carreraDesc"  value="colocar el valor del field descripcion" />
                                <g:hiddenField id="carreraIdId" name="carrera.id" value="${carrera?.id}" />
							</div>
										
							<g:hasErrors bean="${asignaturaDocenteInstance}" field="carrera">
								<g:renderErrors bean="${asignaturaDocenteInstance}" as="list" field="carrera"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${asignaturaDocenteInstance}" field="anioLectivo">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="anioLectivoDesc"><g:message code="asignaturaDocente.anioLectivo.label" default="Anio Lectivo" /></label>
							</div>
							<div class="span-5">
								<g:textField class="ui-widget ui-corner-all ui-widget-content" id="anioLectivoId" name="anioLectivoDesc"  value="colocar el valor del field descripcion" />
                                <g:hiddenField id="anioLectivoIdId" name="anioLectivo.id" value="${anioLectivo?.id}" />
							</div>
										
							<g:hasErrors bean="${asignaturaDocenteInstance}" field="anioLectivo">
								<g:renderErrors bean="${asignaturaDocenteInstance}" as="list" field="anioLectivo"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>

																	
                        
							<g:hasErrors bean="${asignaturaDocenteInstance}" field="docente">
								<div class="ui-state-error ui-corner-all append-bottom">
							</g:hasErrors>
							
							<div class="span-3 spanlabel">
								<label for="docenteDesc"><g:message code="asignaturaDocente.docente.label" default="Docente" /></label>
							</div>
							<div class="span-5">
								<g:textField class="ui-widget ui-corner-all ui-widget-content" id="docenteId" name="docenteDesc"  value="colocar el valor del field descripcion" /> 
                                <g:hiddenField id="docenteIdId" name="docente.id" value="${docente?.id}" />
							</div>
										
							<g:hasErrors bean="${asignaturaDocenteInstance}" field="docente">
								<g:renderErrors bean="${asignaturaDocenteInstance}" as="list" field="docente"/>
								</div>
						   </g:hasErrors>
						   <div class="clear"></div>
                           <fieldset>
                               <legend>Materias a Dictar</legend>
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
