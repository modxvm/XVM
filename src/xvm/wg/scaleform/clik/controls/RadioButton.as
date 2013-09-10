package scaleform.clik.controls 
{
    public class RadioButton extends scaleform.clik.controls.Button
    {
        public function RadioButton()
        {
            super();
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this.toggle = true;
            allowDeselect = false;
            if (_group == null) 
            {
                this.groupName = DEFAULT_GROUPNAME;
            }
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

        public override function get groupName():String
        {
            return super.groupName;
        }

        public override function set groupName(arg1:String):void
        {
            super.groupName = arg1;
            return;
        }

        public override function toString():String
        {
            return "[CLIK RadioButton " + name + "]";
        }

        public static const DEFAULT_GROUPNAME:String="default";
    }
}
