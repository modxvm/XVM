/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.techtree
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;

    public class TechTreeXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:TECHTREE]";
        }

        private static const _views:Object =
        {
            "techtree": TechTreeXvmView,
            "research": ResearchXvmView
        }

        override public function entryPoint():void
        {
            super.entryPoint();
            const _name:String = "xvm_techtree";
            const _ui_name:String = _name + "_ui.swf";
            const _preloads:Array = [ "nodesLib.swf" ];
            Xfw.load_ui_swf(_name, _ui_name, _preloads);
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
