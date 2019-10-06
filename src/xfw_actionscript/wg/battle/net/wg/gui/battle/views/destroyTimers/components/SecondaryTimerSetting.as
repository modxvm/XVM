package net.wg.gui.battle.views.destroyTimers.components
{
    public class SecondaryTimerSetting extends Object
    {

        public var text:String = "";

        public var iconName:String = "";

        public var state:String = "";

        public var noiseVisible:Boolean = false;

        public var pulseVisible:Boolean = false;

        public function SecondaryTimerSetting(param1:String, param2:String, param3:String, param4:Boolean, param5:Boolean)
        {
            super();
            this.text = param1;
            this.iconName = param2;
            this.state = param3;
            this.noiseVisible = param4;
            this.pulseVisible = param5;
        }
    }
}
