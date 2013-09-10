package net.wg.gui.lobby.techtree.data.vo 
{
    import net.wg.gui.lobby.techtree.interfaces.*;
    import net.wg.utils.*;
    
    public class NationDisplaySettings extends Object implements net.wg.gui.lobby.techtree.interfaces.IValueObject
    {
        public function NationDisplaySettings(arg1:String="", arg2:Boolean=false)
        {
            super();
            this._nodeRendererName = arg1;
            this._isLevelDisplayed = arg2;
            return;
        }

        public function get nodeRendererName():String
        {
            return this._nodeRendererName;
        }

        public function get isLevelDisplayed():Boolean
        {
            return this._isLevelDisplayed;
        }

        public function fromArray(arg1:Array, arg2:net.wg.utils.ILocale):void
        {
            if (arg1.length > 1) 
            {
                this._nodeRendererName = arg1[0] ? arg1[0] : "";
                this._isLevelDisplayed = Boolean(arg1[1]);
            }
            return;
        }

        public function fromObject(arg1:Object, arg2:net.wg.utils.ILocale):void
        {
            if (arg1 == null) 
                return;
            if (arg1.nodeRendererName != null) 
                this._nodeRendererName = arg1.nodeRendererName;
            if (arg1.isLevelDisplayed != null) 
                this._isLevelDisplayed = arg1.isLevelDisplayed;
            return;
        }

        public function toString():String
        {
            return "[NationDisplaySettings: nodeRendererName = " + this._nodeRendererName + ", isLevelDisplayed = " + this._isLevelDisplayed + " ]";
        }

        internal var _nodeRendererName:String;

        internal var _isLevelDisplayed:Boolean;
    }
}
