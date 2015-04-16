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

    public dynamic class UI_ProfileSortingButton extends ProfileSortingButton_UI
    {
        #TODO: use or remove

        private var xeffTF:TextField;

        public function UI_ProfileSortingButton()
        {
            Logger.add("UI_ProfileSortingButton");
            super();
        }

        override protected function configUI():void
        {
            super.configUI();

            /*if (Config.networkServicesSettings.statAwards)
            {
                xeffTF = WGUtils.cloneTextField(winsTF);
                xeffTF.x = winsTF.x + 180;
                xeffTF.y = winsTF.y;
                addChild(xeffTF);
            }*/
        }

        override public function set data(value:Object):void
        {
            super.data = value;
            Logger.addObject(value);
        }

        /*override protected function onDispose():void
        {
            super.onDispose();
            xeffTF = null;
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

            if (xeffTF != null)
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
        }*/
    }
}
