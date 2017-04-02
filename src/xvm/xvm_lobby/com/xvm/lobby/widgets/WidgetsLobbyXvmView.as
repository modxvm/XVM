/**
 * XVM - widgets
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.widgets
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.cfg.*;
    import flash.display.*;
    import net.wg.gui.login.impl.*;
    import net.wg.gui.lobby.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.core.*;

    public class WidgetsLobbyXvmView extends WidgetsBaseXvmView
    {
        public function WidgetsLobbyXvmView(view:IView)
        {
            super(view);
        }

        // PROTECTED

        override protected function init():void
        {
            //Logger.add("[widgets] init lobby");

            //XfwUtils.logChilds(page);

            var page:LobbyPage = view as LobbyPage;
            var index:int;
            var cfg:Array = filterWidgets(Config.config.hangar.widgets, Defines.WIDGET_TYPE_EXTRAFIELD, Defines.LAYER_BOTTOM);
            if (cfg != null && cfg.length > 0)
            {
                index = 0;
                extraFieldsWidgetsBottom = page.addChildAt(new ExtraFieldsWidgets(cfg), index) as ExtraFieldsWidgets;
            }

            cfg = filterWidgets(Config.config.hangar.widgets, Defines.WIDGET_TYPE_EXTRAFIELD, Defines.LAYER_BOTTOM);
            if (cfg != null && cfg.length > 0)
            {
                index = page.getChildIndex(page.subViewContainer as DisplayObject) + 1;
                extraFieldsWidgetsNormal = page.addChildAt(new ExtraFieldsWidgets(cfg), index) as ExtraFieldsWidgets;
            }

            cfg = filterWidgets(Config.config.hangar.widgets, Defines.WIDGET_TYPE_EXTRAFIELD, Defines.LAYER_BOTTOM);
            if (cfg != null && cfg.length > 0)
            {
                index = page.getChildIndex(page.header) + 1;
                extraFieldsWidgetsTop = page.addChildAt(new ExtraFieldsWidgets(cfg), index) as ExtraFieldsWidgets;
            }
        }
    }
}
