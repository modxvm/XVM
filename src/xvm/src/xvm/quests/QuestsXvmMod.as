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
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
