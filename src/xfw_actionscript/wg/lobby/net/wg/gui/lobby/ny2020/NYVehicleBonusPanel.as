package net.wg.gui.lobby.ny2020
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.display.DisplayObjectContainer;
    import flash.text.TextField;
    import net.wg.gui.components.controls.Image;
    import flash.display.MovieClip;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.Event;

    public class NYVehicleBonusPanel extends UIComponentEx
    {

        private static const ICON_GAP:Number = 0;

        private static const LBL_BIG:String = "big";

        private static const LBL_SMALL:String = "small";

        private static const LBL_OUT:String = "out";

        private static const LBL_OVER:String = "over";

        public var mcBonusLabel:DisplayObjectContainer = null;

        public var tfLabel:TextField = null;

        public var icon:Image = null;

        public var bg:MovieClip = null;

        private var _tfBonusLabel:TextField = null;

        private var _bonusIcon:String;

        private var _bonusValue:String;

        private var _label:String;

        private var _tooltip:String;

        public function NYVehicleBonusPanel()
        {
            super();
            stop();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                if(!this.icon.hasEventListener(Event.CHANGE))
                {
                    this.icon.addEventListener(Event.CHANGE,this.onChangeHandler);
                }
                this.icon.source = this._bonusIcon;
                this._tfBonusLabel = this.mcBonusLabel["tfBonusLabel"];
                this._tfBonusLabel.text = this._bonusValue;
                this.tfLabel.htmlText = this._label;
                invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.icon.x = -(this._tfBonusLabel.textWidth + this.icon.width + ICON_GAP) >> 1;
                this.mcBonusLabel.x = this.icon.x + this.icon.width + ICON_GAP;
            }
        }

        override protected function onDispose() : void
        {
            this.icon.removeEventListener(Event.CHANGE,this.onChangeHandler);
            this.icon.dispose();
            this.icon = null;
            this.mcBonusLabel = null;
            this._tfBonusLabel = null;
            this.tfLabel = null;
            this.bg = null;
            super.onDispose();
        }

        public function setIsSmall(param1:Boolean) : void
        {
            gotoAndStop(param1?LBL_SMALL:LBL_BIG);
            invalidateData();
        }

        public function showOut() : void
        {
            this.bg.gotoAndStop(LBL_OUT);
            App.toolTipMgr.hide();
        }

        public function showOver() : void
        {
            this.bg.gotoAndStop(LBL_OVER);
            App.toolTipMgr.showComplex(this._tooltip);
        }

        public function update(param1:String, param2:String, param3:String, param4:String) : void
        {
            this._bonusIcon = param1;
            this._bonusValue = param2;
            this._label = param3;
            this._tooltip = param4;
            invalidateData();
        }

        private function onChangeHandler(param1:Event) : void
        {
            invalidateSize();
        }
    }
}
