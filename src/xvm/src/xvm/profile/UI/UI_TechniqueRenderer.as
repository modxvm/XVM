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
        private var xteTF:TextField;

        public function UI_TechniqueRenderer()
        {
            super();

            if (Config.networkServicesSettings.statAwards)
            {
                // xTE
                xteTF = WGUtils.cloneTextField(winsTF);
                xteTF.mouseEnabled = false;
                xteTF.name = "xteTF";
                xteTF.y = winsTF.y;
                xteTF.width = 50;
                addChild(xteTF);

                battlesTF.x -= 0;
                winsTF.x -= 15;
                winsTF.width += 10;
                avgExpTF.x -= 20;
                xteTF.x = masteryIcon.x - 55;
                masteryIcon.x += 5;
                //battlesTF.border = true; battlesTF.borderColor = 0x00FFFF;
                //winsTF.border = true; winsTF.borderColor = 0xFF00FF;
                //avgExpTF.border = true; avgExpTF.borderColor = 0xFFFF00;
                //xteTF.border = true; xteTF.borderColor = 0xFFFFFF;
            }
        }

        override protected function onDispose():void
        {
            super.onDispose();
            xteTF = null;
        }

        override protected function draw():void
        {
            super.draw();

            try
            {
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

                if (xteTF != null)
                {
                    winsTF.htmlText = "<p align='center'><font color='" +
                        MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WINRATE, data.winsEfficiency) + "'>" +
                        data.winsEfficiencyStr +
                        "</font></p>";

                    if (isNaN(data.xvm_xte))
                    {
                        xteTF.htmlText = "";
                    }
                    if (data.xvm_xte <= 0)
                    {
                        xteTF.htmlText = "<font face='$FieldFont' size='15' color='" + XfwUtils.toHtmlColor(XfwConst.UICOLOR_DISABLED) + "'>" + "--" + "</font>";
                    }
                    else
                    {
                        xteTF.htmlText = "<p align='center'><font face='$FieldFont' size='15' color='" +
                            MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, data.xvm_xte) + "'>" +
                            (data.xvm_xte == 100 ? "XX" : (data.xvm_xte < 10 ? "0" : "") + data.xvm_xte) +
                            "</font></p>";
                    }
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
