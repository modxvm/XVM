package net.wg.gui.prebattle.battleSession 
{
    import net.wg.data.daapi.base.*;
    
    public class BSListRendererVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function BSListRendererVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get prbID():Number
        {
            return this._prbID;
        }

        public function set prbID(arg1:Number):void
        {
            this._prbID = arg1;
            return;
        }

        public function get prbType():Number
        {
            return this._prbType;
        }

        public function set prbType(arg1:Number):void
        {
            this._prbType = arg1;
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

        public function get opponents():String
        {
            return this._opponents;
        }

        public function set opponents(arg1:String):void
        {
            this._opponents = arg1;
            return;
        }

        public function get startTime():String
        {
            return this._startTime;
        }

        public function set startTime(arg1:String):void
        {
            this._startTime = arg1;
            return;
        }

        internal var _prbID:Number;

        internal var _prbType:Number;

        internal var _descr:String="";

        internal var _opponents:String="";

        internal var _startTime:String="";
    }
}
