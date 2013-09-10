package net.wg.gui.components.controls.achievements 
{
    import flash.text.*;
    import scaleform.clik.core.*;
    
    public class AchievementProgressComponent extends scaleform.clik.core.UIComponent
    {
        public function AchievementProgressComponent()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.progressBar.setActualSize(_originalWidth, this.progressBar.height);
            return;
        }

        public var progressBar:net.wg.gui.components.controls.achievements.AchievementProgressBar;

        public var progressTextField:flash.text.TextField;
    }
}
