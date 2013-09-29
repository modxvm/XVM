package net.wg.gui.lobby.questsWindow 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.questsWindow.data.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    
    public class QuestRenderer extends net.wg.gui.components.controls.SoundListItemRenderer
    {
        public function QuestRenderer()
        {
            super();
            this.newIndicator.visible = false;
            this.indicatorIGR.visible = false;
            this.counter.visible = false;
            this.statusMC.visible = false;
            this.progressIndicator.visible = false;
            return;
        }

        public function hideNew():void
        {
            this.newIndicator.gotoAndStop("pause");
            this.newIndicator.newLabel.gotoAndPlay("hide");
            return;
        }

        internal function setTexts(arg1:net.wg.gui.lobby.questsWindow.data.QuestRendererVO):void
        {
            this.taskTF.text = arg1.taskType;
            this.descrTF.label = arg1.description;
            this.timerTF.htmlText = arg1.timerDescr;
            return;
        }

        internal function checkProgress(arg1:net.wg.gui.lobby.questsWindow.data.QuestRendererVO):void
        {
            if (arg1.progrBarType) 
            {
                this.progressIndicator.visible = true;
                this.progressIndicator.setValues(arg1.progrBarType, arg1.currentProgrVal, arg1.maxProgrVal);
                this.progressIndicator.setTooltip(arg1.progrTooltip);
            }
            else 
            {
                this.progressIndicator.visible = false;
            }
            if (this.counter.visible && this.progressIndicator.visible) 
            {
                this.counter.y = COMPLEX_COUNTER_Y;
            }
            return;
        }

        internal function checkCounter(arg1:net.wg.gui.lobby.questsWindow.data.QuestRendererVO):void
        {
            if (arg1.tasksCount >= 0) 
            {
                this.counter.visible = true;
                this.counter.textField.text = arg1.tasksCount.toString();
                this.counter.y = DEF_COUNTER_Y;
            }
            else 
            {
                this.counter.visible = false;
            }
            return;
        }

        internal function checkIGR(arg1:net.wg.gui.lobby.questsWindow.data.QuestRendererVO):void
        {
            this.indicatorIGR.visible = arg1.IGR;
            this.indicatorIGR.x = this.taskTF.x + this.taskTF.textWidth + 5;
            return;
        }

        internal function checkNew(arg1:net.wg.gui.lobby.questsWindow.data.QuestRendererVO):void
        {
            if (arg1.isNew) 
            {
                this.newIndicator.newLabel.gotoAndStop("show");
            }
            this.newIndicator.visible = arg1.isNew;
            if (arg1.isNew && !this.wasAnimated) 
            {
                this.newIndicator.gotoAndPlay("shine");
            }
            else 
            {
                this.newIndicator.gotoAndStop("pause");
            }
            return;
        }

        internal function checkStatus(arg1:net.wg.gui.lobby.questsWindow.data.QuestRendererVO):void
        {
            this.descrTF.textColor = 6644049;
            if (arg1.status != net.wg.data.constants.QuestsStates.NOT_AVAILABLE) 
            {
                if (arg1.status != net.wg.data.constants.QuestsStates.DONE) 
                {
                    this._statusTooltip = "";
                    this.statusMC.visible = false;
                    this.descrTF.textColor = 12104084;
                }
                else 
                {
                    this.statusMC.visible = true;
                    this.statusMC.gotoAndStop(net.wg.data.constants.QuestsStates.DONE);
                    this.statusMC.textField.text = QUESTS.QUESTS_STATUS_DONE;
                    flash.text.TextField(this.statusMC.textField).textColor = DONE_COLOR;
                    this._statusTooltip = TOOLTIPS.QUESTS_STATUS_DONE;
                }
            }
            else 
            {
                this.statusMC.visible = true;
                this.statusMC.gotoAndStop(net.wg.data.constants.QuestsStates.NOT_AVAILABLE);
                this.statusMC.textField.text = QUESTS.QUESTS_STATUS_NOTAVAILABLE;
                flash.text.TextField(this.statusMC.textField).textColor = NOT_AVAILABLE_COLOR;
                this._statusTooltip = TOOLTIPS.QUESTS_STATUS_NOTREADY;
            }
            return;
        }

        internal function showNewTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.show(TOOLTIPS.QUESTS_NEWLABEL_TASK);
            return;
        }

        internal function showLockTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.show(TOOLTIPS.QUESTS_COMPLEXTASK_LABEL);
            return;
        }

        internal function showIGRTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.show(TOOLTIPS.QUESTS_IGR);
            return;
        }

        internal function hideTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        internal function showTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.show(TOOLTIPS.QUESTS_RENDERER_LABEL);
            return;
        }

        internal function showCounterTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.show(TOOLTIPS.QUESTS_COUNTER_LABEL);
            return;
        }

        internal function showStatusTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.show(this._statusTooltip);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.mouseChildren = true;
            this.mouseEnabled = true;
            this.hitTooltipMc.addEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip);
            this.hitTooltipMc.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            this.hitTooltipMc.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.showTooltip);
            this.counter.addEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip);
            this.counter.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            this.counter.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.showCounterTooltip);
            this.indicatorIGR.addEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip);
            this.indicatorIGR.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            this.indicatorIGR.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.showIGRTooltip);
            this.newIndicator.addEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip);
            this.newIndicator.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            this.newIndicator.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.showNewTooltip);
            this.lockUpMC.addEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip);
            this.lockUpMC.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            this.lockUpMC.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.showLockTooltip);
            this.lockDownMC.addEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip);
            this.lockDownMC.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            this.lockDownMC.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.showLockTooltip);
            this.statusMC.addEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip);
            this.statusMC.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            this.statusMC.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.showStatusTooltip);
            this.hitArea = this.hitMc;
            this.newIndicator.hitArea = this.newIndicator.hitMC;
            this.hitTooltipMc.buttonMode = true;
            this.buttonMode = true;
            this.newIndicator.mouseChildren = false;
            return;
        }

        public override function dispose():void
        {
            this.hitTooltipMc.removeEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip);
            this.hitTooltipMc.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            this.hitTooltipMc.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.showTooltip);
            this.counter.removeEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip);
            this.counter.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            this.counter.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.showCounterTooltip);
            this.indicatorIGR.removeEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip);
            this.indicatorIGR.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            this.indicatorIGR.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.showIGRTooltip);
            this.newIndicator.removeEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip);
            this.newIndicator.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            this.newIndicator.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.showNewTooltip);
            this.lockUpMC.removeEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip);
            this.lockUpMC.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            this.lockUpMC.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.showLockTooltip);
            this.lockDownMC.removeEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip);
            this.lockDownMC.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            this.lockDownMC.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.showLockTooltip);
            this.statusMC.removeEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip);
            this.statusMC.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            this.statusMC.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.showStatusTooltip);
            this.progressIndicator.dispose();
            super.dispose();
            return;
        }

        public override function get enabled():Boolean
        {
            return super.enabled;
        }

        public override function set enabled(arg1:Boolean):void
        {
            super.enabled = arg1;
            mouseChildren = true;
            return;
        }

        public override function setData(arg1:Object):void
        {
            this.data = arg1;
            invalidateData();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            if (isInvalid(scaleform.clik.constants.InvalidationType.STATE)) 
            {
                if (_newFrame) 
                {
                    gotoAndPlay(_newFrame);
                    _newFrame = null;
                }
                if (focusIndicator && _newFocusIndicatorFrame) 
                {
                    focusIndicator.gotoAndPlay(_newFocusIndicatorFrame);
                    _newFocusIndicatorFrame = null;
                }
                dispatchEvent(new scaleform.clik.events.ComponentEvent(scaleform.clik.events.ComponentEvent.STATE_CHANGE));
                if (data) 
                {
                    loc1 = net.wg.gui.lobby.questsWindow.data.QuestRendererVO(data);
                    this.checkData(loc1);
                }
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                if (data) 
                {
                    loc1 = net.wg.gui.lobby.questsWindow.data.QuestRendererVO(data);
                    this.checkData(loc1);
                    this.checkNew(loc1);
                    this.visible = true;
                }
                else 
                {
                    this.visible = false;
                }
                this.wasAnimated = true;
            }
            this.mouseChildren = true;
            this.mouseEnabled = true;
            this.newIndicator.mouseChildren = false;
            return;
        }

        internal function checkData(arg1:net.wg.gui.lobby.questsWindow.data.QuestRendererVO):void
        {
            this.setTexts(arg1);
            this.checkStatus(arg1);
            this.checkLock(arg1);
            this.checkIGR(arg1);
            this.checkCounter(arg1);
            this.checkProgress(arg1);
            return;
        }

        internal function checkLock(arg1:net.wg.gui.lobby.questsWindow.data.QuestRendererVO):void
        {
            this.lockUpMC.visible = arg1.isLocked;
            this.lockDownMC.visible = arg1.isLock;
            return;
        }

        internal static const DEF_COUNTER_Y:int=27;

        internal static const COMPLEX_COUNTER_Y:int=18;

        internal static const NOT_AVAILABLE_COLOR:int=6381142;

        internal static const DONE_COLOR:int=7785801;

        public var newIndicator:flash.display.MovieClip;

        public var indicatorIGR:flash.display.MovieClip;

        public var counter:flash.display.MovieClip;

        public var statusMC:flash.display.MovieClip;

        public var lockUpMC:flash.display.MovieClip;

        public var lockDownMC:flash.display.MovieClip;

        public var progressIndicator:net.wg.gui.lobby.questsWindow.ProgressQuestIndicator;

        public var taskTF:flash.text.TextField;

        public var descrTF:net.wg.gui.components.controls.TextFieldShort;

        public var timerTF:flash.text.TextField;

        public var hitMc:flash.display.MovieClip;

        public var hitTooltipMc:flash.display.MovieClip;

        internal var _statusTooltip:String="";

        internal var wasAnimated:Boolean=false;
    }
}
