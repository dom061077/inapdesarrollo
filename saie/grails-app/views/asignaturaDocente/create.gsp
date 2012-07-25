

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
        
        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">
        	$(document).ready(function(){

                function initGridBusquedaMaterias(){
                    //---------------inicializacion de la grilla de busqueda del materia para sugerir los materias
                    $('#tablaBusquedaMateriaId').jqGrid({
                        caption:'Búsqueda de Materia',
                        url:locrequisito,
                        mtype:'POST',
                        width:400,
                        rownumbers:true,
                        pager:'pagerBusquedaMateriaId',
                        datatype:'json',
                        colNames:['Id','Denominacion','Estado','Clase'],
                        colModel:[
                            {name:'id',index:'id',width:10,hidden:true},
                            {name:'denominacion',index:'denominacion',width:100,sorttype:'text',sortable:true},
                            {name:'descripcion',index:'descripcion',width:100,sorttype:'text',sortable:true},
                            {name:'nivel_descripcion',index:'nivel_descripcion',width:100,sorttype:'text',sortable:true},
                            {name:'carrera_denomincacion',index:'carrera_denomincacion',width:100,sorttype:'text',sortable:true}
                        ]
                    });
                    jQuery("#tablaBusquedaMateriaId").jqGrid('navGrid','#pagerBusquedaMateriaId',{search:false,edit:false,add:false,del:false,pdf:true});
                    jQuery('#tablaBusquedaMateriaId').jqGrid('filterToolbar',{stringResult: true,searchOnEnter : true});

                    //-----------------------------------------------------------------------------------------

                }


        		$('#carreraId').lookupfield({source:'colocar aqui la url',
 				 title:'Poner aqui titulo de busqueda' 
				,colNames:['Prop.Id','Prop 1','Prop 2'] 
				,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} 
 				,{name:'prop1',index:'prop1', width:100,  sortable:true,search:true} 
 				,{name:'prop2',index:'prop2', width:100,  sortable:true,search:true}] 
 				,hiddenid:'carreraIdId' 
 				,descid:'carreraId' 
 				,hiddenfield:'id' 
 				,descfield:['aqui val prop. de la grilla que se mostrara en texto a buscar ']}); 

                $('#carreraId' ).autocomplete({source: 'colocar aqui la url',
                         minLength: 2,
                         select: function( event, ui ) {
                             if(ui.item){
                                 $('#carreraIdId').val(ui.item.id)
                             }
                            },
                         open: function() {
                            $( this ).removeClass( 'ui-corner-all' ).addClass( 'ui-corner-top' );
                         },
                         close: function() {
                             $( this ).removeClass( 'ui-corner-top' ).addClass( 'ui-corner-all' );
                         }
                        });
//---------------------------------- 
                $('#anioLectivoId').lookupfield({source:'<%out << createLink(controller:"",action:"")%>',
                         title:'Búsqueda de Año Lectivo'
                        ,colNames:['Prop.Id','Prop 1','Prop 2']
                        ,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false}
                        ,{name:'prop1',index:'prop1', width:100,  sortable:true,search:true}
                        ,{name:'prop2',index:'prop2', width:100,  sortable:true,search:true}]
                        ,hiddenid:'anioLectivoIdId'
                        ,descid:'anioLectivoId'
                        ,hiddenfield:'id'
                        ,descfield:['aqui val prop. de la grilla que se mostrara en texto a buscar ']});

                $('#anioLectivoId' ).autocomplete({source: '<%out << createLink(controller:"anioLectivo",action:"listsearchjson")%>',
                         minLength: 2,
                         select: function( event, ui ) {
                             if(ui.item){
                                 $('#anioLectivoIdId').val(ui.item.id)
                             }
                            },
                         open: function() {
                            $( this ).removeClass( 'ui-corner-all' ).addClass( 'ui-corner-top' );
                         },
                         close: function() {
                             $( this ).removeClass( 'ui-corner-top' ).addClass( 'ui-corner-all' );
                         }
                        });
