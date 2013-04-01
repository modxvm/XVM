import net.wargaming.messenger.MessengerUtils;
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
    private var m_infoField:TextField;
    private var stat:Object;

    private static var __dummy = Logger.dummy;

    function TeamMemberRenderer()
    {
        super();

        Utils.TraceXvmModule("TeamMemberRenderer");

        configured = false;
        uid = 0;
        m_infoField = null;
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
        vehicle_type_icon._x -= 8;
        vehicleNameField._x -= 8;
        vehicleLevelField._x -= 12;

        super.configUI();

        configured = true;
        configXVM();
    }
    
    private function configXVM()
    {
        if (!configured || !Config.s_loaded || Config.s_config.rating.showPlayersStatistics != true)
            return;
        if (Config.s_config.rating.enableCompanyStatistics != true)
            return;

        var wnd = owner._parent;
        if (wnd)
        {
            wnd.queueLabelXVM = TeamRendererHelper.CreateXVMHeaderLabel(wnd, "queueLabel", vehicleLevelField, 
                183, 2, "TeamRenderersHeaderTip");
            //wnd.crewStuffFieldXVM = TeamRendererHelper.CreateXVMHeaderLabel(wnd, "crewStuffField", vehicleLevelField, 
            //    185, 2, "TeamRenderersHeaderTip");
        }

        m_infoField = Utils.duplicateTextField(this, "eff", vehicleLevelField, 0, "right");
        m_infoField._width = 20;
        m_infoField._x = width - 4;

        afterSetDataXVM();
    }

    // override
    function afterSetData()
    {
        super.afterSetData();
        setTextColor();
        afterSetDataXVM();
    }

    // override
    function updateAfterStateChange()
    {
        super.updateAfterStateChange();
        setTextColor();
    }
    
    private function setTextColor()
    {
        var color = MessengerUtils.isFriend(data) ? 0x66FF66 : MessengerUtils.isIgnored(data) ? 0xFF6666 : data.colors[0];
        textField.textColor = numberField.textColor = vehicleNameField.textColor = vehicleLevelField.textColor = color;
    }
    
    private function afterSetDataXVM()
    {
        if (!data || !data.uid)
            return;
        //Logger.addObject(data);
        
        if (!configured || !Config.s_loaded || Config.s_config.rating.showPlayersStatistics != true)
            return;
        if (Config.s_config.rating.enableCompanyStatistics != true)
            return;
            
        uid = data.uid;
        if (Cache.Exist("INFO#" + uid))
            setXVMStat();
        else
        {
            m_infoField.htmlText = "";
            GlobalEventDispatcher.addEventListener("userdata_cached", this, setXVMStat);
            UserDataLoaderHelper.LoadUserData(uid, true);
        }
    }

    private function setXVMStat()
    {
        var key = "INFO#" + uid;
        if (!Cache.Exist(key))
            return;
        GlobalEventDispatcher.removeEventListener("userdata_cached", this, setXVMStat);
        stat = TeamRendererHelper.setXVMStat(key, m_infoField);
    }

    // override
    function getToolTipData()
    {
        return (!stat) ? super.getToolTipData() : TeamRendererHelper.GetToolTipData(data, stat);
    }
}
