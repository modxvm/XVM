package net.wg.gui.lobby.window
{
    import net.wg.infrastructure.base.meta.impl.BoosterBuyWindowMeta;
    import net.wg.infrastructure.base.meta.IBoosterBuyWindowMeta;
    import scaleform.clik.utils.Padding;
    import net.wg.gui.data.BoosterBuyWindowVO;
    import net.wg.gui.data.BoosterBuyWindowUpdateVO;
    import net.wg.infrastructure.interfaces.IWindow;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.Event;
    import scaleform.clik.constants.InvalidationType;
    import flash.display.InteractiveObject;
    import net.wg.gui.components.windows.Window;

    public class BoosterBuyWindow extends BoosterBuyWindowMeta implements IBoosterBuyWindowMeta
    {

        private static const PADDING:Padding = new Padding(55,13,16,32);

        private static const INVALID_ITEM_PRICE:String = "invalidItemPriceData";

        public var content:BoosterBuyContent = null;

        private var _data:BoosterBuyWindowVO = null;

        private var _dataUpdate:BoosterBuyWindowUpdateVO = null;

        public function BoosterBuyWindow()
        {
            super();
            isCentered = true;
        }

        override public function setWindow(param1:IWindow) : void
        {
            super.setWindow(param1);
            if(param1)
            {
                param1.useBottomBtns = true;
                param1.contentPadding = PADDING;
            }
        }

        override protected function onDispose() : void
        {
            this.content.submitBtn.removeEventListener(ButtonEvent.CLICK,this.onSubmitBtnClickHandler);
            this.content.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler);
            this.content.rearmCheckbox.removeEventListener(Event.SELECT,this.onRearmCheckboxSelectHandler);
            this.content.removeEventListener(BoosterBuyContent.LAYOUT_CHANGED,this.onContentLayoutChangedHandler);
            this.content.dispose();
            this.content = null;
            this._data = null;
            this._dataUpdate = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                window.title = this._data.windowTitle;
                this.content.setInitData(this._data);
            }
            if(this._dataUpdate && isInvalid(INVALID_ITEM_PRICE))
            {
                this.content.updateItemPrice(this._dataUpdate);
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.content.addEventListener(BoosterBuyContent.LAYOUT_CHANGED,this.onContentLayoutChangedHandler);
            this.content.submitBtn.addEventListener(ButtonEvent.CLICK,this.onSubmitBtnClickHandler);
            this.content.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler);
            this.content.rearmCheckbox.addEventListener(Event.SELECT,this.onRearmCheckboxSelectHandler);
            this.moveFocusToButton();
        }

        override protected function setInitData(param1:BoosterBuyWindowVO) : void
        {
            this._data = BoosterBuyWindowVO(param1);
            invalidateData();
        }

        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            this.moveFocusToButton();
        }

        override protected function updateData(param1:BoosterBuyWindowUpdateVO) : void
        {
            this._dataUpdate = param1;
            invalidate(INVALID_ITEM_PRICE);
        }

        public function moveFocusToButton() : void
        {
            setFocus(this.content.submitBtn);
        }

        override public function get height() : Number
        {
            return this.content.height;
        }

        private function onRearmCheckboxSelectHandler(param1:Event) : void
        {
            setAutoRearmS(this.content.rearmCheckbox.selected);
        }

        private function onContentLayoutChangedHandler(param1:Event) : void
        {
            window.invalidate(Window.INVALID_SRC_VIEW);
        }

        private function onCancelBtnClickHandler(param1:ButtonEvent) : void
        {
            onWindowCloseS();
        }

        private function onSubmitBtnClickHandler(param1:ButtonEvent) : void
        {
            buyS(this.content.countNumStepper.value - this._dataUpdate.itemCount);
        }
    }
}
