package net.wg.gui.lobby.battleResults.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.lobby.battleResults.components.detailsBlockStates.ComparePremiumState;
    import net.wg.gui.lobby.battleResults.components.detailsBlockStates.PremiumBonusState;
    import net.wg.gui.lobby.battleResults.components.detailsBlockStates.PremiumInfoState;
    import net.wg.gui.lobby.battleResults.components.detailsBlockStates.AdvertisingState;
    import net.wg.gui.lobby.battleResults.data.PersonalDataVO;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.generated.BATTLE_RESULTS_PREMIUM_STATES;

    public class DetailsBlock extends UIComponentEx
    {

        public var compareState:ComparePremiumState = null;

        public var bonusState:PremiumBonusState = null;

        public var premiumInfoState:PremiumInfoState = null;

        public var advertisingState:AdvertisingState = null;

        private var _currentSelectedVehIdx:int = 0;

        private var _data:PersonalDataVO = null;

        public function DetailsBlock()
        {
            super();
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data != null)
            {
                if(isInvalid(InvalidationType.DATA))
                {
                    this.bonusState.visible = this._data.dynamicPremiumState == BATTLE_RESULTS_PREMIUM_STATES.PREMIUM_BONUS;
                    this.compareState.visible = this._data.dynamicPremiumState == BATTLE_RESULTS_PREMIUM_STATES.PREMIUM_EARNINGS;
                    this.premiumInfoState.visible = this._data.dynamicPremiumState == BATTLE_RESULTS_PREMIUM_STATES.PREMIUM_INFO;
                    this.advertisingState.visible = this._data.dynamicPremiumState == BATTLE_RESULTS_PREMIUM_STATES.PREMIUM_ADVERTISING;
                    if(this.premiumInfoState.visible)
                    {
                        this.premiumInfoState.setData(this._data.premiumInfo);
                    }
                    if(this.compareState.visible)
                    {
                        this.compareState.setData(this._data);
                    }
                    if(this.bonusState.visible)
                    {
                        this.bonusState.setData(this._data.premiumBonus);
                    }
                    if(this.advertisingState.visible)
                    {
                        this.advertisingState.setData(this._data.premiumInfo);
                    }
                }
                if(isInvalid(InvalidationType.SELECTED_INDEX))
                {
                    this.compareState.currentSelectedVehIdx = this._currentSelectedVehIdx;
                }
            }
        }

        override protected function onDispose() : void
        {
            this.bonusState.dispose();
            this.bonusState = null;
            this.compareState.dispose();
            this.compareState = null;
            this.premiumInfoState.dispose();
            this.premiumInfoState = null;
            this.advertisingState.dispose();
            this.advertisingState = null;
            this._data = null;
            super.onDispose();
        }

        public function set data(param1:PersonalDataVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        public function set currentSelectedVehIdx(param1:int) : void
        {
            this._currentSelectedVehIdx = param1;
            invalidate(InvalidationType.SELECTED_INDEX);
        }
    }
}
