package scaleform.clik.controls 
{
    public class CheckBox extends scaleform.clik.controls.Button
    {
        public function CheckBox()
        {
            super();
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            _toggle = true;
            return;
        }

        public override function get autoRepeat():Boolean
        {
            return false;
        }

        public override function set autoRepeat(arg1:Boolean):void
        {
            return;
        }

        public override function get toggle():Boolean
        {
            return true;
        }

        public override function set toggle(arg1:Boolean):void
        {
            return;
        }

        public override function toString():String
        {
            return "[CLIK CheckBox " + name + "]";
        }
    }
}
