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

    public class WidgetsLoginXvmView extends WidgetsBaseXvmView
    {
        public function WidgetsLoginXvmView(view:IView)
        {
            super(view);
        }

        // PROTECTED

        override protected function init():void
        {
            var page:LoginPage = view as LoginPage;
            var index:int;
            var cfg:Array = filterWidgets(Config.config.login.widgets, Defines.WIDGET_TYPE_EXTRAFIELD, Defines.LAYER_BOTTOM);
            if (cfg != null && cfg.length > 0)
            {
                index = 0;
                extraFieldsWidgetsBottom = page.addChildAt(new ExtraFieldsWidgets(cfg), index) as ExtraFieldsWidgets;
            }

            cfg = filterWidgets(Config.config.login.widgets, Defines.WIDGET_TYPE_EXTRAFIELD, Defines.LAYER_NORMAL);
            if (cfg != null && cfg.length > 0)
            {
                index = page.getChildIndex(page.loginViewStack);
                extraFieldsWidgetsNormal = page.addChildAt(new ExtraFieldsWidgets(cfg), index) as ExtraFieldsWidgets;
            }

            cfg = filterWidgets(Config.config.login.widgets, Defines.WIDGET_TYPE_EXTRAFIELD, Defines.LAYER_TOP);
            if (cfg != null && cfg.length > 0)
            {
                index = page.numChildren;
                extraFieldsWidgetsTop = page.addChildAt(new ExtraFieldsWidgets(cfg), index) as ExtraFieldsWidgets;
            }
        }
    }
}
