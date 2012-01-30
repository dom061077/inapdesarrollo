    <head>
		<link rel="stylesheet" href="${resource(dir:'css/jstree/themes/default',file:'style.css')}" />
		<script type="text/javascript" src="${resource(dir:'js/jstree',file:'jquery.jstree.js')}"></script>
    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'role.label', default: 'Role')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all append-bottom"><H2>${flash.message}</H2></div>
            </g:if>
            <div class="dialog">
            		<div class="span-2">
                            <g:message code="role.id.label" default="Id" />
                    </div>        
                            
                    <div class="span-4">        
                            ${fieldValue(bean: roleInstance, field: "id")}
                    </div>    
                    <div class="clear"></div>
                    
                    <div class="span-2">    
                            <g:message code="role.authority.label" default="Authority" />
                    </div>        
                            
                    <div class="span-4">        
                            ${fieldValue(bean: roleInstance, field: "authority")}
                    </div>        
                            
                    <div class="clear"></div>        
				<div id="requests" class="jstree jstree-0 jstree-default jstree-focused" style="height: 365px;">
						<ul>
							<g:each var="requestGroup" in="${requestmaps}">
								<li id="${requestGroup.id}" class="jstree-open">
									<a href="#">${requestGroup.descripcion}</a>
									<ul>
										<g:each var="reqs" in="${requestGroup.requests}">
											<li id="${"req"+reqs.id}">
												<ins class="jstree-icon"></ins>
												<a href="#">${reqs.descripcion}</a>
											</li>
										</g:each>
									</ul>
								</li>
							</g:each>
						</ul>
				</div>
                
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${roleInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
            
        </div>
<script>
$(document).ready(function() {

	$("#requests").jstree({
		"plugins" : [ "themes", "html_data", "checkbox", "sort", "ui","types" ]
					
	});
	var tree = jQuery.jstree._reference("#requests");
	/*var jsondata =jQuery.jstree._reference("#requests").get_json(-1, ['id']);
	var nodos = jQuery.jstree._reference("#requests").get_container_ul().find("li");
	nodos.each(function(){
		tree.check_node(this);
	});*/
	$.ajax({
		url:'<%out << createLink(controller:"role",action:"listrequestjson",id:roleInstance.id)%>'
		,success: function(data){
			$(data).each(function(){
				tree.check_node("#req"+this.id);	
			});
			tree.lock();
		}
	});
	
});
</script>            
    </body>

