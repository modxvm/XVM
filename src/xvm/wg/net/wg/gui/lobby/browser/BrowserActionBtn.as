package net.wg.gui.lobby.browser 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    
    public class BrowserActionBtn extends scaleform.clik.core.UIComponent
    {
        public function BrowserActionBtn()
        {
            super();
            this.icon.mouseEnabled = false;
            this.icon.mouseChildren = false;
            this.stopIcon.mouseEnabled = false;
            this.stopIcon.mouseChildren = false;
            this.action = "reload";
            return;
        }

        public function get action():String
        {
            return this._action;
        }

        public function set action(arg1:String):void
        {
            this._action = arg1;
            gotoAndStop(this.action);
            this.icon.mouseEnabled = false;
            this.icon.mouseChildren = false;
            if (this.action != ACTION_RELOAD) 
            {
                if (this._isMouseOver) 
                {
                    this.showStopIcon(true);
                }
            }
            else 
            {
                this.showStopIcon(false);
            }
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.btn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onBtnClick);
            this.btn.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.onBtnRollOver);
            this.btn.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.onBtnRollOut);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.showStopIcon(false);
            this.btn.label = "";
            this.btn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onBtnClick);
            this.btn.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.onBtnRollOver);
            this.btn.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.onBtnRollOut);
            return;
        }

        internal function onBtnClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            dispatchEvent(new net.wg.gui.lobby.browser.BrowserEvent(this.action != ACTION_LOADING ? net.wg.gui.lobby.browser.BrowserEvent.ACTION_RELOAD : net.wg.gui.lobby.browser.BrowserEvent.ACTION_LOADING));
            return;
        }

        internal function onBtnRollOver(arg1:flash.events.MouseEvent):void
        {
            this.showStopIcon(this.action == ACTION_LOADING);
            this._isMouseOver = true;
            return;
        }

        internal function onBtnRollOut(arg1:flash.events.MouseEvent):void
        {
            this.showStopIcon(false);
            this._isMouseOver = false;
            return;
        }

        internal function showStopIcon(arg1:Boolean):void
        {
            this.stopIcon.visible = arg1;
            this.icon.visible = !arg1;
            return;
        }

        public static const ACTION_LOADING:String="loading";

        public static const ACTION_RELOAD:String="reload";

        public var btn:net.wg.gui.components.controls.SoundButton;

        public var icon:flash.display.MovieClip;

        public var stopIcon:flash.display.MovieClip;

        internal var _isMouseOver:Boolean=false;

        internal var _action:String="loading";
    }
}
