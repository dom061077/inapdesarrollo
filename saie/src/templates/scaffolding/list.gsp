<% import grails.persistence.Event %>
<%=packageName%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="\${g.resource(dir:'js/jqgrid/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="\${g.resource(dir:'js/jqgrid/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="\${g.resource(dir:'js/jqgrid/i18n',file:'grid.locale-es.js')}"></script>
        <script type="text/javascript" src="\${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        

        <script type="text/javascript">
        	$(document).ready(function(){
				jQuery("#list").jqGrid({
				   	url:'listjson',
					datatype: "json",
					width:680,
				   	colNames:['Id','C.U.I.T', 'Matricula', 'Nombre','Telófono','Large Url','Url','Foto','Operaciones'],
				   	colModel:[
				   		
				   		{name:'id',index:'id', width:40,searchoptions:{sopt:['eq']}},
				   		{name:'cuit',index:'cuit', width:92,sortable:false,searchoptions:{sopt:['eq']}},
				   		{name:'matricula',index:'matricula', width:100,search:false,searchoptions:{sopt:['eq']}},
				   		{name:'nombre',index:'nombre', width:150, sortable:true},
				   		{name:'telefono',index:'telefono', width:80, align:"right",search:false, sortable:false,searchoptions:{sopt:['eq']}},
				   		{name:'urllargephoto',index:'urllargephoto', hidden:true, width:80,search:false, align:"right", sortable:false},
				   		{name:'urlphoto',index:'urlphoto', hidden:true, width:80,search:false, align:"right", sortable:false},						   		
				   		{name:'foto',index:'foto', width:80, align:"center",search:false, sortable:false},						   		
				   		{name:'operaciones',index:'operaciones', width:55,search:false,sortable:false}
				   	],
				   	
				   	rowNum:10,
				   	rownumbers:true,
				   	rowList:[10,20,30],
				   	pager: '#pager',
				   	sortname: 'id',
				    viewrecords: true,
				    sortorder: "desc",
					gridComplete: function(){ 
						/*var ids = jQuery("#list").jqGrid('getDataIDs');
						var obj; 
						for(var i=0;i < ids.length;i++){ 
							var cl = ids[i];
							obj = $("#list").getRowData(ids[i]); 
							be = "<a href='edit/"+ids[i]+"'><span class='ui-icon ui-icon-pencil' style='margin: 3px 3px 3px 10px'  ></span></a>";
							ph = '<a class="thickbox" href="'+obj.urllargephoto+'" onclick="return false"><img src="'+obj.urlphoto+'"/></a>';
							jQuery("#list").jqGrid('setRowData',ids[i],{operaciones:be,foto:ph}); 
							}*/
						
						 
					}, 						    
				    caption:"Listado de xxxxxx"
				});
				jQuery("#list").jqGrid('navGrid','#pager',{search:false,edit:false,add:false,del:false,pdf:true});

				jQuery("#list").jqGrid('navButtonAdd','#pager',{
				       caption:"Informe", 
				       onClickButton : function () { 
				           //jQuery("#list").excelExport();
				           jQuery("#list").jqGrid("excelExport",{url:"excelexport"});
				       } 
				});

				jQuery("#list").jqGrid('filterToolbar',{stringResult: true,searchOnEnter : true});						
	
            });
		</script>        
        
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="\${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="\${flash.message}">
            <div class="ui-state-highlight ui-corner-all">\${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        <%  excludedProps = Event.allEvents.toList() << 'version'
                            allowedNames = domainClass.persistentProperties*.name << 'id' << 'dateCreated' << 'lastUpdated'
                            props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && !Collection.isAssignableFrom(it.type) }
                            Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                            props.eachWithIndex { p, i ->
                                if (i < 6) {
                                    if (p.isAssociation()) { %>
                            <th><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></th>
                        <%      } else { %>
                            <g:sortableColumn property="${p.name}" title="\${message(code: '${domainClass.propertyName}.${p.name}.label', default: '${p.naturalName}')}" />
                        <%  }   }   } %>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="\${${propertyName}List}" status="i" var="${propertyName}">
                        <tr class="\${(i % 2) == 0 ? 'odd' : 'even'}">
                        <%  props.eachWithIndex { p, i ->
                                if (i == 0) { %>
                            <td><g:link action="show" id="\${${propertyName}.id}">\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</g:link></td>
                        <%      } else if (i < 6) {
                                    if (p.type == Boolean.class || p.type == boolean.class) { %>
                            <td><g:formatBoolean boolean="\${${propertyName}.${p.name}}" /></td>
                        <%          } else if (p.type == Date.class || p.type == java.sql.Date.class || p.type == java.sql.Time.class || p.type == Calendar.class) { %>
                            <td><g:formatDate date="\${${propertyName}.${p.name}}" /></td>
                        <%          } else { %>
                            <td>\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</td>
                        <%  }   }   } %>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="\${${propertyName}Total}" />
            </div>
        </div>
    </body>
</html>
