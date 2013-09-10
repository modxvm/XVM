package net.wg.gui.lobby.profile.headerBar 
{
    import flash.display.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.constants.*;
    
    public class ProfileTabButton extends net.wg.gui.components.controls.SoundButtonEx
    {
        public function ProfileTabButton()
        {
            super();
            preventAutosizing = true;
            constraintsDisabled = true;
            this.widthOffset = this.highLight.width - this.background.width;
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            hitArea = this.hit;
            this.hit.visible = false;
            return;
        }

        protected override function draw():void
        {
            var loc1:*=0;
            var loc2:*=null;
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
                textField.x = this.textHOffset;
                loc1 = this.receiveWidth();
                this.highLight.width = loc1 + this.widthOffset;
                this.background.width = loc1;
                this.hit.width = loc1;
            }
            if (isInvalid(LAST_LINE_INVALID)) 
            {
                loc2 = this.background as net.wg.gui.lobby.profile.headerBar.ProfileTabButtonBg;
                if (loc2) 
                    loc2.lastLine.visible = this._showLastLineItem;
            }
            return;
        }

        public override function set data(arg1:Object):void
        {
            super.data = arg1;
            if (data is String) 
                this.label = arg1.toString();
            else 
                this.label = data.label;
            return;
        }

        public override function set label(arg1:String):void
        {
            super.label = arg1.toUpperCase();
            return;
        }

        internal function receiveWidth():uint
        {
            if (textField) 
                return Math.round(textField.width + 2 * this.textHOffset);
            return super.width;
        }

        protected override function updateAfterStateChange():void
        {
            super.updateAfterStateChange();
            invalidate(LAST_LINE_INVALID);
            return;
        }

        protected override function updateText():void
        {
            super.updateText();
            invalidate(scaleform.clik.constants.InvalidationType.SIZE);
            return;
        }

        public override function get width():Number
        {
            return this.receiveWidth();
        }

        public function set showLastLineItem(arg1:Boolean):void
        {
            this._showLastLineItem = arg1;
            invalidate(LAST_LINE_INVALID);
            return;
        }

        internal static const LAST_LINE_INVALID:String="lli";

        public var hit:flash.display.MovieClip;

        public var highLight:flash.display.MovieClip;

        public var background:flash.display.MovieClip;

        internal var textHOffset:uint=14;

        internal var _showLastLineItem:Boolean;

        internal var widthOffset:uint;
    }
}
