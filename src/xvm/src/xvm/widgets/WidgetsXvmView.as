/**
 * XVM - widgets
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.widgets
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import flash.events.MouseEvent;
    import flash.text.TextFormat;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.login.impl.*;
    import net.wg.gui.lobby.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;

    public class WidgetsXvmView extends XvmViewBase
    {
        public function WidgetsXvmView(view:IView)
        {
            super(view);
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            switch (view.as_alias)
            {
                case "login":
                    initLogin(view as LoginPage);
                    break;

                case "lobby":
                    initLobby(view as LobbyPage);
                    break;
            }
        }

        private function initLogin(page:LoginPage):void
        {
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
        }

        private function initLobby(page:LobbyPage):void
        {
            Logger.add("widgets init lobby");
        }

        private function onWidgetsClick(e:MouseEvent):void
        {
            Logger.add("onWidgetsSetupClick");
        }
    }
}
