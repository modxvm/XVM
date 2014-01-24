/**
 * XVM
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.crew
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;

    public class CrewXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:CREW]";
        }

        private static const _views:Object =
        {
            "hangar": CrewXvmView
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
