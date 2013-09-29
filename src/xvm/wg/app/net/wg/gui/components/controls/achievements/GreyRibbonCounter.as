package net.wg.gui.components.controls.achievements 
{
    public class GreyRibbonCounter extends net.wg.gui.components.controls.achievements.CounterComponent
    {
        public function GreyRibbonCounter()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            minBgWindowWidth = 13;
            super.configUI();
            tooltip = TOOLTIPS.ACHIEVEMENT_ATTR_VEHICLERECORD;
            return;
        }

        public override function receiveBottomPadding():Number
        {
            return -5;
        }
    }
}
