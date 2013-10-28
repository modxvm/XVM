package xvm.profile.components
{
    import com.xvm.*;
    import com.xvm.events.*;
    import com.xvm.types.veh.*;
    import com.xvm.utils.*;
    import com.xvm.types.stat.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.profile.pages.technique.*;

    public class ProfileTechniqueRenderer
    {
        private var proxy:TechniqueRenderer;

        private var effField:TextField;
        private var playerName:String;

        public function ProfileTechniqueRenderer(proxy:TechniqueRenderer)
        {
            this.proxy = proxy;
        }

        public function draw():void
        {
            if (!proxy || !proxy.data)
                return;

            var isSummary:Boolean = proxy.data.id == 0;

            proxy.levelMC.visible = !isSummary;
            proxy.vehicleTF.x = isSummary ? 121 : 166;
            proxy.vehicleTF.width = 200;

            proxy.vehicleTF.textColor = Defines.UICOLOR_DEFAULT;
            if (!isSummary)
            {
                var vdata:VehicleData = VehicleInfo.get(proxy.data.id);
                if (vdata != null && vdata.premium == 1)
                    proxy.vehicleTF.textColor = Defines.UICOLOR_GOLD;
            }

            if (Config.config.rating.showPlayersStatistics && Config.config.rating.enableUserInfoStatistics)
            {
                proxy.winsTF.htmlText = "<font color='" +
                    MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, proxy.data.winsEfficiency) + "'>" +
                    proxy.data.winsEfficiencyStr +
                    "</font>";
            }
        }

        // PRIVATE
    }
}
