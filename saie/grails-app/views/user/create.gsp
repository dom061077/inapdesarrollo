<head>
	<meta name="layout" content="main" />
	<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
	<title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>

<h1><g:message code="default.create.label" args="[entityName]"/></h1>

<g:form action="save" name='userCreateForm'>

<%
def tabData = []
tabData << [name: 'userinfo', icon: 'icon_user',  messageCode: 'spring.security.ui.user.info']
tabData << [name: 'roles',    icon: 'icon_role', messageCode: 'spring.security.ui.user.roles']
%>
		<div class="append-bottom">
				<s2ui:tabs elementId='tabs' height='375' data="${tabData}">
				
					<s2ui:tab name='userinfo' height='280'>
						<table>
						<tbody>
				
							<s2ui:textFieldRow name='username' labelCode='user.username.label' bean="${user}"
				                            labelCodeDefault='Username' value="${user?.username}"/>
				
							<s2ui:passwordFieldRow name='password' labelCode='user.password.label' bean="${user}"
				                                labelCodeDefault='Password' value="${user?.password}"/>
				
							<s2ui:checkboxRow name='enabled' labelCode='user.enabled.label' bean="${user}"
				                           labelCodeDefault='Enabled' value="${user?.enabled}"/>
				
							<s2ui:checkboxRow name='accountExpired' labelCode='user.accountExpired.label' bean="${user}"
				                           labelCodeDefault='Account Expired' value="${user?.accountExpired}"/>
				
							<s2ui:checkboxRow name='accountLocked' labelCode='user.accountLocked.label' bean="${user}"
				                           labelCodeDefault='Account Locked' value="${user?.accountLocked}"/>
				
							<s2ui:checkboxRow name='passwordExpired' labelCode='user.passwordExpired.label' bean="${user}"
				                           labelCodeDefault='Password Expired' value="${user?.passwordExpired}"/>
						</tbody>
						</table>
					</s2ui:tab>
				
					<s2ui:tab name='roles' height='280'>
						<g:each var="auth" in="${authorityList}">
						<div>
							<g:checkBox name="${auth.authority}" />
							<g:link controller='role' action='edit' id='${auth.id}'>${auth.authority.encodeAsHTML()}</g:link>
						</div>
						</g:each>
					</s2ui:tab>
				
				</s2ui:tabs>
		</div>
	
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
</g:form>

<script>
$(document).ready(function() {
	$('#username').focus();
	
});
</script>

</body>
