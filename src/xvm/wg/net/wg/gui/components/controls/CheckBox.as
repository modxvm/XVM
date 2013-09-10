package net.wg.gui.components.controls 
{
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.controls.*;
    
    public class CheckBox extends scaleform.clik.controls.CheckBox implements net.wg.infrastructure.interfaces.entity.ISoundable
    {
        public function CheckBox()
        {
            super();
            return;
        }

        public final function getSoundType():String
        {
            return this.soundType;
        }

        public final function getSoundId():String
        {
            return this.soundId;
        }

        public function enableDynamicFrameUpdating():void
        {
            this._dynamicFrameUpdating = true;
            return;
        }

        public final function getStateOverSnd():String
        {
            return net.wg.data.constants.SoundManagerStates.SND_OVER;
        }

        public final function getStateOutSnd():String
        {
            return net.wg.data.constants.SoundManagerStates.SND_OUT;
        }

        public final function getStatePressSnd():String
        {
            return net.wg.data.constants.SoundManagerStates.SND_PRESS;
        }

        public function get textFont():String
        {
            return this._textFont;
        }

        public function set textFont(arg1:String):void
        {
            if (this._textFont == arg1) 
                return;
            this._textFont = arg1;
            invalidate(this.TEXT_FORMAT_INV);
            return;
        }

        public function get textSize():Number
        {
            return this._textSize;
        }

        public override function set label(arg1:String):void
        {
            if (!this._dynamicFrameUpdating || arg1.length > 0) 
                super.label = arg1;
            return;
        }

        public override function set data(arg1:Object):void
        {
            if (!this._dynamicFrameUpdating || arg1.length > 0) 
                super.data = arg1;
            return;
        }

        public function set textSize(arg1:Number):void
        {
            if (this._textSize == arg1) 
                return;
            this._textSize = arg1;
            invalidate(this.TEXT_FORMAT_INV);
            return;
        }

        public function get textColor():Number
        {
            return this._textColor;
        }

        public function set textColor(arg1:Number):void
        {
            if (this._textColor == arg1) 
                return;
            this._textColor = arg1;
            invalidate(this.TEXT_FORMAT_INV);
            return;
        }

        public function get disabledTextAlpha():Number
        {
            return this._disabledTextAlpha;
        }

        public function set disabledTextAlpha(arg1:Number):void
        {
            if (this._disabledTextAlpha == arg1) 
                return;
            this._disabledTextAlpha = arg1;
            invalidate(this.TEXT_FORMAT_INV);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            buttonMode = true;
            if (App.soundMgr != null) 
                App.soundMgr.addSoundsHdlrs(this);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            super.draw();
            if (isInvalid(this.TEXT_FORMAT_INV)) 
                if (textField) 
                {
                    textField.textColor = this._textColor;
                    loc1 = new flash.text.TextFormat();
                    loc1.font = this._textFont;
                    loc1.size = this._textSize;
                    textField.setTextFormat(loc1);
                    textField.alpha = enabled ? 1 : this._disabledTextAlpha;
                }
            return;
        }

        protected override function updateAfterStateChange():void
        {
            super.updateAfterStateChange();
            invalidate(this.TEXT_FORMAT_INV);
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            return;
        }

        public var soundType:String="checkBox";

        public var soundId:String="";

        protected var _textColor:Number=9868935;

        protected var _disabledTextAlpha:Number=0.5;

        internal var TEXT_FORMAT_INV:String="textFormatInv";

        internal var _textFont:String="$TextFont";

        internal var _textSize:Number=12;

        internal var _dynamicFrameUpdating:Boolean=false;
    }
}
