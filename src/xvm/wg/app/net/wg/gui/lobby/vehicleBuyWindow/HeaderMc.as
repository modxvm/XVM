package net.wg.gui.lobby.vehicleBuyWindow
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import net.wg.gui.components.advanced.TankIcon;
   import net.wg.gui.components.advanced.TextAreaSimple;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.ScrollBar;


   public class HeaderMc extends UIComponent
   {
          
      public function HeaderMc() {
         super();
      }

      public var tankName:TextField;

      public var icon:TankIcon;

      public var tankDescr:TextAreaSimple;

      public var tankPriceLabel:TextField;

      public var tankPrice:IconText;

      public var descriptionScrollBar:ScrollBar;
   }

}