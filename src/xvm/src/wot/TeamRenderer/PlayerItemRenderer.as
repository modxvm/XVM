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

    function PlayerItemRendererCtor()
    {
        Utils.TraceXvmModule("TeamRenderer");

        configured = false;
        m_name = null;
        m_effField = null;

        GlobalEventDispatcher.addEventListener(Config.E_CONFIG_LOADED, this, onConfigLoaded);
        Config.LoadConfig();
    }

    function configUIImpl()
    {
        base.configUI();
        configured = true;
        configXVM();
    }

    function afterSetDataImpl()
    {
        base.afterSetData();
        afterSetDataXVM();
    }

    ///////////////////////////////////
    // PRIVATE
    
    private function onConfigLoaded()
    {
        GlobalEventDispatcher.removeEventListener(Config.E_CONFIG_LOADED, this, onConfigLoaded);
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
            GlobalEventDispatcher.addEventListener(UserDataLoaderHelper.E_USERDATACACHED, this, setXVMStat);
            UserDataLoaderHelper.LoadUserData(m_name, false);
        }
    }

    private function setXVMStat()
    {
        var key = "INFO@" + m_name;
        if (!Cache.Exist(key))
            return;
        GlobalEventDispatcher.removeEventListener(UserDataLoaderHelper.E_USERDATACACHED, this, setXVMStat);
        TeamRendererHelper.setXVMStat(key, m_effField);
    }
}
