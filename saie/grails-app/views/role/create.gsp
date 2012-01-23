<head>
	<link rel="stylesheet" href="${resource(dir:'css/jstree/themes/default',file:'style.css')}" />
	<script type="text/javascript" src="${resource(dir:'js/jstree',file:'jquery.jstree.js')}"></script>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />

	<g:set var="entityName" value="${message(code: 'role.label', default: 'Role')}"/>
	<title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>

<div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all"><H2>${flash.message}</H2></div>
            </g:if>
            <g:hasErrors bean="${role}">
            <div class="ui-state-error ui-corner-all append-bottom">
                <g:renderErrors bean="${role}" as="list" />
            </div>
            </g:hasErrors>
            <g:form onSubmit="initsubmit();return true;" action="save" >
            	<div class="append-bottom">
            		<div class="append-bottom">	
						<g:hasErrors bean="${role}" field="authority">
							<div class="ui-state-error ui-corner-all append-bottom">
						</g:hasErrors>
						
						<div class="span-3 spanlabel">
							<label for="authority"><g:message code="role.authority.label" default="Rol:" /></label>
						</div>
						<div class="span-5">
							ROLE_
							<g:textField id="authorityId" name="authority" class="ui-widget ui-corner-all ui-widget-content" value="${role?.authority}" />
						</div>
									
						<g:hasErrors bean="${role}" field="authority">
							<g:renderErrors bean="${role}" as="list" field="authority"/>
							</div>
					   </g:hasErrors>
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
					<button id="test">Chequeados</button>
				</div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
				
			</g:form>		
</div>
<script>
$(document).ready(function() {
	$('#authority').focus();

	$("#requests").jstree({ 
		"plugins" : [ "themes", "html_data", "checkbox", "sort", "ui" ]
	});

	$('#test').click('click',function(){
			$('#requests').jstree("get_checked",null,true).each 
            (function () { 
                alert(this.id); 
            }); 
	});


});
</script>

</body>
