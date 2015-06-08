/**
 * XVM - hangar
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.tcarousel
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;
    import net.wg.gui.lobby.hangar.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class TCarouselXvmView extends XvmViewBase
    {
        public function TCarouselXvmView(view:IView)
        {
            super(view);
        }

        public function get page():net.wg.gui.lobby.hangar.Hangar
        {
            return super.view as net.wg.gui.lobby.hangar.Hangar;
        }

        override public function onBeforePopulate(e:LifeCycleEvent):void
        {
            const _name:String = "xvm_tcarousel";
            const _ui_name:String = _name + "_ui.swf";
            Xfw.try_load_ui_swf(_name, _ui_name);
       }
    }
}
