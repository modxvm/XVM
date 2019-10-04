package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.SmartPopOverView;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.lobby.header.itemSelectorPopover.ItemSelectorRendererVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class BattleTypeSelectPopoverMeta extends SmartPopOverView
    {

        public var selectFight:Function;

        public var demoClick:Function;

        public var getTooltipData:Function;

        private var _dataProviderItemSelectorRendererVO:DataProvider;

        public function BattleTypeSelectPopoverMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            var _loc1_:ItemSelectorRendererVO = null;
            if(this._dataProviderItemSelectorRendererVO)
            {
                for each(_loc1_ in this._dataProviderItemSelectorRendererVO)
                {
                    _loc1_.dispose();
                }
                this._dataProviderItemSelectorRendererVO.cleanUp();
                this._dataProviderItemSelectorRendererVO = null;
            }
            super.onDispose();
        }

        public function selectFightS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.selectFight,"selectFight" + Errors.CANT_NULL);
            this.selectFight(param1);
        }

        public function demoClickS() : void
        {
            App.utils.asserter.assertNotNull(this.demoClick,"demoClick" + Errors.CANT_NULL);
            this.demoClick();
        }

        public function getTooltipDataS(param1:String, param2:Boolean) : Object
        {
            App.utils.asserter.assertNotNull(this.getTooltipData,"getTooltipData" + Errors.CANT_NULL);
            return this.getTooltipData(param1,param2);
        }

        public final function as_update(param1:Array, param2:Boolean, param3:Boolean) : void
        {
            var _loc7_:ItemSelectorRendererVO = null;
            var _loc4_:DataProvider = this._dataProviderItemSelectorRendererVO;
            this._dataProviderItemSelectorRendererVO = new DataProvider();
            var _loc5_:uint = param1.length;
            var _loc6_:* = 0;
            while(_loc6_ < _loc5_)
            {
                this._dataProviderItemSelectorRendererVO[_loc6_] = new ItemSelectorRendererVO(param1[_loc6_]);
                _loc6_++;
            }
            this.update(this._dataProviderItemSelectorRendererVO,param2,param3);
            if(_loc4_)
            {
                for each(_loc7_ in _loc4_)
                {
                    _loc7_.dispose();
                }
                _loc4_.cleanUp();
            }
        }

        protected function update(param1:DataProvider, param2:Boolean, param3:Boolean) : void
        {
            var _loc4_:String = "as_update" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc4_);
            throw new AbstractException(_loc4_);
        }
    }
}
