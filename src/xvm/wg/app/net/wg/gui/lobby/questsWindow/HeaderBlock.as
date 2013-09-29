package net.wg.gui.lobby.questsWindow 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.lobby.questsWindow.data.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class HeaderBlock extends scaleform.clik.core.UIComponent
    {
        public function HeaderBlock()
        {
            super();
            this.statusMC.visible = false;
            this.counter.visible = false;
            this.progressIndicator.visible = false;
            return;
        }

        public function setData(arg1:net.wg.gui.lobby.questsWindow.data.HeaderDataVO):void
        {
            this.headerData = arg1;
            invalidateData();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.counter.addEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip);
            this.counter.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            this.counter.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.showCounterTooltip);
            this.statusMC.addEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip);
            this.statusMC.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            this.statusMC.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.showStatusTooltip);
            this.hitArea = this.maskMC;
            return;
        }

        internal function showStatusTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.show(this._statusTooltip);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                if (this.headerData) 
                {
                    this.setTexts();
                    this.checkStatus();
                    this.checkCounter();
                    this.checkProgress();
                    this.layoutComponents();
                }
                else 
                {
                    setSize(this.width, 0);
                }
                dispatchEvent(new flash.events.Event(flash.events.Event.RESIZE));
            }
            return;
        }

        public override function dispose():void
        {
            if (this.counter) 
            {
                this.counter.removeEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip);
                this.counter.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
                this.counter.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.showCounterTooltip);
                this.statusMC.removeEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip);
                this.statusMC.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
                this.statusMC.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.showStatusTooltip);
                this.counter = null;
            }
            this.lableTF = null;
            this.timeTF = null;
            this.typeTF = null;
            this.notAvailableTF = null;
            this.statusMC = null;
            this.bg = null;
            this.maskMC = null;
            if (this.progressIndicator) 
            {
                this.progressIndicator.dispose();
                this.progressIndicator = null;
            }
            if (this.headerData) 
            {
                this.headerData.dispose();
                this.headerData = null;
            }
            super.dispose();
            return;
        }

        internal function setTexts():void
        {
            this.lableTF.text = this.headerData.title;
            this.timeTF.text = this.headerData.date;
            this.typeTF.text = this.headerData.type;
            this.notAvailableTF.text = this.headerData.impDescr;
            return;
        }

        internal function layoutComponents():void
        {
            this.lableTF.height = this.lableTF.textHeight + TEXT_MARGIN;
            var loc1:*=this.lableTF.textHeight + this.lableTF.y;
            this.timeTF.y = Math.round(loc1 + MIDDLE_PADDING);
            var loc2:*=this.timeTF.textHeight + this.timeTF.y;
            this.typeTF.y = Math.round(loc2 + 2);
            this.typeTF.height = this.typeTF.textHeight + TEXT_MARGIN;
            var loc3:*=this.typeTF.textHeight + this.typeTF.y;
            this.notAvailableTF.y = Math.round((Boolean(this.headerData.type) ? loc3 : loc2) + MIDDLE_PADDING);
            this.notAvailableTF.height = this.notAvailableTF.textHeight + TEXT_MARGIN;
            var loc4:*=this.notAvailableTF.y + this.notAvailableTF.textHeight;
            this.bg.y = Math.round((Boolean(this.headerData.impDescr) ? loc4 : this.notAvailableTF.y - MIDDLE_PADDING) + VERTICAL_PADDING);
            this.maskMC.height = this.headerData.status != net.wg.data.constants.QuestsStates.DONE ? 0 : this.bg.y;
            var loc5:*=Math.round(this.bg.y);
            setSize(this.width, loc5);
            return;
        }

        internal function checkProgress():void
        {
            this.progressIndicator.visible = Boolean(this.headerData.progrBarType);
            if (this.headerData.progrBarType) 
            {
                this.progressIndicator.setValues(this.headerData.progrBarType, this.headerData.currentProgrVal, this.headerData.maxProgrVal);
                this.progressIndicator.setTooltip(this.headerData.progrTooltip);
            }
            return;
        }

        internal function checkCounter():void
        {
            this.counter.textField.text = this.headerData.tasksCount.toString();
            if (this.headerData.tasksCount > COUNTER_NO_DATA) 
            {
                this.counter.visible = true;
                this.progressIndicator.y = this.counter.y + this.counter.height - 5;
            }
            else 
            {
                this.counter.visible = false;
                this.progressIndicator.y = 30;
            }
            return;
        }

        internal function checkStatus():void
        {
            this.statusMC.visible = Boolean(this.headerData.status);
            this.lableTF.textColor = this.headerData.status ? 6644049 : 12104084;
            if (this.headerData.status) 
            {
                this.statusMC.gotoAndStop(this.headerData.status);
                this.counter.x = COUNTER_X;
                this._statusTooltip = this.headerData.status != "done" ? TOOLTIPS.QUESTS_STATUS_NOTREADY : TOOLTIPS.QUESTS_STATUS_DONE;
            }
            else 
            {
                this._statusTooltip = "";
                this.counter.x = COUNTER_X + STATUS_MARGIN;
            }
            return;
        }

        internal function hideTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        internal function showCounterTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.show(TOOLTIPS.QUESTS_COUNTER_LABEL);
            return;
        }

        internal static const VERTICAL_PADDING:int=20;

        internal static const MIDDLE_PADDING:int=13;

        internal static const TEXT_MARGIN:int=10;

        internal static const COUNTER_NO_DATA:int=-1;

        internal static const COUNTER_X:int=307;

        internal static const STATUS_MARGIN:int=18;

        public var lableTF:flash.text.TextField;

        public var timeTF:flash.text.TextField;

        public var typeTF:flash.text.TextField;

        public var notAvailableTF:flash.text.TextField;

        public var statusMC:flash.display.MovieClip;

        public var counter:flash.display.MovieClip;

        public var progressIndicator:net.wg.gui.lobby.questsWindow.ProgressQuestIndicator;

        internal var headerData:net.wg.gui.lobby.questsWindow.data.HeaderDataVO=null;

        public var bg:flash.display.MovieClip;

        public var maskMC:flash.display.MovieClip;

        internal var _statusTooltip:String="";
    }
}
