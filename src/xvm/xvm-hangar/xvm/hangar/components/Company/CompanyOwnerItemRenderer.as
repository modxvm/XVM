package xvm.hangar.components.Company
{
    import flash.text.*;
    import flash.utils.*;
    import flash.geom.Transform;
    import net.wg.gui.prebattle.company.CompanyListItemRenderer;
    import scaleform.gfx.TextFieldEx;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.events.UILoaderEvent;
    import net.wg.gui.lobby.battleloading.PlayerItemRenderer;
    import org.idmedia.as3commons.util.StringUtils;
    import com.xvm.*;
    import com.xvm.utils.*;
    import com.xvm.misc.IconLoader;
    import com.xvm.types.cfg.CClanIcon;
    import xvm.hangar.components.ClanIcon.ClanIcon;
    import xvm.UI.battleLoading.*;

    public class CompanyOwnerItemRenderer
    {
        private var proxy:CompanyListItemRenderer;

        private var stat:Object;
        private var effField:TextField;
        private var playerName:String;
        private var cache:Dictionary;

        public function CompanyOwnerItemRenderer(proxy:CompanyListItemRenderer)
        {
            try
            {
                this.proxy = proxy;

                effField = Utils.cloneTextField(proxy.pCountField);
                effField.styleSheet = Utils.createTextStyleSheet("eff", proxy.pCountField.defaultTextFormat);
                effField.x = proxy.pCountField.x - 15;
                effField.y = proxy.pCountField.y;
                effField.htmlText = "";
                proxy.addChild(effField);

                stat = null;
                playerName = null;
                cache = new Dictionary();
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }

        }

        public function setData(data:Object):void
        {
return;
            //Logger.add("setData: " + (data == null ? "(null)" : data.label));
            if (data == null || !data.uid)
                return;

            stat = null;
            effField.htmlText = "";
            var updateCheckBox:CheckBox = proxy.owner.parent["updateCheckBox"];
            if (updateCheckBox != null && updateCheckBox.selected)
                onUpdateClick();
        }

        // PRIVATE

        private function onUpdateClick():void
        {
            playerName = WGUtils.GetPlayerName(proxy.data.owner);
            if (playerName != null)
                Stat.loadUserData(this, onStatLoaded, playerName, false);
        }

        private function onStatLoaded(stat:Object):void
        {
            this.stat = stat;
            Logger.addObject(stat);
            //stat = TeamRendererHelper.setXVMStat(key, m_effField);<span class='eff'></span>
        }

        private function onRollOver():void
        {
            //if (this.stat != null)
            //    App.toolTipMgr.show(TeamRendererHelper.GetToolTipData($this.wrapper.data, $this.stat));
            //else
            {
                //if (proxy.toolTip != null)
                //    App.toolTipMgr.show(proxy.toolTip);
            }
        }
    }

}
