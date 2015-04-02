package xvm.company.renderers
{
    import com.xfw.*;
    import com.xfw.utils.*;
    import com.xfw.events.*;
    import com.xfw.types.stat.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.prebattle.company.*;
    import xvm.company.UI.*;

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

                effField = new TextField();
                effField.styleSheet = WGUtils.createTextStyleSheet("eff", proxy.pCountField.defaultTextFormat);
                effField.x = proxy.pCountField.x - 15;
                effField.y = proxy.pCountField.y;
                effField.width = 20;
                effField.height = proxy.pCountField.height;
                effField.htmlText = "";
                proxy.addChild(effField);

                proxy.dd.itemRenderer = UI_CompanyDropItemRenderer;

                Stat.instance.addEventListener(Stat.COMPLETE_USERDATA, onStatLoaded);

                playerName = null;
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }

        }

        public function configUI():void
        {
            updateCheckBox.addEventListener(Event.SELECT, onUpdateClick);
        }

        public function setData(data:Object):void
        {
            App.toolTipMgr.hide();
            effField.htmlText = "";

            if (data == null || !data.creatorName)
                return;

            onUpdateClick();
        }

        public function handleMouseRollOver(e:MouseEvent):void
        {
            try
            {
                if (playerName == null)
                    return;
                var sd:StatData = Stat.getUserDataByName(playerName);
                if (sd == null)
                    return;
                var tip:String = TeamRendererHelper.getToolTipData(proxy.data.creatorName, proxy.data);
                if (tip == null)
                    return;
                App.toolTipMgr.show(tip);
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        // PRIVATE

        private function get updateCheckBox():CheckBox
        {
            return proxy.owner.parent.getChildByName("updateStatCheckBox") as CheckBox;
        }

        private function onUpdateClick(e:Event = null):void
        {
            playerName = WGUtils.GetPlayerName(proxy.data.creatorName);
            if (Stat.isUserDataCachedByName(playerName))
                setEffFieldText();
            else
            {
                if (updateCheckBox.selected)
                    Stat.loadUserData(null, null, playerName, false);
            }
        }

        private function onStatLoaded(e:ObjectEvent):void
        {
            if (e == null)
                return;
            var s:String = e.result as String;
            if (s != null && s == playerName)
                setEffFieldText();
        }

        private function setEffFieldText():void
        {
            effField.htmlText = "<span class='eff'>" + TeamRendererHelper.formatXVMStatText(playerName) + "</span>";
        }
    }

}
