package net.wg.gui.battle.views.consumablesPanel.constants
{
    import flash.geom.ColorTransform;

    public class COLOR_STATES extends Object
    {

        public static const DARK_COLOR_TRANSFORM:ColorTransform = new ColorTransform(0.35,0.35,0.35,1,0,0,0,0);

        public static const NORMAL_COLOR_TRANSFORM:ColorTransform = new ColorTransform(1,1,1,1,0,0,0,0);

        public static const DISABLED_COLOR_TRANSFORM:ColorTransform = new ColorTransform(0.35,0.35,0.35,1,0,0,0,0.52);

        public function COLOR_STATES()
        {
            super();
        }
    }
}
