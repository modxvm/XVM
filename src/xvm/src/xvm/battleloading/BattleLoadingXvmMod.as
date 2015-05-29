/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.battleloading
{
    import net.wg.infrastructure.interfaces.IView;
    import com.xfw.*;
    import com.xfw.infrastructure.IXfwView;
    import com.xvm.infrastructure.*;

    public class BattleLoadingXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:BL]";
        }

        private static const _views:Object =
        {
            "battleLoading": BattleLoadingXvmView
        }

        override protected function processView(view:IView, populated:Boolean):IXfwView
        {
            // TODO: move to views
            if (view.as_alias == "hangar")
            {
                super.entryPoint();
                const _name:String = "xvm_hangar";
                const _ui_name:String = _name + "_ui.swf";
                const _preloads:Array = [ "battleLoading.swf" ];
                Xfw.try_load_ui_swf(_name, _ui_name, _preloads);
            }
            return super.processView(view, populated);
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
