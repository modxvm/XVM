package net.wg.gui.lobby.questsWindow.data 
{
    import net.wg.data.daapi.base.*;
    
    public class ConditionElementVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function ConditionElementVO(arg1:Object)
        {
            this._vehicles = [];
            super(arg1);
            return;
        }

        public function get descr():String
        {
            return this._descr;
        }

        public function set descr(arg1:String):void
        {
            this._descr = arg1;
            return;
        }

        public function get vehicles():Array
        {
            return this._vehicles;
        }

        public function set vehicles(arg1:Array):void
        {
            this._vehicles = arg1;
            return;
        }

        internal var _descr:String="";

        internal var _vehicles:Array;
    }
}
