package net.wg.gui.lobby.fortifications.popovers.impl
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import flash.text.TextField;
   import net.wg.gui.components.controls.IconTextButton;
   import scaleform.clik.events.ButtonEvent;
   import flash.events.MouseEvent;
   import net.wg.gui.lobby.fortifications.events.FortBuildingCardPopoverEvent;
   import net.wg.gui.utils.ComplexTooltipHelper;


   public class FortPopoverAssignPlayer extends MovieClip implements IDisposable
   {
          
      public function FortPopoverAssignPlayer() {
         super();
         this.assignBtn.UIID = 85;
         this.assignBtn.textField.x = this.assignBtn.textField.x + TEXT_PADDING;
         this.assignBtn.addEventListener(ButtonEvent.CLICK,this.onClickAssignPlayerHandler);
         this.assignBtn.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.assignBtn.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }

      private static const TEXT_PADDING:uint = 6;

      public var assignLabl:TextField;

      public var assignBtn:IconTextButton;

      private var playerCount:int = 0;

      public function dispose() : void {
         this.assignBtn.removeEventListener(ButtonEvent.CLICK,this.onClickAssignPlayerHandler);
         this.assignBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.assignBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.assignBtn.dispose();
         this.assignBtn = null;
      }

      public function setData(param1:String, param2:int, param3:Boolean) : void {
         this.playerCount = param2;
         this.assignBtn.label = param2.toString();
         this.assignLabl.htmlText = param1;
         this.assignBtn.enabled = !param3;
         if(!this.assignBtn.enabled)
         {
            this.assignBtn.mouseEnabled = this.assignBtn.mouseChildren = true;
         }
      }

      private function onClickAssignPlayerHandler(param1:ButtonEvent) : void {
         App.eventLogManager.logUIEvent(param1,0);
         dispatchEvent(new FortBuildingCardPopoverEvent(FortBuildingCardPopoverEvent.ASSIGN_PLAYERS));
      }

      private function onRollOverHandler(param1:MouseEvent) : void {
         var _loc2_:String = new ComplexTooltipHelper().addHeader(App.utils.locale.makeString(TOOLTIPS.FORTIFICATION_POPOVER_FIXEDPLAYERSBTN_HEADER)).addBody(App.utils.locale.makeString(TOOLTIPS.FORTIFICATION_POPOVER_FIXEDPLAYERSBTN_BODY,{"count":this.playerCount.toString()})).addNote("",false).make();
         if(_loc2_.length > 0)
         {
            App.toolTipMgr.showComplex(_loc2_);
         }
      }

      private function onRollOutHandler(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }
   }

}