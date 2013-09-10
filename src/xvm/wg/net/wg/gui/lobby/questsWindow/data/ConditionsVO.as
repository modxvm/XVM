package net.wg.gui.lobby.questsWindow.data 
{
    import net.wg.data.daapi.base.*;
    
    public class ConditionsVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function ConditionsVO(arg1:Object)
        {
            this._elements = [];
            super(arg1);
            return;
        }

        public function get title():String
        {
            return this._title;
        }

        public function set title(arg1:String):void
        {
            this._title = arg1;
            return;
        }

        public function get elements():Array
        {
            return this._elements;
        }

        public function set elements(arg1:Array):void
        {
            this._elements = arg1;
            return;
        }

        internal var _title:String="";

        internal var _elements:Array;
    }
}
