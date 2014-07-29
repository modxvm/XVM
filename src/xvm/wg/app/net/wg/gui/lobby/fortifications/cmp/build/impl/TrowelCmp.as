package net.wg.gui.lobby.fortifications.cmp.build.impl
{
    import net.wg.gui.lobby.fortifications.cmp.base.impl.FortBuildingBase;
    import flash.text.TextField;
    
    public class TrowelCmp extends FortBuildingBase
    {
        
        public function TrowelCmp()
        {
            super();
        }
        
        public var trowelLbl:TextField = null;
        
        private var _label:String = "";
        
        override public function setState(param1:String) : void
        {
            super.setState(param1);
            this.trowelLbl.text = this._label;
        }
        
        public function set label(param1:String) : void
        {
            this._label = App.utils.locale.makeString(param1);
        }
    }
}
