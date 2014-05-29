package net.wg.gui.lobby.questsWindow.components
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.components.controls.CheckBox;
   import flash.text.TextField;
   import net.wg.data.constants.QuestsStates;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.VO.ProgressElementVO;


   public class ResizableContentHeader extends UIComponent
   {
          
      public function ResizableContentHeader() {
         super();
      }

      private static const INVALIDATE_HTML_LABEL:String = "invHtmlLabel";

      private static const INVALIDATE_LABEL:String = "invLabel";

      private static const INVALIDATE_PROGRESS:String = "invProgress";

      private static const INVALIDATE_SHOW_DONE:String = "invShowDone";

      public static const TEXT_PADDING:int = 5;

      public var slideCheckBox:CheckBox;

      private var _progrType:String = "";

      private var _currentProgr:Number = 0;

      private var _totalProgr:Number = 0;

      private var _progrTooltip:Object = null;

      private var _showDone:Boolean = false;

      private var _htmlLabel:String = "";

      private var _label:String = "";

      public var htmlTF:TextField;

      public var progressIndicator:ProgressQuestIndicator;

      public var statusMC:QuestStatusComponent;

      override protected function configUI() : void {
         super.configUI();
         this.progressIndicator.visible = false;
         this.statusMC.setStatus(QuestsStates.DONE);
         this.statusMC.textAlign = TextFieldAutoSize.RIGHT;
         this.statusMC.showTooltip = false;
         this.statusMC.validateNow();
         this.statusMC.visible = false;
      }

      override protected function onDispose() : void {
         this.statusMC.dispose();
         this.statusMC = null;
         this.slideCheckBox.dispose();
         this.slideCheckBox = null;
         this._progrTooltip = null;
         this.progressIndicator.dispose();
         this.progressIndicator = null;
         this.htmlTF = null;
         super.onDispose();
      }

      public function setProgress(param1:Object) : void {
         var _loc2_:ProgressElementVO = new ProgressElementVO(param1);
         this._progrType = _loc2_.progrBarType;
         this._currentProgr = _loc2_.currentProgrVal;
         this._totalProgr = _loc2_.maxProgrVal;
         this._progrTooltip = _loc2_.progrTooltip;
         invalidate(INVALIDATE_PROGRESS);
      }

      override protected function draw() : void {
         var _loc1_:* = NaN;
         super.draw();
         if(isInvalid(INVALIDATE_LABEL))
         {
            this.slideCheckBox.label = this._label;
            this.slideCheckBox.validateNow();
         }
         if(isInvalid(INVALIDATE_HTML_LABEL))
         {
            _loc1_ = this.slideCheckBox.textField.textWidth;
            this.htmlTF.x = Math.round(this.slideCheckBox.textField.x + _loc1_ + (_loc1_ > 0?TEXT_PADDING:0));
            this.htmlTF.htmlText = this._htmlLabel;
         }
         if(isInvalid(INVALIDATE_PROGRESS))
         {
            this.progressIndicator.visible = Boolean(this._progrType);
            this.progressIndicator.setValues(this._progrType,this._currentProgr,this._totalProgr);
            this.progressIndicator.setTooltip(this._progrTooltip);
         }
         if(isInvalid(INVALIDATE_SHOW_DONE))
         {
            this.statusMC.visible = this._showDone;
            this.progressIndicator.visible = (Boolean(this._progrType)) && !this._showDone;
         }
      }

      public function get htmlLabel() : String {
         return this._htmlLabel;
      }

      public function set htmlLabel(param1:String) : void {
         this._htmlLabel = param1;
         invalidate(INVALIDATE_HTML_LABEL);
      }

      public function get label() : String {
         return this._label;
      }

      public function set label(param1:String) : void {
         this._label = param1;
         invalidate(INVALIDATE_LABEL);
      }

      public function get showDone() : Boolean {
         return this._showDone;
      }

      public function set showDone(param1:Boolean) : void {
         this._showDone = param1;
         invalidate(INVALIDATE_SHOW_DONE);
      }
   }

}