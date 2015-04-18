/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.profile.UI
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.dossier.VehicleDossier;
    import com.xvm.types.stat.StatData;
    import com.xvm.types.veh.*;
    import com.xvm.utils.*;
    import flash.text.*;
    import net.wg.gui.lobby.profile.pages.technique.data.*;
    import net.wg.gui.lobby.profile.pages.technique.ProfileTechnique;
    import xvm.profile.components.*;

    public dynamic class UI_TechniqueRenderer extends TechniqueRenderer_UI
    {
        private var xteTF:TextField;

        public function UI_TechniqueRenderer()
        {
            super();
        }

        override protected function configUI():void
        {
            super.configUI();

            if (Config.networkServicesSettings.statAwards)
            {
                // xTE
                xteTF = new TextField();
                xteTF.name = "xteTF";
                xteTF.antiAliasType = AntiAliasType.ADVANCED;
                xteTF.multiline = true;
                xteTF.wordWrap = false;
                xteTF.selectable = false;
                xteTF.mouseEnabled = false;
                xteTF.y = winsTF.y;
                xteTF.width = 50;
                xteTF.height = 25;
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
            if (xteTF != null)
            {
                removeChild(xteTF);
                xteTF = null;
            }

            super.onDispose();
        }

        override protected function draw():void
        {
            if(_baseDisposed)
                return;

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

                    var xte:Number = data.xvm_xte;
                    var isStat:Boolean = false;
                    if (isNaN(data.xvm_xte))
                    {
                        var vdossier:VehicleDossier = Dossier.getVehicleDossier(data.id, tech.playerId);
                        //Logger.addObject(vdossier, 1, String(tech.playerId) + " " + data.id);
                        if (vdossier != null)
                            xte = vdossier.xte;
                        else
                        {
                            var stat:StatData = Stat.getUserDataById(tech.playerId);
                            if (stat != null && stat.v != null)
                            {
                                var svdata:Object = stat.v[data.id];
                                if (svdata != null)
                                {
                                    isStat = true;
                                    xte = svdata.xte;
                                }
                            }
                        }
                    }

                    if (isNaN(xte))
                    {
                        xteTF.htmlText = "";
                    }
                    else if (xte <= 0)
                    {
                        xteTF.htmlText = "<p align='center'><font face='$FieldFont' size='15' color='" +
                            XfwUtils.toHtmlColor(XfwConst.UICOLOR_DISABLED) + "'>" + "--" +
                            "</font></p>";
                    }
                    else
                    {
                        var value:String = xte == 100 ? "XX" : (xte < 10 ? "0" : "") + xte;
                        if (isStat)
                            value = "<font alpha='#60'>(</font>" + value + "<font alpha='#60'>)</font>";
                        xteTF.htmlText = Sprintf.format("<p align='center'><font face='$FieldFont' size='15' color='%s'>%s</font></p>",
                            MacrosUtils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, xte), value);
                    }
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // PRIVATE PROPERTIES

        private function get page():ProfileTechnique
        {
            try
            {
                return parent.parent.parent.parent as ProfileTechnique;
            }
            catch (ex:Error)
            {
            }
            return null;
        }

        private function get tech():Technique
        {
            return page ? page.getChildByName("xvm_extension") as Technique : null;
        }
    }
}
