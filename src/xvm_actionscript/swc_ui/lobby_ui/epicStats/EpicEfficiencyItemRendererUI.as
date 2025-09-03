package
{
    import net.wg.gui.lobby.battleResults.epic.EpicEfficiencyItemRenderer;

    public dynamic class EpicEfficiencyItemRendererUI extends EpicEfficiencyItemRenderer
    {

        public function EpicEfficiencyItemRendererUI()
        {
            super();
            this.__setProp_iconLoader_EpicEfficiencyItemRendererUI_iconLoader_0();
        }

        public function __setProp_iconLoader_EpicEfficiencyItemRendererUI_iconLoader_0() : *
        {
            try
            {
                iconLoader["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            iconLoader.UIID = 58458112;
            iconLoader.autoSize = false;
            iconLoader.enableInitCallback = false;
            iconLoader.maintainAspectRatio = false;
            iconLoader.source = "";
            iconLoader.sourceAlt = "";
            iconLoader.visible = true;
            try
            {
                iconLoader["componentInspectorSetting"] = false;
                return;
            }
            catch(e:Error)
            {
                return;
            }
        }
    }
}
