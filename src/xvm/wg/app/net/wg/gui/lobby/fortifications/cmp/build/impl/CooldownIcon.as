package net.wg.gui.lobby.fortifications.cmp.build.impl
{
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.gui.lobby.fortifications.cmp.build.ICooldownIcon;
   import flash.text.TextField;
   import net.wg.utils.ITweenAnimator;
   import net.wg.gui.lobby.fortifications.utils.impl.TweenAnimator;
   
   public class CooldownIcon extends UIComponentEx implements ICooldownIcon
   {
      
      public function CooldownIcon() {
         super();
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      public var loader:CooldownIconLoaderCtnr = null;
      
      private var _timeTextField:TextField = null;
      
      private function getTweenAnimator() : ITweenAnimator {
         return TweenAnimator.instance;
      }
      
      override protected function onDispose() : void {
         this.getTweenAnimator().removeAnims(this);
         this._timeTextField = null;
         this.loader.dispose();
         this.loader = null;
         super.onDispose();
      }
      
      public function get timeTextField() : TextField {
         return this._timeTextField;
      }
      
      public function set timeTextField(param1:TextField) : void {
         this._timeTextField = param1;
      }
   }
}
