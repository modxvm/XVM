package xvm.company.renderers
{
    import com.xvm.*;
    import com.xvm.utils.*;
    import com.xvm.types.stat.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.prebattle.company.*;

    public class CompanyDropItemRenderer
    {
        private var proxy:net.wg.gui.prebattle.company.CompanyDropItemRenderer;

        private var effField:TextField;

        public function CompanyDropItemRenderer(proxy:net.wg.gui.prebattle.company.CompanyDropItemRenderer)
        {
            try
            {
                this.proxy = proxy;

                effField = Utils.cloneTextField(proxy.textField);
                effField.styleSheet = Utils.createTextStyleSheet("eff", proxy.textField.defaultTextFormat);
                proxy.numberField.x = 0;
                proxy.numberField.width = 15;
                proxy.textField.x = 15;
                effField.x = 20 + proxy.textField.width;
                effField.width = 20;
                effField.y = proxy.textField.y;
                effField.htmlText = "";
                proxy.addChild(effField);
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }

        }

        public function setData(data:Object):void
        {
            App.toolTipMgr.hide();
            effField.htmlText = "";

            if (data == null || !data.label)
                return;

            var pname:String = WGUtils.GetPlayerName(data.label);
            App.utils.scheduler.scheduleTask(function():void
            {
                Stat.loadUserData(this, onStatLoaded, pname, false);
            }, 10);
        }

        public function handleMouseRollOver(e:MouseEvent):void
        {
            try
            {
                if (proxy.data == null || !proxy.data.label)
                    return;
                var pname:String = WGUtils.GetPlayerName(proxy.data.label);
                var sd:StatData = Stat.getUserDataByName(pname);
                if (sd == null)
                    return;
                var tip:String = TeamRendererHelper.getToolTipData(proxy.data.label, proxy.data);
                if (tip == null)
                    return;
                App.toolTipMgr.show(tip);
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        public function handleMouseRollOut(e:MouseEvent):void
        {
            App.toolTipMgr.hide();
        }

        // PRIVATE

        private function onStatLoaded():void
        {
            effField.htmlText = (proxy.data == null || !proxy.data.label) ? ""
                : "<span class='eff'>" + TeamRendererHelper.formatXVMStatText(proxy.data.label) + "</span>";
        }
    }

}
