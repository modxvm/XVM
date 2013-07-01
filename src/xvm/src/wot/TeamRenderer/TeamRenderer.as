import com.xvm.Cache;
import com.xvm.Config;
import com.xvm.GlobalEventDispatcher;
import com.xvm.Helpers.TeamRendererHelper;
import com.xvm.Helpers.UserDataLoaderHelper;
import com.xvm.Locale;
import com.xvm.Utils;
import net.wargaming.managers.ToolTipManager;

class wot.TeamRenderer.TeamRenderer
{
    /////////////////////////////////////////////////////////////////
    // wrapped methods

    private var wrapper:net.wargaming.messenger.controls.TeamRenderer;
    private var base:net.wargaming.messenger.controls.TeamRenderer;

    public function TeamRenderer(wrapper:net.wargaming.messenger.controls.TeamRenderer, base:net.wargaming.messenger.controls.TeamRenderer)
    {
        this.wrapper = wrapper;
        this.base = base;

        Utils.TraceXvmModule("TeamRenderer");

        TeamRendererCtor();
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
    private var stat:Object;

    public function TeamRendererCtor()
    {
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

        var me = this;
        wrapper.onRollOver = function()
        {
            if (me.stat)
                ToolTipManager.instance.show(TeamRendererHelper.GetToolTipData(me.wrapper.data, me.stat));
            else
            {
                if (me.wrapper.toolTip)
                    ToolTipManager.instance.show(me.wrapper.toolTip);
            }
        }

        if (m_effField == null)
        {
            m_effField = Utils.duplicateTextField(wrapper, "eff", wrapper.textField, 0, "left");
            m_effField._x = wrapper.textField._x + wrapper.textField._width - 20;
        }
        m_effField.htmlText = "";

        var updateButton = wrapper["owner"]._parent.updateButton;
        if (updateButton == null)
        {
            //Logger.add("updateButton");
            updateButton = Utils.duplicateButton(wrapper["owner"]._parent.refreshButton, "updateButton", 135, 0, "", "icons/allUp.tga");
            updateButton.toggle = true;
            updateButton.addEventListener("select", function(e) {
                updateButton._iconSource = e.selected ? "icons/allDown.tga" : "icons/allUp.tga";
                updateButton.tooltipText = Locale.get("Load statistics") + ": " + Locale.get(e.selected ? "enabled" : "disabled");
                updateButton._autoSize = false; // WG bug
                updateButton.configUI();
            });
            updateButton.selected = false;
            updateButton.tooltipText = Locale.get("Load statistics") + ": " + Locale.get("disabled");
        }
        updateButton.addEventListener("click", this, "onUpdateClick");

        afterSetDataXVM();
    }

    private function onUpdateClick()
    {
        UserDataLoaderHelper.LoadUserData(m_name, false);
    }

    function afterSetDataImpl()
    {
        base.afterSetData();
        //Logger.addObject(data);
        afterSetDataXVM();
    }

    private function afterSetDataXVM()
    {
        if (!configured || !Config.s_loaded || Config.s_config.rating.showPlayersStatistics != true)
            return;
        if (Config.s_config.rating.enableCompanyStatistics != true)
            return;
        if (!wrapper.data || !wrapper.data.uid)
            return;

        m_name = Utils.GetPlayerName(wrapper.data.owner);
        if (Cache.Exist("INFO@" + m_name))
            setXVMStat();
        else
        {
            stat = null;
            m_effField.htmlText = "";
            GlobalEventDispatcher.addEventListener("userdata_cached", this, setXVMStat);
            if (wrapper["owner"]._parent.updateButton != null && wrapper["owner"]._parent.updateButton.selected)
                onUpdateClick();
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
