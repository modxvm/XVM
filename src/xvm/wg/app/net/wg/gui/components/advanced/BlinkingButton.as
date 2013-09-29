package net.wg.gui.components.advanced 
{
    import __AS3__.vec.*;
    import net.wg.gui.components.controls.*;
    
    public class BlinkingButton extends net.wg.gui.components.controls.IconButton
    {
        public function BlinkingButton()
        {
            super();
            return;
        }

        public function get blinking():Boolean
        {
            return this._blinking;
        }

        protected override function configUI():void
        {
            super.configUI();
            setState("up");
            return;
        }

        protected override function draw():void
        {
            super.draw();
            return;
        }

        public function set blinking(arg1:Boolean):void
        {
            if (this._blinking == arg1) 
            {
                return;
            }
            this._blinking = arg1;
            setState(state);
            return;
        }

        protected override function getStatePrefixes():__AS3__.vec.Vector.<String>
        {
            return this._blinking ? Vector.<String>(["blinking_", ""]) : Vector.<String>([""]);
        }

        internal var _blinking:Boolean;
    }
}
