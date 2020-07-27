package net.wg.gui.bootcamp.nationsWindow
{
    import net.wg.infrastructure.base.meta.impl.BCNationsWindowMeta;
    import net.wg.infrastructure.base.meta.IBCNationsWindowMeta;
    import net.wg.gui.bootcamp.nationsWindow.containers.InfoContainer;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.gui.bootcamp.nationsWindow.containers.NationsSelectorContainer;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import flash.geom.Point;
    import net.wg.gui.bootcamp.nationsWindow.data.NationItemVO;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.bootcamp.nationsWindow.events.NationSelectEvent;
    import net.wg.infrastructure.constants.WindowViewInvalidationType;
    import scaleform.clik.constants.InvalidationType;

    public class BCNationsWindow extends BCNationsWindowMeta implements IBCNationsWindowMeta
    {

        private static const STAGE_RESIZED:String = "stageResized";

        private static const HEADER_POSITION_MULTIPLIER:Number = 0.1;

        private static const INFO_POSITION_MULTIPLIER:Number = 0.05;

        private static const SELECT_OFFSET:int = 230;

        private static const FX_OFFSET:int = -1;

        public var info:InfoContainer = null;

        public var infoBack:MovieClip = null;

        public var textHeader:TextField = null;

        public var vignette:MovieClip = null;

        public var bottom:NationsSelectorContainer = null;

        public var btnSelect:ISoundButtonEx = null;

        public var fx:MovieClip = null;

        private var _selectedNation:uint = 0;

        private var _stageDimensions:Point = null;

        private var _nationsList:Vector.<NationItemVO> = null;

        public function BCNationsWindow()
        {
            super();
            showWindowBgForm = false;
            showWindowBg = false;
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
            this.btnSelect.label = BOOTCAMP.BTN_SELECT;
            this.btnSelect.addEventListener(ButtonEvent.CLICK,this.onBtnSelectClickHandler);
            this.bottom.addEventListener(NationSelectEvent.NATION_SHOW,this.onBottomNationShowHandler);
            mouseEnabled = window.mouseEnabled = this.bottom.mouseEnabled = false;
            this.textHeader.mouseEnabled = this.fx.mouseEnabled = this.fx.mouseChildren = this.info.mouseEnabled = this.info.mouseChildren = this.infoBack.mouseEnabled = this.infoBack.mouseChildren = this.vignette.mouseEnabled = this.vignette.mouseChildren = false;
            window.getBackground();
        }

        override protected function onBeforeDispose() : void
        {
            this.btnSelect.removeEventListener(ButtonEvent.CLICK,this.onBtnSelectClickHandler);
            this.bottom.removeEventListener(NationSelectEvent.NATION_SHOW,this.onBottomNationShowHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this._stageDimensions = null;
            this.textHeader = null;
            this.vignette = null;
            this.bottom.dispose();
            this.bottom = null;
            this.info.dispose();
            this.info = null;
            this.infoBack = null;
            this.btnSelect.dispose();
            this.btnSelect = null;
            this.fx = null;
            this._nationsList = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            var _loc3_:NationItemVO = null;
            super.draw();
            if(this._stageDimensions && (geometry && isInvalid(WindowViewInvalidationType.POSITION_INVALID) || isInvalid(STAGE_RESIZED)))
            {
                _loc1_ = this._stageDimensions.x;
                _loc2_ = this._stageDimensions.y;
                this.textHeader.x = _loc1_ - this.textHeader.textWidth >> 1;
                this.textHeader.y = HEADER_POSITION_MULTIPLIER * _loc2_ >> 0;
                this.bottom.x = _loc1_ >> 1;
                this.bottom.y = _loc2_;
                this.bottom.setWidth(_loc1_);
                this.vignette.width = _loc1_;
                this.vignette.height = _loc2_;
                this.info.x = _loc1_ * INFO_POSITION_MULTIPLIER >> 0;
                this.info.y = this.infoBack.y = _loc2_ >> 1;
                this.btnSelect.x = _loc1_ - this.btnSelect.width >> 1;
                this.btnSelect.y = _loc2_ - SELECT_OFFSET;
                this.fx.x = this.btnSelect.x + (this.btnSelect.width >> 1);
                this.fx.y = this.btnSelect.y + (this.btnSelect.height >> 1) + FX_OFFSET;
                window.x = window.y = 0;
                x = y = 0;
            }
            if(this._nationsList != null && isInvalid(InvalidationType.DATA))
            {
                this.bottom.selectNation(this._selectedNation);
                this.bottom.setNationsOrder(this._nationsList);
                _loc3_ = this._nationsList[this._selectedNation];
                this.info.selectNation(_loc3_.name,_loc3_.description);
            }
        }

        override protected function selectNation(param1:uint, param2:Vector.<NationItemVO>) : void
        {
            this._selectedNation = param1;
            this._nationsList = param2;
            invalidateData();
        }

        private function onBottomNationShowHandler(param1:NationSelectEvent) : void
        {
            this._selectedNation = param1.selectedNation;
            var _loc2_:NationItemVO = this._nationsList[this._selectedNation];
            this.info.selectNation(_loc2_.name,_loc2_.description);
            onNationShowS(_loc2_.id);
        }

        private function onBtnSelectClickHandler(param1:ButtonEvent) : void
        {
            var _loc2_:NationItemVO = this._nationsList[this._selectedNation];
            onNationSelectedS(_loc2_.id);
        }
    }
}
