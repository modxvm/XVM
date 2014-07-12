package net.wg.gui.lobby.profile.components
{
    import net.wg.gui.components.advanced.LineDescrIconText;
    import net.wg.data.managers.IToolTipParams;
    
    public class AdvancedLineDescrIconText extends LineDescrIconText
    {
        
        public function AdvancedLineDescrIconText() {
            super();
        }
        
        private var _toolTipParams:IToolTipParams;
        
        private var _data:ILditInfo;
        
        override protected function showToolTip(param1:IToolTipParams) : void {
            if((tooltip) && (this._toolTipParams))
            {
                App.toolTipMgr.showComplexWithParams(tooltip,this._toolTipParams);
            }
            else
            {
                super.showToolTip(param1);
            }
        }
        
        public function set toolTipParams(param1:IToolTipParams) : void {
            this._toolTipParams = param1;
        }
        
        public function get data() : ILditInfo {
            return this._data;
        }
        
        public function set data(param1:ILditInfo) : void {
            this._data = param1;
            description = param1.description;
            if(param1.text != "-1")
            {
                enabled = true;
                text = param1.text;
            }
            else
            {
                enabled = false;
            }
            tooltip = param1.tooltip;
            this.toolTipParams = param1.toolTipParams;
            iconSource = param1.iconPath;
        }
        
        override protected function onDispose() : void {
            if(this._data)
            {
                this._data.dispose();
            }
            this._data = null;
            if(this._toolTipParams)
            {
                this._toolTipParams.dispose();
            }
            this._toolTipParams = null;
            super.onDispose();
        }
    }
}
