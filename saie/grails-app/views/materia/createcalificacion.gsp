<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.educacion.academico.Carrera" %>


<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
    <title><g:message code="materia.calificaciones.create.label"  /></title>
    <style>
    </style>

    <script type="text/javascript">
        $(document).ready(function(){
            $.widget( "ui.combobox", {
                _create: function() {
                    var input,
                            self = this,
                            select = this.element.hide(),
                            selected = select.children( ":selected" ),
                            value = selected.val() ? selected.text() : "",
                            wrapper = this.wrapper = $( "<span>" )
                                    .addClass( "ui-combobox" )
                                    .insertAfter( select );

                    input = $( "<input>" )
                            .appendTo( wrapper )
                            .val( value )
                            .addClass( "ui-state-default ui-combobox-input" )
                            .autocomplete({
                                delay: 0,
                                minLength: 0,
                                source: function( request, response ) {
                                    var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
                                    response( select.children( "option" ).map(function() {
                                        var text = $( this ).text();
                                        if ( this.value && ( !request.term || matcher.test(text) ) )
                                            return {
                                                label: text.replace(
                                                        new RegExp(
                                                                "(?![^&;]+;)(?!<[^<>]*)(" +
                                                                        $.ui.autocomplete.escapeRegex(request.term) +
                                                                        ")(?![^<>]*>)(?![^&;]+;)", "gi"
                                                        ), "<strong>$1</strong>" ),
                                                value: text,
                                                option: this
                                            };
                                    }) );
                                },
                                select: function( event, ui ) {
                                    ui.item.option.selected = true;
                                    self._trigger( "selected", event, {
                                        item: ui.item.option
                                    });
                                },
                                change: function( event, ui ) {
                                    if ( !ui.item ) {
                                        var matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( $(this).val() ) + "$", "i" ),
                                                valid = false;
                                        select.children( "option" ).each(function() {
                                            if ( $( this ).text().match( matcher ) ) {
                                                this.selected = valid = true;
                                                return false;
                                            }
                                        });
                                        if ( !valid ) {
                                            // remove invalid value, as it didn't match anything
                                            $( this ).val( "" );
                                            select.val( "" );
                                            input.data( "autocomplete" ).term = "";
                                            return false;
                                        }
                                    }
                                }
                            })
                            .addClass( "ui-widget ui-widget-content ui-corner-left" );

                    input.data( "autocomplete" )._renderItem = function( ul, item ) {
                        return $( "<li></li>" )
                                .data( "item.autocomplete", item )
                                .append( "<a>" + item.label + "</a>" )
                                .appendTo( ul );
                    };

                    $( "<a>" )
                            .attr( "tabIndex", -1 )
                            .attr( "title", "Show All Items" )
                            .appendTo( wrapper )
                            .button({
                                icons: {
                                    primary: "ui-icon-triangle-1-s"
                                },
                                text: false
                            })
                            .removeClass( "ui-corner-all" )
                            .addClass( "ui-corner-right ui-combobox-toggle" )
                            .click(function() {
                                // close if already visible
                                if ( input.autocomplete( "widget" ).is( ":visible" ) ) {
                                    input.autocomplete( "close" );
                                    return;
                                }

                                // work around a bug (likely same cause as #5265)
                                $( this ).blur();

                                // pass empty string as value to search for, displaying all results
                                input.autocomplete( "search", "" );
                                input.focus();
                            });
                },

                destroy: function() {
                    this.wrapper.remove();
                    this.element.show();
                    $.Widget.prototype.destroy.call( this );
                }
            });
            $('#carreraId').combobox();
            $('#nivelId').combobox();

        });

    </script>
</head>
<body>
    <div class="nav">
        <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
    </div>
    <div class="body">
        <h1><g:message code="materia.calificaciones.create.label"  /></h1>
        <g:if test="${flash.message}">
            <div class="ui-state-highlight ui-corner-all"><H2>${flash.message}</H2></div>
        </g:if>
        <div class="append-bottom">
            <div class="span-2">
                <label for="carrera"><g:message code="carrera.label"></g:message>  </label>
            </div>
            <div class="span-7">
                <g:select id="carreraId" from="${Carrera.list()}" name="carrera" optionKey="id" optionValue="denominacion" ></g:select>
            </div>
            <div class="clear"></div>

            <div class="span-2 spanlabel">
                <label for="nivel"><g:message code="nivel.label"></g:message></label>
            </div>
            <div class="span-3">
                <g:textField id="nivelid" class="ui-widget ui-corner-all ui-widget-content" name="nivel"></g:textField>
            </div>



        </div>
    </div>
</body>
</html>