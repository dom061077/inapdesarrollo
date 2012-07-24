$(document).ready(function(){
     $.widget('ui.',{
         options:{

         },
         _create: function() {

         },
         destroy: function() {
             this.wrapper.remove();
             this.element.show();
             $.Widget.prototype.destroy.call( this );
         }

     })
});