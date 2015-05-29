/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.quests
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;
    import net.wg.infrastructure.interfaces.*;

    public class QuestsXvmView extends XvmViewBase
    {
        private static const _name:String = "xvm_quests";
        private static const _ui_name:String = _name + "_ui.swf";

        public function QuestsXvmView(view:IView)
        {
            super(view);

            Xfw.try_load_ui_swf(_name, _ui_name);
        }
    }
}
