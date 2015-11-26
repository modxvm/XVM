/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.limits
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import net.wg.gui.lobby.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import org.idmedia.as3commons.util.StringUtils;

    public class LimitsXvmView extends XvmViewBase
    {
        private static const _name:String = "xvm_limits";
        private static const _ui_name:String = _name + "_ui.swf";

        private var _initialized:Boolean = false;
        private var limits_ui:ILimitsUI = null;

        public function LimitsXvmView(view:IView)
        {
            //Logger.add("LimitsXvmView");
            super(view);

            Xfw.try_load_ui_swf(_name, _ui_name);
        }

        public function get page():LobbyPage
        {
            return super.view as LobbyPage;
        }

        override public function onAfterPopulate(e:LifeCycleEvent):void
        {
            _initialized = false;

            if (!Config.config.hangar.enableGoldLocker && !Config.config.hangar.enableFreeXpLocker)
                return;

            _initialized = true;

            App.instance.loaderMgr.addEventListener(LibraryLoaderEvent.LOADED, onLibLoaded);

            if (Xfw.try_load_ui_swf(_name, _ui_name) != XfwConst.SWF_START_LOADING)
                init();
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            if (!_initialized)
                return;

            App.instance.loaderMgr.removeEventListener(LibraryLoaderEvent.LOADED, onLibLoaded);
            dispose();
        }

        // PRIVATE

        private function onLibLoaded(e:LibraryLoaderEvent):void
        {
            if (StringUtils.endsWith(e.url.toLowerCase(), _ui_name))
            {
                init();
            }
        }

        private function init():void
        {
            if (!Config.config.hangar.enableGoldLocker && !Config.config.hangar.enableFreeXpLocker)
                return;

            var cls:Class = App.utils.classFactory.getClass("xvm.limits_ui::LimitsUIImpl");
            if (cls)
            {
                limits_ui = new cls() as ILimitsUI;
                if (limits_ui != null)
                {
                    limits_ui.init(page);
                }
            }
        }

        private function dispose():void
        {
            if (limits_ui != null)
            {
                limits_ui.dispose();
            }
        }
    }
}
