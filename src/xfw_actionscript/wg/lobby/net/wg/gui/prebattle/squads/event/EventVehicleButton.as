package net.wg.gui.prebattle.squads.event
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.cyberSport.controls.interfaces.IVehicleButton;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.gui.prebattle.squads.event.vo.GeneralVO;
    import net.wg.data.constants.ComponentState;
    import net.wg.gui.rally.vo.VehicleVO;
    import flash.events.MouseEvent;
    import net.wg.gui.rally.events.RallyViewsEvent;
    import scaleform.gfx.TextFieldEx;

    public class EventVehicleButton extends SoundButtonEx implements IVehicleButton
    {

        public static const SELECTED_VEHICLE:int = 0;

        public static const CHOOSE_VEHICLE:int = 1;

        public static const DEFAULT_STATE:int = 3;

        private static const UPDATE_INIT_DATA:String = "updateInitData";

        public var logo:MovieClip = null;

        public var generalTF:TextField = null;

        public var levelTF:TextField = null;

        private var _currentState:int = 3;

        private var _updatedFlag:Boolean = false;

        private var _generalVO:GeneralVO = null;

        private var _currentViewType:String = "autoSearch";

        public function EventVehicleButton()
        {
            super();
            TextFieldEx.setNoTranslate(this.levelTF,true);
        }

        override protected function draw() : void
        {
            super.draw();
            if(!this._updatedFlag && isInvalid(UPDATE_INIT_DATA))
            {
                if(this._generalVO != null)
                {
                    this._currentState = SELECTED_VEHICLE;
                    this.generalTF.text = this._generalVO.name;
                    this.levelTF.text = this._generalVO.romanLevel;
                    this.logo.gotoAndStop(this._generalVO.logo);
                }
                this._updatedFlag = true;
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            buttonMode = false;
            App.soundMgr.removeSoundHdlrs(this);
        }

        override protected function onDispose() : void
        {
            this.clearData();
            this.logo = null;
            this.generalTF = null;
            this.levelTF = null;
            super.onDispose();
        }

        override protected function handleRelease(param1:uint = 0) : void
        {
            super.handleRelease(param1);
            setState(focusIndicator == null?ComponentState.OUT:ComponentState.KB_RELEASE);
        }

        public function reset() : void
        {
            this.clearData();
            invalidate(UPDATE_INIT_DATA);
        }

        public function setGeneral(param1:GeneralVO) : void
        {
            if(this._generalVO != param1)
            {
                this._generalVO = param1;
                this._updatedFlag = false;
                invalidate(UPDATE_INIT_DATA);
            }
        }

        public function selectState(param1:Boolean, param2:String = null) : void
        {
        }

        public function setVehicle(param1:VehicleVO) : void
        {
        }

        private function clearData() : void
        {
            this._updatedFlag = false;
            this._generalVO = null;
        }

        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            mouseChildren = true;
        }

        public function get currentViewType() : String
        {
            return this._currentViewType;
        }

        public function set currentViewType(param1:String) : void
        {
            this._currentViewType = param1;
        }

        public function get forceSoundEnable() : Boolean
        {
            return false;
        }

        public function set forceSoundEnable(param1:Boolean) : void
        {
        }

        public function get showRangeRosterBg() : Boolean
        {
            return false;
        }

        public function set showRangeRosterBg(param1:Boolean) : void
        {
        }

        public function get vehicleCount() : int
        {
            return -1;
        }

        public function set vehicleCount(param1:int) : void
        {
        }

        public function get showCommanderSettings() : Boolean
        {
            return false;
        }

        public function set showCommanderSettings(param1:Boolean) : void
        {
        }

        public function get currentState() : int
        {
            return this._currentState;
        }

        public function get showAlertIcon() : Boolean
        {
            return false;
        }

        public function set showAlertIcon(param1:Boolean) : void
        {
        }

        override protected function handleMousePress(param1:MouseEvent) : void
        {
        }

        override protected function handleMouseRelease(param1:MouseEvent) : void
        {
        }

        override protected function handleMouseRollOver(param1:MouseEvent) : void
        {
            dispatchEvent(new RallyViewsEvent(RallyViewsEvent.VEH_BTN_ROLL_OVER));
        }

        override protected function handleMouseRollOut(param1:MouseEvent) : void
        {
            dispatchEvent(new RallyViewsEvent(RallyViewsEvent.VEH_BTN_ROLL_OUT));
        }
    }
}
