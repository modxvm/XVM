/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.squad
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;

    public class SquadXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:SQUAD]";
        }

        private static const _views:Object =
        {
            //TODO"prb_windows/squadWindow": SquadXvmView
        }

        /* TODO
        override public function entryPoint():void
        {
            super.entryPoint();
            const _name:String = "xvm_squad";
            const _ui_name:String = _name + "_ui.swf";
            const _preloads:Array = [ "squadWindow.swf" ];
            Xfw.try_load_ui_swf(_name, _ui_name, _preloads);
        }
        */

        public override function get views():Object
        {
            return _views;
        }
    }
}
