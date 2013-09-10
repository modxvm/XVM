package net.wg.gui.lobby.profile.pages.summary 
{
    import net.wg.data.gui_items.dossier.*;
    
    public class ProfileSummaryPage extends net.wg.gui.lobby.profile.pages.summary.ProfileSummary
    {
        public function ProfileSummaryPage()
        {
            super();
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            layoutManager.registerComponents(this.nearestAwards);
            return;
        }

        public override function as_setInitData(arg1:Object):void
        {
            this.applyInitData(new net.wg.gui.lobby.profile.pages.summary.SummaryPageInitVO(arg1));
            return;
        }

        protected override function applyInitData(arg1:net.wg.gui.lobby.profile.pages.summary.SummaryInitVO):void
        {
            super.applyInitData(arg1);
            var loc1:*=net.wg.gui.lobby.profile.pages.summary.SummaryPageInitVO(arg1);
            this.nearestAwards.label = loc1.nextAwardsLabel;
            this.nearestAwards.errorText = loc1.nextAwardsErrorText;
            return;
        }

        protected override function updateByDossier(arg1:net.wg.data.gui_items.dossier.AccountDossier):void
        {
            super.updateByDossier(arg1);
            this.nearestAwards.dataProvider = arg1.getNearestAchievements();
            return;
        }

        public var nearestAwards:net.wg.gui.lobby.profile.pages.summary.AwardsListComponent;
    }
}
