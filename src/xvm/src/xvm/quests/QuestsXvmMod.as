/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.quests
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;

    public class QuestsXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:QUESTS]";
        }

        private static const _views:Object =
        {
            "EventsWindow": QuestsXvmView
        }

        override public function entryPoint():void
        {
            super.entryPoint();
            const _name:String = "xvm_quests";
            const _ui_name:String = _name + "_ui.swf";
            const _preloads:Array = [ "questsWindow.swf" ];
            Xfw.load_ui_swf(_name, _ui_name, _preloads);
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
