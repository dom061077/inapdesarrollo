

<%@ page import="com.educacion.alumno.Asistencia" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'asistencia.label', default: 'Asistencia')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: "js/jquery",file: "jquery.extend.ui.js")}"></script>
        <script type="text/javascript" src="${g.resource(dir:'js/jquery',file:'jquery.jlookupfieldcascade.js')}"></script>
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">
        	$(document).ready(function(){
                    $.datepicker.setDefaults($.datepicker.regional[ 'es' ]);
                    $('#fechaId' ).datepicker({changeYear:true});

                    $('#carreraId').combolookupfield({
                        grid:{
                            colNames:['Id','Denominación']
                            ,colModel:[{name:'id',index:'id', width:40,hidden:true}
                                ,{name:'denominacion',index:'denominacion', width:92,search:true,sortable:true}
                            ],
                            url:'<% out << createLink(controller:"carrera",action:"listsearchjson")%>'
                        }
                        ,inputNameDesc:'carreraDesc'
                        ,onSelected:function(){
                            nivel.clear();
                            materia.clear();
                            docente.clear();
                        }
                    });

                nivel=$('#nivelId').combolookupfield({
                    grid:{
                        colNames:['Id','Descripción']
                        ,colModel:[{name:'id',index:'id', width:40,hidden:true}
                            ,{name:'descripcion',index:'descripcion', width:92,search:true,sortable:true}
                        ],
                        url:'<% out << createLink(controller:"nivel",action:"listsearchjson")%>'
                    }
                    ,inputNameDesc:'nivelDesc'
                    ,cascade:{
                        elementCascadeId:['carreraId'],
                        paramName:['carrera_id']
                    }

                    ,onSelected:function(){
                        materia.clear();
                    }
                });

                materia=$('#materiaId').combolookupfield({
                    grid:{
                        colNames:['Id','Denominación','Nivel','Carrera']
                        ,colModel:[{name:'id',index:'id', width:40,hidden:true}
                            ,{name:'denominacion',index:'denominacion', width:92,search:true,sortable:true}
                            ,{name:'nivel_deescripcion',index:'nivel_descripcion', width:92,search:true,sortable:true}
                            ,{name:'carrera_denominacion',index:'carrera_denominacion', width:92,search:true,sortable:true}
                        ],
                        url:'<% out << createLink(controller:"materia",action:"listsearchjson")%>'
                    }
                    ,inputNameDesc:'materiaDesc'
                    ,cascade:{
                        elementCascadeId:['nivelId'],
                        paramName:['nivel_id']
                    }

                    ,onSelected:function(){
                        docente.clear();
                    }
                });


                // Grilla de Alumnos
                jQuery("#list").jqGrid({
                    //url:'listjsonalumnos',
                    url:'<%out << createLink(controller:"asistencia",action:"listjsonalumnos")%>',
                    datatype: 'json',
                    width:680,
                    colNames:['Id','Apellido','Nombre','Tipo Documento','Nro. de Doc.','P/A'],
                    colModel:[
                        {name:'id',index:'id', width:40,sorttype:'int',search:false,sortable:true},
                        {name:'apellido',index:'apellido', width:92,search:false,sortable:true},
                        {name:'nombre',index:'nombre', width:92,search:false,sortable:true},
                        {name:'tipoDocumento',index:'tipoDocumento', width:55,search:false},
                        {name:'numeroDocumento',index:'numeroDocumento', width:55,search:false,sorttype:'int',sortable:true,searchoptions:{sopt:['eq']}},
                        {name:'seleccion', index: 'seleccion',width:10,search:false,formatter:"checkbox",formatoptions: { disabled: false }, editable: true, edittype: "checkbox" }
                    ],

                    rowNum:10,
                    //rownumbers:true,
                    rowList:[10,20,30],
                    pager: '#pager',
                    sortname: 'id',
                    viewrecords: true,
                    sortorder: "desc",
                    gridComplete: function(){

                    },
                    caption:"Listado de Alumnos"
                });
                jQuery("#list").jqGrid('navGrid','#pager',{search:false,edit:false,add:false,del:false,pdf:false});

                jQuery("#list").jqGrid('filterToolbar',{stringResult:true,searchOnEnter:true});


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
            <g:hasErrors bean="${asistenciaInstance}">
            <div class="ui-state-error ui-corner-all append-bottom">
                <g:renderErrors bean="${asistenciaInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >


                    <g:if test="${flash.message}">
                        <div class="ui-state-highlight ui-corner-all append-bottom"><H2>${flash.message}</H2></div>
                    </g:if>

                    <g:hasErrors bean="${asitenciaInstance}" field="nivel">
                        <div class="ui-state-error ui-corner-all append-bottom">
                    </g:hasErrors>
                    <div class="span-2">
                        <label for="carreraId"><g:message code="asistencia.carrera.label" default="Carrera"/></label>
                    </div>
                    <div class="span-4">
                        <input type="text" class="ui-widget ui-corner-all ui-widget-content" id="carreraId" name="carreraid" descValue="${asitenciaInstance?.nivel?.carrera?.denominacion}" value="${asitenciaInstance?.nivel?.carrera?.id}" />
                    </div>
                    <g:hasErrors bean="${asitenciaInstance}" field="nivel">
                        <g:renderErrors bean="${asitenciaInstance}" as="list" field="nivel"/>
                        </div>
                    </g:hasErrors>


                <div class="clear"></div>


                    <g:hasErrors bean="${asitenciaInstance}" field="nivel">
                        <div class="ui-state-error ui-corner-all append-bottom">
                    </g:hasErrors>
                    <div class="span-2">
                        <label for="nivelId"><g:message code="asistencia.nivel.label" default="Nivel"/></label>
                    </div>
                    <div class="span-4">
                        <input name="nivel.id" class="ui-widget ui-corner-all ui-widget-content" id="nivelId" descValue="${asitenciaInstance?.nivel?.descripcion}" value="${asitenciaInstance?.nivel?.id}" />
                    </div>
                    <g:hasErrors bean="${asitenciaInstance}" field="nivel">
                        <g:renderErrors bean="${asitenciaInstance}" as="list" field="nivel"/>
                        </div>
                    </g:hasErrors>


                <div class="clear"></div>


                    <g:hasErrors bean="${asitenciaInstance}" field="materia">
                        <div class="ui-state-error ui-corner-all append-bottom">
                    </g:hasErrors>
                    <div class="span-2">
                        <label for="materiaId"><g:message code="asistencia.materia.label" default="Materia"/></label>
                    </div>
                    <div class="span-4">
                        <input name="materia.id" class="ui-widget ui-corner-all ui-widget-content" id="materiaId" descValue="${asitenciaInstance?.materia?.denominacion}" value="${asitenciaInstance?.materia?.id}" />
                    </div>
                    <g:hasErrors bean="${asitenciaInstance}" field="materia">
                        <g:renderErrors bean="${asitenciaInstance}" as="list" field="materia"/>
                        </div>
                    </g:hasErrors>


                <div class="clear"></div>


                    <div class="span-2 spanlabel">
                        <label for="fecha"><g:message code="asistencia.fecha.label" default="Fecha" /></label>
                    </div>
                    <div class="span-4">
                        <g:textField id="fechaId" class="ui-widget ui-corner-all ui-widget-content" name="fecha" value="${g.formatDate(format:'dd/MM/yyyy',date:asistenciaInstance?.fechaAsistencia)}" />
                    </div>
                    <g:hasErrors bean="${asistenciaInstance}" field="fechaAsistencia">
                        <g:renderErrors bean="${asistenciaInstance}" as="list" field="fechaAsistencia"/>
                        </div>
                    </g:hasErrors>


                    <div class="clear"></div>


                    <table style="z-index:1"  id="list"></table>
                    <div id="pager" ></div>

            		<div class="append-bottom">
				</div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
