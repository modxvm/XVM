/**
 * XVM
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package xvm.company
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;

    public class CompanyXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:COMPANY]";
        }

        private static const _views:Object =
        {
            "prb_windows/companiesWindow": CompaniesListWindowXvmView,
            "prb_windows/companyWindow": CompanyWindowXvmView
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
