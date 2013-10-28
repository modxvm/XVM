package net.wg.gui.lobby.questsWindow
{
   import scaleform.clik.core.UIComponent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import net.wg.gui.lobby.questsWindow.data.ComplexTooltipVO;
   import flash.display.Sprite;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.data.constants.QuestsStates;
   import net.wg.gui.utils.ComplexTooltipHelper;


   public class ProgressQuestIndicator extends UIComponent
   {
          
      public function ProgressQuestIndicator() {
         super();
         this.container = new Sprite();
      }

      public static const MASK_WIDTH:Number = 64;

      private static function hideTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      public var textField:TextField;

      public var maskMC:MovieClip;

      public var lineMC:MovieClip;

      public var dotsMC:MovieClip;

      public var bgMC:MovieClip;

      private var _type:String = "current";

      private var _currentValue:Number = 0;

      private var _totalValue:Number = 100;

      private var _tooltip:ComplexTooltipVO = null;

      public var container:Sprite;

      override protected function configUI() : void {
         super.configUI();
         addEventListener(MouseEvent.CLICK,hideTooltip);
         addEventListener(MouseEvent.ROLL_OUT,hideTooltip);
         addEventListener(MouseEvent.ROLL_OVER,this.showTooltip);
      }

      override public function dispose() : void {
         removeEventListener(MouseEvent.CLICK,hideTooltip);
         removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
         removeEventListener(MouseEvent.ROLL_OVER,this.showTooltip);
         super.dispose();
      }

      public function setValues(param1:String, param2:Number, param3:Number) : void {
         this._currentValue = param2;
         this._totalValue = param3 > 0?param3:100;
         this._type = param1;
         invalidateData();
      }

      public function setTooltip(param1:Object) : void {
         this._tooltip = param1?new ComplexTooltipVO(param1):null;
      }

      override protected function draw() : void {
         var _loc1_:* = NaN;
         var _loc2_:* = NaN;
         var _loc3_:* = 0;
         var _loc4_:MovieClip = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.maskMC.width = this._currentValue / this._totalValue * MASK_WIDTH;
            this.textField.text = App.utils.locale.integer(this._currentValue) + " / " + App.utils.locale.integer(this._totalValue);
            if(this.bgMC.contains(this.container))
            {
               this.bgMC.removeChild(this.container);
            }
            if(this._type == QuestsStates.CURRENT)
            {
               this.lineMC.gotoAndStop(QuestsStates.CURRENT);
            }
            if(this._type == QuestsStates.STRATEGIC)
            {
               this.lineMC.gotoAndStop(QuestsStates.STRATEGIC);
               this.container = new Sprite();
               this.container.scaleX = 1 / scaleX;
               this.container.scaleY = 1 / scaleY;
               this.bgMC.addChild(this.container);
               _loc1_ = this._totalValue-1;
               _loc2_ = MASK_WIDTH / this._totalValue;
               _loc3_ = 0;
               while(_loc3_ < _loc1_)
               {
                  _loc4_ = App.utils.classFactory.getComponent("Delimeter_UI",MovieClip);
                  _loc4_.x = Math.round(_loc2_ + _loc2_ * _loc3_);
                  this.container.addChild(_loc4_);
                  _loc3_++;
               }
            }
         }
      }

      private function showTooltip(param1:MouseEvent) : void {
         var _loc2_:String = null;
         if(this._tooltip)
         {
            _loc2_ = new ComplexTooltipHelper().addHeader(this._tooltip.header).addBody(this._tooltip.body,false).addNote(this._tooltip.note?this._tooltip.note:null,false).make();
            if(_loc2_.length > 0)
            {
               App.toolTipMgr.showComplex(_loc2_);
            }
         }
         else
         {
            if(this._type == QuestsStates.STRATEGIC)
            {
               App.toolTipMgr.show(TOOLTIPS.QUESTS_PROGRESS_STRATEGIC);
            }
            else
            {
               if(this._type == QuestsStates.CURRENT)
               {
                  App.toolTipMgr.show(TOOLTIPS.QUESTS_PROGRESS_CURRENT);
               }
            }
         }
      }
   }

}