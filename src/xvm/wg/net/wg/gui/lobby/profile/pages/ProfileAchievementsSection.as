package net.wg.gui.lobby.profile.pages 
{
    import net.wg.gui.components.controls.achievements.*;
    import net.wg.gui.lobby.profile.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    
    public class ProfileAchievementsSection extends net.wg.infrastructure.base.meta.impl.ProfileAchievementSectionMeta implements net.wg.infrastructure.base.meta.IProfileAchievementSectionMeta
    {
        public function ProfileAchievementsSection()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            addEventListener(net.wg.gui.components.controls.achievements.AchievementEvent.REQUEST_RARE_ACHIEVEMENT, this.requestRareAchievementHandler, false, 0, true);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(net.wg.gui.lobby.profile.ProfileInvalidationTypes.ACHIEVEMENT_REQUEST_INVALID) && this.isRareAchievementRequested) 
            {
                this.isRareAchievementRequested = false;
                requestDataS(currentDossier ? currentDossier.id : null);
            }
            if (isInvalid(net.wg.gui.lobby.profile.ProfileInvalidationTypes.ACHIEVEMENT_RESPONSE_INVALID) && currentDossier) 
                updateByDossier(currentDossier);
            return;
        }

        public override function as_update(arg1:Object):void
        {
            super.as_update(arg1);
            invalidate(net.wg.gui.lobby.profile.ProfileInvalidationTypes.ACHIEVEMENT_RESPONSE_INVALID);
            return;
        }

        internal function requestRareAchievementHandler(arg1:net.wg.gui.components.controls.achievements.AchievementEvent):void
        {
            this.isRareAchievementRequested = true;
            invalidate(net.wg.gui.lobby.profile.ProfileInvalidationTypes.ACHIEVEMENT_REQUEST_INVALID);
            return;
        }

        protected override function onDispose():void
        {
            removeEventListener(net.wg.gui.components.controls.achievements.AchievementEvent.REQUEST_RARE_ACHIEVEMENT, this.requestRareAchievementHandler);
            super.onDispose();
            return;
        }

        internal var isRareAchievementRequested:Boolean;
    }
}
