package xvm.profile.components
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.veh.*;
    import com.xvm.utils.*;
    import flash.text.*;
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

            proxy.vehicleTF.textColor = XfwConst.UICOLOR_VALUE;
            if (!isSummary)
            {
                var vdata:VehicleData = VehicleInfo.get(proxy.data.id);
                if (vdata != null && vdata.premium == 1)
                    proxy.vehicleTF.textColor = XfwConst.UICOLOR_GOLD;
            }

            if (Config.networkServicesSettings.statAwards)
            {
                proxy.winsTF.htmlText = "<font color='" +
                    MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WINRATE, proxy.data.winsEfficiency) + "'>" +
                    proxy.data.winsEfficiencyStr +
                    "</font>";
            }
        }

        // PRIVATE
    }
}
