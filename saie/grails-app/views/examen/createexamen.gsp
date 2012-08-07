<%@ page import="com.educacion.academico.Examen" %>
<%@ page import="com.educacion.enums.examen.TipoExamenEnum" %>
<%@ page import="com.educacion.enums.examen.ModalidadExamenEnum" %>


<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'examen.label', default: 'Examen')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
    <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
    <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
    <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
    <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: "js/jquery",file: "jquery.extend.ui.js")}"></script>
    <script type="text/javascript" src="${g.resource(dir:'js/jquery',file:'jquery.jlookupfieldcascade.js')}"></script>

    <script type="text/javascript">
        var nivel;

        $(document).ready(function(){
           $('#tipoId').combobox();
           $('#modalidadId').combobox();
            $('#carreraId').combolookupfield({
                grid:{
                    colNames:['Id','Denominación']
                    ,colModel:[{name:'id',index:'id', width:40,hidden:true}
                        ,{name:'denominacion',index:'denominacion', width:92,search:true,sortable:true}
                    ],
                    url:'<% out << createLink(controller:"carrera",action:"listsearchjson")%>'
                }
                //inputNameDesc:'carreraDesc'
                ,onSelected:function(){
                    nivel.clear();
                }
            });
            $('#nivelId').combolookupfield({
                grid:{
                    colNames:['Id','Descripción']
                    ,colModel:[{name:'id',index:'id', width:40,hidden:true}
                        ,{name:'descripcion',index:'descripcion', width:92,search:true,sortable:true}
                    ],
                    url:'<% out << createLink(controller:"nivel",action:"listsearchjson")%>'
                }
                //inputNameDesc:'carreraDesc'
                ,cascade:{
                    elementCascadeId:'carreraId',
                    paramName:'carrera_id'
                }

                ,onSelected:function(){
                    //anios.clear();
                    //$('#materiasId').clearGridData();

                }
            });















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
    <g:form action="saveexamen" >
        <div class="append-bottom">
            <div class="span-3">
                <label for="carreraId"><g:message code="examen.carrera.label"/></label>
            </div>
            <div class="span-4">
                <input type="text" class="ui-widget ui-corner-all ui-widget-content" id="carreraId" name="carreraId" descValue="${cmd?.carreraDesc}" value="${cmd?.carreraId}" />

            </div>
            <div class="clear"></div>

            <div class="span-3">
                <label for="nivelId"><g:message code="examen.nivel.label"/></label>
            </div>
            <div class="span-4">
                <%-- g:textField name="nivelId" class="ui-widget ui-corner-all ui-widget-content" id="nivelId" descValue="${cmd?.nivelDesc}" value="${cmd?.nivelId}" / --%>
            </div>
            <div class="clear"></div>


            <div class="span-3 spanlabel">
                <label for="materiaDesc"><g:message code="examen.materia.label"/></label>
            </div>
            <div class="span-4">
                <%-- g:textField name="materiaDesc" class="ui-widget ui-corner-all ui-widget-content" id="materiaId" descValue="${cmd?.materiaDesc}" value="${cmd?.materiaId}" / --%>
            </div>
            <div class="clear"></div>

            <div class="span-3 spanlabel">
                <label for="materiaDesc"><g:message code="examen.docente.label"/></label>
            </div>
            <div class="span-4">
                <%-- g:textField name="docenteDesc" class="ui-widget ui-corner-all ui-widget-content" id="docenteId" descValue="${cmd?.docenteDesc}" value="${cmd?.docenteId}" / --%>
            </div>
            <div class="clear"></div>


            <div class="span-3 spanlabel">
                <label for="titulo"><g:message code="examen.titulo.label"/></label>
            </div>
            <div class="span-4">
                <%-- g:textField name="titulo" class="ui-widget ui-corner-all ui-widget-content" id="tituloId" value="${cmd?.titulo}" / --%>
            </div>
            <div class="clear"></div>

            <div class="append-bottom">
                <div class="span-3">
                    <label for="tipo"><g:message code="examen.tipo.label"/></label>
                </div>
                <div class="span-4">
                    <g:select name="tipo" from="${TipoExamenEnum.list()}"  optionValue="name"
                              class="ui-widget ui-corner-all ui-widget-content" id="tipoId" value="${cmd?.tipo}" />
                </div>
                <div class="clear"></div>
            </div>

            <div class="span-3">
                <label for="modalidad"><g:message code="examen.modalidad.label"/></label>
            </div>
            <div class="span-4">
                <g:select name="modalidad" from="${ModalidadExamenEnum.list()}"  optionValue="name"
                          class="ui-widget ui-corner-all ui-widget-content" id="modalidadId" value="${cmd?.modalidad}" />
            </div>
            <div class="clear"></div>


        </div>
        <div class="buttons">
            <span class="button"><g:submitButton name="create" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
        </div>
    </g:form>
</div>
</body>
</html>
