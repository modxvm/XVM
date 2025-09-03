/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ui.profile
{
    import com.xfw.*;
    import com.xfw.XfwAccess;
    import com.xfw.XfwUtils;
    import com.xvm.*;
    import com.xvm.lobby.ui.profile.components.*;
    import com.xvm.types.dossier.*;
    import com.xvm.vo.*;
    import flash.text.*;
    import net.wg.gui.lobby.profile.pages.technique.*;
    import net.wg.gui.lobby.profile.pages.technique.data.*;
    import scaleform.gfx.*;

    public dynamic class UI_TechniqueRenderer extends TechniqueRenderer_UI
    {
        private var xteTF:TextField;

        public function UI_TechniqueRenderer()
        {
            super();

            xteTF = null;
        }

        override protected function configUI():void
        {
            super.configUI();

            if (Config.networkServicesSettings.statAwards)
            {
                if (Config.config.userInfo.showXTEColumn)
                {
                    // xTE
                    xteTF = new TextField();
                    xteTF.mouseEnabled = false;
                    xteTF.selectable = false;
                    TextFieldEx.setNoTranslate(xteTF, true);
                    xteTF.antiAliasType = AntiAliasType.ADVANCED;
                    xteTF.name = "xteTF";
                    xteTF.multiline = true;
                    xteTF.wordWrap = false;
                    xteTF.y = winsTF.y;
                    xteTF.width = 50;
                    xteTF.height = 25;
                    addChild(xteTF);

                    battlesTF.x -= 5;
                    winsTF.x -= 15;
                    winsTF.width += 10;
                    avgExpTF.x -= 30;
                    xteTF.x = masteryIcon.x - 55;
                    masteryIcon.x += 5;
                    //battlesTF.border = true; battlesTF.borderColor = 0x00FFFF;
                    //winsTF.border = true; winsTF.borderColor = 0xFF00FF;
                    //avgExpTF.border = true; avgExpTF.borderColor = 0xFFFF00;
                    //xteTF.border = true; xteTF.borderColor = 0xFFFFFF;
                }
            }
        }

        override protected function onDispose():void
        {
            if (xteTF)
            {
                removeChild(xteTF);
                xteTF = null;
            }

            super.onDispose();
        }

        override protected function draw():void
        {
            if (_baseDisposed)
                return;

            super.draw();

            try
            {
                var data:TechniqueListVehicleVO = TechniqueListVehicleVO(this.data);
                if (!data)
                    return;

                vehicleTF.width = 200;

                vehicleTF.textColor = XfwConst.UICOLOR_VALUE;

                var vdata:VOVehicleData = VehicleInfo.get(data.id);
                if (vdata)
                {
                    if (vdata.premium == 1)
                    {
                        vehicleTF.textColor = XfwConst.UICOLOR_GOLD;
                    }
                    else if (vdata.special == 1)
                    {
                        vehicleTF.textColor = XfwConst.UICOLOR_SPECIAL;
                    }
                }

                if (Config.networkServicesSettings.statAwards)
                {
                    winsTF.htmlText = "<p align='center'><font color='" +
                        MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_WINRATE, data.winsEfficiency, NaN) + "'>" +
                        data.winsEfficiencyStr +
                        "</font></p>";
                }

                if (xteTF)
                {
                    var xte:Number = XfwAccess.getPrivateField(data, "xvm_xte");
                    //Logger.add("id=" + data.id + " xte=" + data.xvm_xte + " flag=" + data.xvm_xte_flag);
                    if (xte < 0 || (XfwAccess.getPrivateField(data, "xvm_xte_flag") & 0x01) != 0)
                    {
                        var vdossier:VehicleDossier = Dossier.getVehicleDossier(data.id, tech.accountDBID);
                        if (vdossier)
                        {
                            xte = vdossier.xte;
                            XfwAccess.setPrivateField(data, "xvm_xte", vdossier.xte);
                            XfwAccess.setPrivateField(data, "xvm_xte_flag", XfwAccess.getPrivateField(data, "xvm_xte_flag") & ~0x01);
                        }
                    }

                    if (xte < 0)
                    {
                        xteTF.htmlText = "";
                    }
                    else if (xte == 0)
                    {
                        xteTF.htmlText = "<p align='center'><font face='$FieldFont' size='15' color='" +
                            XfwUtils.toHtmlColor(XfwConst.UICOLOR_DISABLED) + "'>" + "--" +
                            "</font></p>";
                    }
                    else
                    {
                        var value:String = xte == 100 ? "XX" : (xte < 10 ? "0" : "") + xte;
                        if ((XfwAccess.getPrivateField(data, "xvm_xte_flag") & 0x01) != 0)
                            value = "<font alpha='#50'>(</font>" + value + "<font alpha='#50'>)</font>";
                        xteTF.htmlText = Sprintf.format("<p align='center'><font face='$FieldFont' size='15' color='%s'>%s</font></p>",
                            MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_X, xte, NaN), value);
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
