package net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet
{
    import net.wg.infrastructure.base.UIComponentEx;
    import scaleform.clik.interfaces.IListItemRenderer;
    import net.wg.gui.lobby.vehicleCustomization.controls.slotsGroup.ICustomizationSlot;
    import net.wg.infrastructure.interfaces.entity.IUpdatable;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.Image;
    import net.wg.gui.lobby.vehicleCustomization.data.propertiesSheet.CustomizationPropertiesSheetStyleRendererVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.data.ListData;
    import scaleform.clik.core.UIComponent;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;

    public class CustomizationSheetStyleItemRenderer extends UIComponentEx implements IListItemRenderer, ICustomizationSlot, IUpdatable
    {

        public var border:MovieClip = null;

        public var imgIcon:Image = null;

        private var _model:CustomizationPropertiesSheetStyleRendererVO = null;

        private var _toolTipMgr:ITooltipMgr;

        public function CustomizationSheetStyleItemRenderer()
        {
            this._toolTipMgr = App.toolTipMgr;
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this.imgIcon.addEventListener(Event.CHANGE,this.onImageChangeHandler);
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._model != null && isInvalid(InvalidationType.DATA))
            {
                this.imgIcon.source = this._model.image;
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.border.width = this.imgIcon.width = _width;
                this.border.height = this.imgIcon.height = _height;
            }
        }

        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this.imgIcon.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
            this.imgIcon.dispose();
            this.imgIcon = null;
            this.border = null;
            this._model = null;
            this._toolTipMgr = null;
            super.onDispose();
        }

        public function getData() : Object
        {
            return this._model;
        }

        public function isWide() : Boolean
        {
            return this._model.isWide;
        }

        public function setData(param1:Object) : void
        {
            this._model = CustomizationPropertiesSheetStyleRendererVO(param1);
            invalidateData();
        }

        public function setListData(param1:ListData) : void
        {
        }

        public function update(param1:Object) : void
        {
            this.setData(param1);
        }

        public function get index() : uint
        {
            return 0;
        }

        public function set index(param1:uint) : void
        {
        }

        public function get owner() : UIComponent
        {
            return null;
        }

        public function set owner(param1:UIComponent) : void
        {
        }

        public function get selectable() : Boolean
        {
            return false;
        }

        public function set selectable(param1:Boolean) : void
        {
        }

        public function get selected() : Boolean
        {
            return false;
        }

        public function set selected(param1:Boolean) : void
        {
        }

        private function onImageChangeHandler(param1:Event) : void
        {
            invalidateSize();
        }

        private function onRollOverHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TECH_CUSTOMIZATION_ITEM,null,this._model.intCD,false,false,this._model.specialArgs);
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }
    }
}
