package net.wg.gui.components.questProgress.components
{
    import net.wg.gui.components.common.FrameStateCmpnt;
    import flash.display.BlendMode;

    public class QPStatusBg extends FrameStateCmpnt
    {

        public function QPStatusBg()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.blendMode = BlendMode.SCREEN;
        }
    }
}
