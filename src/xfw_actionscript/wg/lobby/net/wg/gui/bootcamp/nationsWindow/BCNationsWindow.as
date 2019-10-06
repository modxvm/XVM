package net.wg.gui.bootcamp.nationsWindow
{
    import net.wg.infrastructure.base.meta.impl.BCNationsWindowMeta;
    import net.wg.infrastructure.base.meta.IBCNationsWindowMeta;
    import net.wg.gui.bootcamp.nationsWindow.containers.NationsContainer;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.gui.bootcamp.nationsWindow.containers.NationsSelectorContainer;
    import flash.geom.Point;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.bootcamp.nationsWindow.events.NationSelectEvent;
    import net.wg.infrastructure.constants.WindowViewInvalidationType;

    public class BCNationsWindow extends BCNationsWindowMeta implements IBCNationsWindowMeta
    {

        private static const STAGE_RESIZED:String = "stageResized";

        private static const TO_DELIMITER:String = "to";

        private static const NATION:String = "nation";

        public var nations:NationsContainer = null;

        public var textHeader:TextField = null;

        public var vignette:MovieClip = null;

        public var bottom:NationsSelectorContainer = null;

        private var _selectedNation:uint = 0;

        private var _stageDimensions:Point;

        private var _nationsOriginalWidth:Number;

        private var _nationsOriginalHeight:Number;

        private var _nationsList:Vector.<int>;

        public function BCNationsWindow()
        {
            super();
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            if(!this._stageDimensions)
            {
                this._stageDimensions = new Point();
            }
            this._stageDimensions.x = param1;
            this._stageDimensions.y = param2;
            invalidate(STAGE_RESIZED);
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.textHeader.autoSize = TextFieldAutoSize.LEFT;
            this.textHeader.text = BOOTCAMP.AWARD_OPTIONS_TITLE;
            this._nationsOriginalWidth = this.nations.width;
            this._nationsOriginalHeight = this.nations.height;
            this.bottom.addEventListener(NationSelectEvent.NATION_SELECTED,this.onBottomNationSelectedHandler);
            this.bottom.addEventListener(NationSelectEvent.NATION_SHOW,this.onBottomNationShowHandler);
        }

        override protected function onDispose() : void
        {
            this.bottom.removeEventListener(NationSelectEvent.NATION_SELECTED,this.onBottomNationSelectedHandler);
            this.bottom.removeEventListener(NationSelectEvent.NATION_SHOW,this.onBottomNationShowHandler);
            this._stageDimensions = null;
            this.nations.dispose();
            this.nations = null;
            this.textHeader = null;
            this.vignette = null;
            this.bottom.dispose();
            this.bottom = null;
            this._nationsList = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            super.draw();
            if(this._stageDimensions && (geometry && isInvalid(WindowViewInvalidationType.POSITION_INVALID) || isInvalid(STAGE_RESIZED)))
            {
                _loc1_ = this._stageDimensions.x;
                _loc2_ = this._stageDimensions.y;
                this.textHeader.x = _loc1_ - this.textHeader.textWidth >> 1;
                this.bottom.x = _loc1_ >> 1;
                this.bottom.y = _loc2_;
                this.bottom.bottomBG.width = _loc1_;
                this.bottom.bottomBG.x = -_loc1_ >> 1;
                this.vignette.width = _loc1_;
                this.vignette.height = _loc2_;
                this.nations.scaleX = this.nations.scaleY = Math.max(_loc1_ / this._nationsOriginalWidth,(_loc2_ + this.bottom.bottomBG.y) / this._nationsOriginalHeight);
                this.nations.x = _loc1_ - this._nationsOriginalWidth * this.nations.scaleX >> 1;
                this.nations.y = _loc2_ + this.bottom.bottomBG.y - this._nationsOriginalHeight * this.nations.scaleY >> 1;
                window.x = window.y = 0;
                x = y = 0;
            }
        }

        override protected function selectNation(param1:uint, param2:Vector.<int>) : void
        {
            var _loc3_:int = param2.indexOf(param1);
            var _loc4_:String = NATION + String(_loc3_ + 1);
            this._selectedNation = _loc3_;
            this.bottom.selectNation(_loc3_,_loc4_);
            this.nations.gotoAndStop(_loc4_);
            this._nationsList = param2;
        }

        private function onBottomNationShowHandler(param1:NationSelectEvent) : void
        {
            var _loc2_:String = (this._selectedNation + 1).toString() + TO_DELIMITER + (param1.selectedNation + 1).toString();
            this._selectedNation = param1.selectedNation;
            this.nations.gotoAndPlay(_loc2_);
            var _loc3_:int = this._nationsList[param1.selectedNation];
            onNationShowS(_loc3_);
        }

        private function onBottomNationSelectedHandler(param1:NationSelectEvent) : void
        {
            var _loc2_:int = this._nationsList[param1.selectedNation];
            onNationSelectedS(_loc2_);
        }
    }
}
