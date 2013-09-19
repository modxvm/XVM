package xvm.hangar.components.Company
{
    import com.xvm.*;
    import com.xvm.utils.*;
    import com.xvm.types.stat.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.data.daapi.PlayerInfo;
    import net.wg.gui.prebattle.company.CompaniesListWindow;
    import net.wg.gui.prebattle.company.CompanyListItemRenderer;
    import xvm.hangar.components.Company.*;

    public class CompanyOwnerItemRenderer
    {
        private var proxy:CompanyListItemRenderer;

        private var effField:TextField;
        private var playerName:String;

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

                playerName = null;

                proxy.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }

        }

        public function configUI():void
        {
            //Logger.add('configUI()');
            var updateCheckBox:CheckBox = proxy.owner.parent.getChildByName("updateStatCheckBox") as CheckBox;
            //Logger.addObject(updateCheckBox);
            updateCheckBox.addEventListener(Event.SELECT, onUpdateClick);
        }

        public function setData(data:Object):void
        {
            //Logger.add("setData: " + (data == null ? "(null)" : data.creatorName));
            //Logger.addObject(data, "setData");
            if (data == null || !data.creatorName)
                return;

            effField.htmlText = "";
            var updateCheckBox:CheckBox = proxy.owner.parent.getChildByName("updateStatCheckBox") as CheckBox;
            if (updateCheckBox.selected)
                onUpdateClick();
        }

        // PRIVATE

        private function onUpdateClick(e:Event = null):void
        {
            playerName = WGUtils.GetPlayerName(proxy.data.creatorName);
            //Logger.add("onUpdateClick() " + playerName);
            if (playerName != null)
                Stat.loadUserData(this, onStatLoaded, playerName, false);
        }

        private function onStatLoaded(stat:StatData):void
        {
            Logger.add("onStatLoaded");
            //Logger.addObject(stat);
            effField.htmlText = "<span class='eff'>" + TeamRendererHelper.formatXVMStatText(playerName) + "</span>";
        }

        private function onRollOver():void
        {
            Logger.add("onRollOver");
            //if (stat != null)
            var tip:String = TeamRendererHelper.getToolTipData(proxy.data as PlayerInfo, playerName);
            if (tip != null)
                App.toolTipMgr.show(tip);
            //else
            {
                //if (proxy.toolTip != null)
                //    App.toolTipMgr.show(proxy.toolTip);
            }
        }
    }

}
