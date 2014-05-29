package net.wg.gui.lobby.fortifications.cmp.main
{
   import net.wg.gui.lobby.fortifications.cmp.base.IFilledBar;
   import net.wg.infrastructure.interfaces.entity.IFocusContainer;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.fortifications.cmp.orders.IOrdersPanel;
   import net.wg.gui.components.controls.BitmapFill;


   public interface IMainFooter extends IFilledBar, IFocusContainer
   {
          
      function get leaveModeBtn() : SoundButtonEx;

      function set leaveModeBtn(param1:SoundButtonEx) : void;

      function get ordersPanel() : IOrdersPanel;

      function set ordersPanel(param1:IOrdersPanel) : void;

      function get intelligenceButton() : SoundButtonEx;

      function set intelligenceButton(param1:SoundButtonEx) : void;

      function get sortieBtn() : SoundButtonEx;

      function set sortieBtn(param1:SoundButtonEx) : void;

      function get footerBitmapFill() : BitmapFill;

      function set footerBitmapFill(param1:BitmapFill) : void;
   }

}