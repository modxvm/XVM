/**
 * ...
 * @author Mr.A
 */
import com.xvm.Config;
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import com.xvm.Locale;
import com.xvm.Logger;
import com.xvm.Utils;
import com.xvm.VehicleInfo;
import com.xvm.VehicleInfoDataL10n;

class wot.SquadMemberRenderer.SquadMemberRenderer
{
    // override
    function configUI()
    {
        return this.configUIImpl.apply(this, arguments);
    }

    // override
    function afterSetData()
    {
        return this.afterSetDataImpl.apply(this, arguments);
    }

    // override
    function getToolTipData()
    {
        return this.getToolTipDataImpl.apply(this, arguments);
    }

    /////////////////////////////////////////////////////////////////

    private var wrapper:net.wargaming.messenger.controls.SquadMemberRenderer;
    private var base:net.wargaming.messenger.controls.SquadMemberRenderer;

    /////////////////////////////////////////////////////////////////

    private var configured:Boolean;
    private var uid:Number;
    private var m_infoField:TextField;

    public function SquadMemberRenderer(wrapper:net.wargaming.messenger.controls.SquadMemberRenderer, base:net.wargaming.messenger.controls.SquadMemberRenderer)
    {
        this.wrapper = wrapper;
        this.base = base;

        Utils.TraceXvmModule("Squad");

        configured = false;
        uid = 0;
        m_infoField = null;

        GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
        Config.LoadConfig("SquadMemberRenderer.as");
    }

    private function onConfigLoaded()
    {
        GlobalEventDispatcher.removeEventListener("config_loaded", this, onConfigLoaded);
        configXVM();
    }

    function configUIImpl()
    {
        base.configUI();
        configured = true;
        configXVM();
    }

    private function configXVM()
    {
        if (!configured || !Config.s_loaded)
            return;
        if (Config.s_config.squad.enabled != true)
            return;

        m_infoField = Utils.duplicateTextField(wrapper, "info", wrapper.vehicleNameField, 0, "right");
        m_infoField._width = 20;
        m_infoField._x = wrapper.width - 4;

        afterSetDataXVM();
    }

    function afterSetDataImpl()
    {
        base.afterSetData();
        afterSetDataXVM();
    }

    private function afterSetDataXVM()
    {
        if (m_infoField != null)
            m_infoField.htmlText = "";

        if (!wrapper.data || !wrapper.data.uid)
            return;
        //Logger.addObject(data);
        if (!configured || !Config.s_loaded)
            return;
        if (Config.s_config.squad.enabled != true)
            return;

        uid = wrapper.data.uid;
        /*
        if (Cache.Exist("INFO#" + uid))
            setXVMStat();
        else
        {
            m_infoField.htmlText = "";
            GlobalEventDispatcher.addEventListener("userdata_cached", this, setXVMStat);
            UserDataLoaderHelper.LoadUserData(uid, true);
        }*/

        var ti = getTankInfo(wrapper.data.vehicleName);
        if (ti != null)
            m_infoField.htmlText = "<span class='xvm_info'>" + Config.s_config.squad.leftLvlBorder + ti.level + "</span>";
        //Logger.add(m_infoField.htmlText);
    }

    function getToolTipDataImpl()
    {
        //Logger.add("getToolTipData");
        if (!Config.s_config.squad.enabled)
            return base.getToolTipData();

        var ti = getTankInfo(wrapper.data.vehicleName);
        if (ti == null)
            return base.getToolTipData();

        return
            Locale.get("Type") + ": " + Locale.get(ti.type) + "\n" +
            Locale.get("Battle tiers") + ": " + ti.battleTiers + "\n" +
            Locale.get("Nation") + ": " + Locale.get(ti.nation);
    }

    function getTankInfo(vname:String):Object
    {
        //Logger.add("getTankInfo");
        //Logger.addObject(data);
        if (Config.s_loaded && !Config.s_config.squad.showClan)
            wrapper.data.displayName = Utils.GetPlayerName(wrapper.data.displayName); // FIXIT: bad style

        if (!Config.s_loaded || !Config.s_config.squad.enabled || !wrapper.data || !vname || vname == "")
            return null;

        var vkey = VehicleInfoDataL10n.LocalizedNameToVehicleKey(vname);

        var vi2 = VehicleInfo.getInfo2("/-" + vkey + ".");
        if (vi2 == null)
            return null;
        var vi1 = VehicleInfo.getInfo1("/" + vi2.nation + "-" + vi2.name + ".");
        if (!vi1)
            return null;

        return {
            vname: vname,
            vkey: vkey,
            level: Config.s_config.squad.romanNumbers ? Defines.ROMAN_LEVEL[vi2.level - 1] : String(vi2.level),
            nation: vi2.nation,
            type: vi2.type,
            battleTiers: vi1.tiers.join("-")
        };
    }

}
