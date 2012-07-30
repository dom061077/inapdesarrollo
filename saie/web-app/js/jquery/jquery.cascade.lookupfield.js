$(document).ready(function(){
    var flagcascadelookupfield=false;
    $.widget('ui.cascadelookupfield',{
        input:null,
        localvar:null,
        options:{
            grid:{
                url:'',
                colNames:[],
                colModel:[]
            },
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
                idobj = $(this).attr('id');
                idobjlookup='#'+$(this).attr('id')+'_lookupgrid',
                idgrid=idobjlookup+'_grid';
                iddialog=idobjlookup+'_dialog';
                idpager=idobjlookup+'_pager';
                self = this,
                select = this.element.hide(),
                wrapper = this.wrapper = $( "<span>" )
                    .addClass( "ui-combobox" )
                    .insertAfter( select );
            input = $( '<input class="ui-widget ui-corner-all ui-widget-content" id="'+idobjlookup+'"/>' )
                .appendTo( wrapper );
            $(idobjlookup).keyup(function(e){
                var grid = $(idgrid);
                if(e.keyCode==27){
                    $(idobjlookup+'_wrapper').hide();
                    flagcascadelookupfield = false;
                }else{
                    if($(idobjlookup).val()!=''){
                        if(!flagcascadelookupfield){
                            $(idobjlookup+'_wrapper').show();
                            flagcascadelookupfield=true;
                        }
                        var colNames = $(idgrid).jqGrid('getGridParam','colNames');
                        var colModel = $(idgrid).jqGrid('getGridParam','colModel');
                        var filter = { groupOp: "AND", rules: []};
                        var filterop = 'bw';
                        if(colModel[2].searchoptions )
                            filterop = colModel[2].searchoptions.sopt[0];

                        filter.rules.push({field:colModel[2].name,op:filterop,data:$(idobjlookup).val()});
                        grid[0].p.search = true;
                        $.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
                    }else
                        grid[0].p.search = false;
                    grid.trigger("reloadGrid",[{page:1}]);
                }
            });
            $('<div id="'+idobjlookup+'_wrapper" style="display:none;position:fixed;z-index:4001"><table id="'+idobjlookup+'_grid"></table> <div id="'+idobjlookup+'_pager"></div></div>').insertAfter(wrapper);

           $(idgrid).jqGrid({
                //caption:'colocar caption',
                width:300,
                url:o.grid.url,
                //postData:{profesionalId:$("#profesionalId").val()},
                mtype:"POST",
                rownumbers:true,
                rowList:[10,20,30],
                pager:idpager,
                datatype:"json",
                colNames:o.grid.colNames,
                colModel:o.grid.colModel,
                ondblClickRow: function(id){
                    var colModel = $(idgrid).jqGrid('getGridParam','colModel');
                    var obj=$(idgrid).getRowData(id);
                    $(idobj).val(obj.id);
                    // TODO continuar con las modificaciones de busqueda
                    $(idobjlookupj).val(obj.);

                }
            });




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
                    $(idgrid).trigger("reloadGrid",[{page:1}]);
                    if(!flagcascadelookupfield){
                        $(idobjlookup+'_wrapper').show();
                        flagcascadelookupfield=true;
                    }else{
                        $(idobjlookup+'_wrapper').hide();
                        flagcascadelookupfield=false;
                    }
                });
        },

        destroy: function() {
            this.wrapper.remove();
            this.element.show();
            $.Widget.prototype.destroy.call( this );
        }
    })
});