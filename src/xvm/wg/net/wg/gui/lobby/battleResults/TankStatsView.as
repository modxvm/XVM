package net.wg.gui.lobby.battleResults 
{
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.core.*;
    
    public class TankStatsView extends scaleform.clik.core.UIComponent
    {
        public function TankStatsView()
        {
            super();
            return;
        }

        public override function dispose():void
        {
            this.tankIcon.dispose();
            this.bgOverlay.dispose();
            this.areaIcon.dispose();
            return;
        }

        public var playerNameLbl:flash.text.TextField;

        public var arenaCreateDateLbl:flash.text.TextField;

        public var vehicleStateLbl:flash.text.TextField;

        public var tankNameLbl:flash.text.TextField;

        public var tankIcon:net.wg.gui.components.controls.UILoaderAlt;

        public var bgOverlay:net.wg.gui.components.controls.UILoaderAlt;

        public var areaIcon:net.wg.gui.components.controls.UILoaderAlt;
    }
}
