/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ui.profile
{
    import com.xfw.*;
    import com.xvm.*;
    import net.wg.data.managers.*;

    public dynamic class UI_StatisticsDashLineTextItemIRenderer extends StatisticsDashLineTextItemIRenderer_UI
    {
        private var _toolTipParams:IToolTipParams;

        public function UI_StatisticsDashLineTextItemIRenderer()
        {
            //Logger.add("UI_StatisticsDashLineTextItemIRenderer");
        }

        override public function set toolTipParams(value:IToolTipParams):void
        {
            super.toolTipParams = value;
            this._toolTipParams = value;
        }

        override protected function showToolTip():void
        {
            //Logger.add("UI_StatisticsDashLineTextItemIRenderer.showToolTip(): " + tooltip);
            try
            {
                var params:Object;
                var t:String;
                if (tooltip == "xvm_xte")
                {
                    params = _toolTipParams ? _toolTipParams.body : null;
                    t = Sprintf.format("{{l10n:profile/xvm_xte_extended_tooltip:%s:%s:%s:%s:%s:%s}}",
                        !params.curdmg ? "--" : App.utils.locale.integer(Math.round(params.curdmg)),
                        !params.curfrg ? "--" : App.utils.locale.float(params.curfrg),
                        !params.avgdmg ? "--" : App.utils.locale.integer(Math.round(params.avgdmg)),
                        !params.avgfrg ? "--" : App.utils.locale.float(params.avgfrg),
                        !params.topdmg ? "--" : App.utils.locale.integer(Math.round(params.topdmg)),
                        !params.topfrg ? "--" : App.utils.locale.float(params.topfrg));
                    App.toolTipMgr.show(Locale.get(t));
                }
                else
                {
                    super.showToolTip();
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
