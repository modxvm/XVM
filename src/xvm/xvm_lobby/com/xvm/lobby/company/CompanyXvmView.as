/**
 * XVM - company window
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.company
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import flash.utils.*;
    import net.wg.data.constants.generated.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.events.*;
    import net.wg.gui.events.*;
    import net.wg.gui.prebattle.company.*;

    public class CompanyXvmView extends XvmViewBase
    {
        private static const _swf_name:String = "xvm_lobbycompany_ui.swf";

        public function CompanyXvmView(view:IView)
        {
            super(view);
        }

        public function get page():CompanyMainWindow
        {
            return super.view as CompanyMainWindow;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.add("onAfterPopulate: " + view.as_alias);

            if (!Config.networkServicesSettings.statCompany)
                return;

            App.instance.loaderMgr.addEventListener(LibraryLoaderEvent.LOADED, onLibLoaded, false, 0, true);

            if (XfwComponent.try_load_ui_swf("xvm_lobby", _swf_name) != XfwConst.SWF_START_LOADING)
            {
                init();
            }
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            App.instance.loaderMgr.removeEventListener(LibraryLoaderEvent.LOADED, onLibLoaded);
            page.stack.removeEventListener(ViewStackEvent.VIEW_CHANGED, onViewChanged);
        }

        // PRIVATE

         private function onLibLoaded(e:LibraryLoaderEvent):void
        {
            //if (StringUtils.endsWith(e.url.toLowerCase(), _ui_name))
            {
                init();
                setView(page.stack.currentView as IViewStackContent);
            }
        }

        private function init():void
        {
            page.stack.addEventListener(ViewStackEvent.VIEW_CHANGED, onViewChanged, false, 0, true);
        }

        private function onViewChanged(e:ViewStackEvent):void
        {
            setView(e.view);
        }

        private function setView(view:IViewStackContent):void
        {
            switch (getQualifiedClassName(view))
            {
                case PREBATTLE_ALIASES.COMPANY_LIST_VIEW_UI:
                    new CompanyList(view);
                    break;
                case PREBATTLE_ALIASES.COMPANY_ROOM_VIEW_UI:
                    new CompanyRoom(view);
                    break;
                default:
                    //Logger.addObject(e);
                    break;
            }
        }
    }
}
