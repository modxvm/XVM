package net.wg.gui.lobby.questsWindow.components
{
   import scaleform.clik.core.UIComponent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.QuestsStates;


   public class QuestStatusComponent extends UIComponent
   {
          
      public function QuestStatusComponent() {
         super();
      }

      private static function hideTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      public var textField:TextField;

      private var _statusTooltip:String = "";

      override protected function configUI() : void {
         super.configUI();
         addEventListener(MouseEvent.CLICK,hideTooltip);
         addEventListener(MouseEvent.ROLL_OUT,hideTooltip);
         addEventListener(MouseEvent.ROLL_OVER,this.showStatusTooltip);
      }

      override protected function onDispose() : void {
         removeEventListener(MouseEvent.CLICK,hideTooltip);
         removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
         removeEventListener(MouseEvent.ROLL_OVER,this.showStatusTooltip);
         super.onDispose();
      }

      public function setStatus(param1:String) : void {
         if(param1 == QuestsStates.NOT_AVAILABLE)
         {
            visible = true;
            gotoAndStop(QuestsStates.NOT_AVAILABLE);
            this.textField.text = QUESTS.QUESTS_STATUS_NOTAVAILABLE;
            this.textField.textColor = QuestsStates.CLR_STATUS_NOT_AVAILABLE;
            this._statusTooltip = TOOLTIPS.QUESTS_STATUS_NOTREADY;
         }
         else
         {
            if(param1 == QuestsStates.DONE)
            {
               visible = true;
               gotoAndStop(QuestsStates.DONE);
               this.textField.text = QUESTS.QUESTS_STATUS_DONE;
               this.textField.textColor = QuestsStates.CLR_STATUS_DONE;
               this._statusTooltip = TOOLTIPS.QUESTS_STATUS_DONE;
            }
            else
            {
               visible = false;
               this._statusTooltip = "";
            }
         }
      }

      private function showStatusTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.show(this._statusTooltip);
      }
   }

}