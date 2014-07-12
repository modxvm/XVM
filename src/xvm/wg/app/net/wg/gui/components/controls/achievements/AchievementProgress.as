package net.wg.gui.components.controls.achievements
{
    import flash.events.Event;
    import net.wg.gui.lobby.profile.data.ProfileAchievementVO;
    
    public class AchievementProgress extends AchievementCounter
    {
        
        public function AchievementProgress() {
            super();
        }
        
        private static var PROGRESS_BAR_INVALID:String = "pbInv";
        
        private static function getValidTextValue(param1:Number) : String {
            var _loc2_:Number = param1 / 1000000;
            if(_loc2_ >= 1)
            {
                return getIntegral(Math.floor(_loc2_)) + "M";
            }
            _loc2_ = param1 / 1000;
            if(_loc2_ >= 1)
            {
                return getIntegral(Math.floor(_loc2_)) + "K";
            }
            return param1.toString();
        }
        
        private static function getIntegral(param1:Number) : String {
            var _loc2_:String = null;
            if(App.utils)
            {
                _loc2_ = App.utils.locale.integer(param1);
            }
            else
            {
                _loc2_ = param1.toString();
            }
            return _loc2_;
        }
        
        private var progress:AchievementProgressComponent;
        
        private var progressBarNeedToShow:Boolean;
        
        override protected function draw() : void {
            if(isInvalid(PROGRESS_BAR_INVALID))
            {
                if(this.progressBarNeedToShow)
                {
                    if(!this.progress)
                    {
                        this.progress = AchievementProgressComponent(App.utils.classFactory.getObject("AchievementProgressComponent_UI"));
                        this.progress.x = loader.x + (loader.originalWidth - this.progress.width) >> 1;
                        this.progress.y = loader.y + loader.originalHeight;
                        addChild(this.progress);
                    }
                }
                else if(this.progress)
                {
                    this.progress.dispose();
                    this.progress.parent.removeChild(this.progress);
                    this.progress = null;
                }
                
                this.applyData();
            }
            super.draw();
        }
        
        override public function validateNow(param1:Event = null) : void {
            super.validateNow(param1);
        }
        
        override protected function applyData() : void {
            var _loc2_:* = NaN;
            var _loc3_:* = NaN;
            super.applyData();
            var _loc1_:ProfileAchievementVO = data as ProfileAchievementVO;
            if(_loc1_)
            {
                _loc2_ = _loc1_.lvlUpTotalValue;
                _loc3_ = _loc2_ - _loc1_.lvlUpValue;
                if(this.progress)
                {
                    this.progress.progressBar.minimum = 0;
                    this.progress.progressBar.maximum = _loc2_;
                    this.progress.progressBar.value = _loc3_;
                    this.progress.progressTextField.text = getValidTextValue(_loc3_) + " / " + getValidTextValue(_loc2_);
                }
            }
        }
        
        protected function showProgress() : void {
            this.setProgressBarVisible(true);
        }
        
        protected function hideProgress() : void {
            this.setProgressBarVisible(false);
        }
        
        private function setProgressBarVisible(param1:Boolean) : void {
            if(this.progressBarNeedToShow != param1)
            {
                this.progressBarNeedToShow = param1;
                invalidate(PROGRESS_BAR_INVALID);
            }
        }
    }
}
