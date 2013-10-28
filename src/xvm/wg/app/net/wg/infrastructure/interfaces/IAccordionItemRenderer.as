package net.wg.infrastructure.interfaces
{
   import scaleform.clik.interfaces.IListItemRenderer;


   public interface IAccordionItemRenderer extends IListItemRenderer
   {
          
      function set enableConstraints(param1:Boolean) : void;

      function get label() : String;

      function set label(param1:String) : void;

      function get name() : String;

      function setSize(param1:Number, param2:Number) : void;
   }

}