package net.wg.gui.lobby.vehiclePreview20.infoPanel.crew
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.controls.Image;
    import flash.text.TextField;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;

    public class CommonSkillRenderer extends UIComponentEx
    {

        public var icon:Image = null;

        public var commentTF:TextField = null;

        private var _data:VPCrewTabVO;

        private var _toolTipMgr:ITooltipMgr;

        public function CommonSkillRenderer()
        {
            super();
        }

        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this.icon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
            this.icon.dispose();
            this.icon = null;
            this.commentTF = null;
            this._data = null;
            this._toolTipMgr = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._toolTipMgr = App.toolTipMgr;
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this.icon.addEventListener(Event.CHANGE,this.onIconChangeHandler);
            this.commentTF.autoSize = TextFieldAutoSize.LEFT;
            this.commentTF.wordWrap = true;
            this.commentTF.multiline = true;
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.commentTF.y = this.icon.height - this.commentTF.height >> 1;
                this.commentTF.width = width - this.commentTF.x;
            }
        }

        public function setData(param1:VPCrewTabVO) : void
        {
            this._data = param1;
            this.icon.source = param1.skillIcon;
            this.commentTF.htmlText = param1.vehicleCrewComment;
        }

        private function onRollOverHandler(param1:MouseEvent) : void
        {
            if(this._data.skillName)
            {
                this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.PREVIEW_CREW_SKILL,null,this._data.skillName);
            }
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }

        private function onIconChangeHandler(param1:Event) : void
        {
            dispatchEvent(param1);
            invalidateSize();
        }
    }
}
