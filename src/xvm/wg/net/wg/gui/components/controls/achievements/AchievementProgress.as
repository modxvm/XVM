package net.wg.gui.components.controls.achievements 
{
    import flash.events.*;
    import net.wg.gui.lobby.profile.data.*;
    
    public class AchievementProgress extends net.wg.gui.components.controls.achievements.AchievementCounter
    {
        public function AchievementProgress()
        {
            super();
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(PROGRESS_BAR_INVALID)) 
            {
                if (this.progressBarNeedToShow) 
                    if (!this.progress) 
                    {
                        this.progress = net.wg.gui.components.controls.achievements.AchievementProgressComponent(App.utils.classFactory.getObject("AchievementProgressComponent_UI"));
                        this.progress.x = loader.x + (loader.originalWidth - this.progress.width) >> 1;
                        this.progress.y = loader.y + loader.originalHeight;
                        addChild(this.progress);
                    }
                else if (this.progress) 
                {
                    this.progress.dispose();
                    this.progress.parent.removeChild(this.progress);
                    this.progress = null;
                }
                this.applyData();
            }
            super.draw();
            return;
        }

        public override function validateNow(arg1:flash.events.Event=null):void
        {
            super.validateNow(arg1);
            return;
        }

        protected override function applyData():void
        {
            var loc2:*=NaN;
            var loc3:*=NaN;
            super.applyData();
            var loc1:*=data as net.wg.gui.lobby.profile.data.ProfileAchievementVO;
            if (loc1) 
            {
                loc2 = loc1.lvlUpTotalValue;
                loc3 = loc2 - loc1.lvlUpValue;
                if (this.progress) 
                {
                    this.progress.progressBar.minimum = 0;
                    this.progress.progressBar.maximum = loc2;
                    this.progress.progressBar.value = loc3;
                    this.progress.progressTextField.text = getValidTextValue(loc3) + " / " + getValidTextValue(loc2);
                }
            }
            return;
        }

        protected function showProgress():void
        {
            this.setProgressBarVisible(true);
            return;
        }

        protected function hideProgress():void
        {
            this.setProgressBarVisible(false);
            return;
        }

        internal function setProgressBarVisible(arg1:Boolean):void
        {
            if (this.progressBarNeedToShow != arg1) 
            {
                this.progressBarNeedToShow = arg1;
                invalidate(PROGRESS_BAR_INVALID);
            }
            return;
        }

        internal static function getValidTextValue(arg1:Number):String
        {
            var loc1:*=arg1 / 1000000;
            if (loc1 >= 1) 
                return getIntegral(Math.floor(loc1)) + "M";
            loc1 = arg1 / 1000;
            if (loc1 >= 1) 
                return getIntegral(Math.floor(loc1)) + "K";
            return arg1.toString();
        }

        internal static function getIntegral(arg1:Number):String
        {
            var loc1:*=null;
            if (App.utils) 
                loc1 = App.utils.locale.integer(arg1);
            else 
                loc1 = arg1.toString();
            return loc1;
        }

        internal static const PROGRESS_BAR_INVALID:String="pbInv";

        internal var progress:net.wg.gui.components.controls.achievements.AchievementProgressComponent;

        internal var progressBarNeedToShow:Boolean;
    }
}
