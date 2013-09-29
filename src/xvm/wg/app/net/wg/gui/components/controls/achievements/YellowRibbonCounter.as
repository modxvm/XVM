package net.wg.gui.components.controls.achievements 
{
    public class YellowRibbonCounter extends net.wg.gui.components.controls.achievements.CounterComponent
    {
        public function YellowRibbonCounter()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            minBgWindowWidth = 13;
            tooltip = TOOLTIPS.ACHIEVEMENT_ATTR_RECORD;
            return;
        }

        public override function receiveBottomPadding():Number
        {
            return -5;
        }
    }
}
