/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.company
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;

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

        override public function entryPoint():void
        {
            super.entryPoint();
            const _name:String = "xvm_company";
            const _ui_name:String = _name + "_ui.swf";
            const _preloads:Array = [ "prebattleComponents.swf", "companiesListWindow.swf", "companyWindow.swf" ];
            Xfw.load_ui_swf(_name, _ui_name, _preloads);
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
