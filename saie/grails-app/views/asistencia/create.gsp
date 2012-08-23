

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
                    $('#fechaId' ).datepicker({
                        changeYear:true,
                        onSelect: function(dateText,inst){
                            var grid = $('#list');
                            $.extend(grid[0].p.postData,{carreraId:$('#carreraId').val(),nivelId:$('#nivelId').val()
                                    ,materiaId:$('#materiaId').val(),fecha:$('#fechaId').val()
                                    ,divisionId:$('#divisionId').val()});
                            grid.trigger("reloadGrid",[{page:1}]);

                        }
                    });

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
                    }
                });

                division=$('#divisionId').combolookupfield({
                    grid:{
                        colNames:['Id','Letra','Descripción']
                        ,colModel:[{name:'id',index:'id', width:40,hidden:true}
                            ,{name:'letra',index:'letra', width:92,search:true,sortable:true}
                            ,{name:'descripcion',index:'descripcion', width:92,search:true,sortable:true}
                        ],
                        url:'<% out << createLink(controller:"division",action:"listcombosearchjson")%>'
                    }
                    ,inputNameDesc:'divisionDesc'
                    ,cascade:{
                        elementCascadeId:['nivelId'],
                        paramName:['nivel_id']
                    }

                    ,onSelected:function(){
                        $('#fechaId').val('');
                    }
                });

                // Grilla de Alumnos
                jQuery("#list").jqGrid({
                    //url:'listjsonalumnos',
                    url:'<%out << createLink(controller:"inscripcionMateria",action:"listinscparaasistencia")%>',
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
            <g:hasErrors bean="${cmd}">
            <div class="ui-state-error ui-corner-all append-bottom">
                <g:renderErrors bean="${cmd}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="savecommand" >


                    <g:if test="${flash.message}">
                        <div class="ui-state-highlight ui-corner-all append-bottom"><H2>${flash.message}</H2></div>
                    </g:if>

                    <g:hasErrors bean="${cmd}" field="carreraId">
                        <div class="ui-state-error ui-corner-all append-bottom">
                    </g:hasErrors>
                    <div class="span-2">
                        <label for="carreraId"><g:message code="asistencia.carrera.label" default="Carrera"/></label>
                    </div>
                    <div class="span-4">
                        <input type="text" class="ui-widget ui-corner-all ui-widget-content" id="carreraId" name="carreraId" descValue="${cmd?.carreraDesc}" value="${cmd?.carreraId}" />
                    </div>
                    <g:hasErrors bean="${cmd}" field="carreraId">
                        <g:renderErrors bean="${cmd}" as="list" field="carreraId"/>
                        </div>
                    </g:hasErrors>


                <div class="clear"></div>


                    <g:hasErrors bean="${cmd}" field="nivelId">
                        <div class="ui-state-error ui-corner-all append-bottom">
                    </g:hasErrors>
                    <div class="span-2">
                        <label for="nivelId"><g:message code="asistencia.nivel.label" default="Nivel"/></label>
                    </div>
                    <div class="span-4">
                        <input name="nivelId" class="ui-widget ui-corner-all ui-widget-content" id="nivelId" descValue="${cmd?.nivelDesc}" value="${cmd?.nivelId}" />
                    </div>
                    <g:hasErrors bean="${cmd}" field="nivelId">
                        <g:renderErrors bean="${cmd}" as="list" field="nivelId"/>
                        </div>
                    </g:hasErrors>


                <div class="clear"></div>


                    <g:hasErrors bean="${cmd}" field="materiaId">
                        <div class="ui-state-error ui-corner-all append-bottom">
                    </g:hasErrors>
                    <div class="span-2">
                        <label for="materiaId"><g:message code="asistencia.materia.label" default="Materia"/></label>
                    </div>
                    <div class="span-4">
                        <input name="materiaId" class="ui-widget ui-corner-all ui-widget-content" id="materiaId" descValue="${cmd?.materiaDesc}" value="${cmd?.materiaId}" />
                    </div>
                    <g:hasErrors bean="${cmd}" field="materiaId">
                        <g:renderErrors bean="${cmd}" as="list" field="materiaId"/>
                        </div>
                    </g:hasErrors>


                <div class="clear"></div>

                <g:hasErrors bean="${cmd}" field="divisionId">
                    <div class="ui-state-error ui-corner-all append-bottom">
                </g:hasErrors>
                <div class="span-2">
                    <label for="divisionId"><g:message code="asistencia.division.label" default="División"/></label>
                </div>
                <div class="span-4">
                    <input name="divisionId" class="ui-widget ui-corner-all ui-widget-content" id="divisionId" descValue="${cmd?.divisionDesc}" value="${cmd?.divisionId}" />
                </div>
                <g:hasErrors bean="${cmd}" field="divisionId">
                    <g:renderErrors bean="${cmd}" as="list" field="divisionId"/>
                    </div>
                </g:hasErrors>


                <div class="clear"></div>

                    <g:hasErrors bean="${cmd}" field="fecha">
                        <div class="ui-state-error ui-corner-all append-bottom">
                    </g:hasErrors>
                    <div class="span-2 spanlabel">
                        <label for="fecha"><g:message code="asistencia.fecha.label" default="Fecha" /></label>
                    </div>
                    <div class="span-4">
                        <g:textField id="fechaId" class="ui-widget ui-corner-all ui-widget-content" name="fecha" value="${g.formatDate(format:'dd/MM/yyyy',date:cmd?.fecha)}" />
                    </div>
                    <g:hasErrors bean="${cmd}" field="fecha">
                        <g:renderErrors bean="${cmd}" as="list" field="fecha"/>
                        </div>
                    </g:hasErrors>


                    <div class="clear"></div>


                    <table style="z-index:1"  id="list"></table>
                    <div id="pager" ></div>

            		<div class="append-bottom">
				</div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="${message(code: 'default.button.save.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
