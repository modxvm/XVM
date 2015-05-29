/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.hangar
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;

    public class HangarXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:HANGAR]";
        }

        private static const _views:Object =
        {
            "login": Login,
            "lobby": Lobby,
            "hangar": Hangar,
            "battleLoading": BattleLoading,
            "battleResults": BattleResults
        }

        override public function entryPoint():void
        {
            super.entryPoint();
            const _name:String = "xvm_hangar";
            const _ui_name:String = _name + "_ui.swf";
            const _preloads:Array = [ "battleLoading.swf", "battleResults.swf" ];
            Xfw.try_load_ui_swf(_name, _ui_name, _preloads);
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
