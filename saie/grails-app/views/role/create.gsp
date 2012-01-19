<head>
	<link rel="stylesheet" href="${resource(dir:'css/jstree/themes/default',file:'style.css')}" />
	<script type="text/javascript" src="${resource(dir:'js/jstree',file:'jquery.jstree.js')}"></script>

<!--	<meta name='layout' content='springSecurityUI'/>-->
	<g:set var="entityName" value="${message(code: 'role.label', default: 'Role')}"/>
	<title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>

<div class="body">



	<div id="demo1" class="demo jstree jstree-0 jstree-default jstree-focused" style="height: 365px;">
	</div>
</div>
<script>
$(document).ready(function() {
	$('#authority').focus();

	$("#demo1").jstree({ 
		"json_data" : {
			"data" : [
				{ 
					"data" : "A node", 
					"metadata" : { id : 23 },
					"children" : [ "Child 1", "A Child 2" ]
				},
				{ 
					"attr" : { "id" : "li.node.id1" }, 
					"data" : { 
						"title" : "Long format demo", 
						"attr" : { "href" : "#" } 
					} 
				}
			]
		},
		"plugins" : [ "themes", "json_data", "ui","checkbox" ]
	}).bind("select_node.jstree", function (e, data) { alert(data.rslt.obj.data("id")); })
});
</script>

</body>
