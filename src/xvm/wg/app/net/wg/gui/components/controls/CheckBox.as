package net.wg.gui.components.controls
{
   import scaleform.clik.controls.CheckBox;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   import net.wg.infrastructure.interfaces.ITextContainer;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.data.constants.Errors;
   import flash.text.TextFormat;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   
   public class CheckBox extends scaleform.clik.controls.CheckBox implements ISoundable, ITextContainer
   {
      
      public function CheckBox() {
         super();
      }
      
      public var soundId:String = "";
      
      protected var _textColor:Number = 9868935;
      
      protected var _disabledTextAlpha:Number = 0.5;
      
      private var _soundType:String = "checkBox";
      
      private var TEXT_FORMAT_INV:String = "textFormatInv";
      
      private var INFO_INV:String = "infoInv";
      
      private var _textFont:String = "$TextFont";
      
      private var _textSize:Number = 12;
      
      private var _dynamicFrameUpdating:Boolean = false;
      
      private var _toolTip:String = "";
      
      private var _infoIcoType:String = "";
      
      private var _infoIco:InfoIcon = null;
      
      override protected function onDispose() : void {
         if(App.soundMgr)
         {
            App.soundMgr.removeSoundHdlrs(this);
         }
         if(this._infoIco)
         {
            this.removeInfoIco();
         }
         super.onDispose();
      }
      
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
      
      override public function set label(param1:String) : void {
         if(!this._dynamicFrameUpdating || param1.length > 0)
         {
            super.label = param1;
         }
      }
      
      override protected function updateText() : void {
         if(!(_label == null) && !(textField == null))
         {
            textField.text = _label;
         }
      }
      
      override public function set data(param1:Object) : void {
         if(!this._dynamicFrameUpdating || param1.length > 0)
         {
            super.data = param1;
         }
      }
      
      public function set textAlign(param1:String) : void {
         throw new AbstractException("setter CheckBox::textAlign" + Errors.ABSTRACT_INVOKE);
      }
      
      public function get textAlign() : String {
         return textField.getTextFormat().align;
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
      
      public function get soundType() : String {
         return this._soundType;
      }
      
      public function set soundType(param1:String) : void {
         if((param1) && !(param1 == this._soundType))
         {
            this._soundType = param1;
         }
      }
      
      public function set infoIcoType(param1:String) : void {
         if(param1 == this._infoIcoType)
         {
            return;
         }
         this._infoIcoType = param1;
         invalidate(this.INFO_INV);
      }
      
      public function get infoIcoType() : String {
         return this._infoIcoType;
      }
      
      public function set toolTip(param1:String) : void {
         if((param1) && !(param1 == this._toolTip))
         {
            this._toolTip = param1;
            invalidate(this.INFO_INV);
         }
      }
      
      public function get toolTip() : String {
         return this._toolTip;
      }
      
      override public function set enabled(param1:Boolean) : void {
         super.enabled = param1;
         buttonMode = enabled;
         mouseEnabled = true;
      }
      
      override protected function configUI() : void {
         super.configUI();
         buttonMode = enabled;
         mouseEnabled = true;
         if(App.soundMgr != null)
         {
            App.soundMgr.addSoundsHdlrs(this);
         }
      }
      
      override protected function draw() : void {
         var _loc1_:TextFormat = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.repositionInfoIcon();
         }
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
         if(isInvalid(this.INFO_INV))
         {
            if(!(this._infoIcoType == "") && !(this._toolTip == ""))
            {
               if(!this._infoIco)
               {
                  this.createInfoIco();
               }
               this._infoIco.tooltip = this._toolTip;
               this._infoIco.icoType = this._infoIcoType;
               this.repositionInfoIcon();
            }
            else
            {
               this.removeInfoIco();
            }
         }
      }
      
      private function repositionInfoIcon() : void {
         if(this._infoIco)
         {
            this._infoIco.x = this.x + textField.x + textField.textWidth + InfoIcon.CHECK_BOX_MARGIN;
            this._infoIco.y = this.y + (textField.y + textField.height >> 1) - 1;
         }
      }
      
      private function createInfoIco() : void {
         if(!owner && (parent))
         {
            owner = parent as UIComponent;
         }
         this._infoIco = InfoIcon(App.utils.classFactory.getObject("InfoIconUI"));
         owner.addChild(this._infoIco);
      }
      
      private function removeInfoIco() : void {
         if(this._infoIco)
         {
            this._infoIco.dispose();
            owner.removeChild(this._infoIco);
            this._infoIco = null;
         }
      }
      
      override protected function updateAfterStateChange() : void {
         super.updateAfterStateChange();
         invalidate(this.TEXT_FORMAT_INV);
      }
   }
}
