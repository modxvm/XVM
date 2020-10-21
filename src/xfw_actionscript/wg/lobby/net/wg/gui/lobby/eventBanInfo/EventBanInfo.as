package net.wg.gui.lobby.eventBanInfo
{
    import net.wg.infrastructure.base.meta.impl.EventBanInfoMeta;
    import net.wg.infrastructure.base.meta.IEventBanInfoMeta;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.lobby.eventBanInfo.data.EventBanInfoVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.utils.ICommons;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import org.idmedia.as3commons.util.StringUtils;

    public class EventBanInfo extends EventBanInfoMeta implements IEventBanInfoMeta
    {

        private static const ICON_LEFT_PADDING:int = -10;

        private static const SHADOW_DISTANCE:int = 0;

        private static const SHADOW_ANGLE:int = 90;

        private static const SHADOW_COLOR:uint = 9831174;

        private static const SHADOW_ALPHA:int = 1;

        private static const SHADOW_BLUR:int = 12;

        private static const SHADOW_STRENGTH:Number = 1.8;

        private static const SHADOW_QUALITY:int = 2;

        public var textField:TextField = null;

        public var banIcon:Sprite = null;

        private var _data:EventBanInfoVO = null;

        private var _toolTipMgr:ITooltipMgr = null;

        private var _commons:ICommons = null;

        public function EventBanInfo()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this._toolTipMgr = App.toolTipMgr;
            this._commons = App.utils.commons;
            this._commons.setShadowFilterWithParams(this.textField,SHADOW_DISTANCE,SHADOW_ANGLE,SHADOW_COLOR,SHADOW_ALPHA,SHADOW_BLUR,SHADOW_BLUR,SHADOW_STRENGTH,SHADOW_QUALITY);
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                this.textField.text = this._data.description;
                this._commons.updateTextFieldSize(this.textField,true,false);
                this.textField.x = width - this.textField.width >> 1;
                this.banIcon.x = this.textField.x + this.textField.width + ICON_LEFT_PADDING | 0;
            }
        }

        override protected function onDispose() : void
        {
            this._toolTipMgr = null;
            this._commons = null;
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this.banIcon = null;
            this.textField = null;
            this._data = null;
            super.onDispose();
        }

        override protected function setEventBanInfo(param1:EventBanInfoVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        public function as_setVisible(param1:Boolean) : void
        {
            visible = param1;
        }

        private function onRollOverHandler(param1:MouseEvent) : void
        {
            if(this._data == null)
            {
                return;
            }
            if(StringUtils.isNotEmpty(this._data.tooltip))
            {
                this._toolTipMgr.showComplex(this._data.tooltip);
            }
            else
            {
                this._toolTipMgr.showSpecial.apply(this._toolTipMgr,[this._data.specialAlias,null].concat(this._data.specialArgs));
            }
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }
    }
}
