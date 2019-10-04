package net.wg.gui.lobby.vehiclePreview20.buyingPanel
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.controls.Image;
    import flash.text.TextField;
    import net.wg.gui.lobby.vehiclePreview20.data.VPCompensationVO;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.managers.ITooltipProps;

    public class CompensationPanel extends UIComponentEx
    {

        private static const MAX_TOOLTIP_WIDTH:Number = 350;

        public var iconInfo:Image = null;

        public var descriptionTF:TextField = null;

        public var valueTF:TextField = null;

        private var _data:VPCompensationVO = null;

        public function CompensationPanel()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            mouseEnabled = false;
            this.iconInfo.addEventListener(MouseEvent.MOUSE_OVER,this.onIconInfoMouseOverHandler);
            this.iconInfo.addEventListener(MouseEvent.MOUSE_OUT,this.onIconInfoMouseOutHandler);
            this.iconInfo.addEventListener(Event.CHANGE,this.onIconInfoLoadHandler);
            this.descriptionTF.mouseWheelEnabled = this.descriptionTF.mouseEnabled = false;
            this.descriptionTF.autoSize = TextFieldAutoSize.LEFT;
            this.valueTF.mouseWheelEnabled = this.valueTF.mouseEnabled = false;
            this.valueTF.autoSize = TextFieldAutoSize.LEFT;
        }

        private function onIconInfoLoadHandler(param1:Event) : void
        {
            invalidateSize();
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data != null && isInvalid(InvalidationType.DATA))
            {
                this.iconInfo.source = this._data.iconInfo;
                this.descriptionTF.text = this._data.description;
                this.valueTF.htmlText = this._data.value;
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.descriptionTF.x = this.valueTF.x - this.descriptionTF.width >> 0;
                this.iconInfo.x = this.descriptionTF.x - this.iconInfo.width >> 0;
                dispatchEvent(new Event(Event.RESIZE));
            }
        }

        override protected function onDispose() : void
        {
            this.iconInfo.removeEventListener(MouseEvent.MOUSE_OVER,this.onIconInfoMouseOverHandler);
            this.iconInfo.removeEventListener(MouseEvent.MOUSE_OUT,this.onIconInfoMouseOutHandler);
            this.iconInfo.removeEventListener(Event.CHANGE,this.onIconInfoLoadHandler);
            this.iconInfo.dispose();
            this.iconInfo = null;
            this.descriptionTF = null;
            this.valueTF = null;
            this._data = null;
            super.onDispose();
        }

        public function get contentWidth() : Number
        {
            return this.iconInfo.width + this.descriptionTF.width + this.valueTF.width >> 0;
        }

        public function setData(param1:VPCompensationVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        private function onIconInfoMouseOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }

        private function onIconInfoMouseOverHandler(param1:MouseEvent) : void
        {
            var _loc2_:ITooltipProps = App.toolTipMgr.getDefaultTooltipProps();
            _loc2_ = ITooltipProps(_loc2_.clone());
            _loc2_.maxWidth = MAX_TOOLTIP_WIDTH;
            App.toolTipMgr.showComplex(this._data.tooltip,_loc2_);
        }
    }
}
