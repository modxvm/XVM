/**
 * XVM
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package xvm.techtree
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;

    public class TechTreeXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:TECHTREE]";
        }

        private static const _views:Object =
        {
            // TODO: 0.8.10 "techtree": TechTreeXvmView
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
