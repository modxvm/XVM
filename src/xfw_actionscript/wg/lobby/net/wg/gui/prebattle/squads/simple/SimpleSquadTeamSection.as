package net.wg.gui.prebattle.squads.simple
{
    import net.wg.gui.prebattle.squads.SquadTeamSectionBase;
    import flash.display.Sprite;
    import net.wg.gui.components.controls.Image;
    import flash.text.TextField;
    import net.wg.gui.prebattle.squads.simple.vo.SimpleSquadTeamSectionVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.gui.components.containers.GroupEx;
    import net.wg.data.constants.Linkages;
    import net.wg.gui.components.containers.HorizontalGroupLayout;
    import flash.events.MouseEvent;
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    import net.wg.gui.prebattle.squads.simple.vo.SimpleSquadRallySlotVO;
    import net.wg.gui.rally.controls.RallyInvalidationType;
    import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
    import net.wg.gui.rally.controls.interfaces.ISlotRendererHelper;
    import net.wg.data.constants.Errors;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
    import flash.text.TextFieldAutoSize;
    import scaleform.gfx.TextFieldEx;

    public class SimpleSquadTeamSection extends SquadTeamSectionBase
    {

        private static const INFO_ICON_OFFSET:int = 4;

        private static const GROUP_BONUSES_NAME:String = "bonuses";

        private static const BONUSES_OFFSET:int = 15;

        private static const BONUSES_GAP:int = 5;

        private static const BONUSES_Y:int = 5;

        private static const HEADER_MESSAGE_OFFSET:int = 10;

        public var infoIcon:Sprite = null;

        public var headerIcon:Image = null;

        public var backgroundHeader:Image = null;

        public var headerMessage:TextField = null;

        private var _sectionData:SimpleSquadTeamSectionVO = null;

        private var _tooltipMgr:ITooltipMgr;

        private var _bonuses:GroupEx = null;

        public function SimpleSquadTeamSection()
        {
            super();
            lblTeamVehicles.autoSize = TextFieldAutoSize.LEFT;
            TextFieldEx.setVerticalAlign(this.headerMessage,TextFieldEx.VALIGN_CENTER);
        }

        override protected function initialize() : void
        {
            super.initialize();
            if(this.showBonuses())
            {
                this._bonuses = new GroupEx();
                this._bonuses.name = GROUP_BONUSES_NAME;
                this._bonuses.itemRendererLinkage = Linkages.SIMPLE_SQUAD_BONUS_RENDERER;
                this._bonuses.layout = new HorizontalGroupLayout(BONUSES_GAP);
                this._bonuses.y = BONUSES_Y;
                addChild(this._bonuses);
            }
        }

        protected function showBonuses() : Boolean
        {
            return true;
        }

        override protected function configUI() : void
        {
            super.configUI();
            vehiclesLabel = MESSENGER.DIALOGS_SQUADCHANNEL_VEHICLESLBL;
            this.infoIcon.addEventListener(MouseEvent.ROLL_OVER,this.onInfoIconRollOverHandler);
            this.infoIcon.addEventListener(MouseEvent.ROLL_OUT,this.onInfoIconRollOutHandler);
            this._tooltipMgr = App.toolTipMgr;
        }

        override protected function getSlotVO(param1:Object) : IRallySlotVO
        {
            return new SimpleSquadRallySlotVO(param1);
        }

        override protected function draw() : void
        {
            super.draw();
            if(RallyInvalidationType.SECTION_DATA)
            {
                this.infoIcon.visible = this._sectionData.isVisibleInfoIcon;
                if(this.infoIcon.visible)
                {
                    lblTeamVehicles.addEventListener(MouseEvent.ROLL_OVER,this.onLabelRollOverHandler);
                    lblTeamVehicles.addEventListener(MouseEvent.ROLL_OUT,this.onLabelRollOutHandler);
                }
                this.headerIcon.visible = this._sectionData.isVisibleHeaderIcon;
                this.headerIcon.source = this._sectionData.headerIconSource;
                this.headerMessage.htmlText = this._sectionData.headerMessageText;
                this.headerMessage.visible = this._sectionData.isVisibleHeaderMessage;
                this.backgroundHeader.source = this._sectionData.backgroundHeaderSource;
                if(this.showBonuses())
                {
                    this._bonuses.dataProvider = this._sectionData.bonuses;
                    this._bonuses.validateNow();
                    this._bonuses.x = width - this._bonuses.width - BONUSES_OFFSET ^ 0;
                }
            }
            if(this.infoIcon.visible && isInvalid(RallyInvalidationType.VEHICLE_LABEL))
            {
                this.infoIcon.x = lblTeamVehicles.x + lblTeamVehicles.width + INFO_ICON_OFFSET ^ 0;
                if(!this._sectionData.isVisibleHeaderIcon)
                {
                    this.headerMessage.x = width - this.headerMessage.width - HEADER_MESSAGE_OFFSET;
                }
            }
        }

        override protected function getSlotsUI() : Vector.<IRallySimpleSlotRenderer>
        {
            var _loc2_:IRallySimpleSlotRenderer = null;
            var _loc1_:Vector.<IRallySimpleSlotRenderer> = new <IRallySimpleSlotRenderer>[slot0,slot1,slot2];
            var _loc3_:ISlotRendererHelper = new SimpleSquadSlotHelper();
            for each(_loc2_ in _loc1_)
            {
                _loc2_.helper = _loc3_;
            }
            return _loc1_;
        }

        override protected function onDispose() : void
        {
            lblTeamVehicles.removeEventListener(MouseEvent.ROLL_OVER,this.onLabelRollOverHandler);
            lblTeamVehicles.removeEventListener(MouseEvent.ROLL_OUT,this.onLabelRollOutHandler);
            this._sectionData = null;
            this.infoIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onInfoIconRollOverHandler);
            this.infoIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onInfoIconRollOutHandler);
            this.infoIcon = null;
            this.headerIcon.dispose();
            this.headerIcon = null;
            this.backgroundHeader.dispose();
            this.backgroundHeader = null;
            if(this._bonuses != null)
            {
                this._bonuses.dispose();
                this._bonuses = null;
            }
            this.headerMessage = null;
            this._tooltipMgr = null;
            super.onDispose();
        }

        override protected function updateComponents() : void
        {
            var _loc2_:IRallySimpleSlotRenderer = null;
            var _loc3_:SimpleSquadSlotRenderer = null;
            var _loc1_:Array = rallyData?rallyData.slotsArray:null;
            for each(_loc2_ in _slotsUi)
            {
                _loc2_.slotData = _loc1_?_loc1_[_slotsUi.indexOf(_loc2_)]:null;
                _loc3_ = _loc2_ as SimpleSquadSlotRenderer;
                App.utils.asserter.assertNotNull(_loc3_,"simpleSquadSlot" + Errors.CANT_NULL);
            }
        }

        public function setSimpleSquadTeamSectionVO(param1:SimpleSquadTeamSectionVO) : void
        {
            this._sectionData = param1;
            invalidate(RallyInvalidationType.SECTION_DATA);
        }

        private function hideTooltip() : void
        {
            this._tooltipMgr.hide();
        }

        private function onInfoIconRollOverHandler(param1:MouseEvent) : void
        {
            if(this._sectionData.infoIconTooltipType == TOOLTIPS_CONSTANTS.SPECIAL)
            {
                this._tooltipMgr.showSpecial(this._sectionData.infoIconTooltip,null);
            }
            else
            {
                this._tooltipMgr.showComplex(this._sectionData.infoIconTooltip);
            }
        }

        private function onInfoIconRollOutHandler(param1:MouseEvent) : void
        {
            this.hideTooltip();
        }

        private function onLabelRollOutHandler(param1:MouseEvent) : void
        {
            this.hideTooltip();
        }

        private function onLabelRollOverHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.showComplex(this._sectionData.infoIconTooltip);
        }
    }
}
