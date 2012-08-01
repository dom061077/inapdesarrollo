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
            }
        },
        mostrar: function(){
            var grid = $('#'+this.idgrid);
            //input.focus();
            if(this.o.paramName!='')
                $.extend(grid[0].p.postData,{paramName : this.o.paramName,paramData:$('#'+this.o.elementCascadeId).val()});

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
        _create: function(value) {
            this.flagcascadelookupfield=false
            this.idwrapper=this.element[0].id+'_lookupgrid'+'_wrapper';
            this.idgrid = this.element[0].id+'_lookupgrid'+'_grid';
            this.option = this.options;
            var input;
                this.o = this.options,
                this.idobj = this.element[0].id;
                this.idobjlookup=this.element[0].id+'_lookupgrid',
                this.idgrid=this.idobjlookup+'_grid';
                this.idpager=this.idobjlookup+'_pager';
                this.idwrapper=this.idobjlookup+'_wrapper';
                self = this,
                select = this.element.hide();
                //select = this.element,
            var wrapper = this.wrapper = $( '<span id="'+this.idobj+'_wrapper">' )
                    .addClass( "ui-combobox" )
                    .insertAfter( select );
            this.input = $( '<input type="text" style="margin: 0 0" class="ui-widget ui-corner-all ui-widget-content" name="'+this.o.inputNameDesc+'" id="'+this.idobjlookup+'"/>' )
                .appendTo( wrapper );
            this.input.val($('#'+this.idobj).attr('descValue'));
            this.input.keyup(function(e){
                var grid = $('#'+self.idgrid);
                if(e.keyCode==27){
                    $('#'+self.idobjlookup+'_wrapper').hide();
                    this.flagcascadelookupfield = false;
                }else{
                    if(e.keyCode==40){
                        if(!self.flagcascadelookupfield)
                            $('#'+self.idobjlookup+'_wrapper').show();
                        $('#'+idgrid).focus();
                    }
                    if(e.keyCode==8){
                        if($('#'+self.idobjlookup).val()==''){
                            $('#'+self.idobj).val('');
                            self.flagcascadelookupfield = false;
                            $('#'+self.idwrapper).hide();
                            return
                        }
                    }
                    if(e.keyCode==46){
                        if($('#'+self.idobjlookup).val()==''){
                            $('#'+self.idobj).val('');
                            self.flagcascadelookupfield = false;
                            $('#'+self.idwrapper).hide();
                            return
                        }
                    }
                    if($('#'+self.idobjlookup).val()!=''){
                        if(!self.flagcascadelookupfield){
                            $('#'+self.idobjlookup+'_wrapper').show();
                            this.flagcascadelookupfield=true;
                        }
                        var colNames = $('#'+self.idgrid).jqGrid('getGridParam','colNames');
                        var colModel = $('#'+self.idgrid).jqGrid('getGridParam','colModel');
                        var filter = { groupOp: "AND", rules: []};
                        var filterop = 'bw';
                        if(colModel[2].searchoptions )
                            filterop = colModel[2].searchoptions.sopt[0];

                        filter.rules.push({field:colModel[2].name,op:filterop,data:$('#'+self.idobjlookup).val()});
                        grid[0].p.search = true;
                        if(self.o.paramName!='')
                            $.extend(grid[0].p.postData,{paramName : self.o.paramName,paramData:$('#'+self.o.elementCascadeId).val(),altfilters:JSON.stringify(filter)});
                        else
                            $.extend(grid[0].p.postData,{altfilters:JSON.stringify(filter)});
                    }else
                        grid[0].p.search = false;
                    grid.trigger("reloadGrid",[{page:1}]);
                }
            });
            $('<div style="float:left;position:absolute;z-index:4001" id="'+this.idwrapper+'" ><table id="'+this.idgrid+'"></table> <div id="'+this.idpager+'"></div></div>').insertAfter(this.wrapper);

           $('#'+this.idgrid).jqGrid({
                //caption:'colocar caption',
                width:300,
                url:self.o.grid.url,
                //postData:{profesionalId:$("#profesionalId").val()},
                mtype:"POST",
                rownumbers:true,
                rowList:[10,20,30],
                pager:self.idpager,
                datatype:"json",
                colNames:self.o.grid.colNames,
                colModel:self.o.grid.colModel,
                ondblClickRow: function(id){

                }
            });

            /*
            this.show =  function hola() {
                var grid = $('#'+self.idgrid);
                input.focus();
                if(self.o.paramName!='')
                    $.extend(grid[0].p.postData,{paramName : self.o.paramName,paramData:$('#'+self.o.elementCascadeId).val()});

                grid.trigger("reloadGrid",[{page:1}]);
                if(!self.flagcascadelookupfield){
                    $('#'+self.idwrapper).show();
                    //carreraId_lookupgrid_wrapper
                    self.flagcascadelookupfield=true;
                }else{
                    $('#'+self.idwrapper).hide();
                    self.flagcascadelookupfield=false;
                } ;*/


            $( '<a href="#" id="'+this.idobj+'_triangle">'+this.idobj+'_triangle</a>' )
                .attr( "tabIndex", -1 )
                .attr( "title", "Mostrar todas las opciones" )
                .appendTo( wrapper )
                /*.button({
                    icons: {
                        primary: "ui-icon-triangle-1-s"
                    },
                    text: true
                    ,label:self.idobj
                });
                .removeClass( "ui-corner-all" )
                .addClass( "ui-corner-right ui-combobox-toggle" );
               .click(function(){
                    alert(self.idobj);
                });*/
           $('#'+this.idobj+'_triangle').bind('click',function(){
               alert(self.idobj);
           });
        },

        destroy: function() {
            this.wrapper.remove();
            this.element.show();
            $.Widget.prototype.destroy.call( this );
        }
    })
});