package net.wg.gui.rally.views.intro
{
   import net.wg.infrastructure.base.meta.impl.BaseRallyIntroViewMeta;
   import net.wg.infrastructure.base.meta.IBaseRallyIntroViewMeta;
   import net.wg.gui.components.controls.SoundButtonEx;
   import flash.text.TextField;
   import scaleform.clik.events.ButtonEvent;
   import flash.events.MouseEvent;


   public class BaseRallyIntroView extends BaseRallyIntroViewMeta implements IBaseRallyIntroViewMeta
   {
          
      public function BaseRallyIntroView() {
         super();
      }

      public var listRoomBtn:SoundButtonEx;

      public var listRoomTitleLbl:TextField;

      public var listRoomDescrLbl:TextField;

      override protected function configUI() : void {
         super.configUI();
         this.listRoomBtn.addEventListener(ButtonEvent.CLICK,this.onListRoomBtnClick);
         this.listRoomBtn.addEventListener(MouseEvent.ROLL_OVER,onControlRollOver);
         this.listRoomBtn.addEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
      }

      override protected function onDispose() : void {
         if(this.listRoomBtn)
         {
            this.listRoomBtn.removeEventListener(ButtonEvent.CLICK,this.onListRoomBtnClick);
            this.listRoomBtn.removeEventListener(MouseEvent.ROLL_OVER,onControlRollOver);
            this.listRoomBtn.removeEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            this.listRoomBtn.dispose();
            this.listRoomBtn = null;
         }
         super.onDispose();
      }

      protected function onListRoomBtnClick(param1:ButtonEvent) : void {
          
      }
   }

}