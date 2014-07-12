package net.wg.gui.lobby.profile.components
{
    import net.wg.gui.components.advanced.LineDescrIconText;
    import net.wg.data.managers.IToolTipParams;
    import net.wg.data.managers.impl.ToolTipParams;
    
    public class LditValued extends LineDescrIconText
    {
        
        public function LditValued() {
            super();
        }
        
        private var _value:String;
        
        override protected function showToolTip(param1:IToolTipParams) : void {
            var _loc2_:Object = null;
            if(tooltip)
            {
                if(this._value)
                {
                    _loc2_ = {"value_0":"<b>" + this._value + "</b>"};
                }
                App.toolTipMgr.showComplexWithParams(tooltip,new ToolTipParams({},_loc2_));
            }
        }
        
        public function set value(param1:*) : void {
            this._value = param1;
        }
    }
}
