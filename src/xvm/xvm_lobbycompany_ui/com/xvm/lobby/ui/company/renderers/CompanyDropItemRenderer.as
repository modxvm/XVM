/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.lobby.ui.company.renderers
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xfw.events.*;
    import com.xvm.types.stat.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.prebattle.company.*;
    import scaleform.gfx.*;

    public class CompanyDropItemRenderer
    {
        private var proxy:net.wg.gui.prebattle.company.CompanyDropItemRenderer;

        private var effField:TextField;
        private var playerName:String;

        public function CompanyDropItemRenderer(proxy:net.wg.gui.prebattle.company.CompanyDropItemRenderer)
        {
            try
            {
                this.proxy = proxy;

                proxy.numberField.x = 0;
                proxy.numberField.width = 15;
                proxy.textField.x = 15;
                effField = new TextField();
                effField.mouseEnabled = false;
                effField.selectable = false;
                TextFieldEx.setNoTranslate(effField, true);
                effField.antiAliasType = AntiAliasType.ADVANCED;
                effField.styleSheet = XfwUtils.createTextStyleSheet("eff", proxy.textField.defaultTextFormat);
                effField.x = 20 + proxy.textField.width;
                effField.y = proxy.textField.y;
                effField.width = 20;
                effField.height = proxy.textField.height;
                effField.htmlText = "";
                proxy.addChild(effField);

                Stat.instance.addEventListener(Stat.COMPLETE_USERDATA, onStatLoaded, false, 0, true);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }

        }

        public function setData(data:Object):void
        {
            App.toolTipMgr.hide();
            effField.htmlText = "";

            if (!data || !data.label)
            {
                playerName = null;
                return;
            }

            playerName = XfwUtils.GetPlayerName(data.label);
            App.utils.scheduler.scheduleTask(function():void
            {
                if (!Stat.isUserDataCachedByName(playerName))
                {
                    Stat.loadUserData(playerName);
                }
                else
                {
                    setEffFieldText();
                }
            }, 10);
        }

        public function handleMouseRollOver(e:MouseEvent):void
        {
            try
            {
                if (proxy.data == null || !proxy.data.label)
                    return;
                var sd:StatData = Stat.getUserDataByName(playerName);
                if (sd == null)
                    return;
                var tip:String = TeamRendererHelper.getToolTipData(proxy.data.label, proxy.data);
                if (tip == null)
                    return;
                App.toolTipMgr.show(tip);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        public function handleMouseRollOut(e:MouseEvent):void
        {
            App.toolTipMgr.hide();
        }

        // PRIVATE

        private function onStatLoaded(e:ObjectEvent):void
        {
            if (e == null)
                return;
            var s:String = e.result as String;
            if (s == playerName)
            {
                setEffFieldText();
            }
        }

        private function setEffFieldText():void
        {
            effField.htmlText = (proxy.data == null || !proxy.data.label) ? "--"
                : "<span class='eff'>" + TeamRendererHelper.formatXVMStatText(proxy.data.label) + "</span>";
        }
    }

}
