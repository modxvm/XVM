package net.wg.gui.lobby.eventShopConfirmation.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.infrastructure.interfaces.entity.IUpdatable;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.lobby.eventShopConfirmation.data.ConfirmationRewardVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.events.MouseEvent;
    import net.wg.gui.events.UILoaderEvent;
    import scaleform.clik.constants.InvalidationType;
    import org.idmedia.as3commons.util.StringUtils;

    public class ConfirmationRewardRenderer extends UIComponentEx implements IUpdatable
    {

        public static const SIZE:int = 154;

        public var textField:TextField = null;

        public var icon:UILoaderAlt = null;

        private var _data:ConfirmationRewardVO = null;

        private var _tooltipMgr:ITooltipMgr;

        public function ConfirmationRewardRenderer()
        {
            this._tooltipMgr = App.toolTipMgr;
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.icon.x = SIZE - this.icon.width >> 1;
                this.icon.y = -this.icon.height >> 1;
            }
            if(this._data != null && isInvalid(InvalidationType.DATA))
            {
                this.textField.text = this._data.label;
                App.utils.commons.updateTextFieldSize(this.textField,true,false);
                this.textField.x = SIZE - this.textField.width >> 1;
                this.icon.source = this._data.icon;
            }
        }

        public function update(param1:Object) : void
        {
            this._data = ConfirmationRewardVO(param1);
            invalidateData();
        }

        override protected function onBeforeDispose() : void
        {
            this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.textField = null;
            this.icon.dispose();
            this.icon = null;
            this._data = null;
            this._tooltipMgr = null;
            super.onDispose();
        }

        private function onRollOverHandler(param1:MouseEvent) : void
        {
            if(this._data != null)
            {
                if(StringUtils.isNotEmpty(this._data.tooltip))
                {
                    this._tooltipMgr.showComplex(this._data.tooltip);
                }
                else
                {
                    this._tooltipMgr.showSpecial.apply(this._tooltipMgr,[this._data.specialAlias,null].concat(this._data.specialArgs));
                }
            }
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.hide();
        }

        private function onIconCompleteHandler(param1:UILoaderEvent) : void
        {
            invalidateSize();
        }
    }
}
