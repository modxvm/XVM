package net.wg.gui.lobby.eventQuests.controls
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.infrastructure.interfaces.entity.IUpdatable;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.gui.lobby.eventQuests.data.QuestItemVO;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import org.idmedia.as3commons.util.StringUtils;

    public class RewardItemRenderer extends UIComponentEx implements IUpdatable
    {

        public var icon:UILoaderAlt = null;

        public var countField:TextField = null;

        public var valueField:TextField = null;

        private var _toolTipMgr:ITooltipMgr = null;

        private var _data:QuestItemVO = null;

        public function RewardItemRenderer()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.icon.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this.icon.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this.icon.dispose();
            this.icon = null;
            this.countField = null;
            this.valueField = null;
            this._data = null;
            this._toolTipMgr = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._toolTipMgr = App.toolTipMgr;
            this.icon.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this.icon.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data != null && isInvalid(InvalidationType.DATA))
            {
                this.icon.source = this._data.icon;
                this.countField.visible = !this._data.isMoney;
                this.valueField.visible = this._data.isMoney;
                if(this._data.isMoney)
                {
                    this.valueField.text = this._data.value;
                }
                else
                {
                    this.countField.text = this._data.value;
                }
            }
        }

        public function update(param1:Object) : void
        {
            this._data = QuestItemVO(param1);
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
