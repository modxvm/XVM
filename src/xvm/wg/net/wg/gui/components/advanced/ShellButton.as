package net.wg.gui.components.advanced 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    
    public class ShellButton extends net.wg.gui.components.controls.SoundButton
    {
        public function ShellButton()
        {
            super();
            soundType = net.wg.data.constants.SoundTypes.FITTING_BUTTON;
            soundId = "tankShell";
            this.count = "";
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            _stateMap = {"up":["up"], "over":["over"], "down":["down"], "release":["release", "over"], "out":["out", "up"], "disabled":["disabled"], "selecting":["selecting", "over"], "kb_selecting":["kb_selecting", "up"], "kb_release":["kb_release", "out", "up"], "kb_down":["kb_down", "down"]};
            if (hitMc != null) 
                this.hitArea = hitMc;
            addEventListener(flash.events.MouseEvent.MOUSE_OVER, this.onOver);
            addEventListener(flash.events.MouseEvent.MOUSE_OUT, this.onOut);
            return;
        }

        public override function dispose():void
        {
            removeEventListener(flash.events.MouseEvent.MOUSE_OVER, this.onOver);
            removeEventListener(flash.events.MouseEvent.MOUSE_OUT, this.onOut);
            this.iconLoader.dispose();
            super.dispose();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (this.iconLoader) 
            {
                this.iconLoader.visible = !(this.shellIcon == "");
                if (this.shellIcon != "") 
                    this.iconLoader.source = this.shellIcon;
            }
            if (this.count_txt) 
            {
                this.count_txt.text = this._count;
                this.countBg.visible = !(this._count == "");
            }
            return;
        }

        public function get shellIcon():String
        {
            return this._shellIcon;
        }

        public function set shellIcon(arg1:String):void
        {
            this._shellIcon = arg1;
            invalidate();
            return;
        }

        public function get shellType():String
        {
            return this._shellType;
        }

        public function set shellType(arg1:String):void
        {
            this._shellType = arg1;
            return;
        }

        public function get inventoryCount():String
        {
            return this._inventoryCount;
        }

        public function set inventoryCount(arg1:String):void
        {
            this._inventoryCount = arg1;
            return;
        }

        public function get count():String
        {
            return this._count;
        }

        public function set count(arg1:String):void
        {
            this._count = arg1;
            return;
        }

        public function clear():void
        {
            this.id = null;
            this.count = "";
            this.shellIcon = "";
            label = "";
            return;
        }

        internal function onOver(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.showSpecial("hangarShell", null, this.id, this.inventoryCount, this.count);
            return;
        }

        public function onOut(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        public var id:String;

        internal var _shellType:String;

        internal var _shellIcon:String="";

        internal var _count:String;

        internal var _inventoryCount:String;

        public var count_txt:flash.text.TextField;

        public var countBg:flash.display.MovieClip;

        public var iconLoader:net.wg.gui.components.controls.UILoaderAlt;
    }
}
