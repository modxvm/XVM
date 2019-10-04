package net.wg.gui.lobby.premiumWindow
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.text.TextField;
    import net.wg.gui.components.controls.TileList;
    import net.wg.gui.components.controls.ScrollBar;
    import scaleform.clik.events.ListEvent;
    import net.wg.gui.lobby.premiumWindow.data.PremiumWindowRatesVO;
    import org.idmedia.as3commons.util.StringUtils;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.premiumWindow.data.PremiumItemRendererVo;
    import scaleform.clik.interfaces.IDataProvider;
    import scaleform.gfx.MouseEventEx;
    import net.wg.gui.lobby.premiumWindow.events.PremiumWindowEvent;

    public class PremiumBody extends UIComponentEx
    {

        public var headerTf:TextField = null;

        public var premList:TileList = null;

        public var scrollBar:ScrollBar = null;

        private var _headerTfTooltip:String = null;

        private var _selectedRateId:String = "";

        private var _lastSelectedItem:String;

        public function PremiumBody()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.premList.removeEventListener(ListEvent.INDEX_CHANGE,this.onPremListIndexChangeHandler);
            this.premList.removeEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.onPremListItemDoubleClickHandler);
            this.setHeaderTfListeners(false);
            this.scrollBar.dispose();
            this.scrollBar = null;
            this.headerTf = null;
            this.premList.dispose();
            this.premList = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.premList.addEventListener(ListEvent.INDEX_CHANGE,this.onPremListIndexChangeHandler);
            this.premList.addEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.onPremListItemDoubleClickHandler);
        }

        public function getSelectedRate() : String
        {
            return this._selectedRateId;
        }

        public function setData(param1:PremiumWindowRatesVO) : void
        {
            this.headerTf.htmlText = param1.header;
            this._headerTfTooltip = param1.headerTooltip;
            this.setHeaderTfListeners(StringUtils.isNotEmpty(this._headerTfTooltip));
            this._selectedRateId = this.getSelectedRateId(param1.selectedRateId);
            this.premList.dataProvider = param1.rates;
            this.premList.selectedIndex = this.getSelectedRateIndexById(this._selectedRateId);
        }

        private function setHeaderTfListeners(param1:Boolean) : void
        {
            if(param1)
            {
                this.headerTf.addEventListener(MouseEvent.ROLL_OVER,this.onHeaderTfRollOverHandler);
                this.headerTf.addEventListener(MouseEvent.ROLL_OUT,this.onHeaderTfRollOutHandler);
            }
            else
            {
                this.headerTf.removeEventListener(MouseEvent.ROLL_OVER,this.onHeaderTfRollOverHandler);
                this.headerTf.removeEventListener(MouseEvent.ROLL_OUT,this.onHeaderTfRollOutHandler);
            }
        }

        private function getSelectedRateId(param1:String) : String
        {
            var _loc2_:PremiumItemRendererVo = null;
            if(this._lastSelectedItem)
            {
                for each(_loc2_ in this.premList.dataProvider)
                {
                    if(_loc2_.id == this._lastSelectedItem && _loc2_.enabled)
                    {
                        return this._lastSelectedItem;
                    }
                }
            }
            return param1;
        }

        private function getSelectedRateIndexById(param1:String) : int
        {
            var _loc2_:* = -1;
            var _loc3_:IDataProvider = this.premList.dataProvider;
            var _loc4_:Number = _loc3_.length;
            var _loc5_:Number = 0;
            while(_loc5_ < _loc4_)
            {
                if(param1 == PremiumItemRendererVo(_loc3_[_loc5_]).id)
                {
                    _loc2_ = _loc5_;
                    break;
                }
                _loc5_++;
            }
            return _loc2_;
        }

        private function onHeaderTfRollOverHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.showComplex(this._headerTfTooltip);
        }

        private function onHeaderTfRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }

        private function onPremListIndexChangeHandler(param1:ListEvent) : void
        {
            var _loc2_:PremiumItemRendererVo = PremiumItemRendererVo(param1.itemData);
            if(_loc2_ != null)
            {
                this._selectedRateId = this._lastSelectedItem = _loc2_.id;
            }
        }

        private function onPremListItemDoubleClickHandler(param1:ListEvent) : void
        {
            if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
            {
                if(param1.itemRenderer.enabled)
                {
                    dispatchEvent(new PremiumWindowEvent(PremiumWindowEvent.PREMIUM_RENDERER_DOUBLE_CLICK));
                }
            }
        }
    }
}
