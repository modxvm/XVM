package net.wg.gui.lobby.techtree.data.vo
{
    import net.wg.gui.lobby.techtree.interfaces.IValueObject;
    import net.wg.utils.ILocale;
    
    public class NationDisplaySettings extends Object implements IValueObject
    {
        
        public function NationDisplaySettings(param1:String = "", param2:Boolean = false) {
            super();
            this._nodeRendererName = param1;
            this._isLevelDisplayed = param2;
        }
        
        private var _nodeRendererName:String;
        
        private var _isLevelDisplayed:Boolean;
        
        public function get nodeRendererName() : String {
            return this._nodeRendererName;
        }
        
        public function get isLevelDisplayed() : Boolean {
            return this._isLevelDisplayed;
        }
        
        public function fromArray(param1:Array, param2:ILocale) : void {
            if(param1.length > 1)
            {
                this._nodeRendererName = param1[0]?param1[0]:"";
                this._isLevelDisplayed = Boolean(param1[1]);
            }
        }
        
        public function fromObject(param1:Object, param2:ILocale) : void {
            if(param1 == null)
            {
                return;
            }
            if(param1.nodeRendererName != null)
            {
                this._nodeRendererName = param1.nodeRendererName;
            }
            if(param1.isLevelDisplayed != null)
            {
                this._isLevelDisplayed = param1.isLevelDisplayed;
            }
        }
        
        public function toString() : String {
            return "[NationDisplaySettings: nodeRendererName = " + this._nodeRendererName + ", isLevelDisplayed = " + this._isLevelDisplayed + " ]";
        }
    }
}
