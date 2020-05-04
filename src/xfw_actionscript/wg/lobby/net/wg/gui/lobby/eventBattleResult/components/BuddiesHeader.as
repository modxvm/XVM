package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.gui.lobby.eventBattleResult.data.ResultDataVO;
    import flash.events.MouseEvent;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.components.paginator.vo.ToolTipVO;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.data.constants.Values;
    import net.wg.gui.lobby.eventBattleResult.events.EventBattleResultEvent;

    public class BuddiesHeader extends UIComponentEx
    {

        private static const INACTIVE_ALPHA:Number = 0.6;

        private static const HOVER_ALPHA:Number = 0.8;

        public var kills:ISoundButtonEx = null;

        public var damage:ISoundButtonEx = null;

        public var assist:ISoundButtonEx = null;

        public var armor:ISoundButtonEx = null;

        public var vehicles:ISoundButtonEx = null;

        public var arrow:MovieClip = null;

        public var playerTF:TextField = null;

        private var _tooltipMgr:ITooltipMgr;

        private var _sortButtons:Vector.<ISoundButtonEx> = null;

        private var _data:ResultDataVO = null;

        public function BuddiesHeader()
        {
            this._tooltipMgr = App.toolTipMgr;
            super();
            this._sortButtons = new <ISoundButtonEx>[this.kills,this.damage,this.assist,this.armor,this.vehicles];
        }

        override protected function configUI() : void
        {
            var _loc1_:ISoundButtonEx = null;
            super.configUI();
            this.playerTF.text = EVENT.RESULTSCREEN_ALLIES;
            for each(_loc1_ in this._sortButtons)
            {
                _loc1_.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
                _loc1_.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
                _loc1_.addEventListener(ButtonEvent.CLICK,this.onSortButtonClickHandler);
            }
            this.setActiveButton(this.vehicles);
        }

        public function setData(param1:ResultDataVO) : void
        {
            this._data = param1;
        }

        private function onRollOverHandler(param1:MouseEvent) : void
        {
            if(this._data == null)
            {
                return;
            }
            var _loc2_:ISoundButtonEx = ISoundButtonEx(param1.currentTarget);
            if(_loc2_.soundEnabled)
            {
                _loc2_.alpha = HOVER_ALPHA;
            }
            switch(_loc2_)
            {
                case this.armor:
                    this.showTooltip(this._data.alliesArmorTooltip);
                    break;
                case this.assist:
                    this.showTooltip(this._data.alliesAssistTooltip);
                    break;
                case this.kills:
                    this.showTooltip(this._data.alliesKillsTooltip);
                    break;
                case this.damage:
                    this.showTooltip(this._data.alliesDamageTooltip);
                    break;
                case this.vehicles:
                    this.showTooltip(this._data.alliesVehiclesTooltip);
                    break;
            }
        }

        override protected function onBeforeDispose() : void
        {
            var _loc1_:ISoundButtonEx = null;
            for each(_loc1_ in this._sortButtons)
            {
                _loc1_.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
                _loc1_.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
                _loc1_.removeEventListener(ButtonEvent.CLICK,this.onSortButtonClickHandler);
            }
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this._sortButtons.splice(0,this._sortButtons.length);
            this._sortButtons = null;
            this.kills.dispose();
            this.kills = null;
            this.damage.dispose();
            this.damage = null;
            this.assist.dispose();
            this.assist = null;
            this.armor.dispose();
            this.armor = null;
            this.vehicles.dispose();
            this.vehicles = null;
            this.playerTF = null;
            this.arrow = null;
            this._data = null;
            this._tooltipMgr = null;
            super.onDispose();
        }

        private function showTooltip(param1:ToolTipVO) : void
        {
            if(param1 == null)
            {
                return;
            }
            if(StringUtils.isNotEmpty(param1.tooltip))
            {
                this._tooltipMgr.showComplex(param1.tooltip);
            }
            else
            {
                this._tooltipMgr.showSpecial.apply(this._tooltipMgr,[param1.specialAlias,null].concat(param1.specialArgs));
            }
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.hide();
            var _loc2_:ISoundButtonEx = ISoundButtonEx(param1.currentTarget);
            if(_loc2_.soundEnabled)
            {
                _loc2_.alpha = INACTIVE_ALPHA;
            }
        }

        private function onSortButtonClickHandler(param1:ButtonEvent) : void
        {
            if(this._data == null)
            {
                return;
            }
            var _loc2_:int = Values.DEFAULT_INT;
            switch(param1.currentTarget)
            {
                case this.armor:
                    _loc2_ = ResultBuddies.SORT_ON_ARMOR;
                    break;
                case this.assist:
                    _loc2_ = ResultBuddies.SORT_ON_ASSIST;
                    break;
                case this.kills:
                    _loc2_ = ResultBuddies.SORT_ON_KILLS;
                    break;
                case this.damage:
                    _loc2_ = ResultBuddies.SORT_ON_DAMAGE;
                    break;
                case this.vehicles:
                    _loc2_ = ResultBuddies.SORT_ON_VEHICLE;
                    break;
            }
            this.setActiveButton(ISoundButtonEx(param1.currentTarget));
            dispatchEvent(new EventBattleResultEvent(EventBattleResultEvent.SORT_ON,_loc2_));
        }

        private function setActiveButton(param1:ISoundButtonEx) : void
        {
            var _loc2_:ISoundButtonEx = null;
            for each(_loc2_ in this._sortButtons)
            {
                _loc2_.alpha = _loc2_ == param1?Values.DEFAULT_ALPHA:INACTIVE_ALPHA;
                _loc2_.soundEnabled = _loc2_ != param1;
            }
            this.arrow.x = param1.x + (param1.width >> 1);
        }
    }
}
