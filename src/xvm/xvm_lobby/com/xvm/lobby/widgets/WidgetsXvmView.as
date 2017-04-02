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

    public class WidgetsXvmView extends XvmViewBase
    {
        private var _extraFieldsWidgetsBottom:ExtraFieldsWidgets = null;
        private var _extraFieldsWidgetsNormal:ExtraFieldsWidgets = null;
        private var _extraFieldsWidgetsTop:ExtraFieldsWidgets = null;

        public function WidgetsXvmView(view:IView)
        {
            super(view);
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            try
            {
                switch (view.as_config.alias)
                {
                    case "login":
                        initLogin(view as LoginPage);
                        break;

                    case "lobby":
                        initLobby(view as LobbyPage);
                        break;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            var page:UIComponent = view as UIComponent;
            if (_extraFieldsWidgetsBottom != null)
            {
                page.removeChild(_extraFieldsWidgetsBottom);
                _extraFieldsWidgetsBottom.dispose();
                _extraFieldsWidgetsBottom = null;
            }
            if (_extraFieldsWidgetsNormal != null)
            {
                page.removeChild(_extraFieldsWidgetsNormal);
                _extraFieldsWidgetsNormal.dispose();
                _extraFieldsWidgetsNormal = null;
            }
            if (_extraFieldsWidgetsTop != null)
            {
                page.removeChild(_extraFieldsWidgetsTop);
                _extraFieldsWidgetsTop.dispose();
                _extraFieldsWidgetsTop = null;
            }
            super.onBeforeDispose(e);
        }

        private function initLogin(page:LoginPage):void
        {
            //Logger.add("[widgets] init login");

            /*
            var wb:IconTextButton = (page.form as UIComponent).addChild(App.utils.classFactory.getComponent("ButtonIconText", IconTextButton, {
                x: 90,
                y: 110,
                width: 90,
                label: Locale.get("WIDGETS"),
                iconSource: "../maps/icons/buttons/settings.png",
                tooltip: Locale.get("Setup XVM widgets")
            })) as IconTextButton;
            //wb.addEventListener(MouseEvent.ROLL_OVER, function():void { App.toolTipMgr.show(wb.tooltip); } );
            //wb.addEventListener(MouseEvent.ROLL_OUT, App.toolTipMgr.hide);
            wb.addEventListener(MouseEvent.CLICK, onWidgetsClick);
            */

            //XfwUtils.logChilds(page);

            var index:int;
            var cfg:Array = filterWidgets(Config.config.login.widgets, Defines.WIDGET_TYPE_EXTRAFIELD, Defines.LAYER_BOTTOM);
            if (cfg != null && cfg.length > 0)
            {
                index = 0;
                _extraFieldsWidgetsBottom = page.addChildAt(new ExtraFieldsWidgets(cfg), index) as ExtraFieldsWidgets;
            }

            cfg = filterWidgets(Config.config.login.widgets, Defines.WIDGET_TYPE_EXTRAFIELD, Defines.LAYER_NORMAL);
            if (cfg != null && cfg.length > 0)
            {
                index = page.getChildIndex(page.loginViewStack);
                _extraFieldsWidgetsNormal = page.addChildAt(new ExtraFieldsWidgets(cfg), index) as ExtraFieldsWidgets;
            }

            cfg = filterWidgets(Config.config.login.widgets, Defines.WIDGET_TYPE_EXTRAFIELD, Defines.LAYER_TOP);
            if (cfg != null && cfg.length > 0)
            {
                index = page.numChildren;
                _extraFieldsWidgetsTop = page.addChildAt(new ExtraFieldsWidgets(cfg), index) as ExtraFieldsWidgets;
            }
        }

        private function initLobby(page:LobbyPage):void
        {
            //Logger.add("[widgets] init lobby");

            var index:int;
            var cfg:Array = filterWidgets(Config.config.lobby.widgets, Defines.WIDGET_TYPE_EXTRAFIELD, Defines.LAYER_BOTTOM);
            if (cfg != null && cfg.length > 0)
            {
                index = 0;
                _extraFieldsWidgetsBottom = page.addChildAt(new ExtraFieldsWidgets(cfg), index) as ExtraFieldsWidgets;
            }

            cfg = filterWidgets(Config.config.lobby.widgets, Defines.WIDGET_TYPE_EXTRAFIELD, Defines.LAYER_BOTTOM);
            if (cfg != null && cfg.length > 0)
            {
                index = page.getChildIndex(page.subViewContainer as DisplayObject) + 1;
                _extraFieldsWidgetsNormal = page.addChildAt(new ExtraFieldsWidgets(cfg), index) as ExtraFieldsWidgets;
            }

            cfg = filterWidgets(Config.config.lobby.widgets, Defines.WIDGET_TYPE_EXTRAFIELD, Defines.LAYER_BOTTOM);
            if (cfg != null && cfg.length > 0)
            {
                index = page.getChildIndex(page.header) + 1;
                _extraFieldsWidgetsTop = page.addChildAt(new ExtraFieldsWidgets(cfg), index) as ExtraFieldsWidgets;
            }
        }

        /*
        private function onWidgetsClick(e:MouseEvent):void
        {
            Logger.add("onWidgetsSetupClick");
        }
        */

        private function filterWidgets(cfg:Array, type:String, layer:String):Array
        {
            var res:Array = [];
            for (var i:int = 0; i < cfg.length; ++i)
            {
                var w:CWidget = ObjectConverter.convertData(cfg[i], CWidget);
                if (w != null && w.enabled && w.type == type && w.layer.toLowerCase() == layer)
                {
                    res.push(ObjectConverter.convertData(w.format, CExtraField));
                }
            }
            return res;
        }
    }
}
