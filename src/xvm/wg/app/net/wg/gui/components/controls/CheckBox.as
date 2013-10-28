package net.wg.gui.components.controls
{
   import scaleform.clik.controls.CheckBox;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   import net.wg.data.constants.SoundManagerStates;
   import flash.text.TextFormat;


   public class CheckBox extends scaleform.clik.controls.CheckBox implements ISoundable
   {
          
      public function CheckBox() {
         super();
      }

      private var _soundType:String = "checkBox";

      public var soundId:String = "";

      protected var _textColor:Number = 9868935;

      protected var _disabledTextAlpha:Number = 0.5;

      private var TEXT_FORMAT_INV:String = "textFormatInv";

      private var _textFont:String = "$TextFont";

      private var _textSize:Number = 12;

      private var _dynamicFrameUpdating:Boolean = false;

      public final function getSoundType() : String {
         return this.soundType;
      }

      public final function getSoundId() : String {
         return this.soundId;
      }

      public function enableDynamicFrameUpdating() : void {
         this._dynamicFrameUpdating = true;
      }

      public final function getStateOverSnd() : String {
         return SoundManagerStates.SND_OVER;
      }

      public final function getStateOutSnd() : String {
         return SoundManagerStates.SND_OUT;
      }

      public final function getStatePressSnd() : String {
         return SoundManagerStates.SND_PRESS;
      }

      public function get textFont() : String {
         return this._textFont;
      }

      public function set textFont(param1:String) : void {
         if(this._textFont == param1)
         {
            return;
         }
         this._textFont = param1;
         invalidate(this.TEXT_FORMAT_INV);
      }

      public function get textSize() : Number {
         return this._textSize;
      }

      override public function set label(param1:String) : void {
         if(!this._dynamicFrameUpdating || param1.length > 0)
         {
            super.label = param1;
         }
      }

      override public function set data(param1:Object) : void {
         if(!this._dynamicFrameUpdating || param1.length > 0)
         {
            super.data = param1;
         }
      }

      public function set textSize(param1:Number) : void {
         if(this._textSize == param1)
         {
            return;
         }
         this._textSize = param1;
         invalidate(this.TEXT_FORMAT_INV);
      }

      public function get textColor() : Number {
         return this._textColor;
      }

      public function set textColor(param1:Number) : void {
         if(this._textColor == param1)
         {
            return;
         }
         this._textColor = param1;
         invalidate(this.TEXT_FORMAT_INV);
      }

      public function get disabledTextAlpha() : Number {
         return this._disabledTextAlpha;
      }

      public function set disabledTextAlpha(param1:Number) : void {
         if(this._disabledTextAlpha == param1)
         {
            return;
         }
         this._disabledTextAlpha = param1;
         invalidate(this.TEXT_FORMAT_INV);
      }

      override protected function configUI() : void {
         super.configUI();
         buttonMode = true;
         if(App.soundMgr != null)
         {
            App.soundMgr.addSoundsHdlrs(this);
         }
      }

      override protected function draw() : void {
         var _loc1_:TextFormat = null;
         super.draw();
         if(isInvalid(this.TEXT_FORMAT_INV))
         {
            if(textField)
            {
               textField.textColor = this._textColor;
               _loc1_ = new TextFormat();
               _loc1_.font = this._textFont;
               _loc1_.size = this._textSize;
               textField.setTextFormat(_loc1_);
               textField.alpha = enabled?1:this._disabledTextAlpha;
            }
         }
      }

      override protected function updateAfterStateChange() : void {
         super.updateAfterStateChange();
         invalidate(this.TEXT_FORMAT_INV);
      }

      override public function dispose() : void {
         if(App.soundMgr)
         {
            App.soundMgr.removeSoundHdlrs(this);
         }
         super.dispose();
      }

      public function get soundType() : String {
         return this._soundType;
      }

      public function set soundType(param1:String) : void {
         if((param1) && !(param1 == this._soundType))
         {
            this._soundType = param1;
         }
      }
   }

}