package net.wg.gui.components.controls.achievements 
{
    public class SmallCounter extends net.wg.gui.components.controls.achievements.CounterComponent
    {
        public function SmallCounter()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            minBgWindowWidth = 12;
            tooltip = TOOLTIPS.ACHIEVEMENT_ATTR_SMALL;
            return;
        }
    }
}
