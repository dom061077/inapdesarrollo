<% import grails.persistence.Event %>
<%=packageName%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="\${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="\${flash.message}">
            <div class="ui-state-highlight ui-corner-all"><H2>\${flash.message}</H2></div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    <%  excludedProps = Event.allEvents.toList() << 'version'
                        allowedNames = domainClass.persistentProperties*.name << 'id' << 'dateCreated' << 'lastUpdated'
                        props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) }
                        Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                        props.each { p -> %>
                            <div class="span-4 spanlabel"><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></div>
                            <%  if (p.isEnum()) { %>
                            <div class="span-4">\${${propertyName}?.${p.name}?.encodeAsHTML()}</div>
                            <%  } else if (p.oneToMany || p.manyToMany) { %>
                            <div class="span-4">
                                <ul>
                                <g:each in="\${${propertyName}.${p.name}}" var="${p.name[0]}">
                                    <li><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.name[0]}.id}">\${${p.name[0]}?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            <%  } else if (p.manyToOne || p.oneToOne) { %>
                            <div class="span-4"><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.id}">\${${propertyName}?.${p.name}?.encodeAsHTML()}</g:link></div>
                            <%  } else if (p.type == Boolean.class || p.type == boolean.class) { %>
                            <div class="span-4"><g:formatBoolean boolean="\${${propertyName}?.${p.name}}" /></div>
                            <%  } else if (p.type == Date.class || p.type == java.sql.Date.class || p.type == java.sql.Time.class || p.type == Calendar.class) { %>
                            <div class="span-4"><g:formatDate date="\${${propertyName}?.${p.name}}" /></div>
                            <%  } else if(!p.type.isArray()) { %>
                            <div class="span-4">\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</div>
                            <%  } %>
							<div class="clear"></div>
                    <%  } %>
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="\${${propertyName}?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="\${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="\${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
