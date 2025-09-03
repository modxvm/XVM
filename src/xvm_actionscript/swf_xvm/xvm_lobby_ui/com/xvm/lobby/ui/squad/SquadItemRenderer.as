/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 * @author Mr.A
 * @author Pavel Máca
 */
package com.xvm.lobby.ui.squad
{
    import com.xfw.*;
    import com.xfw.types.veh.*;
    import com.xfw.utils.*;
    import flash.events.*;
    import flash.text.*;

    public class SquadItemRenderer
    {
        private var proxy:net.wg.gui.prebattle.squad.SquadItemRenderer;
        private var vehicleTierField:TextField;

        public function SquadItemRenderer(proxy:net.wg.gui.prebattle.squad.SquadItemRenderer):void
        {
            this.proxy = proxy;
            this.vehicleTierField = null;
        }

        private var initialized:Boolean = false;

        public function configUI():void
        {
            initialized = true;
            proxy.vehicleLevelField.alpha = 0; // TODO: use this text field
        }

        public function getToolTipData():String
        {
            if (!Config.config.squad.enabled)
                return null;

            // Hide WG field
            proxy.vehicleLevelField.alpha = 0;

            // Prevent editing empty or "invite" fields
            if (!proxy.data || proxy.data.dummy)
                return null;

            var vdata:VehicleData = VehicleInfo.getByLocalizedShortName(proxy.data.vShortName);
            if (vdata == null)
                return null;
            return Locale.get("Type") + ": " + Locale.get(vdata.vtype) + "\n" +
                Locale.get("Battle tiers") + ": " + vdata.tierLo + "-" + vdata.tierHi + "\n" +
                Locale.get("Nation") + ": " + Locale.get(vdata.nation);
        }

        public function afterSetData():void
        {
            draw();
            proxy.owner.dispatchEvent(new Event("item_updated"));
        }

        public function draw():void
        {
            if (!Config.config.squad.enabled)
                return;

            // Erase field
            if (vehicleTierField)
                vehicleTierField.htmlText = "";

            // Hide WG field
            proxy.vehicleLevelField.alpha = 0;

            // Prevent editing empty or "invite" fields
            if (!proxy.data || proxy.data.dummy)
                return;

            // UI ready
            if (!initialized)
                return;

            // Display vehicle info
            var vdata:VehicleData = VehicleInfo.getByLocalizedShortName(proxy.data.vShortName);
            if (vdata)
            {
                if (vehicleTierField == null)
                    createVehicleTierField();
                Macros.RegisterMinimalMacrosData(proxy.data.dbID, proxy.data.fullName, vdata.vehCD);
                vehicleTierField.htmlText = "<p class='xvm_vehicleTier' align='right'>" +
                    Macros.Format(proxy.data.userName, Config.config.squad.formatInfoField) + "</p>";
            }

            // Remove clan tag from player name
            if (Config.config.squad.showClan == false)
                proxy.data.clanAbbrev = "";
        }

        // -- Private

        private function createVehicleTierField():void
        {
            vehicleTierField = new TextField();
            vehicleTierField.mouseEnabled = false;
            vehicleTierField.selectable = false;
            TextFieldEx.setNoTranslate(vehicleTierField, true);
            vehicleTierField.antiAliasType = AntiAliasType.ADVANCED;
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
