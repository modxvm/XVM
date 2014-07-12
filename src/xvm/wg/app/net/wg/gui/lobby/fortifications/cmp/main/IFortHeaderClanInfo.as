package net.wg.gui.lobby.fortifications.cmp.main
{
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.gui.lobby.fortifications.data.FortificationVO;
   
   public interface IFortHeaderClanInfo extends IUIComponentEx
   {
      
      function applyClanData(param1:FortificationVO) : void;
   }
}
