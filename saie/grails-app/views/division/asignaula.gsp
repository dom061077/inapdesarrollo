
<%@ page import="com.educacion.academico.Division" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
    <g:set var="entityName" value="" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
    <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'ui.jqgrid.css')}" />
    <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/src/css',file:'jquery.searchFilter.css')}" />
    <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/src/i18n',file:'grid.locale-es.js')}"></script>
    <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>

    <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
    <script type="text/javascript">


        $(document).ready(function(){

            $('#carreraId').lookupfield({source:'<%out<<createLink(controller:'carrera',action:'listsearchjson')%>',
                title:'Búsqueda de Carreras'
                ,colNames:['Id','Denominación']
                ,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false}
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
                        $('#matregcursarId').clearGridData();
                        $('#mataprobcursarId').clearGridData();
                        $('#matregrendirId').clearGridData();
                        $('#mataprobrendirId').clearGridData();

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
                    {name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false}
                    ,{name:'descripcion',index:'descripcion', width:100,  sortable:true,search:true}
                    ,{name:'carrera',index:'carrear',hidden:false}
                    ,{name:'esprimernivel',index:'esprimernivel',width:100,sortable:false,search:false} ]
                ,hiddenid:'nivelIdId'
                ,descid:'nivelId'
                ,hiddenfield:'id'
                ,descfield:['descripcion']
                ,onSelected:function(){
                    var grid = $('#divisionesId');
                    $.extend(grid[0].p.postData,{nivelid:$('#nivelIdId').val(),carreraid:$('#carreraIdId').val()});
                    grid.trigger("reloadGrid",[{page:1}]);
                }
                ,onShowgrid:function(){
                    if(($("#matregcursarId").getRowData().length>0)
                            ||
                            ($("#mataprobcursarId").getRowData().length>0)||
                            ($("#matregrendirId").getRowData().length>0) ||
                            ($("#mataprobcursarId").getRowData().length>0)
                            ){
                        $("<div>Recuerde de que si cargo algunas materias en alguna grilla de abajo al cambiar de carrera se limpiaran dichas grillas</div>").dialog({
                            resizable: false,
                            height:140,
                            modal: true,
                            buttons: {
                                Ok: function() {
                                    $( this ).dialog( "close" );
                                }
                            }
                        });
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


            // Grilla Maestro detalle de Alumnos
            jQuery(document).ready(function(){
                jQuery("#divisionesId").jqGrid({
                    url:'<%out << createLink(controller:"division",action:"listalumnos")%>',
                    datatype: 'json',
                    width:680,
                    colNames:['Id','Apellido','Nombre','Tipo Documento','Nro. de Doc.','Fecha Nac.','Ver'],
                    colModel:[
                        {name:'id',index:'id', width:40,sorttype:'int',sortable:true,searchoptions:{sopt:['eq']}},
                        {name:'apellido',index:'apellido', width:92,search:true,sortable:true},
                        {name:'nombre',index:'nombre', width:92,search:true,sortable:true},
                        {name:'tipoDocumento',index:'tipoDocumento', width:55,search:false},
                        {name:'numeroDocumento',index:'numeroDocumento', width:55,search:true,sorttype:'int',sortable:true,searchoptions:{sopt:['eq']}},
                        {name:'fechaNacimiento',index:'fechaNacimiento', width:55,search:false,sortable:false},
                        {name:'operaciones',index:'operaciones', width:55,search:false,sortable:false}
                    ],

                    rowNum:10,
                    //rownumbers:true,
                    rowList:[10,20,30],
                    pager: '#pager',
                    sortname: 'id',
                    viewrecords: true,
                    sortorder: "desc",
                    gridComplete: function(){
                        var ids = jQuery("#list").jqGrid('getDataIDs');
                        var obj;
                        var se;
                        var be;
                        var co;
                        for(var i=0;i < ids.length;i++){
                            var cl = ids[i];
                            obj = jQuery("#list").getRowData(ids[i]);
                            be = "<a title='Editar' href='edit?id="+ids[i]+"'><span class='ui-icon ui-icon-pencil' style='float:left;margin: 3px 3px 3px 10px'  ></span></a>";
                            se = "<a title='Ver' href='show/"+ids[i]+"'><span class='ui-icon ui-icon-search' style='float:left;margin: 3px 3px 3px 10px'  ></span></a>";
                            co = "<a title='Correlatividades' href='reportecorrelatividades/"+ids[i]+"'><span class='ui-icon ui-icon-contact' style='float:left;margin: 3px 3px 3px 10px'  ></span></a>";
                            jQuery("#list").jqGrid('setRowData',ids[i],{operaciones:be+se+co});
                        }
                    }
                    ,subGrid:true
                    ,subGridRowExpanded: function(subgrid_id, row_id) {
                        var subgrid_table_id, pager_id;
                        subgrid_table_id = subgrid_id+"_t";
                        pager_id = "p_"+subgrid_table_id;
                        var obj=$('#list').getRowData(row_id);
                        $("#"+subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll'></table><div id='"+pager_id+"' class='scroll'></div>");
                        jQuery("#"+subgrid_table_id).jqGrid({
                            url:'<%out<<createLink(controller:"carrera",action:"listdocumentos")%>?id='+obj.id,
                            datatype: "json",
                            mtype:'POST',
                            colNames: ['Id','Nombre PDF','URL Doc.PDF','URL Image','URL Large Image','Documento PDF','Imagen','Opciones'],
                            colModel: [
                                {name:"id",index:"id",width:80,key:true,hidden:true},
                                {name:"nombreOriginalDocumento",index:"nombreOriginalDocumento",width:80,hidden:true},
                                {name:"urlDocumentoPDF",index:"urlDocumentoPDF",width:80,hidden:true},
                                {name:"image",index:"image",width:70,hidden:true},
                                {name:"largeImage",index:"largeImage",width:70,hidden:true},
                                {name:"documentoPDF",index:"documentoPDF",width:80},
                                {name:"documentoImagen",index:"documentoImagen",width:20},
                                {name:'operaciones',index:'operaciones',width:20,sorttype:'text',sortable:false,search:false}
                            ],
                            rowNum:20,
                            pager: pager_id,
                            height: '100%',
                            width: 600,
                            gridComplete: function(){
                                var ids = jQuery('#'+subgrid_table_id).jqGrid('getDataIDs');
                                var be;
                                var row;
                                var image;
                                var documentoPDF;
                                for(var i=0;i < ids.length;i++){
                                    var cl = ids[i];
                                    row = jQuery('#'+subgrid_table_id).getRowData(cl);
                                    be = "<a title='Editar' href='<%out << createLink(controller:"documentoCarrera",action:"edit")%>/"+row.id+"'><span style='float:left' class='ui-icon ui-icon-pencil'></span></a>";
                                    image = "<a  class='thickbox' href='"+row.largeImage+"'><img src='"+row.image+"'/></a>";
                                    documentoPDF = "<a href='"+row.urlDocumentoPDF+"'>"+row.nombreOriginalDocumento+"</a>";
                                    jQuery("#"+subgrid_table_id).jqGrid('setRowData',ids[i],{operaciones:be,documentoImagen:image,documentoPDF:documentoPDF});
                                }
                                tb_init('a.thickbox, area.thickbox, input.thickbox');
                            }
                        });
                        jQuery("#"+subgrid_table_id).jqGrid('navGrid',"#"+pager_id,{search:false,edit:false,add:false,del:false});
                        //jQuery("#"+subgrid_table_id).jqGrid('filterToolbar',{stringResult: true,searchOnEnter : true});
                    },
                    caption:"Listado de ${message(code: 'carrera.label', default: 'Carrera')}"
                });
                jQuery("#list").jqGrid('navGrid','#pager',{search:false,edit:false,add:false,del:false,pdf:true});

                jQuery("#list").jqGrid('navButtonAdd','#pager',{
                    caption:"Informe",
                    onClickButton : function () {
                        //jQuery("#list").excelExport();
                        //jQuery("#list").jqGrid("excelExport",{url:"excelexport"});
                        window.location = '<%out << createLink(controller:"carrera",action:"reportecarreras") %>';
                    }
                });

                jQuery("#list").jqGrid('filterToolbar',{stringResult: true,searchOnEnter : true});

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
    <h1><g:message code="Asignación de Divisiones" args="[entityName]" /></h1>
    <g:if test="${flash.message}">
        <div class="ui-state-highlight ui-corner-all"><H2>${flash.message}</H2></div>
    </g:if>

    <g:hasErrors bean="${nivelInstance}">
        <div class="ui-state-error ui-corner-all append-bottom">
            <g:renderErrors bean="${nivelInstance}" as="list" />
        </div>
    </g:hasErrors>
    <g:form action="save" onSubmit="initsubmit()">
        <div class="append-bottom">

        <div class="span-3 spanlabel">
            <label for="carreraDesc"><g:message code="materia.carrera.label" default="Carrera" /></label>
		</div>
        <div class="span-5">
            <g:textField class="ui-widget ui-corner-all ui-widget-content" id="carreraId" name="carreraDesc"  value="${nivelInstance?.carrera?.denominacion}" />
            <g:hiddenField id="carreraIdId" name="carreraId" value="${nivelInstance?.carrera?.id}" />
        </div>
        <div class="clear"></div>


        <g:hasErrors bean="${nivelInstance}" field="nivel">
            <div class="ui-state-error ui-corner-all append-bottom">
        </g:hasErrors>

        <div class="span-3 spanlabel">
            <label for="nivel"><g:message code="materia.nivel.label" default="Nivel" /></label>
        </div>
        <div class="span-5">
            <g:textField class="ui-widget ui-corner-all ui-widget-content" id="nivelId" name="nivelDesc"  value="${nivelInstance?.descripcion}" />
            <g:hiddenField id="nivelIdId" name="nivelid" value="${nivelInstance?.id}" />
        </div>
        <div class="clear"></div>


        <fieldset>
            <g:hiddenField id="divisionesSerializedId" name="divisionesSerialized" value="${divisionesSerialized}"/>
            <legend>Alumnos Matriculados</legend>
            <div id="pager"></div>
            <table id="divisionesId">

            </table>
        </fieldset>


        <div style="display:none" id="busquedaAulaDialogId">
            <table id="tablaBusquedaAulaId"></table><div id="pagerBusquedaAulaId"></div>
        </div>


        </div>
    </g:form>
</div>
</body>
</html>