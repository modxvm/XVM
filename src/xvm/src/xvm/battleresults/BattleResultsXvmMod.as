/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.battleresults
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;

    public class BattleResultsXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:BR]";
        }

        private static const _views:Object =
        {
            "battleResults": BattleResultsXvmView
        }

        override public function entryPoint():void
        {
            super.entryPoint();
            const _name:String = "xvm_battleresults";
            const _ui_name:String = _name + "_ui.swf";
            const _preloads:Array = [ "battleResults.swf" ];
            Xfw.try_load_ui_swf(_name, _ui_name, _preloads);
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
