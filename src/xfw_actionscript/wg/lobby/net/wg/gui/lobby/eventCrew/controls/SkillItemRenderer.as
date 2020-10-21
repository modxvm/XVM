package net.wg.gui.lobby.eventCrew.controls
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.infrastructure.interfaces.entity.IUpdatable;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.gui.lobby.eventCrew.data.EventBonusItemVO;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import org.idmedia.as3commons.util.StringUtils;

    public class SkillItemRenderer extends UIComponentEx implements IUpdatable
    {

        public var icon:UILoaderAlt = null;

        public var textField:TextField = null;

        public var completed:Sprite = null;

        public var size:Sprite = null;

        private var _toolTipMgr:ITooltipMgr = null;

        private var _data:EventBonusItemVO = null;

        public function SkillItemRenderer()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.icon.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this.icon.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this.icon.dispose();
            this.icon = null;
            this.textField = null;
            this.completed = null;
            this.size = null;
            this._data = null;
            this._toolTipMgr = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._toolTipMgr = App.toolTipMgr;
            this.completed.visible = false;
            this.icon.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this.icon.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data != null && isInvalid(InvalidationType.DATA))
            {
                if(this._data.icon)
                {
                    this.icon.source = this._data.icon;
                }
                else
                {
                    this.icon.unload();
                }
                this.textField.text = this._data.label;
                this.completed.visible = this._data.completed && this._data.icon;
            }
        }

        public function update(param1:Object) : void
        {
            this._data = EventBonusItemVO(param1);
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

        override public function get width() : Number
        {
            return this.size.width;
        }

        override public function get height() : Number
        {
            return this.size.height;
        }
    }
}
