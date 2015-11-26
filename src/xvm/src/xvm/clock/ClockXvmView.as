/**
 * XVM - clock
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.clock
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import flash.events.*;
    import net.wg.gui.lobby.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import org.idmedia.as3commons.util.StringUtils;

    public class ClockXvmView extends XvmViewBase
    {
        private static const _name:String = "xvm_clock";
        private static const _ui_name:String = _name + "_ui.swf";

        private var _initialized:Boolean = false;
        private var clock_ui:IClockUI = null;

        public function ClockXvmView(view:IView)
        {
            super(view);
        }

        public function get page():LobbyPage
        {
            return super.view as LobbyPage;
        }

        override public function onAfterPopulate(e:LifeCycleEvent):void
        {
            _initialized = false;

            if (!Config.config.hangar.clock.enabled)
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

        override public function onConfigLoaded(e:Event):void
        {
            if (clock_ui != null)
            {
                dispose();
                init();
            }
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
            var cls:Class = App.utils.classFactory.getClass("xvm.clock_ui::ClockUIImpl");
            if (cls)
            {
                clock_ui = new cls() as IClockUI;
                if (clock_ui != null)
                {
                    clock_ui.init(page);
                }
            }
        }

        private function dispose():void
        {
            if (clock_ui != null)
            {
                clock_ui.dispose();
                clock_ui = null;
            }
        }
    }
}
