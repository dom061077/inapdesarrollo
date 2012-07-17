<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.educacion.academico.Carrera" %>


<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
    <title><g:message code="materia.calificaciones.create.label"  /></title>
    <script type="text/javascript" src="${resource(dir: "js/jquery",file: "jquery.extend.ui.js")}"></script>
    <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
    <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
    <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
    <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>


    <script type="text/javascript">
        $(document).ready(function(){
            $('#carreraId').combobox({
                onSelect:function(event,ui){
                    $('#nivelId').combobox('reloadcmb',{carreraId:$('#carreraId').val()})
                }
            });
            $('#nivelId').combobox({
                reload:{url:'<%out << createLink(controller:"nivel",action:"listjsonautocomplete")%>'}
                ,onSelect:function(event,ui){
                    $('#materiaId').combobox('reloadcmb',{nivelId:$('#nivelId').val()});
                }
            });
            $('#nivelId').combobox('reloadcmb',{carreraId:$('#carreraId').val()})
            $('#materiaId').combobox({
                reload:{url:'<%out << createLink(controller:"materia",action:"listjsonautocomplete")%>'}
            });
            $('#alumnosInscriptosId').jqGrid({
                url:'<%out<<createLink(controller:"inscripcionMateria",action:"listdetalleinscripcion")%>',
                datatype:'json',
                colNames:['Id','IdId','Alumno','Calificación','Nota'],
                colModel:[
                    {name:'id',index:'id',hidden:true}
                    ,{name:'idid',index:'idid',hidden:true}
                    ,{name:'alumno',index:'alumno',width:150,search:true,sortable:true}
                    ,{name:'estado',index:'estado',width:100}
                    ,{name:'nota',index:'nota'}
                ]
                ,pager:'#pagerAlumnosInscriptosId'
                ,caption:'Inscriptos'
            });
            //var grid = $('#divisionesId');
            //$.extend(grid[0].p.postData,{nivelid:$('#nivelIdId').val(),carreraid:$('#carreraIdId').val()});
            //grid.trigger("reloadGrid",[{page:1}]);

        });

    </script>
</head>
<body>
    <div class="nav">
        <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
    </div>
    <div class="body">
        <h1><g:message code="materia.calificaciones.create.label"  /></h1>
        <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all"><H2>${flash.message}</H2></div>
        </g:if>
        <div class="append-bottom">
            <div class="append-bottom">
                <div class="span-2">
                    <label for="carrera"><g:message code="carrera.label"></g:message>  </label>
                </div>
                <div class="span-7">
                    <g:select id="carreraId"   from="${Carrera.list()}" name="carrera" optionKey="id" optionValue="denominacion" ></g:select>
                </div>
                <div class="clear"></div>
            </div>
            <div class="append-bottom">
                <div class="span-2">
                    <label for="nivel"><g:message code="nivel.label"></g:message></label>
                </div>
                <div class="span-3">
                    <g:select id="nivelId" class="ui-widget ui-corner-all ui-widget-content" name="nivel"></g:select>
                </div>
                <div class="clear"></div>
            </div>

            <div class="append-bottom">
                <div class="span-2">
                    <label for="materia"><g:message code="materia.label"/></label>
                </div>
                <div>
                    <g:select id="materiaId" name="materia"></g:select>
                </div>
            </div>
            <fieldset>
                <legend>Alumnos Inscriptos</legend>
                <table id="alumnosInscriptosId"></table>
                <div id="pagerAlumnosInscriptosId"></div>
            </fieldset>

        </div>
    </div>
</body>
</html>