//---------------------------------- 
                $('#docenteId').lookupfield({source:'<%out << createLink(controller:"docente",action:"listsearchjson")%>',
                         title:'Búsqueda de Docente'
                        ,colNames:['Id','Apellido','Nombre']
                        ,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false}
                        ,{name:'apellido',index:'apellido', width:100,  sortable:true,search:true}
                        ,{name:'nombre',index:'nombre', width:100,  sortable:true,search:true}]
                        ,hiddenid:'docenteIdId'
                        ,descid:'docenteId'
                        ,hiddenfield:'id'
                        ,descfield:['apellido','nombre']});

                $('#docenteId' ).autocomplete({source: 'colocar aqui la url',
                         minLength: 2,
                         select: function( event, ui ) {
                             if(ui.item){
                                 $('#docenteIdId').val(ui.item.id)
                             }
                            },
                         open: function() {
                            $( this ).removeClass( 'ui-corner-all' ).addClass( 'ui-corner-top' );
                         },
                         close: function() {
                             $( this ).removeClass( 'ui-corner-top' ).addClass( 'ui-corner-all' );
                         }
                        });

                $('#materiasId').jqGrid({
                    url:'<%out << createLink(controller:"materia",action:"listjson")%>'
                    ,editurl:'editmaterias'
                    ,datatype: "local"
                    ,width:600
                    ,colNames:['Id','IdId', 'Denominación','Descripción']
                    ,colModel:[
                        {name:'id',index:'id', width:30,editable:true,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
                        ,{name:'idid',index:'idid', width:30,editable:true,hidden:true	,editoptions:{readonly:true,size:10}, sortable:false}
                        ,{name:'denominacion',index:'denominacion', width:100, align:"left",editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}
                        ,{name:'descripcion',index:'descripcion', width:100, align:"left",editable:true,editoptions:{size:30},editrules:{required:true}, sortable:false}
                    ]
                    , pager: '#pagermaterias'
                    , sortname: 'id'
                    , viewrecords: true, sortorder: "desc"
                    , caption:"Materias"
                    , height:140
                });

                $("#materiasId").jqGrid('navGrid','#pagermaterias', {add:true,edit:false,del:true,search:false,refresh:false}, //options
                        {height:280,width:310,reloadAfterSubmit:false
                            , recreateForm:true
                            ,modal:false
                            ,editCaption:'Modificar Materias'
                            , beforeShowForm:function(form){
                        }
                            ,bSubmit:'Modificar'

                        }, // edit options
                        {height:350,width:430,reloadAfterSubmit:false
                            ,recreateForm:true
                            ,modal:false
                            ,addCaption:'Agregar Requisito'
                            ,beforeSubmit: function(postData,formId){
                            var id = $('#tablaBusquedaRequisitoId').jqGrid('getGridParam','selrow');
                            var retornar = false;
                            var obj;
                            if(!id){
                                alert('Seleccione un requisito de la Grilla');
                                return [false,''];
                            }else{
                                obj = $('#tablaBusquedaRequisitoId').getRowData(id);
                                var gridDataRequisitos = $('#listRequisitosId').getRowData();
                                $.each( gridDataRequisitos, function(i, row){
                                    if(obj.id==row.idid){
                                        retornar=true;
                                        return;
                                    }
                                });
                                if(retornar){
                                    alert('Ya agregó este Requisito');
                                    return [false,'YA EXISTE EL REQUISITO AGREGADO'];
                                }
                                postData.idid = obj.id;
                                postData.descripcion = obj.descripcion;
                                postData.claseRequisito_descripcion = obj.claseRequisito_descripcion;
                                return [true,''];
                            }
                        }
                            ,beforeShowForm:function(form){
                            $('#TblGrid_listRequisitosId').hide();
                            $('#FrmGrid_listRequisitosId').append('<table id="tablaBusquedaMateriaId"></table><div id="pagerBusquedaMateriaId"></div>');
                            initGridBusquedaMaterias();

                        }
                            ,bSubmit:'Agregar'

                        }, // add options
                        {reloadAfterSubmit:false}, // del options
                        {} // search options
                );


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
							
							<div class="span-3 spanlabel">
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
                               <div id="pagermaterias"></div>
                           </fieldset>

				</div>                        
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
