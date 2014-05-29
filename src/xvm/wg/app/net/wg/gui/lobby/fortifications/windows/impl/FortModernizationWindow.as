package net.wg.gui.lobby.fortifications.windows.impl
{
   import net.wg.infrastructure.base.meta.impl.FortModernizationWindowMeta;
   import net.wg.infrastructure.base.meta.IFortModernizationWindowMeta;
   import net.wg.gui.components.advanced.DashLine;
   import flash.text.TextField;
   import net.wg.gui.lobby.fortifications.cmp.build.impl.ModernizationCmp;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.fortifications.data.BuildingModernizationVO;
   import net.wg.data.constants.generated.EVENT_LOG_CONSTANTS;
   import flash.events.MouseEvent;
   import flash.display.InteractiveObject;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.gui.utils.ComplexTooltipHelper;


   public class FortModernizationWindow extends FortModernizationWindowMeta implements IFortModernizationWindowMeta
   {
          
      public function FortModernizationWindow() {
         super();
         this.applyButton.UIID = 76;
         this.cancelButton.UIID = 77;
         UIID = 78;
         isModal = false;
         isCentered = true;
         canDrag = true;
      }

      private static const HORIZONTAL_PADDING:int = 5;

      public var dashLine:DashLine;

      public var conditionIcon:TextField = null;

      public var buildingBefore:ModernizationCmp = null;

      public var buildingAfter:ModernizationCmp = null;

      public var conditions:TextField = null;

      public var costLabel:TextField = null;

      public var costValue:TextField = null;

      public var applyButton:SoundButtonEx = null;

      public var cancelButton:SoundButtonEx = null;

      private var model:BuildingModernizationVO = null;

      private var btnToolTipText:String = "";

      override public function onWindowCloseS() : void {
         App.eventLogManager.logUIElement(this,EVENT_LOG_CONSTANTS.EVENT_TYPE_ON_WINDOW_CLOSE,this.model.intBuildingID);
         super.onWindowCloseS();
      }

      public function as_applyButtonLbl(param1:String) : void {
         this.applyButton.label = param1;
      }

      public function as_cancelButton(param1:String) : void {
         this.cancelButton.label = param1;
      }

      public function as_windowTitle(param1:String) : void {
         window.title = param1;
      }

      override protected function setData(param1:BuildingModernizationVO) : void {
         this.model = param1;
         this.conditions.htmlText = this.model.condition;
         this.costLabel.htmlText = this.model.costUpgrade;
         this.costValue.htmlText = this.model.costValue;
         this.conditionIcon.htmlText = this.model.conditionIcon;
         this.applyButton.enabled = this.model.canUpgrade;
         this.applyButton.mouseChildren = this.applyButton.mouseEnabled = true;
         if(!this.applyButton.enabled && !(this.model.btnToolTip == null))
         {
            this.prepareToolTipMessage();
            this.applyButton.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this.applyButton.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         }
         this.buildingBefore.setData(this.model.beforeUpgradeData);
         this.buildingBefore.applyGlowFilter();
         this.buildingAfter.setData(this.model.afterUpgradeData);
         this.buildingAfter.applyGlowFilter();
      }

      override protected function onInitModalFocus(param1:InteractiveObject) : void {
         super.onInitModalFocus(param1);
         if((this.model) && (this.model.canUpgrade) && (this.applyButton.enabled))
         {
            setFocus(this.applyButton);
         }
         else
         {
            setFocus(this.cancelButton);
         }
      }

      override protected function configUI() : void {
         super.configUI();
         this.applyButton.addEventListener(ButtonEvent.CLICK,this.onClickApplyBtnHandler);
         this.cancelButton.addEventListener(ButtonEvent.CLICK,this.onClickCancelBtnHandler);
         var _loc1_:int = this.costLabel.x + HORIZONTAL_PADDING;
         this.dashLine.width = Math.floor(this.costValue.x + this.costValue.width - _loc1_ - HORIZONTAL_PADDING);
         this.dashLine.x = _loc1_;
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         window.useBottomBtns = true;
      }

      override protected function onDispose() : void {
         this.applyButton.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.applyButton.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.applyButton.removeEventListener(ButtonEvent.CLICK,this.onClickApplyBtnHandler);
         this.applyButton.dispose();
         this.applyButton = null;
         this.cancelButton.removeEventListener(ButtonEvent.CLICK,this.onClickCancelBtnHandler);
         this.cancelButton.dispose();
         this.cancelButton = null;
         this.buildingBefore.dispose();
         this.buildingBefore = null;
         this.buildingAfter.dispose();
         this.buildingAfter = null;
         this.model.dispose();
         this.model = null;
         this.conditions = null;
         this.costLabel = null;
         this.costValue = null;
         this.conditionIcon = null;
         super.onDispose();
      }

      protected function prepareToolTipMessage() : void {
         this.btnToolTipText = new ComplexTooltipHelper().addHeader(this.model.btnToolTip["header"]).addBody(this.model.btnToolTip["body"]).addNote("",false).make();
      }

      private function onRollOverHandler(param1:MouseEvent) : void {
         App.toolTipMgr.showComplex(this.btnToolTipText);
      }

      private function onRollOutHandler(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      private function onClickApplyBtnHandler(param1:ButtonEvent) : void {
         if(this.model.canUpgrade)
         {
            App.eventLogManager.logUIEvent(param1,this.model.intBuildingID);
            applyActionS();
         }
      }

      private function onClickCancelBtnHandler(param1:ButtonEvent) : void {
         App.eventLogManager.logUIEvent(param1,this.model.intBuildingID);
         this.onWindowCloseS();
      }
   }

}