/**
 * ...
 * @author Mr.A
 */
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.GlobalEventDispatcher;
import wot.utils.Locale;
import wot.utils.Logger;
import wot.utils.Utils;
import wot.utils.VehicleInfo;
import wot.utils.VehicleInfoDataL10n;

class wot.SquadMemberRenderer.SquadMemberRenderer extends net.wargaming.messenger.controls.SquadMemberRenderer
{
    private var configured:Boolean;
    private var uid:Number;
    private var m_infoField:TextField;

    private static var __dummy = Logger.dummy; // avoid compiler warning
    
    function SquadMemberRenderer()
    {
        super();

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

    // override
    function configUI()
    {
        super.configUI();

        configured = true;
        configXVM();
    }

    private function configXVM()
    {
        if (!configured || !Config.s_loaded)
            return;
        if (Config.s_config.squad.enabled != true)
            return;

        m_infoField = Utils.duplicateTextField(this, "info", vehicleNameField, 0, "right");
        m_infoField._width = 20;
        m_infoField._x = width - 4;

        afterSetDataXVM();
    }
    
    // override
    function afterSetData()
    {
        super.afterSetData();
        afterSetDataXVM();
    }

    private function afterSetDataXVM()
    {
        if (m_infoField != null)
            m_infoField.htmlText = "";

        if (!data || !data.uid)
            return;
        //Logger.addObject(data);
        if (!configured || !Config.s_loaded)
            return;
        if (Config.s_config.squad.enabled != true)
            return;

        uid = data.uid;
        /*
        if (Cache.Exist("INFO#" + uid))
            setXVMStat();
        else
        {
            m_infoField.htmlText = "";
            GlobalEventDispatcher.addEventListener("userdata_cached", this, setXVMStat);
            UserDataLoaderHelper.LoadUserData(uid, true);
        }*/
        
        var ti = getTankInfo(data.vehicleName);
        if (ti != null)
            m_infoField.htmlText = "<span class='xvm_info'>" + Config.s_config.squad.leftLvlBorder + ti.level + "</span>";
        //Logger.add(m_infoField.htmlText);
    }

    // override
    function getToolTipData()
    {
        //Logger.add("getToolTipData");
        if (!Config.s_config.squad.enabled)
            return super.getToolTipData();

        var ti = getTankInfo(data.vehicleName);
        if (ti == null)
            return super.getToolTipData();
        
        return
            Locale.get("Vehicle") + ": " + ti.vname + "\n" +
            Locale.get("Type") + ": " + Locale.get(ti.type) + "\n" +
            Locale.get("Level") + ": " + ti.level + "\n" +
            Locale.get("Battle tiers") + ": " + ti.battleTiers + "\n" +
            Locale.get("Nation") + ": " + Locale.get(ti.nation);
    }

    function getTankInfo(vname:String):Object
    {
        //Logger.add("getTankInfo");
        //Logger.addObject(data);
        if (!Config.s_loaded || !Config.s_config.squad.enabled || !data || !vname || vname == "")
            return null;

        if (!Config.s_config.squad.showClan)
            data.displayName = Utils.GetPlayerName(data.displayName); // FIXIT: bad style

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
