package net.wg.gui.lobby.modulesPanel.components
{
    import flash.text.TextField;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.modulesPanel.data.BattleAbilityVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.data.constants.SoundTypes;
    import net.wg.data.constants.Values;
    import org.idmedia.as3commons.util.StringUtils;
    import scaleform.clik.events.ListEvent;
    import net.wg.gui.events.DeviceEvent;

    public class BattleAbilityItemRenderer extends FittingListItemRenderer
    {

        private static const EQUIPPED_ON_VEHICLE:String = "vehicle";

        private static const BUTTON_WIDTH:int = 140;

        private static const DISABLED_ALPHA:Number = 0.5;

        private static const NOT_ACTIVATED_TF_OFFSET:int = 15;

        public var descField:TextField = null;

        public var notActivatedTF:TextField = null;

        public var filterTF:TextField = null;

        public var removeButton:ISoundButtonEx = null;

        public var changeOrderButton:ISoundButtonEx = null;

        public var levelIcon:MovieClip = null;

        private var _battleAbilityVO:BattleAbilityVO = null;

        private var _tooltipMgr:ITooltipMgr;

        public function BattleAbilityItemRenderer()
        {
            this._tooltipMgr = App.toolTipMgr;
            super();
        }

        override public function setData(param1:Object) : void
        {
            super.setData(param1);
            this._battleAbilityVO = BattleAbilityVO(param1);
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.notActivatedTF.x = width - this.notActivatedTF.width - NOT_ACTIVATED_TF_OFFSET | 0;
                this.filterTF.x = width - this.filterTF.width - NOT_ACTIVATED_TF_OFFSET | 0;
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.changeOrderButton.visible = false;
            this.changeOrderButton.focusTarget = this;
            this.changeOrderButton.width = BUTTON_WIDTH;
            this.changeOrderButton.addEventListener(ButtonEvent.CLICK,this.onChangeOrderButtonClickHandler);
            this.changeOrderButton.soundType = SoundTypes.ITEM_RDR;
            this.removeButton.visible = false;
            this.removeButton.focusTarget = this;
            this.removeButton.width = BUTTON_WIDTH;
            this.removeButton.addEventListener(ButtonEvent.CLICK,this.onRemoveButtonClickHandler);
            this.removeButton.soundType = SoundTypes.ITEM_RDR;
            this.levelIcon.mouseEnabled = this.levelIcon.mouseChildren = false;
            this.descField.mouseEnabled = this.notActivatedTF.mouseEnabled = this.filterTF.mouseEnabled = false;
            this.notActivatedTF.text = EPIC_BATTLE.FITTINGSELECTPOPOVER_NOTACTIVATED;
            this.notActivatedTF.alpha = DISABLED_ALPHA;
        }

        override protected function onDispose() : void
        {
            this.changeOrderButton.removeEventListener(ButtonEvent.CLICK,this.onChangeOrderButtonClickHandler);
            this.changeOrderButton.dispose();
            this.changeOrderButton = null;
            this.removeButton.removeEventListener(ButtonEvent.CLICK,this.onRemoveButtonClickHandler);
            this.removeButton.dispose();
            this.removeButton = null;
            this.descField = null;
            this.notActivatedTF = null;
            this.filterTF = null;
            this.levelIcon = null;
            this._battleAbilityVO = null;
            this._tooltipMgr = null;
            super.onDispose();
        }

        override protected function setup() : void
        {
            var _loc1_:* = false;
            var _loc2_:String = null;
            var _loc3_:* = false;
            var _loc4_:* = false;
            var _loc5_:* = 0;
            var _loc6_:String = null;
            var _loc7_:* = false;
            super.setup();
            if(this._battleAbilityVO != null)
            {
                _loc1_ = this._battleAbilityVO.isSelected;
                _loc2_ = this._battleAbilityVO.filterText;
                _loc3_ = _loc2_ != Values.EMPTY_STR;
                _loc4_ = !_loc1_ && this._battleAbilityVO.target == EQUIPPED_ON_VEHICLE;
                _loc5_ = this._battleAbilityVO.level;
                this.removeButton.visible = _loc1_;
                this.changeOrderButton.visible = _loc4_;
                if(this.removeButton.visible)
                {
                    this.removeButton.label = this._battleAbilityVO.removeButtonLabel;
                }
                else if(this.changeOrderButton.visible)
                {
                    this.changeOrderButton.label = this._battleAbilityVO.changeOrderButtonLabel;
                }
                this.levelIcon.visible = _loc5_ > 0;
                if(this.levelIcon.visible)
                {
                    this.levelIcon.gotoAndStop(_loc5_);
                }
                this.filterTF.text = _loc2_;
                _loc6_ = this._battleAbilityVO.desc;
                this.descField.visible = !_loc1_ && !_loc4_ && StringUtils.isNotEmpty(_loc6_);
                if(this.descField.visible)
                {
                    App.utils.commons.truncateTextFieldText(this.descField,_loc6_,false,true);
                }
                errorField.visible = false;
                _loc7_ = this._battleAbilityVO.disabled;
                this.notActivatedTF.visible = _loc7_ && !_loc1_ && !_loc4_ && !_loc3_;
                this.changeOrderButton.soundEnabled = _loc7_;
                this.removeButton.soundEnabled = _loc7_;
            }
        }

        override protected function showItemTooltip() : void
        {
            this._tooltipMgr.showSpecial(this._battleAbilityVO.tooltipType,null,this._battleAbilityVO.id,this._battleAbilityVO.slotIndex);
        }

        private function onChangeOrderButtonClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new ListEvent(ListEvent.ITEM_CLICK,false,true,_index));
        }

        private function onRemoveButtonClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new DeviceEvent(DeviceEvent.DEVICE_REMOVE,this._battleAbilityVO.id));
        }
    }
}
