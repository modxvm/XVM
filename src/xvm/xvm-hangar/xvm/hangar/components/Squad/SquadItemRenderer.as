/**
 * @author Mr.A
 * @author Pavel Máca
 */
package xvm.hangar.components.Squad
{
    import com.xvm.*;
    import net.wg.gui.prebattle.squad.SquadItemRenderer;

    public class SquadItemRenderer
	{
        private var proxy:net.wg.gui.prebattle.squad.SquadItemRenderer;

        public function SquadItemRenderer(proxy:net.wg.gui.prebattle.squad.SquadItemRenderer):void
        {
            this.proxy = proxy;
        }

        private var configUI:Boolean = false;

        public function setUIConfigured():void {
            configUI = true;
        }
/*
        public function getToolTipData():String
        {
            // Prevent editing empty or "invite" fields
            if (!wrapper.data || wrapper.data.dummy)
                return base.getToolTipData();

            if (!Config.s_loaded || !Config.s_config.squad.enabled)
                return base.getToolTipData();

            var ti = getTankInfo(wrapper.data.vehicleName);

            return  (ti == null) ? base.getToolTipData() :
                Locale.get("Type") + ": " + Locale.get(ti.type) + "\n" +
                Locale.get("Battle tiers") + ": " + ti.battleTiers + "\n" +
                Locale.get("Nation") + ": " + Locale.get(ti.nation);
        }*/

        // -- Private
/*
        private function onConfigLoaded()
        {
            GlobalEventDispatcher.removeEventListener(Config.E_CONFIG_LOADED, this, onConfigLoaded);
            displayVehicleTier();
        }*/
/*
        private function displayVehicleTier()
        {
            // Erase field
            if (vehicleTierField != null)
                vehicleTierField.htmlText = "";

            // Prevent editing empty or "invite" fileds
            if (!wrapper.data || wrapper.data.dummy)
                return;

            // UI and Config ready
            if (!configured || !Config.s_loaded)
                return;

            if (!Config.s_config.squad.enabled)
                return;

            // Remove clan tag from player name
            if (Config.s_config.squad.showClan == false)
                wrapper.data.displayName = Utils.GetPlayerName(wrapper.data.displayName);

            // Is vehicle selected ?
            if (wrapper.data.vehicleName == null || wrapper.data.vehicleName == "")
                return;

            // Display vehicle tier
            var ti = getTankInfo(wrapper.data.vehicleName);
            if (ti != null)
            {
                if (vehicleTierField == null)
                    createVehicleTierField();

                vehicleTierField.htmlText = "<span class='xvm_vehicleTier'>" +
                    Utils.fixImgTag(Config.s_config.squad.leftLvlBorder) +
                    ti.level +
                    Utils.fixImgTag(Config.s_config.squad.rightLvlBorder) +
                    "</span>";
            }
        }*/
/*
        private function getTankInfo(localizedName:String):Object
        {
            if (!localizedName)
                return null;

            var vname = VehicleInfoDataL10n.getVehicleName(localizedName);
            var vi2 = VehicleInfoData2.data[vname];
            var vi1 = VehicleInfo.getInfo1("/" + vi2.nation + "-" + vi2.name + ".");

            return (vi1 == null || vi2 == null) ? null : {
                level: Config.s_config.squad.romanNumbers ? Defines.ROMAN_LEVEL[vi2.level - 1] : String(vi2.level),
                nation: vi2.nation,
                type: vi2.type,
                battleTiers: vi1.tiers.join("-")
            };
        }
*//*
        private function createVehicleTierField() {
            vehicleTierField = Utils.duplicateTextField(wrapper, "vehicleTier", wrapper.vehicleNameField, 0, "right");
            vehicleTierField._width = 20;
            vehicleTierField._x = wrapper.width - 4;
        }*/
    }

}