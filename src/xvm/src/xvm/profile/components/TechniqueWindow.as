package xvm.profile.components
{
    import com.xfw.*;
    import com.xvm.*;
    import net.wg.gui.lobby.profile.pages.technique.*;

    public class TechniqueWindow extends Technique
    {
        public function TechniqueWindow(window:ProfileTechniqueWindow, playerName:String, playerId:int):void
        {
            super(window, playerName);

            _playerId = playerId;
            Dossier.loadAccountDossier(null, null, PROFILE.PROFILE_DROPDOWN_LABELS_ALL, playerId);
        }

        override protected function createFilters():void
        {
            super.createFilters();

            filter.visible = false;
            filter.x = 680;
            filter.y = -47;
        }
    }
}
