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

        public function setVisibility(isHangar:Boolean):void
        {
            if (extraFieldsWidgetsBottom)
            {
                extraFieldsWidgetsBottom.visible = isHangar;
            }
            if (extraFieldsWidgetsNormal)
            {
                extraFieldsWidgetsNormal.visible = isHangar;
            }
            if (extraFieldsWidgetsTop)
            {
                extraFieldsWidgetsTop.visible = true;
            }
        }

        // PROTECTED

        override protected function init():void
        {
            //Logger.add("[widgets] init lobby");

            //XfwUtils.logChilds(page);

            cfg = Config.config.hangar.widgets;

            var page:LobbyPage = view as LobbyPage;
            var index:int;

            var widgets:Array = filterWidgets(cfg, Defines.WIDGET_TYPE_EXTRAFIELD, Defines.LAYER_BOTTOM);
            if (widgets != null && widgets.length > 0)
            {
                index = 0;
                extraFieldsWidgetsBottom = page.addChildAt(new ExtraFieldsWidgets(widgets), index) as ExtraFieldsWidgets;
                extraFieldsWidgetsBottom.visible = false;
            }

            widgets = filterWidgets(cfg, Defines.WIDGET_TYPE_EXTRAFIELD, Defines.LAYER_NORMAL);
            if (widgets != null && widgets.length > 0)
            {
                index = page.getChildIndex(page.subViewContainer as DisplayObject) + 1;
                extraFieldsWidgetsNormal = page.addChildAt(new ExtraFieldsWidgets(widgets), index) as ExtraFieldsWidgets;
                extraFieldsWidgetsNormal.visible = false;
            }

            widgets = filterWidgets(cfg, Defines.WIDGET_TYPE_EXTRAFIELD, Defines.LAYER_TOP);
            if (widgets != null && widgets.length > 0)
            {
                index = page.getChildIndex(page.header) + 1;
                extraFieldsWidgetsTop = page.addChildAt(new ExtraFieldsWidgets(widgets), index) as ExtraFieldsWidgets;
                extraFieldsWidgetsTop.visible = false;
            }
        }
    }
}
