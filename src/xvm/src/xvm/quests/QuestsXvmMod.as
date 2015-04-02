/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.quests
{
    import com.xvm.*;
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

        public override function get views():Object
        {
            return _views;
        }
    }
}
