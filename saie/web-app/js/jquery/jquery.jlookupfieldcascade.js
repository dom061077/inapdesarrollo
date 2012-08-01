$(document).ready(function(){
    $.fn.extend({

        combolookupfield: function(settings) {

            var defaults = {
                grid:{
                    url:'',
                    colNames:[],
                    colModel:[]
                },
                inputDesc:'',
                cascade: {
                    elementCascadeId:'',
                    paramName:''
                },
                onSelected:function(){

                }
            };
            var o = $.extend(defaults, settings),
            flagcascadelookupfield=false;
            var input,
                idobj ,
                idobjlookup,
                idgrid,
                idpager,
                idwrapper,
                select ;
             var wrapper;

            this.clear = function (){
                $('#'+idobj).val('');
                $('#'+idobjlookup).val('');
                $('#'+idobjlookup+'_wrapper').hide();
                flagcascadelookupfield =false;
            }

            return this.each(function() {

                idobj =$(this).attr('id');
                idobjlookup=$(this).attr('id')+'_lookupgrid',
                    idgrid=idobjlookup+'_grid';
                idpager=idobjlookup+'_pager';
                idwrapper=idobjlookup+'_wrapper';
                select = $(this).hide();

                /*var input,
                    o = this.options,
                    idobj = this.element[0].id;
                idobjlookup=this.element[0].id+'_lookupgrid',
                    idgrid=idobjlookup+'_grid';
                idpager=idobjlookup+'_pager';
                idwrapper=idobjlookup+'_wrapper';
                self = this,
                select = this.element.hide();*/

                wrapper = $( '<span id="'+idobj+'_wrapper">' )
                    .addClass( "ui-combobox" )
                    .insertAfter( select );
                input = $( '<input type="text" style="margin: 0 0" class="ui-widget ui-corner-all ui-widget-content" name="'+o.inputNameDesc+'" id="'+idobjlookup+'"/>' )
                    .appendTo( wrapper );
                input.val($('#'+idobj).attr('descValue'));
                $('#'+idobjlookup).keyup(function(e){
                    o.onSelected();
                    var grid = $('#'+idgrid);
                    if(e.keyCode==27){
                        $('#'+idobjlookup+'_wrapper').hide();
                        flagcascadelookupfield = false;
                    }else{
                        if(e.keyCode==40){
                            if(!flagcascadelookupfield)
                                $('#'+idobjlookup+'_wrapper').show();
                            grid[0].p.search = false;
                            grid.trigger("reloadGrid",[{page:1}]);
                        }
                        if(e.keyCode==8){
                            if($('#'+idobjlookup).val()==''){
                                $('#'+idobj).val('');
                                flagcascadelookupfield = false;
                                $('#'+idwrapper).hide();
                                grid[0].p.search = false;
                                grid.trigger("reloadGrid",[{page:1}]);
                                return
                            }
                        }
                        if(e.keyCode==46){
                            if($('#'+idobjlookup).val()==''){
                                $('#'+idobj).val('');
                                flagcascadelookupfield = false;
                                $('#'+idwrapper).hide();
                                grid[0].p.search = false;
                                grid.trigger("reloadGrid",[{page:1}]);
                                return
                            }
                        }
                        if($('#'+idobjlookup).val()!=''){
                            if(!flagcascadelookupfield){
                                $('#'+idobjlookup+'_wrapper').show();
                                flagcascadelookupfield=true;
                            }
                            var colNames = $('#'+idgrid).jqGrid('getGridParam','colNames');
                            var colModel = $('#'+idgrid).jqGrid('getGridParam','colModel');
                            var filter = { groupOp: "AND", rules: []},filterop='bw';
                            if(colModel[2].searchoptions )
                                filterop = colModel[2].searchoptions.sopt[0];

                            filter.rules.push({field:colModel[2].name,op:filterop,data:$('#'+idobjlookup).val()});
                            grid[0].p.search = true;
                            if(o.paramName!='')
                                $.extend(grid[0].p.postData,{paramName : o.cascade.paramName,paramData:$('#'+o.cascade.elementCascadeId).val(),altfilters:JSON.stringify(filter)});
                            else
                                $.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
                        }else
                            grid[0].p.search = false;
                        grid.trigger("reloadGrid",[{page:1}]);
                    }
                });
                $('<div style="display:none;float:left;position:absolute;z-index:4001" id="'+idwrapper+'" ><table id="'+idgrid+'"></table> <div id="'+idpager+'"></div></div>').insertAfter(wrapper);

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
                        var colModel = $('#'+idgrid).jqGrid('getGridParam','colModel');
                        var obj=$('#'+idgrid).getRowData(id);
                        $('#'+idobj).val(obj.id);
                        $('#'+idobjlookup).val(obj[colModel[2].name]);
                        $('#'+idobjlookup+'_wrapper').hide();
                        flagcascadelookupfield = false;
                        o.onSelected();
                    }
                });



                $( '<a id="'+idobj+'_triangle">' )
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
                        var grid = $('#'+idgrid);
                         input.focus();
                         if(o.cascade.paramName!=''){
                             grid[0].p.search = true;
                            $.extend(grid[0].p.postData,{paramName : o.cascade.paramName,paramData:$('#'+o.cascade.elementCascadeId).val()});
                         }

                         grid.trigger("reloadGrid",[{page:1}]);
                         if(!flagcascadelookupfield){
                         $('#'+idwrapper).show();
                         //carreraId_lookupgrid_wrapper
                         flagcascadelookupfield=true;
                         }else{
                         $('#'+idwrapper).hide();
                         flagcascadelookupfield=false;
                         }
                    });


            });  //----------cierre de function each--------
        }
    });
});