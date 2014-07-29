package net.wg.gui.lobby.profile.pages
{
    import net.wg.infrastructure.base.meta.impl.ProfileAchievementSectionMeta;
    import net.wg.infrastructure.base.meta.IProfileAchievementSectionMeta;
    import net.wg.gui.components.controls.achievements.AchievementEvent;
    import net.wg.gui.lobby.profile.ProfileInvalidationTypes;
    
    public class ProfileAchievementsSection extends ProfileAchievementSectionMeta implements IProfileAchievementSectionMeta
    {
        
        public function ProfileAchievementsSection()
        {
            super();
        }
        
        private var isRareAchievementRequested:Boolean;
        
        override protected function configUI() : void
        {
            if(_baseDisposed)
            {
                return;
            }
            super.configUI();
            addEventListener(AchievementEvent.REQUEST_RARE_ACHIEVEMENT,this.requestRareAchievementHandler,false,0,true);
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(ProfileInvalidationTypes.ACHIEVEMENT_REQUEST_INVALID)) && (this.isRareAchievementRequested))
            {
                this.isRareAchievementRequested = false;
                requestDataS({});
            }
        }
        
        private function requestRareAchievementHandler(param1:AchievementEvent) : void
        {
            this.isRareAchievementRequested = true;
            invalidate(ProfileInvalidationTypes.ACHIEVEMENT_REQUEST_INVALID);
        }
        
        override protected function onDispose() : void
        {
            removeEventListener(AchievementEvent.REQUEST_RARE_ACHIEVEMENT,this.requestRareAchievementHandler);
            super.onDispose();
        }
    }
}
