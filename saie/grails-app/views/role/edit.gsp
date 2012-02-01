<head>
		<link rel="stylesheet" href="${resource(dir:'css/jstree/themes/default',file:'style.css')}" />
		<script type="text/javascript" src="${resource(dir:'js/jstree',file:'jquery.jstree.js')}"></script>
    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'role.label', default: 'Role')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
<!--        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/css',file:'ui.jqgrid.css')}" />-->
<!--        <link rel="stylesheet" type="text/css" media="screen" href="${g.resource(dir:'js/jqgrid/css',file:'jquery.searchFilter.css')}" />-->
<!--        <script type="text/javascript" src="${g.resource(dir:'js/jqgrid/i18n',file:'grid.locale-es.js')}"></script>-->
<!--         <script type="text/javascript" src="${g.resource(dir:'js/jqgrid',file:'jquery.jqGrid.min.js')}"></script>        -->
        
<!--        <script type="text/javascript" src="${resource(dir:'js/jquery',file:'jquery.jlookupfield.js')}"></script>-->
         
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all append-bottom"><H2>${flash.message}</H2></div>
            </g:if>
            <g:hasErrors bean="${roleInstance}">
            <div class="ui-state-error ui-corner-all">
                <g:renderErrors bean="${roleInstance}" as="list" />
            </div>
            </g:hasErrors>
            <div class="dialog">
		            <g:form onsubmit='initsubmit()' method="post" >
		            	<div class="append-bottom">
		                <g:hiddenField name="id" value="${roleInstance?.id}" />
		                <g:hiddenField name="version" value="${roleInstance?.version}" />
				                
								<g:hasErrors bean="${roleInstance}" field="authority">
									<div class="ui-state-error ui-corner-all append-bottom">
								</g:hasErrors>
								
								<div class="span-3 spanlabel">
									<label for="authority"><g:message code="role.authority.label" default="Authority" /></label>
								</div>
								<div class="span-5">
									ROLE_<g:textField id="authorityId" name="authority" class="ui-widget ui-corner-all ui-widget-content" value="${roleInstance?.authority.replace('ROLE_','')}" />
								</div>
											
								<g:hasErrors bean="${roleInstance}" field="authority">
									<g:renderErrors bean="${roleInstance}" as="list" field="authority"/>
									</div>
							   </g:hasErrors>
							   <div class="clear"></div>
				
																		
				            
		                </div>
		                <g:hiddenField id="requestsSerializedId" name="requestsSerialized" value="${requestsSerialized}"/>
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
		                
		                
		                <div class="buttons">
		                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
		                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
		                </div>
		            </g:form>
		     </div>
        </div>
<script>
function initsubmit(){
	var arrayRequests=[];
	$('#requests').jstree('get_checked',null,true).each(function(){
		arrayRequests.push({id:this.id});
	});
	
	$('#requestsSerializedId').val(JSON.stringify(arrayRequests));
	return true;
}

function bindrequests(){
	
	var requests = jQuery.parseJSON($("#requestsSerializedId").val());
	if(requests==null)
    		data=[];

	var tree = jQuery.jstree._reference("#requests");
	
	$.ajax({
		url:'<%out << createLink(controller:"role",action:"listrequestjson")%>'
		,success: function(data){
				$(requests).each(function(){
					tree.check_node("#"+this.id);	
				});
				
			}

	});
	
}

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
		url:'<%out << createLink(controller:"role",action:"listrequestjson",id:roleInstance?.id)%>'
		,success: function(data){
			$(data).each(function(){
				tree.check_node("#req"+this.id);	
			});
			
		}
	});
	
});
</script>           
        
    </body>
