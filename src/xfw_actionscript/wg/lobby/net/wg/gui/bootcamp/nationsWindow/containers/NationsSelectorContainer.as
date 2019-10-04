package net.wg.gui.bootcamp.nationsWindow.containers
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.controls.IconButton;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.text.TextField;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.bootcamp.nationsWindow.events.NationSelectEvent;

    public class NationsSelectorContainer extends MovieClip implements IDisposable
    {

        private static const LIGHT_ICON:String = "light";

        private static const MEDIUM_ICON:String = "medium";

        private static const TO_DELIMITER:String = "to";

        public var btnUsa:IconButton = null;

        public var btnGe:IconButton = null;

        public var btnUssr:IconButton = null;

        public var btnSelect:SoundButtonEx = null;

        public var txtUS:TextField = null;

        public var txtGE:TextField = null;

        public var txtUSSR:TextField = null;

        public var bottomBG:MovieClip = null;

        public var txtTankUSSR:TankInfoContainer = null;

        public var txtTankGE:TankInfoContainer = null;

        public var txtTankUS:TankInfoContainer = null;

        private var _selectedNation:int = 0;

        private var _nationButtons:Vector.<SoundButtonEx>;

        public function NationsSelectorContainer()
        {
            this._nationButtons = new Vector.<SoundButtonEx>();
            super();
            this.configUI();
        }

        public final function dispose() : void
        {
            this._nationButtons.splice(0,this._nationButtons.length);
            this._nationButtons = null;
            this.btnUsa.removeEventListener(ButtonEvent.CLICK,this.onBtnNationClickHandler);
            this.btnGe.removeEventListener(ButtonEvent.CLICK,this.onBtnNationClickHandler);
            this.btnUssr.removeEventListener(ButtonEvent.CLICK,this.onBtnNationClickHandler);
            this.btnSelect.removeEventListener(ButtonEvent.CLICK,this.onBtnSelectClickHandler);
            this.btnUsa.dispose();
            this.btnUsa = null;
            this.btnGe.dispose();
            this.btnGe = null;
            this.btnUssr.dispose();
            this.btnUssr = null;
            this.btnSelect.dispose();
            this.btnSelect = null;
            this.txtUS = null;
            this.txtGE = null;
            this.txtUSSR = null;
            this.bottomBG = null;
            this.txtTankUSSR.dispose();
            this.txtTankUSSR = null;
            this.txtTankGE.dispose();
            this.txtTankGE = null;
            this.txtTankUS.dispose();
            this.txtTankUS = null;
        }

        public function selectNation(param1:int, param2:String) : void
        {
            this._selectedNation = param1;
            gotoAndPlay(param2);
            this.updateTextFields();
        }

        protected function configUI() : void
        {
            this.btnSelect.label = BOOTCAMP.BTN_SELECT;
            this.updateTextFields();
            this.txtTankUS.setTankIfo(MEDIUM_ICON,BOOTCAMP.AWARD_OPTIONS_NAME_US,BOOTCAMP.AWARD_OPTIONS_DESCRIPTION_US);
            this.txtTankGE.setTankIfo(LIGHT_ICON,BOOTCAMP.AWARD_OPTIONS_NAME_GE,BOOTCAMP.AWARD_OPTIONS_DESCRIPTION_GE);
            this.txtTankUSSR.setTankIfo(LIGHT_ICON,BOOTCAMP.AWARD_OPTIONS_NAME_USSR,BOOTCAMP.AWARD_OPTIONS_DESCRIPTION_USSR);
            this.btnUsa.iconSource = RES_ICONS.MAPS_ICONS_BOOTCAMP_REWARDS_NATIONSSELECTUSA;
            this.btnUssr.iconSource = RES_ICONS.MAPS_ICONS_BOOTCAMP_REWARDS_NATIONSSELECTUSSR;
            this.btnGe.iconSource = RES_ICONS.MAPS_ICONS_BOOTCAMP_REWARDS_NATIONSSELECTGE;
            this.btnUsa.addEventListener(ButtonEvent.CLICK,this.onBtnNationClickHandler);
            this.btnGe.addEventListener(ButtonEvent.CLICK,this.onBtnNationClickHandler);
            this.btnUssr.addEventListener(ButtonEvent.CLICK,this.onBtnNationClickHandler);
            this.btnSelect.addEventListener(ButtonEvent.CLICK,this.onBtnSelectClickHandler);
            this._nationButtons.push(this.btnUsa,this.btnGe,this.btnUssr);
        }

        private function updateTextFields() : void
        {
            this.txtUS.text = BOOTCAMP.AWARD_OPTIONS_NATION_US;
            this.txtGE.text = BOOTCAMP.AWARD_OPTIONS_NATION_GE;
            this.txtUSSR.text = BOOTCAMP.AWARD_OPTIONS_NATION_USSR;
        }

        private function onBtnSelectClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new NationSelectEvent(NationSelectEvent.NATION_SELECTED,this._selectedNation));
        }

        private function onBtnNationClickHandler(param1:ButtonEvent) : void
        {
            var _loc2_:SoundButtonEx = SoundButtonEx(param1.currentTarget);
            var _loc3_:uint = this._nationButtons.indexOf(_loc2_);
            if(_loc3_ == this._selectedNation)
            {
                return;
            }
            var _loc4_:String = (this._selectedNation + 1).toString() + TO_DELIMITER + (_loc3_ + 1).toString();
            this.selectNation(_loc3_,_loc4_);
            dispatchEvent(new NationSelectEvent(NationSelectEvent.NATION_SHOW,this._selectedNation));
        }
    }
}
