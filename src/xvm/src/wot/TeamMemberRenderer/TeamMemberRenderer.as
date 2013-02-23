import wot.utils.Cache;
import wot.utils.Config;
import wot.utils.GlobalEventDispatcher;
import wot.utils.Logger;
import wot.utils.Utils;
import wot.Helpers.TeamRendererHelper;
import wot.Helpers.UserDataLoaderHelper;

class wot.TeamMemberRenderer.TeamMemberRenderer extends net.wargaming.messenger.controls.TeamMemberRenderer
{
    private var configured:Boolean;
    private var uid:Number;
    private var m_effField:TextField;
    private var stat:Object;

    private static var dummy = Logger.dummy;

    function TeamMemberRenderer()
    {
        super();

        Utils.TraceXvmModule("TeamMemberRenderer");

        configured = false;
        uid = 0;
        m_effField = null;
        stat = null;

        GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
        Config.LoadConfig("TeamMemberRenderer.as");
    }

    private function onConfigLoaded()
    {
        GlobalEventDispatcher.removeEventListener("config_loaded", this, onConfigLoaded);
        configXVM();
    }

    // override
    function configUI()
    {
        textField._x -= 10;
        vehicle_type_icon._x -= 10;
        vehicleNameField._x -= 10;
        vehicleLevelField._x -= 15;

        super.configUI();

        configured = true;
        configXVM();
    }
    
    private function configXVM()
    {
        if (!configured || !Config.s_loaded || Config.s_config.rating.showPlayersStatistics != true)
            return;
        if (Config.s_config.rating.enableUserInfoStatistics != true)
            return;

        var wnd = owner._parent;
        if (wnd)
        {
            wnd.crewStuffFieldXVM = TeamRendererHelper.CreateXVMHeaderLabel(wnd, "crewStuffField", vehicleLevelField, 
                187, 2, "TeamRenderersHeaderTip");
            wnd.queueLabelXVM = TeamRendererHelper.CreateXVMHeaderLabel(wnd, "queueLabel", vehicleLevelField, 
                187, 2, "TeamRenderersHeaderTip");
        }

        m_effField = Utils.duplicateTextField(this, "eff", vehicleLevelField, 0, "center");
        m_effField._x += 20;

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
        if (!data || !data.uid)
            return;
        if (!configured || !Config.s_loaded || Config.s_config.rating.showPlayersStatistics != true)
            return;
        if (Config.s_config.rating.enableUserInfoStatistics != true)
            return;
            
        uid = data.uid;
        if (Cache.Exist("INFO#" + uid))
            setXVMStat();
        else
        {
            m_effField.htmlText = "";
            GlobalEventDispatcher.addEventListener("userdata_cached", this, setXVMStat);
            UserDataLoaderHelper.LoadUserData(uid, true);
        }
    }

    private function setXVMStat()
    {
        var key = "INFO#" + uid;
        stat = TeamRendererHelper.setXVMStat(key, m_effField);
    }

    // override
    function getToolTipData()
    {
        return (!stat) ? super.getToolTipData() : TeamRendererHelper.GetToolTipData(stat);
    }
}
