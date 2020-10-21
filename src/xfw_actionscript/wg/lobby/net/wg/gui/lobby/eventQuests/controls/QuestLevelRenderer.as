package net.wg.gui.lobby.eventQuests.controls
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
    import flash.display.MovieClip;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.gui.lobby.eventQuests.data.QuestLevelProgressVO;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.components.paginator.vo.ToolTipVO;
    import org.idmedia.as3commons.util.StringUtils;

    public class QuestLevelRenderer extends SoundButtonEx
    {

        private static const STATE_COMPLETE:String = "complete";

        private static const STATE_IDLE:String = "idle";

        private static const STATE_SELECTED:String = "selected";

        public var icon:AnimatedTextContainer = null;

        public var lock:MovieClip = null;

        public var bgSmall:MovieClip = null;

        public var bgBig:MovieClip = null;

        public var mcSize:MovieClip = null;

        public var line:MovieClip = null;

        private var _toolTipMgr:ITooltipMgr = null;

        private var _dataLevel:QuestLevelProgressVO = null;

        public function QuestLevelRenderer()
        {
            super();
        }

        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this.icon.dispose();
            this.icon = null;
            this.lock = null;
            this.bgSmall = null;
            this.bgBig = null;
            this.mcSize = null;
            this.line = null;
            this._dataLevel = null;
            this._toolTipMgr = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.line.mouseEnabled = false;
            this._toolTipMgr = App.toolTipMgr;
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            statesSelected.pop();
        }

        override protected function draw() : void
        {
            var _loc1_:String = null;
            super.draw();
            if(this._dataLevel != null && isInvalid(InvalidationType.DATA))
            {
                _loc1_ = STATE_IDLE;
                if(this._dataLevel.completed)
                {
                    _loc1_ = STATE_COMPLETE;
                }
                else if(this._dataLevel.current)
                {
                    _loc1_ = STATE_SELECTED;
                }
                this.icon.gotoAndStop(_loc1_);
                this.bgSmall.gotoAndStop(_loc1_);
                this.bgBig.gotoAndStop(_loc1_);
                this.icon.text = this._dataLevel.label;
                this.lock.visible = !this._dataLevel.unlocked;
                this.icon.visible = !this.lock.visible;
                this.line.visible = !this._dataLevel.isLast;
            }
        }

        override public function set data(param1:Object) : void
        {
            super.data = param1;
            this._dataLevel = QuestLevelProgressVO(data);
            invalidateData();
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }

        private function onRollOverHandler(param1:MouseEvent) : void
        {
            if(this._dataLevel == null)
            {
                return;
            }
            var _loc2_:ToolTipVO = this._dataLevel.tooltipData;
            if(_loc2_ == null)
            {
                return;
            }
            if(StringUtils.isNotEmpty(_loc2_.tooltip))
            {
                this._toolTipMgr.showComplex(_loc2_.tooltip);
            }
            else
            {
                this._toolTipMgr.showSpecial.apply(this._toolTipMgr,[_loc2_.specialAlias,null].concat(_loc2_.specialArgs));
            }
        }
    }
}
