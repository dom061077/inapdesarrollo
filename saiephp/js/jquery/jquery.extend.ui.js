$(document).ready(function(){
    $.widget('ui.combobox',{
        input:null,
        localvar:null,
        options:{
            reload: {
                url:null,
                params:{}
            },
            emptyMsg:'',
            onSelect:function(event,ui){
            }
        },
        initvalue: function(value){
            this.input.val(value);
        },
        reloadcmb:function(params,initval,initdesc){
            var select = this.localvar;
            var input = this.input;
            var self = this;
            $.getJSON(this.options.reload.url,params,function(data){
                var items = [];
                items.push('<option value="0">'+self.options.emptyMsg+'</option>');
                $.each(data, function(key, val) {
                    items.push('<option value="' + val.id + '">' + val.label + '</option>');
                });
                select.html(items.join(''));
                if(initval)
                    select.val(initval);
                if(initdesc)
                    input.val(initdesc);
            });
            //this.localvar.html('<option value="1">Option 1</option><option value="1">Option 1</option><option value="1">Option 1</option>');
            if(!params.term)
                this.input.val('');
            $.extend(this.options.reload.params,params);
        },
        _create: function() {
            var input,
                o = this.options,
                self = this,
                select = this.element.hide(),
                selected = select.children( ":selected" ),
                value = selected.val() ? selected.text() : "",
                wrapper = this.wrapper = $( "<span>" )
                    .addClass( "ui-combobox" )
                    .insertAfter( select );
            this.localvar = select;
            var onSelect = this.options.onSelect;
            var    source = function( request, response ) {

                    if(o.reload.url){
                        // TODO ORDENAR EL ENVIO DE PARAMETROS
                        var params=o.reload.params;
                        $.extend(params,{term:request.term});
                        self.reloadcmb(params);
                    }

                    var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
                    response( select.children( "option" ).map(function() {
                        var text = $( this ).text();
                        if ( this.value && ( !request.term || matcher.test(text) ) ) {
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
                        }
                    }) );
                };
            input = $( "<input>" )
                .appendTo( wrapper )
                .val( value )
                .addClass( "ui-state-default ui-combobox-input" )
                .autocomplete({
                    delay: 0,
                    minLength: 0,
                    source: source,
                    select: function( event, ui ) {
                        ui.item.option.selected = true;
                        self.element.val(ui.item.option.value);
                        //self._trigger( "selected", event, {
                        //    item: ui.item.option
                        //});
                        onSelect(event,ui);
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
            this.input = input;
            $( "<a>" )
                .attr( "tabIndex", -1 )
                .attr( "title", "Mostrar todas las opciones" )
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
    })
});