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

    <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
    <script type="text/javascript">


        $(document).ready(function(){
           var filternivel = { groupOp: "AND", rules: []};
           filternivel.rules.push({field:"carrera_id",op:"eq",data:$('#carreraIdId').val()});
           var filtermateria = { groupOp: "AND", rules: []};
           filtermateria.rules.push({field:"nivel_id",op:"eq",data:$('#nivelIdId').val()});


           $('#tipoId').combobox();
           $('#modalidadId').combobox();


            $('#carreraId').lookupfield({source:'<%out<<createLink(controller:'carrera',action:'listsearchjson')%>',
                title:'Búsqueda de Carreras'
                ,colNames:['Id','Denominación']
                ,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:true,search:false}
                    ,{name:'denominacion',index:'denominacion', width:100,  sortable:true,search:true}
                ]
                ,hiddenid:'carreraIdId'
                ,descid:'carreraId'
                ,hiddenfield:'id'
                ,descfield:['denominacion']
                ,onSelected:function(){
                    var filter = { groupOp: "AND", rules: []};
                    filter.rules.push({field:"carrera_id",op:"eq",data:$('#carreraIdId').val()});
                    var grid = $('#nivelIdtablesearchId')
                    grid[0].p.search = filter.rules.length>0;
                    $.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
                    grid.trigger("reloadGrid",[{page:1}]);
                    $('#nivelId').val('');
                    $('#nivelIdId').val('');
                    $('#materiaId').val('');
                    $('#materiaIdId').val('');


                }
                ,onKeyup:function(){
                    if($.trim($('#carreraId').val())==""){
                        var filter = { groupOp: "AND", rules: []};
                        filter.rules.push({field:"carrera_id",op:"eq",data:0});
                        var grid = $('#nivelIdtablesearchId')
                        grid[0].p.search = filter.rules.length>0;
                        $.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
                        grid.trigger("reloadGrid",[{page:1}]);
                        $('#nivelId').val('');
                        $('#nivelIdId').val('');
                        $('#materiaId').val('');
                        $('#materiaIdId').val('');

                    }
                }
            });

            $('#carreraId' ).autocomplete({source: '<%out<<createLink(controller:'carrera',action:'listjsonautocomplete')%>',
                minLength: 2,
                select: function( event, ui ) {
                    if(ui.item){
                        $('#carreraIdId').val(ui.item.id)

                        var filter = { groupOp: "AND", rules: []};
                        filter.rules.push({field:"carrera_id",op:"eq",data:ui.item.id});
                        var grid = $('#nivelIdtablesearchId')
                        grid[0].p.search = filter.rules.length>0;
                        $.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
                        grid.trigger("reloadGrid",[{page:1}]);
                        $('#nivelId').val('');
                        $('#nivelIdId').val('');
                        $('#materiaId').val('');
                        $('#materiaIdId').val('');
                    }
                },
                open: function() {
                    $( this ).removeClass( 'ui-corner-all' ).addClass( 'ui-corner-top' );
                },
                close: function() {
                    $( this ).removeClass( 'ui-corner-top' ).addClass( 'ui-corner-all' );
                }
            });



            $('#nivelId').lookupfield({source:'<%out<<createLink(controller:'nivel',action:'listsearchjson')%>',
                title:'Búsqueda de niveles'
                ,colNames:['Id','Descripcion','Carrera','Es primer nivel']
                ,colModel:[
                    {name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:true,search:false}
                    ,{name:'descripcion',index:'descripcion', width:100,  sortable:true,search:true}
                    ,{name:'carrera',index:'carrear',hidden:false}
                    ,{name:'esprimernivel',index:'esprimernivel',width:100,sortable:false,search:false} ]
                ,hiddenid:'nivelIdId'
                ,descid:'nivelId'
                ,hiddenfield:'id'
                ,altfilters:filternivel
                ,descfield:['descripcion']
                ,onSelected:function(){
                    var filter = { groupOp: "AND", rules: []};
                    filter.rules.push({field:"nivel_id",op:"eq",data:$('#nivelIdId').val()});
                    var grid = $('#materiaIdtablesearchId')
                    grid[0].p.search = filter.rules.length>0;
                    $.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
                    grid.trigger("reloadGrid",[{page:1}]);
                    $('#materiaId').val('');
                    $('#materiaIdId').val('');
                }
                ,onKeyup:function(){
                    if($.trim($('#carreraId').val())==""){
                        var filter = { groupOp: "AND", rules: []};
                        filter.rules.push({field:"materia_id",op:"eq",data:0});
                        var grid = $('#materiaIdtablesearchId')
                        grid[0].p.search = filter.rules.length>0;
                        $.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
                        grid.trigger("reloadGrid",[{page:1}]);
                        $('#materiaId').val('');
                        $('#materiaIdId').val('');
                    }
                }

            });

            $('#nivelId' ).autocomplete({
                source: function( request, response ) {
                    $.ajax({
                        url: '<%out<<createLink(controller:'nivel',action:'listjsonautocomplete')%>',
                        //dataType: "jsonp",
                        data: {
                            carreraId:$('#carreraIdId').val(),
                            term: request.term
                        },
                        success: function( data ) {
                            response( $.map( data, function( item ) {
                                return {
                                    label: item.label,
                                    value: item.value,
                                    id: item.id
                                }
                            }));
                        },
                        error:function(jqXHR, textStatus, errorThrown){
                            alert('ERROR');
                        }
                    });
                }
                ,
                minLength: 2,
                select: function( event, ui ) {
                    if(ui.item){
                        $('#nivelIdId').val(ui.item.id);

                    }
                },
                open: function() {
                    $( this ).removeClass( 'ui-corner-all' ).addClass( 'ui-corner-top' );
                },
                close: function() {
                    $( this ).removeClass( 'ui-corner-top' ).addClass( 'ui-corner-all' );
                }
            });

            $('#materiaId').lookupfield({source:'<%out<<createLink(controller:'materia',action:'listsearchjson')%>',
                title:'Búsqueda de Materias'
                ,colNames:['Id','Denominación']
                ,colModel:[
                    {name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:true,search:false}
                    ,{name:'denominacion',index:'denominacion', width:100,  sortable:true,search:true} ]
                ,hiddenid:'materiaIdId'
                ,descid:'materiaId'
                ,altfilters:filtermateria
                ,hiddenfield:'id'
                ,descfield:['denominacion']

            });

            $('#materiaId' ).autocomplete({
                source: function( request, response ) {
                    $.ajax({
                        url: '<%out<<createLink(controller:'materia',action:'listjsonautocomplete')%>',
                        //dataType: "jsonp",
                        data: {
                            nivelId:$('#nivelIdId').val(),
                            term: request.term
                        },
                        success: function( data ) {
                            response( $.map( data, function( item ) {
                                return {
                                    label: item.label,
                                    value: item.value,
                                    id: item.id
                                }
                            }));
                        },
                        error:function(jqXHR, textStatus, errorThrown){
                            alert('ERROR');
                        }
                    });
                }
                ,
                minLength: 2,
                select: function( event, ui ) {
                    if(ui.item){
                        $('#materiaIdId').val(ui.item.id);

                    }
                },
                open: function() {
                    $( this ).removeClass( 'ui-corner-all' ).addClass( 'ui-corner-top' );
                },
                close: function() {
                    $( this ).removeClass( 'ui-corner-top' ).addClass( 'ui-corner-all' );
                }
            });

            $('#docenteId').lookupfield({source:'<%out<<createLink(controller:'docente',action:'listsearchjson')%>',
                title:'Búsqueda de Docentes'
                ,colNames:['Id','Nº Documento','Apellido', 'Nombre']
                ,colModel:[
                    {name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:true,search:false}
                    ,{name:'numeroDocumento',index:'numeroDocumento', width:100,  sortable:true,search:true,searchoptions:{sopt:['eq']} }
                    ,{name:'apellido',index:'apellido', width:100,  sortable:true,search:true}
                    ,{name:'nombre',index:'nombre', width:100,  sortable:true,search:true} ]
                ,hiddenid:'docenteIdId'
                ,descid:'docenteId'
                ,hiddenfield:'id'
                ,descfield:['apellido','nombre']

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
            <div class="span-3 spanlabel">
                <label for="carreraDesc"><g:message code="examen.carrera.label"/></label>
            </div>
            <div class="span-4">
                <g:textField name="carreraDesc" class="ui-widget ui-corner-all ui-widget-content" id="carreraId" value="${cmd?.carreraDesc}" />
                <g:hiddenField name="carreraId" id="carreraIdId"  value="${cmd?.carreraId}"/>
            </div>
            <div class="clear"></div>

            <div class="span-3 spanlabel">
                <label for="carreraDesc"><g:message code="examen.nivel.label"/></label>
            </div>
            <div class="span-4">
                <g:textField name="nivelDesc" class="ui-widget ui-corner-all ui-widget-content" id="nivelId" value="${cmd?.nivelDesc}" />
                <g:hiddenField name="nivelId" id="nivelIdId"  value="${cmd?.nivelId}"/>
            </div>
            <div class="clear"></div>


            <div class="span-3 spanlabel">
                <label for="materiaDesc"><g:message code="examen.materia.label"/></label>
            </div>
            <div class="span-4">
                <g:textField name="materiaDesc" class="ui-widget ui-corner-all ui-widget-content" id="materiaId" value="${cmd?.materiaDesc}" />
                <g:hiddenField id="materiaIdId" name="materiaId" value="${cmd?.materiaId}"/>
            </div>
            <div class="clear"></div>

            <div class="span-3 spanlabel">
                <label for="materiaDesc"><g:message code="examen.docente.label"/></label>
            </div>
            <div class="span-4">
                <g:textField name="docenteDesc" class="ui-widget ui-corner-all ui-widget-content" id="docenteId" value="${cmd?.docenteDesc}" />
                <g:hiddenField id="docenteIdId" name="docenteId" value="${cmd?.docenteId}"/>
            </div>
            <div class="clear"></div>


            <div class="span-3 spanlabel">
                <label for="titulo"><g:message code="examen.titulo.label"/></label>
            </div>
            <div class="span-4">
                <g:textField name="titulo" class="ui-widget ui-corner-all ui-widget-content" id="tituloId" value="${cmd?.titulo}" />
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
