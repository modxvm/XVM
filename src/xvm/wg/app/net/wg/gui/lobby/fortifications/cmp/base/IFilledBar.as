package net.wg.gui.lobby.fortifications.cmp.base
{
   import net.wg.infrastructure.interfaces.IUIComponentEx;


   public interface IFilledBar extends IUIComponentEx
   {
          
      function updateControls() : void;

      function set widthFill(param1:Number) : void;

      function get heightFill() : Number;
   }

}