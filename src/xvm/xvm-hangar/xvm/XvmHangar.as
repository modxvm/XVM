/**
 * XVM
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package xvm
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.events.*;
    import net.wg.gui.components.common.*;
    import net.wg.infrastructure.managers.impl.*;
    import com.xvm.*;
    import xvm.hangar.*;
    import xvm.hangar.views.*;
    import xvm.hangar.components.PingServers.*;

    public class XvmHangar extends Sprite
    {
        public static const G_NAME:String = "name";
        public static var Globals:Object = { };

        public function XvmHangar():void
        {
            //Logger.add("XvmHangar: .ctor()");
            try
            {
                if (stage)
                {
                    init();
                }
                else
                {
                    addEventListener(Event.ADDED_TO_STAGE, init);
                }
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function init(e:Event = null):void
        {
            //Logger.add("XvmHangar: init()");
            removeEventListener(Event.ADDED_TO_STAGE, init);

            // entry point

            try
            {
                Logger.add("[XVM] hangar, current view: " + (App.containerMgr.lastFocusedView ? App.containerMgr.lastFocusedView.as_alias : "None"));

                // init pinger as earlier as possible
                PingServers.initFeature(Config.config.login.pingServers.enabled || Config.config.hangar.pingServers.enabled);

                // view can be already loaded
                var mgr:ContainerManager = App.containerMgr as ContainerManager;
                for each (var c:IManagedContainer in mgr.containersMap)
                {
                    var vc:MainViewContainer = c as MainViewContainer;
                    if (vc != null)
                    {
                        for (var i:int = 0; i < vc.numChildren; ++i)
                        {
                            var v:IView = vc.getChildAt(i) as IView;
                            if (v != null)
                                processView(v, true);
                        }
                    }
                }

                App.containerMgr.loader.addEventListener(LoaderEvent.VIEW_LOADED, onViewLoaded);
            }
            catch (e:*)
            {
                Logger.add(e.getStackTrace());
            }
        }

        private static var _views:Vector.<String> = Vector.<String>([
            "login",
            "lobby",
            "hangar",
            "battleLoading",
            "prb_windows/companiesWindow",
            "prb_windows/companyWindow",
            "prb_windows/squadWindow",
            "battleResults",
            "profile",
            "profileWindow"
        ]);
        private function onViewLoaded(e:LoaderEvent):void
        {
            var alias:String = e.view.as_alias;
            if (_views.indexOf(alias) >= 0)
                Logger.add("View loaded: " + alias);
            processView(e.view);
        }

        private function processView(view:IView, populated:Boolean = false):void
        {
            //Logger.add("Process view: " + view.as_alias + " class=" + getQualifiedClassName(view));
            var mod:IXvmMod = null;
            switch (view.as_alias)
            {
                case "login":
                    mod = new Login(view);
                    break;
                case "lobby":
                    mod = new Lobby(view);
                    break;
                case "hangar":
                    mod = new Hangar(view);
                    break;
                case "battleLoading":
                    mod = new BattleLoading(view);
                    break;
                case "prb_windows/companiesWindow":
                    mod = new CompaniesListWindow(view);
                    break;
                case "prb_windows/companyWindow":
                    mod = new CompanyWindow(view);
                    break;
                case "prb_windows/squadWindow":
                    mod = new SquadWindow(view);
                    break;
                case "battleResults":
                    mod = new BattleResults(view);
                    break;
                case "profile":
                case "profileWindow":
                    mod = new Profile(view);
                    break;
            }
            if (mod != null && populated)
            {
                mod.onBeforePopulate(null);
                mod.onAfterPopulate(null);
            }
        }
    }
}
