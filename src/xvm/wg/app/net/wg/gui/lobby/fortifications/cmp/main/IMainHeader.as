package net.wg.gui.lobby.fortifications.cmp.main
{
   import net.wg.gui.lobby.fortifications.cmp.base.IFilledBar;
   import net.wg.infrastructure.interfaces.entity.IFocusContainer;
   import flash.text.TextField;
   import net.wg.gui.components.controls.IconTextButton;
   import net.wg.gui.components.advanced.ToggleButton;
   import net.wg.gui.lobby.fortifications.cmp.main.impl.VignetteYellow;
   import net.wg.infrastructure.interfaces.IUIComponentEx;


   public interface IMainHeader extends IFilledBar, IFocusContainer
   {
          
      function get totalDepotQuantityText() : TextField;

      function set totalDepotQuantityText(param1:TextField) : void;

      function get statsBtn() : IconTextButton;

      function set statsBtn(param1:IconTextButton) : void;

      function get clanListBtn() : IconTextButton;

      function set clanListBtn(param1:IconTextButton) : void;

      function get transportBtn() : ToggleButton;

      function set transportBtn(param1:ToggleButton) : void;

      function get vignetteYellow() : VignetteYellow;

      function set vignetteYellow(param1:VignetteYellow) : void;

      function get clanInfo() : IFortHeaderClanInfo;

      function set clanInfo(param1:IFortHeaderClanInfo) : void;

      function get title() : TextField;

      function set title(param1:TextField) : void;

      function get tutorialArrow() : IUIComponentEx;

      function set tutorialArrow(param1:IUIComponentEx) : void;
   }

}