/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.battleloading
{
    import com.xfw.*;
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

        override public function entryPoint():void
        {
            super.entryPoint();
            const _name:String = "xvm_battleloading";
            const _ui_name:String = _name + "_ui.swf";
            const _preloads:Array = [ "battleloading.swf" ];
            Xfw.try_load_ui_swf(_name, _ui_name, _preloads);
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
