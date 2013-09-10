package net.wg.gui.lobby.profile.pages.technique 
{
    import net.wg.data.gui_items.dossier.*;
    
    public class ProfileTechniqueWindow extends net.wg.gui.lobby.profile.pages.technique.ProfileTechnique
    {
        public function ProfileTechniqueWindow()
        {
            super();
            return;
        }

        protected override function updateByDossier(arg1:net.wg.data.gui_items.dossier.AccountDossier):void
        {
            super.updateByDossier(arg1);
            listComponent.dataProvider = arg1.getAllVehiclesList();
            return;
        }
    }
}
