<%@ page import="com.medfire.security.Person" %>



<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'username', 'error')} required">
    <label for="username">
        <g:message code="person.username.label" default="Username"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="username" required="" value="${personInstance?.username}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'password', 'error')} required">
    <label for="password">
        <g:message code="person.password.label" default="Password"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="password" required="" value="${personInstance?.password}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'profesionalAsignado', 'error')} ">
    <label for="profesionalAsignado">
        <g:message code="person.profesionalAsignado.label" default="Profesional Asignado"/>
        
    </label>
    <g:select id="profesionalAsignado" name="profesionalAsignado.id" from="${com.medfire.Profesional.list()}" optionKey="id" value="${personInstance?.profesionalAsignado?.id}" class="many-to-one" noSelection="['null': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'esProfesional', 'error')} ">
    <label for="esProfesional">
        <g:message code="person.esProfesional.label" default="Es Profesional"/>
        
    </label>
    <g:checkBox name="esProfesional" value="${personInstance?.esProfesional}" />

</div>

<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'accountExpired', 'error')} ">
    <label for="accountExpired">
        <g:message code="person.accountExpired.label" default="Account Expired"/>
        
    </label>
    <g:checkBox name="accountExpired" value="${personInstance?.accountExpired}" />

</div>

<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'accountLocked', 'error')} ">
    <label for="accountLocked">
        <g:message code="person.accountLocked.label" default="Account Locked"/>
        
    </label>
    <g:checkBox name="accountLocked" value="${personInstance?.accountLocked}" />

</div>

<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'enabled', 'error')} ">
    <label for="enabled">
        <g:message code="person.enabled.label" default="Enabled"/>
        
    </label>
    <g:checkBox name="enabled" value="${personInstance?.enabled}" />

</div>

<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'institucion', 'error')} required">
    <label for="institucion">
        <g:message code="person.institucion.label" default="Institucion"/>
        <span class="required-indicator">*</span>
    </label>
    <g:select id="institucion" name="institucion.id" from="${com.medfire.Institucion.list()}" optionKey="id" required="" value="${personInstance?.institucion?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'passwordExpired', 'error')} ">
    <label for="passwordExpired">
        <g:message code="person.passwordExpired.label" default="Password Expired"/>
        
    </label>
    <g:checkBox name="passwordExpired" value="${personInstance?.passwordExpired}" />

</div>

<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'userRealName', 'error')} required">
    <label for="userRealName">
        <g:message code="person.userRealName.label" default="User Real Name"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="userRealName" required="" value="${personInstance?.userRealName}"/>

</div>

