/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.profile.UI
{
    import com.xfw.*;
    import com.xvm.*;
    import net.wg.data.managers.*;

    public dynamic class UI_TechnicsDashLineTextItemIRenderer extends TechnicsDashLineTextItemIRenderer_UI
    {
        private var _toolTipParams:IToolTipParams;

        public function UI_TechnicsDashLineTextItemIRenderer()
        {
            //Logger.add("UI_TechnicsDashLineTextItemIRenderer");
        }

        override public function set toolTipParams(value:IToolTipParams):void
        {
            super.toolTipParams = value;
            this._toolTipParams = value;
        }

        override protected function showToolTip(param1:IToolTipParams):void
        {
            try
            {
                if (tooltip == "xvm_xte")
                {
                    var params:Object = _toolTipParams != null ? _toolTipParams.body : null;
                    var t:String = Sprintf.format("{{l10n:profile/xvm_xte_extended_tooltip:%s:%s:%s:%s:%s:%s}}",
                        !params.myD  ? "--" : App.utils.locale.integer(Math.round(params.myD)),
                        !params.myF  ? "--" : App.utils.locale.float(params.myF),
                        !params.avgD ? "--" : App.utils.locale.integer(Math.round(params.avgD)),
                        !params.avgF ? "--" : App.utils.locale.float(params.avgF),
                        !params.topD ? "--" : App.utils.locale.integer(Math.round(params.topD)),
                        !params.topF ? "--" : App.utils.locale.float(params.topF));
                    App.toolTipMgr.show(Locale.get(t));
                }
                else
                {
                    super.showToolTip(param1);
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
