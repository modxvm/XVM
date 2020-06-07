package net.wg.gui.components.carousels.controls
{
    import net.wg.infrastructure.base.UIComponentEx;
    import scaleform.clik.interfaces.IListItemRenderer;
    import net.wg.gui.components.controls.RadioButton;
    import net.wg.gui.components.carousels.data.BaseRendererVO;
    import scaleform.clik.events.ButtonEvent;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.data.ListData;
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.controls.events.RendererEvent;

    public class RadioButtonRenderer extends UIComponentEx implements IListItemRenderer
    {

        public var btn:RadioButton = null;

        private var _rendererData:BaseRendererVO = null;

        private var _index:uint = 0;

        private var _selectable:Boolean = true;

        public function RadioButtonRenderer()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.btn.addEventListener(ButtonEvent.CLICK,this.onBtnClickHandler);
            this.btn.autoSize = TextFieldAutoSize.LEFT;
        }

        override protected function onDispose() : void
        {
            this.btn.removeEventListener(ButtonEvent.CLICK,this.onBtnClickHandler);
            this.btn.dispose();
            this.btn = null;
            this._rendererData = null;
            super.onDispose();
        }

        public function getData() : Object
        {
            return this._rendererData;
        }

        public function setData(param1:Object) : void
        {
            if(param1 != null)
            {
                this._rendererData = BaseRendererVO(param1);
                this.btn.label = this._rendererData.label;
                this.btn.selected = this._rendererData.selected;
                visible = this._rendererData.visible;
            }
            else
            {
                this._rendererData = null;
                visible = false;
            }
        }

        public function setListData(param1:ListData) : void
        {
            this.index = param1.index;
            this.selected = param1.selected;
        }

        public function get index() : uint
        {
            return this._index;
        }

        public function set index(param1:uint) : void
        {
            this._index = param1;
        }

        public function get selectable() : Boolean
        {
            return this._selectable;
        }

        public function set selectable(param1:Boolean) : void
        {
            this._selectable = param1;
        }

        public function get owner() : UIComponent
        {
            return this.btn.owner;
        }

        public function set owner(param1:UIComponent) : void
        {
            this.btn.owner = param1;
        }

        public function get selected() : Boolean
        {
            return this.btn.selected;
        }

        public function set selected(param1:Boolean) : void
        {
            this.btn.selected = param1;
        }

        private function onBtnClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new RendererEvent(RendererEvent.ITEM_CLICK,this._index,true));
        }
    }
}
