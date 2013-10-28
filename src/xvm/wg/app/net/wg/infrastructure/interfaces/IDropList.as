package net.wg.infrastructure.interfaces
{
   import scaleform.clik.interfaces.IUIComponent;


   public interface IDropList extends IUIComponent
   {
          
      function get selectable() : Boolean;

      function set selectable(param1:Boolean) : void;

      function highlightList() : void;

      function hideHighLight() : void;
   }

}