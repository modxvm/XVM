package xvm.profile.components
{
    import com.xvm.*;
    import net.wg.gui.lobby.profile.pages.technique.*;

    public class TechniqueWindow extends Technique
    {
        public function TechniqueWindow(window:ProfileTechniqueWindow, playerName:String):void
        {
            super(window, playerName);
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
