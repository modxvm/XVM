import net.wargaming.messenger.MessengerUtils;
import com.xvm.Cache;
import com.xvm.Config;
import com.xvm.GlobalEventDispatcher;
import com.xvm.Logger;
import com.xvm.Utils;
import com.xvm.Helpers.TeamRendererHelper;
import com.xvm.Helpers.UserDataLoaderHelper;

class wot.TeamMemberRenderer.TeamMemberRenderer
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
    function updateAfterStateChange()
    {
        return this.updateAfterStateChangeImpl.apply(this, arguments);
    }

    // override
    function getToolTipData()
    {
        return this.getToolTipDataImpl.apply(this, arguments);
    }

    /////////////////////////////////////////////////////////////////

    private var wrapper:net.wargaming.messenger.controls.TeamMemberRenderer;
    private var base:net.wargaming.messenger.controls.TeamMemberRenderer;

    /////////////////////////////////////////////////////////////////
    private var configured:Boolean;
    private var uid:Number;
    private var m_infoField:TextField;
    private var stat:Object;

    public function TeamMemberRenderer(wrapper:net.wargaming.messenger.controls.TeamMemberRenderer, base:net.wargaming.messenger.controls.TeamMemberRenderer)
    {
        this.wrapper = wrapper;
        this.base = base;

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

    function configUIImpl()
    {
        wrapper.textField._x -= 10;
        wrapper.vehicle_type_icon._x -= 8;
        wrapper.vehicleNameField._x -= 8;
        wrapper.vehicleLevelField._x -= 12;

        base.configUI();

        configured = true;
        configXVM();
    }
    
    private function configXVM()
    {
        if (!configured || !Config.s_loaded || Config.s_config.rating.showPlayersStatistics != true)
            return;
        if (Config.s_config.rating.enableCompanyStatistics != true)
            return;

        var wnd = wrapper.owner._parent;
        if (wnd)
        {
            wnd.queueLabelXVM = TeamRendererHelper.CreateXVMHeaderLabel(wnd, "queueLabel", wrapper.vehicleLevelField, 
                183, 2, "TeamRenderersHeaderTip");
        }

        m_infoField = Utils.duplicateTextField(wrapper, "eff", wrapper.vehicleLevelField, 0, "right");
        m_infoField._width = 20;
        m_infoField._x = wrapper.width - 4;

        afterSetDataXVM();
    }

    function afterSetDataImpl()
    {
        base.afterSetData();
        setTextColor();
        afterSetDataXVM();
    }

    function updateAfterStateChangeImpl()
    {
        base.updateAfterStateChange();
        setTextColor();
    }
    
    private function setTextColor()
    {
        var color = MessengerUtils.isFriend(wrapper.data) ? 0x66FF66 : MessengerUtils.isIgnored(wrapper.data) ? 0xFF6666 : wrapper.data.colors[0];
        wrapper.textField.textColor = wrapper.numberField.textColor = wrapper.vehicleNameField.textColor = wrapper.vehicleLevelField.textColor = color;
    }
    
    private function afterSetDataXVM()
    {
        if (!configured || !Config.s_loaded || Config.s_config.rating.showPlayersStatistics != true)
            return;
        if (Config.s_config.rating.enableCompanyStatistics != true)
            return;
        if (!wrapper.data || !wrapper.data.uid)
            return;
        //Logger.addObject(wrapper.data);
        
        uid = wrapper.data.uid;
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

    function getToolTipDataImpl()
    {
        return (!stat) ? base.getToolTipData() : TeamRendererHelper.GetToolTipData(wrapper.data, stat);
    }
}
