package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.infrastructure.interfaces.entity.IUpdatable;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.gui.lobby.eventBattleResult.data.RewardItemVO;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import org.idmedia.as3commons.util.StringUtils;

    public class RewardItemRenderer extends UIComponentEx implements IUpdatable
    {

        public var icon:UILoaderAlt = null;

        public var takenIcon:MovieClip = null;

        public var countField:TextField = null;

        public var overlayType:MovieClip = null;

        public var highlightType:MovieClip = null;

        private var _toolTipMgr:ITooltipMgr = null;

        private var _data:RewardItemVO = null;

        public function RewardItemRenderer()
        {
            super();
        }

        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this.icon.dispose();
            this.icon = null;
            this.countField = null;
            this.takenIcon = null;
            this.overlayType = null;
            this.highlightType = null;
            this._data = null;
            this._toolTipMgr = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._toolTipMgr = App.toolTipMgr;
            mouseChildren = false;
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            if(this.overlayType != null)
            {
                this.overlayType.mouseEnabled = this.overlayType.mouseChildren = false;
            }
            if(this.highlightType != null)
            {
                this.highlightType.mouseEnabled = this.highlightType.mouseChildren = false;
            }
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data != null && isInvalid(InvalidationType.DATA))
            {
                this.icon.source = this._data.icon;
                this.countField.text = this._data.value;
                if(this.overlayType != null && StringUtils.isNotEmpty(this._data.overlayType))
                {
                    this.overlayType.gotoAndStop(this._data.overlayType);
                }
                if(this.highlightType != null && StringUtils.isNotEmpty(this._data.highlightType))
                {
                    this.highlightType.gotoAndStop(this._data.highlightType);
                }
            }
        }

        public function appear() : void
        {
            if(this.takenIcon)
            {
                this.countField.alpha = 0;
                this.takenIcon.visible = true;
            }
        }

        public function update(param1:Object) : void
        {
            this._data = RewardItemVO(param1);
            invalidateData();
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
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
    }
}
