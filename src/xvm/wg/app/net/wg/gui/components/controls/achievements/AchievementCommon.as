package net.wg.gui.components.controls.achievements
{
    import net.wg.data.VO.AchievementProgressVO;
    import net.wg.data.VO.AchievementItemVO;
    import net.wg.gui.events.UILoaderEvent;
    
    public class AchievementCommon extends AchievementProgress
    {
        
        public function AchievementCommon()
        {
            super();
        }
        
        override protected function applyData() : void
        {
            var _loc1_:AchievementProgressVO = null;
            if(data != null)
            {
                _loc1_ = data as AchievementProgressVO;
                if(_loc1_)
                {
                    progressInfo = _loc1_.progressInfo;
                }
                loader.alpha = AchievementItemVO(data).iconAlpha;
            }
            super.applyData();
        }
        
        override protected function tryToLoadRareAchievement() : void
        {
            var _loc1_:* = getDataOwnValue(data,"rareIconId",null);
            if(_loc1_)
            {
                loader.source = "img://" + _loc1_;
                loader.addEventListener(UILoaderEvent.COMPLETE,this.onComplete);
            }
            else
            {
                loader.startLoadAlt();
                dispatchEvent(new AchievementEvent(AchievementEvent.REQUEST_RARE_ACHIEVEMENT,true));
            }
        }
        
        override protected function onComplete(param1:UILoaderEvent) : void
        {
            super.onComplete(param1);
        }
        
        override protected function onDispose() : void
        {
            if((counter) && (contains(counter)))
            {
                removeChild(counter);
            }
            super.onDispose();
        }
    }
}
