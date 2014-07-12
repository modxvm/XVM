package net.wg.gui.lobby.questsWindow
{
    import net.wg.gui.components.controls.SoundListItemRenderer;
    import flash.events.MouseEvent;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.lobby.questsWindow.components.QuestsCounter;
    import net.wg.gui.lobby.questsWindow.components.QuestStatusComponent;
    import net.wg.gui.lobby.questsWindow.components.ProgressQuestIndicator;
    import flash.text.TextField;
    import net.wg.gui.components.controls.TextFieldShort;
    import net.wg.data.constants.QuestsStates;
    import net.wg.gui.lobby.questsWindow.data.QuestRendererVO;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.events.ComponentEvent;
    
    public class QuestRenderer extends SoundListItemRenderer
    {
        
        public function QuestRenderer() {
            super();
            this.newIndicator.visible = false;
            this.indicatorIGR.visible = false;
            this.counter.visible = false;
            this.statusMC.visible = false;
            this.progressIndicator.visible = false;
            this.actionMC.visible = false;
        }
        
        private static var DEF_COUNTER_Y:int = 27;
        
        private static var COMPLEX_COUNTER_Y:int = 18;
        
        private static function showLockTooltip(param1:MouseEvent) : void {
            App.toolTipMgr.show(TOOLTIPS.QUESTS_COMPLEXTASK_LABEL);
        }
        
        private static function showIGRTooltip(param1:MouseEvent) : void {
            App.toolTipMgr.show(TOOLTIPS.QUESTS_IGR);
        }
        
        private static function hideTooltip(param1:MouseEvent) : void {
            App.toolTipMgr.hide();
        }
        
        private static function showTooltip(param1:MouseEvent) : void {
            App.toolTipMgr.show(TOOLTIPS.QUESTS_RENDERER_LABEL);
        }
        
        public var newIndicator:MovieClip;
        
        public var indicatorIGR:UILoaderAlt;
        
        public var counter:QuestsCounter;
        
        public var statusMC:QuestStatusComponent;
        
        public var lockUpMC:MovieClip;
        
        public var lockDownMC:MovieClip;
        
        public var actionMC:MovieClip;
        
        public var progressIndicator:ProgressQuestIndicator;
        
        public var taskTF:TextField;
        
        public var descrTF:TextFieldShort;
        
        public var timerTF:TextField;
        
        public var hitMc:MovieClip;
        
        public var hitTooltipMc:MovieClip;
        
        private var _status:String = "";
        
        private var wasAnimated:Boolean = false;
        
        override protected function configUI() : void {
            super.configUI();
            this.mouseChildren = true;
            this.mouseEnabled = true;
            this.addListeners();
            this.hitArea = this.hitMc;
            this.newIndicator.hitArea = this.newIndicator.hitMC;
            this.hitTooltipMc.buttonMode = true;
            this.buttonMode = true;
            this.newIndicator.mouseChildren = false;
            this.descrTF.textColor = QuestsStates.CLR_TASK_TF_NORMAL;
            this.descrTF.validateNow();
        }
        
        private function addListeners() : void {
            this.hitTooltipMc.addEventListener(MouseEvent.CLICK,hideTooltip);
            this.hitTooltipMc.addEventListener(MouseEvent.ROLL_OUT,hideTooltip);
            this.hitTooltipMc.addEventListener(MouseEvent.ROLL_OVER,showTooltip);
            this.indicatorIGR.addEventListener(MouseEvent.CLICK,hideTooltip);
            this.indicatorIGR.addEventListener(MouseEvent.ROLL_OUT,hideTooltip);
            this.indicatorIGR.addEventListener(MouseEvent.ROLL_OVER,showIGRTooltip);
            this.newIndicator.addEventListener(MouseEvent.CLICK,hideTooltip);
            this.newIndicator.addEventListener(MouseEvent.ROLL_OUT,hideTooltip);
            this.newIndicator.addEventListener(MouseEvent.ROLL_OVER,this.showNewTooltip);
            this.lockUpMC.addEventListener(MouseEvent.CLICK,hideTooltip);
            this.lockUpMC.addEventListener(MouseEvent.ROLL_OUT,hideTooltip);
            this.lockUpMC.addEventListener(MouseEvent.ROLL_OVER,showLockTooltip);
            this.lockDownMC.addEventListener(MouseEvent.CLICK,hideTooltip);
            this.lockDownMC.addEventListener(MouseEvent.ROLL_OUT,hideTooltip);
            this.lockDownMC.addEventListener(MouseEvent.ROLL_OVER,showLockTooltip);
        }
        
        override protected function onDispose() : void {
            this.hitArea = null;
            this.newIndicator.hitArea = null;
            this.removeListeners();
            this.hitTooltipMc = null;
            this.hitMc = null;
            this.timerTF = null;
            this.descrTF.dispose();
            this.descrTF = null;
            this.taskTF = null;
            this.actionMC = null;
            this.lockUpMC = null;
            this.lockDownMC = null;
            this.newIndicator = null;
            this.indicatorIGR = null;
            this.counter.dispose();
            this.counter = null;
            this.statusMC.dispose();
            this.statusMC = null;
            this.progressIndicator.dispose();
            super.onDispose();
        }
        
        private function removeListeners() : void {
            this.hitTooltipMc.removeEventListener(MouseEvent.CLICK,hideTooltip);
            this.hitTooltipMc.removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
            this.hitTooltipMc.removeEventListener(MouseEvent.ROLL_OVER,showTooltip);
            this.indicatorIGR.removeEventListener(MouseEvent.CLICK,hideTooltip);
            this.indicatorIGR.removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
            this.indicatorIGR.removeEventListener(MouseEvent.ROLL_OVER,showIGRTooltip);
            this.newIndicator.removeEventListener(MouseEvent.CLICK,hideTooltip);
            this.newIndicator.removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
            this.newIndicator.removeEventListener(MouseEvent.ROLL_OVER,this.showNewTooltip);
            this.lockUpMC.removeEventListener(MouseEvent.CLICK,hideTooltip);
            this.lockUpMC.removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
            this.lockUpMC.removeEventListener(MouseEvent.ROLL_OVER,showLockTooltip);
            this.lockDownMC.removeEventListener(MouseEvent.CLICK,hideTooltip);
            this.lockDownMC.removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
            this.lockDownMC.removeEventListener(MouseEvent.ROLL_OVER,showLockTooltip);
        }
        
        override public function get enabled() : Boolean {
            return super.enabled;
        }
        
        override public function set enabled(param1:Boolean) : void {
            super.enabled = param1;
            mouseChildren = true;
        }
        
        override public function setData(param1:Object) : void {
            this.data = param1;
            invalidateData();
        }
        
        override protected function draw() : void {
            var _loc1_:QuestRendererVO = null;
            if(isInvalid(InvalidationType.STATE))
            {
                if(_newFrame)
                {
                    gotoAndPlay(_newFrame);
                    _newFrame = null;
                }
                if((focusIndicator) && (_newFocusIndicatorFrame))
                {
                    focusIndicator.gotoAndPlay(_newFocusIndicatorFrame);
                    _newFocusIndicatorFrame = null;
                }
                dispatchEvent(new ComponentEvent(ComponentEvent.STATE_CHANGE));
                if(data)
                {
                    _loc1_ = QuestRendererVO(data);
                    this.checkData(_loc1_);
                }
            }
            if(isInvalid(InvalidationType.DATA))
            {
                if(data)
                {
                    _loc1_ = QuestRendererVO(data);
                    this.checkData(_loc1_);
                    this.checkNew(_loc1_);
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
        }
        
        private function checkData(param1:QuestRendererVO) : void {
            this.setTexts(param1);
            this.checkStatus(param1);
            this.checkCounter(param1);
            this.checkProgress(param1);
            this.checkLock(param1);
            this.checkIGR(param1);
            this.checkAction(param1);
        }
        
        private function checkAction(param1:QuestRendererVO) : void {
            this.actionMC.visible = param1.eventType == QuestsStates.ACTION;
        }
        
        private function checkLock(param1:QuestRendererVO) : void {
            this.lockUpMC.visible = param1.isLocked;
            this.lockDownMC.visible = param1.isLock;
        }
        
        public function hideNew() : void {
            this.newIndicator.gotoAndStop("pause");
            this.newIndicator.newLabel.gotoAndPlay("hide");
        }
        
        private function setTexts(param1:QuestRendererVO) : void {
            this.taskTF.text = param1.taskType;
            this.descrTF.label = param1.description;
            this.timerTF.htmlText = param1.timerDescr;
        }
        
        private function checkProgress(param1:QuestRendererVO) : void {
            if((param1.progrBarType) && !param1.status)
            {
                this.progressIndicator.visible = true;
                this.progressIndicator.setValues(param1.progrBarType,param1.currentProgrVal,param1.maxProgrVal);
                this.progressIndicator.setTooltip(param1.progrTooltip);
            }
            else
            {
                this.progressIndicator.visible = false;
            }
            if((this.counter.visible) && (this.progressIndicator.visible))
            {
                this.counter.y = COMPLEX_COUNTER_Y;
            }
        }
        
        private function checkCounter(param1:QuestRendererVO) : void {
            if(param1.tasksCount >= 0 && !param1.status)
            {
                this.counter.visible = true;
                this.counter.textField.text = param1.tasksCount.toString();
                this.counter.y = DEF_COUNTER_Y;
            }
            else
            {
                this.counter.visible = false;
            }
        }
        
        private function checkIGR(param1:QuestRendererVO) : void {
            this.indicatorIGR.visible = param1.IGR;
            if(this.indicatorIGR.visible)
            {
                this.indicatorIGR.source = RES_ICONS.MAPS_ICONS_LIBRARY_PREMIUM_SMALL;
            }
            this.indicatorIGR.x = int(this.taskTF.x + this.taskTF.textWidth + 5);
        }
        
        private function checkNew(param1:QuestRendererVO) : void {
            if(param1.isNew)
            {
                this.newIndicator.newLabel.gotoAndStop("show");
            }
            this.newIndicator.visible = param1.isNew;
            if((param1.isNew) && !this.wasAnimated)
            {
                this.newIndicator.gotoAndPlay("shine");
            }
            else
            {
                this.newIndicator.gotoAndStop("pause");
            }
        }
        
        private function checkStatus(param1:QuestRendererVO) : void {
            if(this._status != param1.status)
            {
                this._status = param1.status;
                this.statusMC.setStatus(this._status);
                this.descrTF.textColor = this._status?QuestsStates.CLR_TASK_TF_WITH_STATUS:QuestsStates.CLR_TASK_TF_NORMAL;
                this.descrTF.validateNow();
            }
        }
        
        private function showNewTooltip(param1:MouseEvent) : void {
            var _loc2_:QuestRendererVO = QuestRendererVO(data);
            App.toolTipMgr.show(_loc2_.eventType == QuestsStates.ACTION?TOOLTIPS.QUESTS_NEWLABEL_ACTION:TOOLTIPS.QUESTS_NEWLABEL_TASK);
        }
    }
}
