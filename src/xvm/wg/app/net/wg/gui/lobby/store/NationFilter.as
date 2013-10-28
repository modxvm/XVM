package net.wg.gui.lobby.store
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.components.controls.NationDropDownMenu;
   import flash.text.TextField;


   public class NationFilter extends UIComponent
   {
          
      public function NationFilter() {
         super();
      }

      public var nation:NationDropDownMenu = null;

      public var textField:TextField = null;
   }

}