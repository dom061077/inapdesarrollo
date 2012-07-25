
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

        function initGridBusquedaDivisiones(idtable){
            jQuery("#"+idtable).jqGrid({
                caption:'Búsqueda de Divisiones',
                url:'listdivisionjson',
                mtype:'POST',
                rownumbers:true
                ,datatype:'json'
                ,postData:{nivelID:$('#nivelIdId').val()}
                ,colNames:['Id','Descricpion','Letra','Cupo','Turno','Aula']
                ,colModel:[
                    {name:'id',index:'id', width:40, hidden:true},
                    {name:'descripcion',index:'descripcion', width:92,sortable:false},
                    {name:'letra',index:'letra', width:100,search:true},
                    {name:'cupo',index:'cupo', width:100,search:true},
                    {name:'turno',index:'turno', width:100,search:true},
                    {name:'aula',index:'aula', width:100,search:true}
                ]
                , pager: '#pagerBusquedaDivisionId'
                , sortname: 'id'
                , viewrecords: true, sortorder: "desc"
                , caption:"Lista de Divisiones"
            });
        }



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

                    grid = $('#divisionesId');
                    $.extend(grid[0].p.postData,{nivelid:"",carreraid:""});
                    grid.trigger("reloadGrid",[{page:1}]);

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
                    editurl:'editdivisiones',
                    colNames:['Id','Apellido','Nombre','Tipo Documento','Nro. de Doc.','Fecha Nac.', 'Divisiones'],
                    colModel:[
                        // TODO: Modificar el closure para que filtre
                        {name:'id',index:'id', width:40,sorttype:'int',sortable:true,searchoptions:{sopt:['eq']}},
                        {name:'apellido',index:'apellido', width:92,search:true,sortable:true},
                        {name:'nombre',index:'nombre', width:92,search:true,sortable:true},
                        {name:'tipoDocumento',index:'tipoDocumento', width:55,search:false},
                        {name:'numeroDocumento',index:'numeroDocumento', width:55,search:true,sorttype:'int',sortable:true,searchoptions:{sopt:['eq']}},
                        {name:'fechaNacimiento',index:'fechaNacimiento', width:55,search:false,sortable:false},
                        {name:'divisiones',index:'divisiones',editable:true, hidden:true,width:55,search:false,sortable:false}
                    ],
                    rowNum:10,
                    rowList:[10,20,30],
                    pager: '#pager',
                    sortname: 'id',
                    viewrecords: true,
                    sortorder: "desc"
                    ,subGrid:true
                    ,subGridRowExpanded: function(subgrid_id, row_id) {
                        var subgrid_table_id, pager_id;
                        subgrid_table_id = "subdivisionesId_t";
                        pager_id = "p_"+subgrid_table_id;
                        var obj=$('#divisionesId').getRowData(row_id);
                        $("#"+subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll'></table><div id='"+pager_id+"' class='scroll'></div>");
                        jQuery("#"+subgrid_table_id).jqGrid({
                            url:'<%out<<createLink(controller:"division",action:"listamateriainscripcion")%>?id='+obj.id+'&nivelid='+$('#nivelIdId').val(),
                            editurl:'editdivmateria',
                            datatype: "json",
                            mtype:'POST',
                            colNames: ['Id','Materia','Divisiones'],
                            colModel: [
                                {name:"id",index:"id",width:80,key:true,hidden:true},
                                {name:"materia",index:"materia",width:80,hidden:false},
                                {name:'divisiones',index:'divisiones',width:50,sorttype:'text',editable:true,sortable:false,search:false}
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
                            }
                        });
                        jQuery("#"+subgrid_table_id).jqGrid('navGrid',"#"+pager_id,{search:false,edit:true,add:false,del:false},
                                {height:300
                                    ,width:530
                                    ,top:50
                                    ,left:200
                                    ,reloadAfterSubmit:false
                                    ,recreateForm:true
                                    ,beforeSubmit: function(postData,formId){
                                        var id = $('#tablaBusquedaDivisionSubGridId').jqGrid('getGridParam','selrow');
                                        var retornar = false;
                                        var obj;
                                        if(!id){
                                            return [false,''];
                                        }else{
                                            obj = $('#tablaBusquedaDivisionSubGridId').getRowData(id);
                                            postData.divisiones = obj.id;
                                            return [true,''];
                                        }


                                    },
                                    afterSubmit: function(response, postdata){
                                        $('#divisionesId_1_t').trigger("reloadGrid",[{page:1}]);
                                        return [true,''];
                                    }

                                    ,editCaption:'Asignar una division a la materia seleccionada...'
                                    ,beforeShowForm:function(form){

                                        $('#TblGrid_subdivisionesId_t').hide();
                                        $('#FrmGrid_subdivisionesId_t').append('<table id="tablaBusquedaDivisionSubGridId"></table><div id="pagerBusquedaDivisionId"></div>');
                                        initGridBusquedaDivisiones('tablaBusquedaDivisionSubGridId');

                                    }
                                }

                        );

                    },
                    caption:"Listado de ${message(code: 'carrera.label', default: 'Carrera')}"
                });

                // Pie de la Grilla
                jQuery("#divisionesId").jqGrid('navGrid','#pager', {add:false,edit:true,del:false,search:false,refresh:false}, //options
                        {height:300
                            ,width:530
                            ,reloadAfterSubmit:false
                            ,top:50
                            ,left:200
                            ,recreateForm:true
                            ,beforeSubmit: function(postData,formId){
                            var id = $('#tablaBusquedaDivisionId').jqGrid('getGridParam','selrow');
                            var retornar = false;
                            var obj;
                            if(!id){
                                return [false,''];
                            }else{
                                obj = $('#tablaBusquedaDivisionId').getRowData(id);
                                postData.divisiones = obj.id;
                                //$('#editcntdivisionesId').dialog("close");
                                return [true,''];
                            }


                            },
                            afterSubmit: function(response, postdata){
                                 $('#divisionesId_1_t').trigger("reloadGrid",[{page:1}]);
                                 return [true,''];
                            }

                            ,editCaption:'Asignar una division a todas las materias...'
                            ,beforeShowForm:function(form){
                                $('#TblGrid_divisionesId').hide();
                                $('#FrmGrid_divisionesId').append('<table id="tablaBusquedaDivisionId"></table><div id="pagerBusquedaDivisionId"></div>');
                                initGridBusquedaDivisiones('tablaBusquedaDivisionId');

                            }
                        }
                );

                // Búsqueda del fitro
                jQuery("#divisionesId").jqGrid('filterToolbar',{stringResult: true,searchOnEnter : false});

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

         </div>
    </g:form>
</div>
</body>
</html>
