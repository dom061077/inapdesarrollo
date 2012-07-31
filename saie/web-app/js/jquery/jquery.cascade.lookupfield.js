$(document).ready(function(){

    $.widget('ui.cascadelookupfield',{
        input:null,
        localvar:null,
        option:null,
        options:{
            grid:{
                url:'',
                colNames:[],
                colModel:[]
            },
            cascade: {
                elementCascadeId:'',
                paramName:''
            },
            inputNameDesc:''
        },
        show:function(){
            var o = this.option;
            var grid = $('#'+this.idgrid);
            if(o.paramName!='') {
                //input.focus();
                $.extend(grid[0].p.postData, {paramName:o.paramName, paramData:$('#' + o.elementCascadeId).val()});
            }

            grid.trigger("reloadGrid",[{page:1}]);
            if(!this.flagcascadelookupfield){
                $('#'+this.idwrapper).show();
                //carreraId_lookupgrid_wrapper
                this.flagcascadelookupfield=true;
            }else{
                $('#'+this.idwrapper).hide();
                this.flagcascadelookupfield=false;
            }

        },
        _create: function() {
            this.flagcascadelookupfield=false
            this.idwrapper=this.element[0].id+'_lookupgrid'+'_wrapper';
            this.idgrid = this.element[0].id+'_lookupgrid'+'_grid';
            this.option = this.options;
            var input,
                o = this.options,
                idobj = this.element[0].id;
                idobjlookup=this.element[0].id+'_lookupgrid',
                idgrid=idobjlookup+'_grid';
                idpager=idobjlookup+'_pager';
                idwrapper=idobjlookup+'_wrapper';
                self = this,
                select = this.element.hide();
                //select = this.element,
                this.wrapper = $( '<span id="'+idobj+'_wrapper">' )
                    .addClass( "ui-combobox" )
                    .insertAfter( select );
            input = $( '<input type="text" style="margin: 0 0" class="ui-widget ui-corner-all ui-widget-content" name="'+o.inputNameDesc+'" id="'+idobjlookup+'"/>' )
                .appendTo( this.wrapper );
            input.val($('#'+idobj).attr('descValue'));
            $('#'+idobjlookup).keyup(function(e){
                var grid = $('#'+idgrid);
                if(e.keyCode==27){
                    $('#'+idobjlookup+'_wrapper').hide();
                    this.flagcascadelookupfield = false;
                }else{
                    if(e.keyCode==40){
                        if(!this.flagcascadelookupfield)
                            $('#'+idobjlookup+'_wrapper').show();
                        $('#'+idgrid).focus();
                    }
                    if(e.keyCode==8){
                        if($('#'+idobjlookup).val()==''){
                            $('#'+idobj).val('');
                            this.flagcascadelookupfield = false;
                            $('#'+idwrapper).hide();
                            return
                        }
                    }
                    if(e.keyCode==46){
                        if($('#'+idobjlookup).val()==''){
                            $('#'+idobj).val('');
                            this.flagcascadelookupfield = false;
                            $('#'+idwrapper).hide();
                            return
                        }
                    }
                    if($('#'+idobjlookup).val()!=''){
                        if(!this.flagcascadelookupfield){
                            $('#'+idobjlookup+'_wrapper').show();
                            this.flagcascadelookupfield=true;
                        }
                        var colNames = $('#'+idgrid).jqGrid('getGridParam','colNames');
                        var colModel = $('#'+idgrid).jqGrid('getGridParam','colModel');
                        var filter = { groupOp: "AND", rules: []};
                        var filterop = 'bw';
                        if(colModel[2].searchoptions )
                            filterop = colModel[2].searchoptions.sopt[0];

                        filter.rules.push({field:colModel[2].name,op:filterop,data:$('#'+idobjlookup).val()});
                        grid[0].p.search = true;
                        if(o.paramName!='')
                            $.extend(grid[0].p.postData,{paramName : o.paramName,paramData:$('#'+o.elementCascadeId).val(),altfilters:JSON.stringify(filter)});
                        else
                            $.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
                    }else
                        grid[0].p.search = false;
                    grid.trigger("reloadGrid",[{page:1}]);
                }
            });
            $('<div style="display:none;float:left;position:absolute;z-index:4001" id="'+idwrapper+'" ><table id="'+idgrid+'"></table> <div id="'+idpager+'"></div></div>').insertAfter(this.wrapper);

           $('#'+idgrid).jqGrid({
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

                }
            });

            var mostrar = this.show;


            $( '<a id="'+idobj+'_triangle">' )
                .attr( "tabIndex", -1 )
                .attr( "title", "Mostrar todas las opciones" )
                .appendTo( this.wrapper )
                .button({
                    icons: {
                        primary: "ui-icon-triangle-1-s"
                    },
                    text: true
                    ,label:idobj
                })
                .removeClass( "ui-corner-all" )
                .addClass( "ui-corner-right ui-combobox-toggle" )
                .click(function() {
                    mostrar();
                    /*var grid = $('#'+idgrid);
                    input.focus();
                    if(o.paramName!='')
                        $.extend(grid[0].p.postData,{paramName : o.paramName,paramData:$('#'+o.elementCascadeId).val()});

                    grid.trigger("reloadGrid",[{page:1}]);
                    if(!this.flagcascadelookupfield){
                        $('#'+idwrapper).show();
                        //carreraId_lookupgrid_wrapper
                        this.flagcascadelookupfield=true;
                    }else{
                        $('#'+idwrapper).hide();
                        this.flagcascadelookupfield=false;
                    }*/
                });
        },

        destroy: function() {
            this.wrapper.remove();
            this.element.show();
            $.Widget.prototype.destroy.call( this );
        }
    })
});