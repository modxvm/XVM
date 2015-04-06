/**
 * XVM
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.widgets
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;

    public class WidgetsXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:WIDGETS]";
        }

        private static const _views:Object =
        {
            //"login": WidgetsXvmView,
            //"lobby": WidgetsXvmView
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
