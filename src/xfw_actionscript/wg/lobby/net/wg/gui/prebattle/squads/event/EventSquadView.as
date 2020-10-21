package net.wg.gui.prebattle.squads.event
{
    import net.wg.infrastructure.base.meta.impl.EventSquadViewMeta;
    import net.wg.infrastructure.base.meta.IEventSquadViewMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.DropdownMenu;
    import net.wg.gui.components.common.FrameStateCmpnt;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.gui.prebattle.squads.event.data.EventSquadDifficultyVO;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.events.ListEvent;
    import flash.events.MouseEvent;
    import net.wg.gui.prebattle.squads.event.data.EventSquadDifficultyRendererVO;
    import net.wg.data.constants.generated.SQUADTYPES;
    import org.idmedia.as3commons.util.StringUtils;

    public class EventSquadView extends EventSquadViewMeta implements IEventSquadViewMeta
    {

        private static const DIFFICULTY_LABEL:String = "difficulty";

        private static const SQUAD_LABEL:String = "Squad";

        private static const INVITE_BTN_Y_EVENT_SQUAD:int = 415;

        private static const STARS_OFFSET_Y:int = 8;

        private static const STARS_COMMANDER_OFFSET_X:int = 336;

        private static const STARS_OFFSET_X:int = 330;

        private static const DD_OFFSET_Y:int = 2;

        public var difficultyTF:TextField = null;

        public var difficultyDropdown:DropdownMenu = null;

        public var difficultyStars:FrameStateCmpnt = null;

        private var _toolTipMgr:ITooltipMgr;

        private var _data:EventSquadDifficultyVO = null;

        public function EventSquadView()
        {
            this._toolTipMgr = App.toolTipMgr;
            super();
        }

        override protected function updateDifficulty(param1:EventSquadDifficultyVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        override protected function draw() : void
        {
            var _loc1_:* = false;
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                _loc1_ = this._data.isCommander;
                this.difficultyStars.frameLabel = _loc1_?DIFFICULTY_LABEL + this._data.difficultyLevel:DIFFICULTY_LABEL + this._data.difficultyLevel + SQUAD_LABEL;
                this.difficultyStars.x = _loc1_?STARS_COMMANDER_OFFSET_X:STARS_OFFSET_X;
                this.difficultyDropdown.visible = _loc1_;
                this.difficultyTF.visible = !_loc1_;
                if(_loc1_)
                {
                    this.difficultyDropdown.dataProvider = this._data.difficultiesData;
                    this.difficultyDropdown.selectedIndex = this._data.difficultyLevel - 1;
                }
            }
        }

        override protected function initBattleType() : void
        {
            super.initBattleType();
            this.difficultyTF.y = inviteBtn.y - DD_OFFSET_Y;
            this.difficultyDropdown.y = inviteBtn.y - DD_OFFSET_Y;
            this.difficultyStars.y = this.difficultyDropdown.y + STARS_OFFSET_Y;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.difficultyTF.text = EVENT.EVENT_SQUAD_DIFFICULTY;
            this.difficultyTF.visible = false;
            this.difficultyStars.mouseEnabled = this.difficultyStars.mouseChildren = false;
            this.difficultyDropdown.focusable = true;
            this.difficultyDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.onDifficultyDropdownChangeHandler);
            this.difficultyDropdown.addEventListener(MouseEvent.CLICK,this.onDifficultyDropdownClick);
            this.difficultyDropdown.addEventListener(MouseEvent.ROLL_OVER,this.onDifficultyDropdownOverHandler);
            this.difficultyDropdown.addEventListener(MouseEvent.ROLL_OUT,this.onDifficultyDropdownOutHandler);
            this.difficultyDropdown.checkItemDisabledFunction = this.checkItemDisabledFunction;
            this.difficultyTF.addEventListener(MouseEvent.ROLL_OVER,this.onDifficultyDropdownOverHandler);
            this.difficultyTF.addEventListener(MouseEvent.ROLL_OUT,this.onDifficultyDropdownOutHandler);
        }

        override protected function onDispose() : void
        {
            this._toolTipMgr = null;
            this._data = null;
            this.difficultyTF.removeEventListener(MouseEvent.ROLL_OVER,this.onDifficultyDropdownOverHandler);
            this.difficultyTF.removeEventListener(MouseEvent.ROLL_OUT,this.onDifficultyDropdownOutHandler);
            this.difficultyTF = null;
            this.difficultyStars.dispose();
            this.difficultyStars = null;
            this.difficultyDropdown.checkItemDisabledFunction = null;
            this.difficultyDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.onDifficultyDropdownChangeHandler);
            this.difficultyDropdown.removeEventListener(MouseEvent.CLICK,this.onDifficultyDropdownClick);
            this.difficultyDropdown.removeEventListener(MouseEvent.ROLL_OVER,this.onDifficultyDropdownOverHandler);
            this.difficultyDropdown.removeEventListener(MouseEvent.ROLL_OUT,this.onDifficultyDropdownOutHandler);
            this.difficultyDropdown.dispose();
            this.difficultyDropdown = null;
            super.onDispose();
        }

        public function as_enableDifficultyDropdown(param1:Boolean) : void
        {
            this.difficultyDropdown.enabled = param1;
        }

        private function checkItemDisabledFunction(param1:EventSquadDifficultyRendererVO) : Boolean
        {
            return param1.disabled == true;
        }

        override protected function get squadType() : String
        {
            return SQUADTYPES.SQUAD_TYPE_EVENT;
        }

        override protected function get teamSectionPosY() : Number
        {
            return INVITE_BTN_Y_EVENT_SQUAD;
        }

        private function onDifficultyDropdownChangeHandler(param1:ListEvent) : void
        {
            var _loc2_:int = param1.index + 1;
            this.difficultyStars.frameLabel = DIFFICULTY_LABEL + _loc2_;
            selectDifficultyS(_loc2_);
        }

        private function onDifficultyDropdownClick(param1:MouseEvent) : void
        {
            this.difficultyDropdown.focused = 1;
        }

        private function onDifficultyDropdownOverHandler(param1:MouseEvent) : void
        {
            if(StringUtils.isNotEmpty(this._data.tooltip))
            {
                this._toolTipMgr.showComplex(this._data.tooltip);
            }
        }

        private function onDifficultyDropdownOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }
    }
}
