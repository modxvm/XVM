package net.wg.gui.lobby.questsWindow 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.lobby.questsWindow.data.*;
    import net.wg.gui.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class ProgressQuestIndicator extends scaleform.clik.core.UIComponent
    {
        public function ProgressQuestIndicator()
        {
            super();
            this.container = new flash.display.Sprite();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            addEventListener(flash.events.MouseEvent.CLICK, hideTooltip);
            addEventListener(flash.events.MouseEvent.ROLL_OUT, hideTooltip);
            addEventListener(flash.events.MouseEvent.ROLL_OVER, this.showTooltip);
            return;
        }

        public override function dispose():void
        {
            removeEventListener(flash.events.MouseEvent.CLICK, hideTooltip);
            removeEventListener(flash.events.MouseEvent.ROLL_OUT, hideTooltip);
            removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.showTooltip);
            super.dispose();
            return;
        }

        public function setValues(arg1:String, arg2:Number, arg3:Number):void
        {
            this._currentValue = arg2;
            this._totalValue = arg3 > 0 ? arg3 : 100;
            this._type = arg1;
            invalidateData();
            return;
        }

        public function setTooltip(arg1:Object):void
        {
            this._tooltip = arg1 ? new net.wg.gui.lobby.questsWindow.data.ComplexTooltipVO(arg1) : null;
            return;
        }

        protected override function draw():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=0;
            var loc4:*=null;
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this.maskMC.width = this._currentValue / this._totalValue * MASK_WIDTH;
                this.textField.text = App.utils.locale.integer(this._currentValue) + " / " + App.utils.locale.integer(this._totalValue);
                if (this.bgMC.contains(this.container)) 
                {
                    this.bgMC.removeChild(this.container);
                }
                if (this._type == net.wg.data.constants.QuestsStates.CURRENT) 
                {
                    this.lineMC.gotoAndStop(net.wg.data.constants.QuestsStates.CURRENT);
                }
                if (this._type == net.wg.data.constants.QuestsStates.STRATEGIC) 
                {
                    this.lineMC.gotoAndStop(net.wg.data.constants.QuestsStates.STRATEGIC);
                    this.container = new flash.display.Sprite();
                    this.container.scaleX = 1 / scaleX;
                    this.container.scaleY = 1 / scaleY;
                    this.bgMC.addChild(this.container);
                    loc1 = (this._totalValue - 1);
                    loc2 = MASK_WIDTH / this._totalValue;
                    loc3 = 0;
                    while (loc3 < loc1) 
                    {
                        (loc4 = App.utils.classFactory.getComponent("Delimeter_UI", flash.display.MovieClip)).x = Math.round(loc2 + loc2 * loc3);
                        this.container.addChild(loc4);
                        ++loc3;
                    }
                }
            }
            return;
        }

        internal function showTooltip(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=null;
            if (this._tooltip) 
            {
                loc1 = new net.wg.gui.utils.ComplexTooltipHelper().addHeader(this._tooltip.header).addBody(this._tooltip.body, false).addNote(this._tooltip.note ? this._tooltip.note : null, false).make();
                if (loc1.length > 0) 
                {
                    App.toolTipMgr.showComplex(loc1);
                }
            }
            else if (this._type != net.wg.data.constants.QuestsStates.STRATEGIC) 
            {
                if (this._type == net.wg.data.constants.QuestsStates.CURRENT) 
                {
                    App.toolTipMgr.show(TOOLTIPS.QUESTS_PROGRESS_CURRENT);
                }
            }
            else 
            {
                App.toolTipMgr.show(TOOLTIPS.QUESTS_PROGRESS_STRATEGIC);
            }
            return;
        }

        internal static function hideTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        public static const MASK_WIDTH:Number=64;

        public var textField:flash.text.TextField;

        public var maskMC:flash.display.MovieClip;

        public var lineMC:flash.display.MovieClip;

        public var dotsMC:flash.display.MovieClip;

        public var bgMC:flash.display.MovieClip;

        internal var _type:String="current";

        internal var _currentValue:Number=0;

        internal var _totalValue:Number=100;

        internal var _tooltip:net.wg.gui.lobby.questsWindow.data.ComplexTooltipVO=null;

        public var container:flash.display.Sprite;
    }
}
