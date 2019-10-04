package net.wg.gui.components.controls.achievements
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;

    public class AchievementProgressComponent extends UIComponent
    {

        public var progressBar:AchievementProgressBar;

        public var progressTextField:TextField;

        public function AchievementProgressComponent()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.progressBar.setActualSize(_originalWidth,this.progressBar.height);
        }
    }
}
