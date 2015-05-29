/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.quests
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;
    import net.wg.gui.lobby.questsWindow.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class QuestsXvmView extends XvmViewBase
    {

        public function QuestsXvmView(view:IView)
        {
            super(view);
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            const _name:String = "xvm_quests";
            const _ui_name:String = _name + "_ui.swf";
            Xfw.load_ui_swf(_name, _ui_name);
        }
    }
}
