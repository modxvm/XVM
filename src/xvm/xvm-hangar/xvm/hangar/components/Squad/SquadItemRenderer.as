/**
 * @author Mr.A
 * @author Pavel Máca
 */
package xvm.hangar.components.Squad
{
    import com.xvm.*;
    import com.xvm.l10n.Locale;
    import com.xvm.utils.Utils;
    import com.xvm.vehinfo.*;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.prebattle.squad.SquadItemRenderer;

    public class SquadItemRenderer
    {
        private var proxy:net.wg.gui.prebattle.squad.SquadItemRenderer;

        public function SquadItemRenderer(proxy:net.wg.gui.prebattle.squad.SquadItemRenderer):void
        {
            this.proxy = proxy;
        }

        private var configUI:Boolean = false;

        public function setUIConfigured():void
        {
            configUI = true;
        }

        public function getToolTipData():String
        {
            // Prevent editing empty or "invite" fields
            if (!proxy.data || proxy.data.dummy)
                return null;

            if (!Config.config.squad.enabled)
                return null;

            var ti:Object = getTankInfo(proxy.model.vShortName);
            return (ti == null) ? null : Locale.get("Type") + ": " + Locale.get(ti.type) + "\n" + Locale.get("Battle tiers") + ": " + ti.battleTiers + "\n" + Locale.get("Nation") + ": " + Locale.get(ti.nation);
        }

        public function displayVehicleTier():void
        {
            // Erase field
            if (vehicleTierField != null)
                vehicleTierField.htmlText = "";

            // Prevent editing empty or "invite" fileds
            if (!proxy.data || proxy.data.dummy)
                return;

            // UI ready
            if (!configUI)
                return;

            if (!Config.config.squad.enabled)
                return;

            // Remove clan tag from player name
            if (Config.config.squad.showClan == false)
                proxy.data.fullName = proxy.data.userName;

            // Display vehicle tier
            var ti:Object = getTankInfo(proxy.data.vShortName);
            if (ti != null)
            {
                if (vehicleTierField == null)
                    createVehicleTierField();

                vehicleTierField.htmlText = "<p class='xvm_vehicleTier' align='right'>" +
                    Utils.fixImgTag(Config.config.squad.leftLvlBorder) +
                    ti.level +
                    Utils.fixImgTag(Config.config.squad.rightLvlBorder) + "</p>";
            }
        }

        // -- Private

        private var vehicleTierField:TextField = null;

        private function getTankInfo(localizedShortName:String):Object
        {
            if (localizedShortName == null || localizedShortName == "")
                return null;

            if (!VehicleInfoDataL10n.data.hasOwnProperty(localizedShortName))
                return null;

            var vname:String = VehicleInfoDataL10n.data[localizedShortName];
            var vi2:Object = VehicleInfoData2.data[vname];
            var vi1Key:String = VehicleInfo.getVehicleKey1(vi2.nation + "-" + vi2.name);
            var vi1:Object = VehicleInfoData.data[vi1Key];

            return (vi1 == null || vi2 == null) ? null : {
                level: Config.config.squad.romanNumbers ? Defines.ROMAN_LEVEL[vi2.level - 1] : String(vi2.level),
                nation: vi2.nation, type: vi2.type,
                battleTiers: vi1.tiers.join("-")
            };
        }

        private function createVehicleTierField():void
        {
            vehicleTierField = new TextField();
            vehicleTierField.selectable = false;
            vehicleTierField.autoSize = TextFieldAutoSize.RIGHT;
            vehicleTierField.styleSheet = Utils.createTextStyleSheet("xvm_vehicleTier", proxy.vehicleNameField.defaultTextFormat);

            // position
            vehicleTierField.x = proxy.width - vehicleTierField.width - 3;
            vehicleTierField.y = proxy.vehicleNameField.y;

            vehicleTierField.htmlText = "";
            proxy.addChild(vehicleTierField);
        }
    }

}