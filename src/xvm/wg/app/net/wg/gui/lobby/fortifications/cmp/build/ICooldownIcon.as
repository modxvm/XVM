package net.wg.gui.lobby.fortifications.cmp.build
{
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import flash.text.TextField;


   public interface ICooldownIcon extends IUIComponentEx
   {
          
      function get timeTextField() : TextField;

      function set timeTextField(param1:TextField) : void;
   }

}