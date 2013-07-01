import com.xvm.Cache;
import com.xvm.Config;
import com.xvm.GlobalEventDispatcher;
import com.xvm.Helpers.TeamRendererHelper;
import com.xvm.Helpers.UserDataLoaderHelper;
import com.xvm.Utils;

class wot.TeamRenderer.PlayerItemRenderer
{
    /////////////////////////////////////////////////////////////////
    // wrapped methods

    private var wrapper:net.wargaming.messenger.controls.PlayerItemRenderer;
    private var base:net.wargaming.messenger.controls.PlayerItemRenderer;

    public function PlayerItemRenderer(wrapper:net.wargaming.messenger.controls.PlayerItemRenderer, base:net.wargaming.messenger.controls.PlayerItemRenderer)
    {
        this.wrapper = wrapper;
        this.base = base;

        Utils.TraceXvmModule("TeamRenderer");

        PlayerItemRendererCtor();
    }

    function configUI()
    {
        return this.configUIImpl.apply(this, arguments);
    }

    function afterSetData()
    {
        return this.afterSetDataImpl.apply(this, arguments);
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    private var configured:Boolean;
    private var m_name:String;
    private var m_effField:TextField;

    public function PlayerItemRendererCtor()
    {
        configured = false;
        m_name = null;
        m_effField = null;

        GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
        Config.LoadConfig("PlayerItemRenderer.as");
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
        if (!configured || !Config.s_loaded || Config.s_config.rating.showPlayersStatistics != true)
            return;
        if (Config.s_config.rating.enableCompanyStatistics != true)
            return;

        if (m_effField == null)
        {
            m_effField = Utils.duplicateTextField(wrapper, "eff", wrapper.numberField, 0, "left");
            m_effField._x = wrapper.width - 20;
        }
        m_effField.htmlText = "";

        afterSetDataXVM();
    }

    function afterSetDataImpl()
    {
        base.afterSetData();
        afterSetDataXVM();
    }

    private function afterSetDataXVM()
    {
        if (!configured || !Config.s_loaded || Config.s_config.rating.showPlayersStatistics != true)
            return;
        if (Config.s_config.rating.enableCompanyStatistics != true)
            return;

        if (!wrapper.data || !wrapper.data.label)
        {
            m_name = null;
            m_effField.htmlText = "";
            return;
        }

        m_name = Utils.GetPlayerName(wrapper.data.label);
        if (Cache.Exist("INFO@" + m_name))
            setXVMStat();
        else
        {
            m_effField.htmlText = "";
            GlobalEventDispatcher.addEventListener("userdata_cached", this, setXVMStat);
            UserDataLoaderHelper.LoadUserData(m_name, false);
        }
    }

    private function setXVMStat()
    {
        var key = "INFO@" + m_name;
        if (!Cache.Exist(key))
            return;
        GlobalEventDispatcher.removeEventListener("userdata_cached", this, setXVMStat);
        TeamRendererHelper.setXVMStat(key, m_effField);
    }
}
