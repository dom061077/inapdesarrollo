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



	<div id="demo1" class="jstree jstree-0 jstree-default jstree-focused" style="height: 365px;">
	</div>
</div>
<script>
$(document).ready(function() {
	$('#authority').focus();

	$("#demo1").jstree({ 
		"json_data" : {
			"data" : [
						{ 
							"data" : "Permisos", 
							"checked" ; true,
							"state" : "closed"
						},
					],
			"ajax" : {
				"url" : "<%out << createLink(controller:"role",action:"grouprequestmap")%>",
			}
		},
		"plugins" : [ "themes", "json_data","checkbox" ]
	});	


});
</script>

</body>
