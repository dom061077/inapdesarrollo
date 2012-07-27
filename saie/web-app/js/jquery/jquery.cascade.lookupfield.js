$(document).ready(function(){
    $.widget('ui.cascade.lookupfield',{
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
        _create: function() {
            var input,
                o = this.options,
                self = this,
                select = this.element.hide(),
                wrapper = this.wrapper = $( "<span>" )
                    .addClass( "ui-combobox" )
                    .insertAfter( select );
            input = $( '<input id="'+this.attr('id')+'_oculto">' )
                .appendTo( wrapper )
                .val( value )
                .addClass( "ui-state-default ui-combobox-input" );

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