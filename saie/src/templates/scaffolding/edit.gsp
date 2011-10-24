<% import grails.persistence.Event %>
<% import org.codehaus.groovy.grails.plugins.PluginManagerHolder %>
<%=packageName%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <link rel="stylesheet" type="text/css" media="screen" href="\${g.resource(dir:'js/jqgrid/css',file:'ui.jqgrid.css')}" />
        <link rel="stylesheet" type="text/css" media="screen" href="\${g.resource(dir:'js/jqgrid/css',file:'jquery.searchFilter.css')}" />
        <script type="text/javascript" src="\${g.resource(dir:'js/jqgrid/i18n',file:'grid.locale-es.js')}"></script>
         <script type="text/javascript" src="\${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        
        
        <script type="text/javascript" src="\${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>
        <script type="text/javascript">
        	\$(document).ready(function(){
        <% 
			private renderLookupField(property){
				return "\t\t\$('#${property.name+"Id"}').lookupfield({source:'colocar aqui la url',\n \t\t\t\t title:'Poner aqui titulo de busqueda' \n\t\t\t\t,colnames:['Prop.Id','Prop 1','Prop 2'] \n\t\t\t\t,colModel:[{name:'id',index:'id', width:10, sorttype:'int', sortable:true,hidden:false,search:false} \n \t\t\t\t,{name:'prop1',index:'prop1', width:100,  sortable:true,search:true} \n \t\t\t\t,{name:'prop2',index:'prop2', width:100,  sortable:true,search:true}] \n \t\t\t\t,hiddenid:'${property.name+"Id"}' \n \t\t\t\t,descid:'${property.name+"Id"}' \n \t\t\t\t,hiddenfield:'id' \n \t\t\t\t,descfield:['aqui val prop. de la grilla que se mostrara en texto a buscar ']}); \n"
			}
			
			private renderAutocompleField(property){
				return "\t\t\$('#${property.name}Id' ).autocomplete({source: 'colocar aqui la url',\n \t\t\t\t minLength: 2, \n  \t\t\t\t select: function( event, ui ) {\n \t\t\t\t\t if(ui.item){ \n \t\t\t\t\t\t \$('#${property.name+"Id"}').val(ui.item.id) \n\t\t\t\t\t } \n\t\t\t\t	}, \n \t\t\t\t open: function() { \n \t\t\t\t\t\$( this ).removeClass( 'ui-corner-all' ).addClass( 'ui-corner-top' ); \n \t\t\t\t }, \n \t\t\t\t close: function() {\n \t\t\t\t\t \$( this ).removeClass( 'ui-corner-top' ).addClass( 'ui-corner-all' ); \n \t\t\t\t } \n  \t\t\t\t}); \n"
			}
			excludedProps = Event.allEvents.toList() << 'version' << 'id' << 'dateCreated' << 'lastUpdated'
			persistentPropNames = domainClass.persistentProperties*.name
			props = domainClass.properties.findAll { persistentPropNames.contains(it.name) && !excludedProps.contains(it.name) }
			Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
			display = true
			boolean hasHibernate = PluginManagerHolder.pluginManager.hasGrailsPlugin('hibernate')
			props.each { p ->
				if (!Collection.class.isAssignableFrom(p.type)) {
					if (hasHibernate) {
						cp = domainClass.constrainedProperties[p.name]
						display = (cp ? cp.display : true)
					}
					if (display) {
						if (p.type == Boolean.class || p.type == boolean.class)
							out<< ""
					    else if (Number.class.isAssignableFrom(p.type) || (p.type.isPrimitive() && p.type != boolean.class))
							out<< ""
					    else if (p.type == String.class)
							out<< ""
					    else if (p.type == Date.class || p.type == java.sql.Date.class || p.type == java.sql.Time.class || p.type == Calendar.class)
							out << "\$('#${p.name+"Id"}' ).datepicker(\$.datepicker.regional[ 'es' ]); \n";
					    else if (p.type == URL.class)
							out<< ""
					    else if (p.isEnum())
							out<< ""
					    else if (p.type == TimeZone.class)
							out<< ""
					    else if (p.type == Locale.class)
							out<< ""
					    else if (p.type == Currency.class)
							out<< ""
					    else if (p.type==([] as Byte[]).class)out<< "" //TODO: Bug in groovy means i have to do this :(
					    else if (p.type==([] as byte[]).class) out<< ""//TODO: Bug in groovy means i have to do this :(
					    else if (p.manyToOne || p.oneToOne){
								out << renderLookupField(p)
								out << "\n"
								out << renderAutocompleField(p)
								out << "//---------------------------------- \n"
							}
					    else if ((p.oneToMany && !p.bidirectional) || (p.manyToMany && p.isOwningSide()))
							out<< "oneToMany or manyToMany"
					    else if (p.oneToMany){

													
								}
       
			  }   }   } 
		%>
        	});
		</script>
        
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="\${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="\${flash.message}">
            <div class="ui-state-highlight ui-corner-all">\${flash.message}</div>
            </g:if>
            <g:hasErrors bean="\${${propertyName}}">
            <div class="ui-state-error ui-corner-all">
                <g:renderErrors bean="\${${propertyName}}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
                <g:hiddenField name="id" value="\${${propertyName}?.id}" />
                <g:hiddenField name="version" value="\${${propertyName}?.version}" />
		                <%  excludedProps = Event.allEvents.toList() << 'version' << 'id' << 'dateCreated' << 'lastUpdated'
		                persistentPropNames = domainClass.persistentProperties*.name
		                props = domainClass.properties.findAll { persistentPropNames.contains(it.name) && !excludedProps.contains(it.name) }
		                Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
		                display = true
		                hasHibernate = PluginManagerHolder.pluginManager.hasGrailsPlugin('hibernate')
		                props.each { p ->
		                    if (!Collection.class.isAssignableFrom(p.type)) {
		                        if (hasHibernate) {
		                            cp = domainClass.constrainedProperties[p.name]
		                            display = (cp ? cp.display : true)
		                        }
		                        if (display) { %>
						<g:hasErrors bean="${propertyName}" field="${p.name}">
							<div class="ui-state-error ui-corner-all">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="${p.name}"><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></label>
						</div>
						<div class="span-5">
							${renderEditor(p)}
						</div>
									
						<g:hasErrors bean="${propertyName}" field="${p.name}">
							<g:renderErrors bean="${propertyName}" as="list" field="${p.name}"/>
							</div>
					   </g:hasErrors>
					   <div class="clear"></div>
		
																
		            <%  }   }   } %>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="\${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="\${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
