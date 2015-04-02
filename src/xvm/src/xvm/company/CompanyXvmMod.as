/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.company
{
    import com.xfw.*;
    import com.xfw.infrastructure.*;

    public class CompanyXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:COMPANY]";
        }

        private static const _views:Object =
        {
            "prb_windows/companyWindow": CompanyXvmView
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
