package net.wg.gui.lobby.window 
{
    import net.wg.data.daapi.base.*;
    
    public class VcoinExchangeDataVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function VcoinExchangeDataVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function set minTransactVal(arg1:uint):void
        {
            this._minTransactVal = arg1;
            return;
        }

        public function set maxTransactVal(arg1:uint):void
        {
            this._maxTransactVal = arg1;
            return;
        }

        public function set countStep(arg1:uint):void
        {
            this._countStep = arg1;
            return;
        }

        public function get minTransactVal():uint
        {
            return this._minTransactVal;
        }

        public function get maxTransactVal():uint
        {
            return this._maxTransactVal;
        }

        public function get countStep():uint
        {
            return this._countStep;
        }

        internal var _minTransactVal:uint;

        internal var _maxTransactVal:uint;

        internal var _countStep:uint;
    }
}
