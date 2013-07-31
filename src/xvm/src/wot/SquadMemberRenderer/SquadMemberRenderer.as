/**
 * @author Mr.A
 * @author Assassik
 */
import com.xvm.Config;
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import com.xvm.Locale;
import com.xvm.Utils;
import com.xvm.VehicleInfo;
import com.xvm.VehicleInfoData2;
import com.xvm.VehicleInfoDataL10n;

class wot.SquadMemberRenderer.SquadMemberRenderer
{
    /////////////////////////////////////////////////////////////////
    // wrapped methods

    private var wrapper:net.wargaming.messenger.controls.SquadMemberRenderer;
    private var base:net.wargaming.messenger.controls.SquadMemberRenderer;

    public function SquadMemberRenderer(wrapper:net.wargaming.messenger.controls.SquadMemberRenderer, base:net.wargaming.messenger.controls.SquadMemberRenderer)
    {
        this.wrapper = wrapper;
        this.base = base;

        Utils.TraceXvmModule("Squad");

        SquadMemberRendererCtor();
    }

    function configUI()
    {
        return this.configUIImpl.apply(this, arguments);
    }

    function afterSetData()
    {
        return this.afterSetDataImpl.apply(this, arguments);
    }

    function getToolTipData()
    {
        return this.getToolTipDataImpl.apply(this, arguments);
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    private var configured:Boolean = false;
    private var vehicleTierField:TextField = null;

    public function SquadMemberRendererCtor()
    {
        if(!Config.s_loaded) { // rendere is initialized more than once
            GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
            Config.LoadConfig("SquadMemberRenderer.as");
        }
    }

    function configUIImpl()
    {
        base.configUI();
        configured = true;
    }

    function afterSetDataImpl()
    {
        base.afterSetData();
        displayVehicleTier();
    }

    function getToolTipDataImpl()
    {
        /** Prevent editing empty or "invite" fileds */
        if (!wrapper.data || wrapper.data.dummy)
            return base.getToolTipData();

        if (!Config.s_loaded || !Config.s_config.squad.enabled)
            return base.getToolTipData();

        var ti = getTankInfo(wrapper.data.vehicleName);

        return  (ti == null) ? base.getToolTipData() :
            Locale.get("Type") + ": " + Locale.get(ti.type) + "\n" +
            Locale.get("Battle tiers") + ": " + ti.battleTiers + "\n" +
            Locale.get("Nation") + ": " + Locale.get(ti.nation);
    }

    // -- Private

    private function onConfigLoaded()
    {
        GlobalEventDispatcher.removeEventListener("config_loaded", this, onConfigLoaded);
        displayVehicleTier();
    }

    private function displayVehicleTier()
    {
        /** Erase field */
        vehicleTierField.htmlText = "";

        /** Prevent editing empty or "invite" fileds */
        if (!wrapper.data || wrapper.data.dummy)
            return;

        /** UI and Config ready */
        if (!configured || !Config.s_loaded)
            return;

        if (!Config.s_config.squad.enabled)
            return;

        /** Remove clan tag from player name */
        if (Config.s_config.squad.showClan == false)
            wrapper.data.displayName = Utils.GetPlayerName(wrapper.data.displayName);

        /** Is vehicle selected ? */
        if (!wrapper.data.vehicleName)
            return;

        /** Display vehicle tier */
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
    }

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

    private function createVehicleTierField() {
        vehicleTierField = Utils.duplicateTextField(wrapper, "vehicleTier", wrapper.vehicleNameField, 0, "right");
        vehicleTierField._width = 20;
        vehicleTierField._x = wrapper.width - 4;
    }
}
