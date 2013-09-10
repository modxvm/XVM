package net.wg.gui.components.controls.achievements 
{
    public class RedCounter extends net.wg.gui.components.controls.achievements.CounterComponent
    {
        public function RedCounter()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            minBgWindowWidth = 14;
            tooltip = TOOLTIPS.ACHIEVEMENT_ATTR_COUNTER;
            return;
        }
    }
}
