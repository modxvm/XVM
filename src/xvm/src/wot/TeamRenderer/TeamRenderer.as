import net.wargaming.managers.ToolTipManager;
import wot.utils.Cache;
import wot.utils.Config;
import wot.utils.GlobalEventDispatcher;
import wot.utils.Logger;
import wot.utils.Utils;
import wot.Helpers.TeamRendererHelper;

class wot.TeamRenderer.TeamRenderer extends net.wargaming.messenger.controls.TeamRenderer
{
    private var configured:Boolean;
    private var m_name:String;
    private var m_effField:TextField;
    private var stat:Object;

    private static var dummy = Logger.dummy;

    function TeamRenderer()
    {
        super();

        Utils.TraceXvmModule("TeamRenderer");

        configured = false;
        m_name = null;
        m_effField = null;
        stat = null;

        GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
        Config.LoadConfig("TeamRenderer.as");
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
        if (!configured || !Config.s_loaded || Config.s_config.rating.showPlayersStatistics != true)
            return;

        this.onRollOver = function()
        {
            if (this.stat)
                ToolTipManager.instance.show(TeamRendererHelper.GetToolTipData(this.stat));
            else
            {
                if (this.toolTip)
                    ToolTipManager.instance.show(this.toolTip);
            }
        }

        if (m_effField == null)
        {
            m_effField = Utils.duplicateTextField(this, "eff", textField, 0, "left");
            m_effField._x = textField._x + textField._width - 20;
        }
        m_effField.htmlText = "";

        afterSetDataXVM();
    }

    // override
    function afterSetData()
    {
        super.afterSetData();
        //Logger.addObject(data);
        afterSetDataXVM();
    }

    private function afterSetDataXVM()
    {
        if (!data || !data.uid)
            return;
        if (!configured || !Config.s_loaded || Config.s_config.rating.showPlayersStatistics != true)
            return;

        m_name = Utils.GetPlayerName(data.owner);
        if (Cache.Exist("INFO@" + m_name))
            setXVMStat();
        else
        {
            m_effField.htmlText = "";
            GlobalEventDispatcher.addEventListener("userdata_cached", this, setXVMStat);
            // Disabled because of slow loading and client freezing.
            //UserDataLoaderHelper.LoadUserData(m_name, false);
        }
    }

    private function setXVMStat()
    {
        var key = "INFO@" + m_name;
        if (Cache.Exist("INFO@" + m_name))
        {
            GlobalEventDispatcher.removeEventListener("userdata_cached", this, setXVMStat);
            stat = TeamRendererHelper.setXVMStat(key, m_effField);
        }
    }
}
