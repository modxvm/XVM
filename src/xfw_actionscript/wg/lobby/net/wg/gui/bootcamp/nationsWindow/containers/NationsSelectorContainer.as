package net.wg.gui.bootcamp.nationsWindow.containers
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.controls.SoundButtonEx;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.bootcamp.nationsWindow.events.NationSelectEvent;

    public class NationsSelectorContainer extends MovieClip implements IDisposable
    {

        public var selectItem:MovieClip = null;

        public var btnUsa:NationButton = null;

        public var btnGe:NationButton = null;

        public var btnUssr:NationButton = null;

        public var bottomBG:MovieClip = null;

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
            this.selectItem = null;
            this.btnUsa.dispose();
            this.btnUsa = null;
            this.btnGe.dispose();
            this.btnGe = null;
            this.btnUssr.dispose();
            this.btnUssr = null;
            this.bottomBG = null;
        }

        public function selectNation(param1:int) : void
        {
            this._selectedNation = param1;
            if(this._nationButtons.length > param1)
            {
                this.selectItem.x = this._nationButtons[param1].x;
            }
        }

        public function setWidth(param1:int) : void
        {
            this.bottomBG.width = param1;
            this.bottomBG.x = -param1 >> 1;
        }

        protected function configUI() : void
        {
            this.btnUsa.setSource(RES_ICONS.MAPS_ICONS_BOOTCAMP_REWARDS_NATIONSSELECTUSA);
            this.btnGe.setSource(RES_ICONS.MAPS_ICONS_BOOTCAMP_REWARDS_NATIONSSELECTGE);
            this.btnUssr.setSource(RES_ICONS.MAPS_ICONS_BOOTCAMP_REWARDS_NATIONSSELECTUSSR);
            this.btnUsa.addEventListener(ButtonEvent.CLICK,this.onBtnNationClickHandler);
            this.btnGe.addEventListener(ButtonEvent.CLICK,this.onBtnNationClickHandler);
            this.btnUssr.addEventListener(ButtonEvent.CLICK,this.onBtnNationClickHandler);
            this.btnUsa.label = BOOTCAMP.AWARD_OPTIONS_NATION_US;
            this.btnGe.label = BOOTCAMP.AWARD_OPTIONS_NATION_GE;
            this.btnUssr.label = BOOTCAMP.AWARD_OPTIONS_NATION_USSR;
            this._nationButtons.push(this.btnUsa,this.btnGe,this.btnUssr);
            this.selectItem.mouseEnabled = this.selectItem.mouseChildren = this.bottomBG.mouseEnabled = this.bottomBG.mouseChildren = false;
        }

        private function onBtnNationClickHandler(param1:ButtonEvent) : void
        {
            var _loc2_:SoundButtonEx = SoundButtonEx(param1.currentTarget);
            var _loc3_:uint = this._nationButtons.indexOf(_loc2_);
            if(_loc3_ == this._selectedNation)
            {
                return;
            }
            this.selectNation(_loc3_);
            dispatchEvent(new NationSelectEvent(NationSelectEvent.NATION_SHOW,this._selectedNation));
        }
    }
}
