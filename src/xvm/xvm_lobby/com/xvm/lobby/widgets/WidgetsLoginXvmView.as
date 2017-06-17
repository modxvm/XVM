/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.lobby.widgets
{
    import com.xfw.*;
    import com.xvm.*;
    import net.wg.gui.login.impl.*;
    import net.wg.infrastructure.interfaces.*;

    public class WidgetsLoginXvmView extends WidgetsBaseXvmView
    {
        public function WidgetsLoginXvmView(view:IView)
        {
            super(view);
        }

        // PROTECTED

        override protected function init():void
        {
            cfg = Config.config.login.widgets;

            var page:LoginPage = view as LoginPage;
            var index:int;

            var widgets:Array = filterWidgets(cfg, Defines.WIDGET_TYPE_EXTRAFIELD, Defines.LAYER_BOTTOM);
            if (widgets != null && widgets.length > 0)
            {
                index = 0;
                extraFieldsWidgetsBottom = page.addChildAt(new ExtraFieldsWidgets(widgets), index) as ExtraFieldsWidgets;
            }

            widgets = filterWidgets(cfg, Defines.WIDGET_TYPE_EXTRAFIELD, Defines.LAYER_NORMAL);
            if (widgets != null && widgets.length > 0)
            {
                index = page.getChildIndex(page.loginViewStack);
                extraFieldsWidgetsNormal = page.addChildAt(new ExtraFieldsWidgets(widgets), index) as ExtraFieldsWidgets;
            }

            widgets = filterWidgets(cfg, Defines.WIDGET_TYPE_EXTRAFIELD, Defines.LAYER_TOP);
            if (widgets != null && widgets.length > 0)
            {
                index = page.numChildren;
                extraFieldsWidgetsTop = page.addChildAt(new ExtraFieldsWidgets(widgets), index) as ExtraFieldsWidgets;
            }
        }
    }
}
