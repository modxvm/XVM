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
            "hangar": Hangar
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
