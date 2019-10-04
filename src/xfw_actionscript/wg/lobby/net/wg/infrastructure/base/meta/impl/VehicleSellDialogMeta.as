package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.gui.lobby.vehicleTradeWnds.sell.vo.SellDialogVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class VehicleSellDialogMeta extends AbstractWindowView
    {

        public var setDialogSettings:Function;

        public var sell:Function;

        public var setUserInput:Function;

        public var setResultCredit:Function;

        public var checkControlQuestion:Function;

        public var onChangeConfiguration:Function;

        private var _sellDialogVO:SellDialogVO;

        public function VehicleSellDialogMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._sellDialogVO)
            {
                this._sellDialogVO.dispose();
                this._sellDialogVO = null;
            }
            super.onDispose();
        }

        public function setDialogSettingsS(param1:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.setDialogSettings,"setDialogSettings" + Errors.CANT_NULL);
            this.setDialogSettings(param1);
        }

        public function sellS(param1:Object, param2:Array, param3:Array, param4:Array, param5:Array, param6:Array, param7:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.sell,"sell" + Errors.CANT_NULL);
            this.sell(param1,param2,param3,param4,param5,param6,param7);
        }

        public function setUserInputS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.setUserInput,"setUserInput" + Errors.CANT_NULL);
            this.setUserInput(param1);
        }

        public function setResultCreditS(param1:Boolean, param2:int) : void
        {
            App.utils.asserter.assertNotNull(this.setResultCredit,"setResultCredit" + Errors.CANT_NULL);
            this.setResultCredit(param1,param2);
        }

        public function checkControlQuestionS(param1:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.checkControlQuestion,"checkControlQuestion" + Errors.CANT_NULL);
            this.checkControlQuestion(param1);
        }

        public function onChangeConfigurationS(param1:Array) : void
        {
            App.utils.asserter.assertNotNull(this.onChangeConfiguration,"onChangeConfiguration" + Errors.CANT_NULL);
            this.onChangeConfiguration(param1);
        }

        public final function as_setData(param1:Object) : void
        {
            var _loc2_:SellDialogVO = this._sellDialogVO;
            this._sellDialogVO = new SellDialogVO(param1);
            this.setData(this._sellDialogVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setData(param1:SellDialogVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
