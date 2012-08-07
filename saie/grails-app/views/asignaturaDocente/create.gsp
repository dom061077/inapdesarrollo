

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
        <script type="text/javascript" src="${g.resource(dir:'js/jquery',file:'jquery.jlookupfieldcascade.js')}"></script>


        <script type="text/javascript">
            function initsubmit(){
                var gridData = jQuery("#materiasId").getRowData();
                var postData = JSON.stringify(gridData);
                $("#materiasSerializedId").val(postData);

            }

            function bindmaterias(){
                var griddata = [];

                var data = jQuery.parseJSON($("#materiasSerializedId").val());
                if(data==null)
                    data=[];
                for (var i = 0; i < data.length; i++) {
                    griddata[i] = {};
                    griddata[i]["id"] = data[i].id;
                    griddata[i]["idid"] = data[i].idid;
                    griddata[i]["codigo"] = data[i].codigo;
                    griddata[i]["denominacion"] = data[i].denominacion;
                    griddata[i]["nivel"] = data[i].nivel;
                    griddata[i]["carrera"] = data[i].carrera;
                }

                for (var i = 0; i <= griddata.length; i++) {
                    jQuery("#materiasId").jqGrid('addRowData', i + 1, griddata[i]);
                }

            }

            function initGridBusquedaMaterias(){
                $('#tablaBusquedaMateriaId').jqGrid({
                    caption:'Búsqueda de Materia',
                    url:'<%out << createLink(controller:"materia",action:"listjson")%>',
                    mtype:'POST',
                    width:400,
                    rownumbers:true,
                    postData:{nivel_carrera_id:$('#carreraId').val()},
                    pager:'pagerBusquedaMateriaId',
                    datatype:'json',
                    colNames:['Id','Código','Denominación','Nivel','Carrera'],
                    colModel:[
                        {name:'id',index:'id',width:10,hidden:true},
                        {name:'codigo',index:'codigo',width:100,sorttype:'text',sortable:true},
                        {name:'denominacion',index:'denominacion',width:100,sorttype:'text',sortable:true},
                        {name:'nivel_descripcion',index:'nivel_descripcion',width:100,sorttype:'text',sortable:true},
                        {name:'nivel_carrera_denominacion',index:'nivel_carrera_denominacion',width:100,sorttype:'text',sortable:true}
                    ]
                });
                jQuery("#tablaBusquedaMateriaId").jqGrid('navGrid','#pagerBusquedaMateriaId',{search:false,edit:false,add:false,del:false,pdf:true});
                jQuery('#tablaBusquedaMateriaId').jqGrid('filterToolbar',{stringResult: true,searchOnEnter : true});


            }

        	$(document).ready(function(){



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
                        anios.clear();
                        $('#materiasId').clearGridData();

                    }
                });

                var anios = $('#anioLectivoId').combolookupfield({
                    grid:{
                        colNames:['Id','AnioLectivo']
                        ,colModel:[{name:'id',index:'id',hidden:true}
                                ,{name:'anioLectivo',index:'anioLectivo',width:60,search:false,sortable:true,searchoptions:{sopt:['eq']}}
                        ],
                        url:'<%out << createLink(controller:"carrera",action:"listsearchjsonanioslectivos")%>'
                    },
                    //inputNameDesc:'anioLectivo',
                    cascade:{
                        elementCascadeId:'carreraId',
                        paramName:'carrera_id'
                    }
                    ,onSelected:function(){
                         docentes.clear();
                    }
                });

                var materiaCmb;


                var docentes=$('#docenteId').combolookupfield({
                   grid:{
                      colNames:['Id','Apellido','Nombre']
                      ,colModel:[
                        {name:'id',index:'id',hidden:true}
                        ,{name:'apellido',index:'apellido',width:100,search:false,sortable:true}
                        ,{name:'nombre',index:'nombre',width:100,search:false,sortable:true}
                      ]
                      ,url:'<%out << createLink(controller:"docente",action:"listsearchjson")%>'
                   },
                   inputNameDesc:'docenteDesc'
                   /*,cascade:{
                        elementCascadeId:'doncenteId',
                        paramName:'anioLectivo_id'
                    }*/

                });


                jQuery("#materiasId").jqGrid({
                    editurl:'editurl',
                    datatype: "local",
                    width:680,
                    colNames:['Id','IdId','Código','Denominación','Nivel','Carrera'],
                    colModel:[
                        {name:'id',index:'id', width:40,hidden:true},
                        {name:'idid',index:'idid',hidden:true},
                        {name:'codigo',index:'codigo', width:92,sortable:true,editable:true},
                        {name:'denominacion',index:'denominacion', width:92,sortable:true,editable:true},
                        {name:'nivel',index:'nivel', width:100,search:true,editable:false},
                        {name:'carrera',index:'carrera', width:100,search:true,editable:false}
                    ],

                    rowNum:10,
                    rownumbers:true,
                    rowList:[10,20,30],
                    pager: '#pagermateriasId',
                    sortname: 'id',
                    viewrecords: true,
                    sortorder: "desc"
                   // caption:"Listado de ${message(code: 'docente.label', default: 'Docente')}"
                });

                jQuery("#materiasId").jqGrid('navGrid','#pagermateriasId', {add:true,edit:false,del:true,search:false,refresh:false}, //options
                        {}, // edit options
                            {height:350,width:430,reloadAfterSubmit:false
                            ,left:200,top:200
                            ,recreateForm:true
                            ,modal:false
                            ,addCaption:'Agregar Materia'
                            ,beforeSubmit: function(postData,formId){
                                        var id = $('#tablaBusquedaMateriaId').jqGrid('getGridParam','selrow');
                                        var retornar = false;
                                        var obj;
                                        if(!id){
                                            alert('Seleccione una materia de la Grilla');
                                            return [false,''];
                                        }else{
                                            obj = $('#tablaBusquedaMateriaId').getRowData(id);
                                            var gridDataMaterias = $('#materiasId').getRowData();
                                            $.each( gridDataMaterias, function(i, row){
                                                if(obj.id==row.idid){
                                                    retornar=true;
                                                    return;
                                                }
                                            });
                                            if(retornar){
                                                alert('Ya agregó esta Materia');
                                                return [false,'YA EXISTE LA MATERIA AGREGADA'];
                                            }


                                            postData.idid = obj.id;
                                            postData.codigo = obj.codigo;
                                            postData.denominacion = obj.denominacion;
                                            postData.nivel = obj.nivel_descripcion;
                                            postData.carrera = obj.nivel_carrera_denominacion;
                                            return [true,''];
                                        }
                                        return[true,''];
                            }
                            ,beforeShowForm:function(form){
                                $('#TblGrid_materiasId').hide();
                                $('#FrmGrid_materiasId').append('<table id="tablaBusquedaMateriaId"></table><div id="pagerBusquedaMateriaId"></div>');

                                initGridBusquedaMaterias();
                            }
                            ,bSubmit:'Agregar'

                        }, // add options
                        {reloadAfterSubmit:false}, // del options
                        {} // search options
                );
                bindmaterias();

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
            <g:form action="save" onsubmit="initsubmit()">
            		<div class="append-bottom">	

                            <div class="append-bottom">
                                <g:hasErrors bean="${asignaturaDocenteInstance}" field="carrera">
                                    <div class="ui-state-error ui-corner-all append-bottom">
                                </g:hasErrors>

                                <div class="span-3">
                                    <label for="carreraId"><g:message code="asignaturaDocente.carrera.label" default="Carrera" /></label>
                                </div>
                                <div class="span-5">
                                    <input type="text" class="ui-widget ui-corner-all ui-widget-content" id="carreraId" name="carrera.id" descValue="${asignaturaDocenteInstance?.carrera?.denominacion}" value="${asignaturaDocenteInstance?.carrera?.id}" />
                                </div>
                                <g:hasErrors bean="${asignaturaDocenteInstance}" field="carrera">
                                    <g:renderErrors bean="${asignaturaDocenteInstance}" as="list" field="carrera"/>
                                    </div>
                               </g:hasErrors>
                               <div class="clear"></div>
                            </div>

                            <div class="append-bottom">
                                <g:hasErrors bean="${asignaturaDocenteInstance}" field="anioLectivo">
                                    <div class="ui-state-error ui-corner-all append-bottom">
                                </g:hasErrors>

                                <div class="span-3">
                                    <label for="anioLectivoId"><g:message code="asignaturaDocente.anioLectivo.label" default="Anio Lectivo" /></label>
                                </div>
                                <div class="span-5">
                                    <input type="text" class="ui-widget ui-corner-all ui-widget-content" id="anioLectivoId" name="anioLectivo.id" descValue="${asignaturaDocenteInstance?.anioLectivo?.anioLectivo}"  value="${asignaturaDocenteInstance?.anioLectivo?.id}" />
                                </div>

                                <g:hasErrors bean="${asignaturaDocenteInstance}" field="anioLectivo">
                                    <g:renderErrors bean="${asignaturaDocenteInstance}" as="list" field="anioLectivo"/>
                                    </div>
                                </g:hasErrors>
                                <div class="clear"></div>
                            </div>
                
                
                            <div class="append-bottom">
                                <g:hasErrors bean="${asignaturaDocenteInstance}" field="docente">
                                    <div class="ui-state-error ui-corner-all append-bottom">
                                </g:hasErrors>
                                
                                <div class="span-3">
                                    <label for="docenteId"><g:message code="asignaturaDocente.docente.label" default="Docente" /></label>
                                </div>
                                <div class="span-5">
                                    <input type="text" class="ui-widget ui-corner-all ui-widget-content" id="docenteId" name="docente.id"
                                               descValue="${(asignaturaDocenteInstance?.docente==null?"":asignaturaDocenteInstance?.docente?.apellido+"-"+asignaturaDocenteInstance?.docente?.nombre)}"
                                            value="${asignaturaDocenteInstance?.docente?.id}" />

                                </div>
                                            
                                <g:hasErrors bean="${asignaturaDocenteInstance}" field="docente">
                                    <g:renderErrors bean="${asignaturaDocenteInstance}" as="list" field="docente"/>
                                    </div>
                               </g:hasErrors>
                               <div class="clear"></div>
                            </div>
                
                
                           <fieldset>
                               <legend>Materias a Dictar</legend>
                               <g:hiddenField name="materiasSerialized" id="materiasSerializedId" value="${materiasSerialized}"/>
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
