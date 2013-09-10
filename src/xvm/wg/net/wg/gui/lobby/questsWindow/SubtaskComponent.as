package net.wg.gui.lobby.questsWindow 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.questsWindow.data.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    
    public class SubtaskComponent extends scaleform.clik.core.UIComponent
    {
        public function SubtaskComponent()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.statusMC.visible = false;
            this.progressIndicator.visible = false;
            this.linkBtn.visible = true;
            this.linkBtn.focusable = false;
            this.typeTF.mouseEnabled = false;
            this.taskTF.mouseEnabled = false;
            this.linkBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.linkBtnHandler);
            this.linkBtn.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            this.linkBtn.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.showLinkBtnTooltip);
            this.counter.addEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip);
            this.counter.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            this.counter.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.showCounterTooltip);
            this.statusMC.addEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip);
            this.statusMC.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            this.statusMC.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.showStatusTooltip);
            return;
        }

        internal function showStatusTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.show(this._statusTooltip);
            return;
        }

        internal function hideTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        internal function showLinkBtnTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.show(TOOLTIPS.QUESTS_LINKBTN_TASK);
            return;
        }

        public function setData(arg1:Object):void
        {
            this.data = arg1 ? new net.wg.gui.lobby.questsWindow.data.SubtaskVO(arg1) : null;
            invalidateData();
            return;
        }

        public override function dispose():void
        {
            this.linkBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.linkBtnHandler);
            this.linkBtn.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            this.linkBtn.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.showLinkBtnTooltip);
            this.counter.removeEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip);
            this.counter.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            this.counter.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.showCounterTooltip);
            this.statusMC.removeEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip);
            this.statusMC.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            this.statusMC.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.showStatusTooltip);
            this.typeTF = null;
            this.taskTF = null;
            this.linkBtn.dispose();
            this.linkBtn = null;
            this.statusMC = null;
            this.lineMC = null;
            this.progressIndicator.dispose();
            this.progressIndicator = null;
            this._data = null;
            super.dispose();
            return;
        }

        internal function showCounterTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.show(TOOLTIPS.QUESTS_COUNTER_LABEL);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=NaN;
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
                if (this.data) 
                {
                    this.visible = true;
                    this.typeTF.text = this.data.title;
                    this.taskTF.text = this.data.questInfo.description;
                    this.linkBtn.y = (this.taskTF.text ? this.taskTF.textHeight + this.taskTF.y - this.linkBtn.height : this.taskTF.y) + 2;
                    this.linkBtn.x = this.taskTF.text ? this.taskTF.x + this.taskTF.getLineMetrics((this.taskTF.numLines - 1)).width + LINKBTN_PADDING : this.taskTF.x;
                    this.linkBtn.validateNow();
                    this.checkStatus();
                    this.checkCounter();
                    this.checkProgressBar();
                    this.lineMC.y = this.linkBtn.y + this.linkBtn.height + BOTTOM_PADDING;
                    loc1 = Math.round(this.lineMC.y + this.lineMC.height);
                    setSize(this.width, loc1);
                    dispatchEvent(new flash.events.Event(flash.events.Event.RESIZE));
                }
                else 
                    this.visible = false;
            return;
        }

        internal function checkProgressBar():void
        {
            if (this.data.questInfo.progrBarType) 
            {
                this.progressIndicator.visible = true;
                this.progressIndicator.setValues(this.data.questInfo.progrBarType, this.data.questInfo.currentProgrVal, this.data.questInfo.maxProgrVal);
                this.progressIndicator.validateNow();
            }
            else 
                this.progressIndicator.visible = false;
            return;
        }

        internal function checkCounter():void
        {
            if (this.data.questInfo.tasksCount >= 0) 
            {
                this.counter.visible = true;
                this.counter.textField.text = this.data.questInfo.tasksCount.toString();
            }
            else 
                this.counter.visible = false;
            return;
        }

        internal function checkStatus():void
        {
            this.taskTF.textColor = 6644049;
            if (this.data.questInfo.status != net.wg.data.constants.QuestsStates.NOT_AVAILABLE) 
                if (this.data.questInfo.status != net.wg.data.constants.QuestsStates.DONE) 
                {
                    this.statusMC.visible = false;
                    this.taskTF.textColor = 12104084;
                    this._statusTooltip = "";
                }
                else 
                {
                    this.statusMC.visible = true;
                    this.statusMC.gotoAndStop(net.wg.data.constants.QuestsStates.DONE);
                    this.statusMC.textField.text = QUESTS.QUESTS_STATUS_DONE;
                    flash.text.TextField(this.statusMC.textField).textColor = 7785801;
                    this._statusTooltip = TOOLTIPS.QUESTS_STATUS_DONE;
                }
            else 
            {
                this.statusMC.visible = true;
                this.statusMC.gotoAndStop(net.wg.data.constants.QuestsStates.NOT_AVAILABLE);
                this.statusMC.textField.text = QUESTS.QUESTS_STATUS_NOTAVAILABLE;
                flash.text.TextField(this.statusMC.textField).textColor = 6381142;
                this._statusTooltip = TOOLTIPS.QUESTS_STATUS_NOTREADY;
            }
            return;
        }

        public function get data():net.wg.gui.lobby.questsWindow.data.SubtaskVO
        {
            return this._data;
        }

        public function set data(arg1:net.wg.gui.lobby.questsWindow.data.SubtaskVO):void
        {
            this._data = arg1;
            return;
        }

        internal function linkBtnHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            App.toolTipMgr.hide();
            dispatchEvent(new net.wg.gui.events.QuestEvent(net.wg.gui.events.QuestEvent.SELECT_QUEST, this.data.questInfo.questID));
            return;
        }

        internal static const BOTTOM_PADDING:int=20;

        internal static const LINKBTN_PADDING:int=10;

        public var typeTF:flash.text.TextField;

        public var taskTF:flash.text.TextField;

        public var linkBtn:net.wg.gui.components.controls.SoundButton;

        public var statusMC:flash.display.MovieClip;

        public var counter:flash.display.MovieClip;

        public var progressIndicator:net.wg.gui.lobby.questsWindow.ProgressQuestIndicator;

        public var lineMC:flash.display.MovieClip;

        internal var _data:net.wg.gui.lobby.questsWindow.data.SubtaskVO=null;

        internal var _statusTooltip:String="";
    }
}
