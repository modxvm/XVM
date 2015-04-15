/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.profile.UI
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.veh.*;
    import com.xvm.utils.*;
    import flash.text.*;
    import net.wg.gui.lobby.profile.pages.technique.data.*;

    public dynamic class UI_TechniqueRenderer extends TechniqueRenderer_UI
    {
        private var xeffTF:TextField;

        public function UI_TechniqueRenderer()
        {
            super();
        }

        override protected function configUI():void
        {
            super.configUI();

            xeffTF = WGUtils.cloneTextField(winsTF);
            xeffTF.x = winsTF.x + 80;
            xeffTF.y = winsTF.y;
            addChild(xeffTF);
        }

        override protected function draw():void
        {
            super.draw();

            var data:TechniqueListVehicleVO = TechniqueListVehicleVO(this.data);
            if (!data)
                return;

            var isSummary:Boolean = data.id == 0;

            levelMC.visible = !isSummary;
            vehicleTF.x = isSummary ? 121 : 166;
            vehicleTF.width = 200;

            vehicleTF.textColor = XfwConst.UICOLOR_VALUE;
            if (!isSummary)
            {
                var vdata:VehicleData = VehicleInfo.get(data.id);
                if (vdata != null && vdata.premium == 1)
                    vehicleTF.textColor = XfwConst.UICOLOR_GOLD;
            }

            if (Config.networkServicesSettings.statAwards)
            {
                winsTF.htmlText = "<font color='" +
                    MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WINRATE, data.winsEfficiency) + "'>" +
                    data.winsEfficiencyStr +
                    "</font>";

                if (isNaN(data.xvm_xe) || data.xvm_xe <= 0)
                {
                    xeffTF.htmlText = "<font face='$FieldFont' size='15' color='" + XfwUtils.toHtmlColor(XfwConst.UICOLOR_DISABLED) + "'>" + "--" + "</font>";
                }
                else
                {
                    xeffTF.htmlText = "<font face='$FieldFont' size='15' color='" +
                        MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, data.xvm_xe) + "'>" +
                        (data.xvm_xe == 100 ? "XX" : (data.xvm_xe < 10 ? "0" : "") + data.xvm_xe) +
                        "</font>";
                }
            }
        }
    }
}
