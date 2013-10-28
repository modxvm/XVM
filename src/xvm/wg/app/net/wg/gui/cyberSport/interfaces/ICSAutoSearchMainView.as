package net.wg.gui.cyberSport.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.gui.cyberSport.vo.AutoSearchVO;


   public interface ICSAutoSearchMainView extends IDisposable
   {
          
      function set changeState(param1:AutoSearchVO) : void;

      function set visible(param1:Boolean) : void;

      function get visible() : Boolean;

      function stopTimer() : void;

      function updateFocus() : void;

      function enableButton(param1:Boolean) : void;
   }

}