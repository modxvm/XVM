package net.wg.gui.components.controls
{
   import flash.text.TextField;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import scaleform.clik.utils.ConstrainedElement;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.utils.IHelpLayout;
   import net.wg.data.constants.SoundTypes;


   public class MainMenuButton extends SoundButtonEx
   {
          
      public function MainMenuButton() {
         super();
         constraintsDisabled = true;
         soundType = SoundTypes.MAIN_MENU;
         this.fxTextField2 = this.fx.fxTextField2;
      }

      private var _caps:Boolean = true;

      public var fxTextField1:TextField = null;

      public var fxTextField2:TextField = null;

      public var fx:MovieClip = null;

      public var gradient:MovieClip = null;

      private var _textColorOver:Number;

      private var textColorBeforeBlink:Number = NaN;

      override protected function configUI() : void {
         super.configUI();
         this.paddingHorizontal = 0;
         addEventListener(MouseEvent.ROLL_OVER,this.onBtnOver);
         addEventListener(MouseEvent.ROLL_OUT,this.onBtnOut);
         this.checkBrowserEffect();
      }

      override public function get paddingHorizontal() : Number {
         return _paddingHorizontal;
      }

      override public function set paddingHorizontal(param1:Number) : void {
         _paddingHorizontal = param1;
         invalidate();
      }

      public function get caps() : Boolean {
         return this._caps;
      }

      public function set caps(param1:Boolean) : void {
         if(this._caps == param1)
         {
            return;
         }
         this._caps = param1;
         invalidate();
      }

      override public function set enabled(param1:Boolean) : void {
         super.enabled = param1;
         if(param1)
         {
            this.checkBrowserEffect();
         }
      }

      override protected function updateText() : void {
         var _loc1_:String = null;
         if(this.gradient)
         {
            this.gradient.width = 1;
         }
         if(this.caps)
         {
            if(_label != null)
            {
               _loc1_ = App.utils.locale.makeString(_label,{});
               if(_loc1_)
               {
                  _loc1_ = _loc1_.toUpperCase();
               }
               else
               {
                  _loc1_ = "";
               }
               if(textField != null)
               {
                  textField.text = _loc1_;
               }
               if(textField1 != null)
               {
                  textField1.text = _loc1_;
               }
               if(blurTextField != null)
               {
                  blurTextField.text = _loc1_;
                  blurTextField.width = blurTextField.textWidth + 5;
               }
               if(this.fxTextField1 != null)
               {
                  this.fxTextField1.text = _loc1_;
                  this.fxTextField1.width = this.fxTextField1.textWidth + 5;
               }
               if(this.fxTextField2 != null)
               {
                  this.fxTextField2.text = _loc1_;
                  this.fxTextField2.width = this.fxTextField2.textWidth + 5;
               }
            }
         }
         else
         {
            super.updateText();
            if(blurTextField != null)
            {
               blurTextField.text = _label;
            }
            if(this.fxTextField1 != null)
            {
               this.fxTextField1.text = _label;
            }
            if(this.fxTextField2 != null)
            {
               this.fxTextField2.text = _label;
            }
         }
         if(this.gradient)
         {
            this.gradient.width = this.actualWidth;
         }
         this.width = this.actualWidth;
      }

      override protected function alignForAutoSize() : void {
         var _loc1_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         if(!initialized || _autoSize == TextFieldAutoSize.NONE || !textField)
         {
            return;
         }
         _loc1_ = _width;
         var _loc2_:Number = _width = this.calculateWidth();
         switch(_autoSize)
         {
            case TextFieldAutoSize.RIGHT:
               _loc3_ = x + _loc1_;
               x = _loc3_ - _loc2_;
               break;
            case TextFieldAutoSize.CENTER:
               _loc4_ = x + _loc1_ * 0.5;
               x = _loc4_ - _loc2_ * 0.5;
               break;
         }
      }

      override protected function calculateWidth() : Number {
         var _loc2_:ConstrainedElement = null;
         var _loc3_:TextField = null;
         var _loc1_:Number = actualWidth;
         if(!constraintsDisabled && (initialized))
         {
            _loc2_ = constraints.getElement(textField?"textField":"blurTextField");
            _loc3_ = textField?textField:blurTextField;
            _loc1_ = _loc3_.textWidth + _loc2_.left + _loc2_.right + 5 + (_paddingHorizontal << 1);
         }
         return _loc1_;
      }

      public function get textColorOver() : Number {
         return _textColor;
      }

      public function set textColorOver(param1:Number) : void {
         if(this._textColorOver == param1)
         {
            return;
         }
         this._textColorOver = param1;
         invalidate();
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            if(((this._textColorOver) && (!selected)) && (state == "over") && !(this.fxTextField1 == null))
            {
               this.fxTextField1.textColor = this._textColorOver;
            }
            else
            {
               if((_textColor) && (enabled) && !(this.fxTextField1 == null))
               {
                  this.fxTextField1.textColor = _textColor;
               }
            }
            if((selected) && (enabled))
            {
               this.gradient.alpha = 0.4;
            }
            else
            {
               this.gradient.alpha = 1;
            }
         }
      }

      override public function showHelpLayout() : void {
         var _loc1_:IHelpLayout = App.utils.helpLayout;
         var _loc2_:Object =
            {
               "borderWidth":width,
               "borderHeight":this.fxTextField1.textHeight + 5,
               "direction":data["helpDirection"],
               "text":data["helpText"],
               "x":0,
               "y":0,
               "connectorLength":data["helpConnectorLength"]
            }
         ;
         if(data["helpText"])
         {
            setHelpLayout(_loc1_.create(root,_loc2_,this));
         }
      }

      private function checkBrowserEffect() : void {
         if((data) && data.value == "browser")
         {
            App.utils.scheduler.scheduleTask(this.changeEffectState,1000);
            selected = false;
         }
      }

      private var _isBlinking:Boolean = false;

      private function changeEffectState() : void {
         if((selected) || !enabled)
         {
            filters = [];
            this._isBlinking = false;
            return;
         }
         if(this.fxTextField1)
         {
            if(isNaN(this.textColorBeforeBlink))
            {
               this.textColorBeforeBlink = this.fxTextField1.textColor;
            }
            this._isBlinking = !this._isBlinking;
            if(this._isBlinking)
            {
               this.fxTextField1.textColor = 16563563;
            }
            else
            {
               this.fxTextField1.textColor = this.textColorBeforeBlink;
            }
            App.utils.scheduler.scheduleTask(this.changeEffectState,1000);
         }
      }

      private function onBtnOver(param1:MouseEvent) : void {
         if((data) && data.value == "browser")
         {
            App.utils.scheduler.cancelTask(this.changeEffectState);
            filters = [];
         }
      }

      private function onBtnOut(param1:MouseEvent) : void {
         this.checkBrowserEffect();
      }
   }

}