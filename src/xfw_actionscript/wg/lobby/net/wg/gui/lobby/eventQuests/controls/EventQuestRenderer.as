package net.wg.gui.lobby.eventQuests.controls
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.infrastructure.interfaces.entity.IUpdatable;
    import scaleform.clik.interfaces.IListItemRenderer;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.eventQuests.data.EventQuestVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import scaleform.clik.motion.Tween;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Values;
    import scaleform.gfx.TextFieldEx;
    import scaleform.clik.data.ListData;
    import net.wg.gui.components.paginator.vo.ToolTipVO;
    import org.idmedia.as3commons.util.StringUtils;

    public class EventQuestRenderer extends SoundButtonEx implements IUpdatable, IListItemRenderer
    {

        private static const SLASH:String = "/ ";

        private static const PROGRESS_SPACE:int = 6;

        private static const TWEEN_SHOW_TIME:int = 1000;

        private static const HEADER_FULL_OFFSET:int = 21;

        private static const HEADER_OFFSET:int = 19;

        private static const HEADER_COLOR:int = 15327935;

        private static const COMPLETE_COLOR:int = 12051803;

        private static const MAX_LINE_NUMBER:int = 2;

        private static const DOTS:String = "...";

        public var textHeader:TextField = null;

        public var icon:UILoaderAlt = null;

        public var progress:MovieClip = null;

        public var bg:MovieClip = null;

        public var textCurrent:TextField = null;

        public var textTotal:TextField = null;

        private var _dataVO:EventQuestVO = null;

        private var _toolTipMgr:ITooltipMgr;

        private var _tweenShow:Tween = null;

        private var _progressValue:int = -1;

        private var _progressBar:int = -1;

        private var _index:uint;

        public function EventQuestRenderer()
        {
            this._toolTipMgr = App.toolTipMgr;
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._dataVO != null && isInvalid(InvalidationType.DATA))
            {
                this.textCurrent.visible = this.textTotal.visible = this.progress.visible = this._dataVO.progress != Values.DEFAULT_INT;
                this.textHeader.y = this.textCurrent.y - (this.textCurrent.visible?HEADER_OFFSET:HEADER_FULL_OFFSET);
                this.textHeader.wordWrap = this.textHeader.multiline = !this.textCurrent.visible;
                TextFieldEx.setVerticalAlign(this.textHeader,this.textCurrent.visible?TextFieldEx.VALIGN_NONE:TextFieldEx.VALIGN_CENTER);
                if(this.textHeader.multiline)
                {
                    App.utils.commons.truncateTextFieldMultiline(this.textHeader,this._dataVO.header,MAX_LINE_NUMBER,DOTS);
                }
                else
                {
                    App.utils.commons.truncateTextFieldText(this.textHeader,this._dataVO.header,true,false,DOTS);
                }
                this.textHeader.textColor = this._dataVO.completed?COMPLETE_COLOR:HEADER_COLOR;
                this.textTotal.text = SLASH + this._dataVO.progressTotal;
                this.icon.source = this._dataVO.icon;
                if(this._dataVO.progressCurrent != Values.DEFAULT_INT)
                {
                    this.removeTween();
                    this._tweenShow = new Tween(TWEEN_SHOW_TIME,this,{
                        "progressValue":this._dataVO.progressCurrent,
                        "progressBar":this._dataVO.progress
                    });
                }
            }
        }

        private function removeTween() : void
        {
            if(this._tweenShow)
            {
                this._tweenShow.paused = true;
                this._tweenShow.dispose();
                this._tweenShow = null;
            }
        }

        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this.removeTween();
            this.textHeader = null;
            this.icon.dispose();
            this.icon = null;
            this.progress = null;
            this.bg = null;
            this.textCurrent = null;
            this.textTotal = null;
            this._dataVO = null;
            this._toolTipMgr = null;
            super.onDispose();
        }

        public function getData() : Object
        {
            return this._dataVO;
        }

        public function setData(param1:Object) : void
        {
            if(this._dataVO != param1)
            {
                this._dataVO = EventQuestVO(param1);
                invalidateData();
            }
        }

        public function setListData(param1:ListData) : void
        {
        }

        public function update(param1:Object) : void
        {
            this._dataVO = EventQuestVO(param1);
            invalidateData();
        }

        private function updateProgress() : void
        {
            this.textCurrent.text = this.progressValue.toString();
            this.textTotal.x = this.textCurrent.x + this.textCurrent.textWidth + PROGRESS_SPACE | 0;
        }

        private function updateProgressBar() : void
        {
            this.progress.gotoAndStop(this.progressBar);
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
            return false;
        }

        public function set selectable(param1:Boolean) : void
        {
        }

        public function get progressValue() : int
        {
            return this._progressValue;
        }

        public function set progressValue(param1:int) : void
        {
            this._progressValue = param1;
            this.updateProgress();
        }

        public function get progressBar() : int
        {
            return this._progressBar;
        }

        public function set progressBar(param1:int) : void
        {
            this._progressBar = param1;
            this.updateProgressBar();
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }

        private function onRollOverHandler(param1:MouseEvent) : void
        {
            if(this._dataVO == null)
            {
                return;
            }
            var _loc2_:ToolTipVO = this._dataVO.tooltipData;
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
