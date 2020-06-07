package net.wg.gui.battle.views.consumablesPanel
{
    import net.wg.infrastructure.base.meta.impl.ConsumablesPanelMeta;
    import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesPanel;
    import net.wg.utils.IStageSizeDependComponent;
    import net.wg.utils.StageSizeBoundaries;
    import net.wg.data.constants.InvalidationType;
    import net.wg.gui.battle.components.buttons.BattleButton;
    import flash.events.MouseEvent;
    import net.wg.data.constants.generated.CONSUMABLES_PANEL_SETTINGS;
    import net.wg.data.constants.Linkages;
    import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesButton;
    import net.wg.data.constants.generated.BATTLE_CONSUMABLES_PANEL_TAGS;
    import net.wg.gui.battle.views.consumablesPanel.VO.ConsumablesVO;
    import net.wg.gui.battle.views.consumablesPanel.interfaces.IBattleShellButton;
    import net.wg.gui.battle.views.consumablesPanel.events.ConsumablesPanelEvent;
    import net.wg.gui.battle.views.consumablesPanel.constants.COLOR_STATES;
    import flash.geom.ColorTransform;
    import scaleform.gfx.MouseEventEx;

    public class ConsumablesPanel extends ConsumablesPanelMeta implements IConsumablesPanel, IStageSizeDependComponent
    {

        private static const CONSUMABLES_PANEL_Y_OFFSET:int = 58;

        private static const ITEM_WIDTH_PADDING:int = 57;

        private static const ITEM_WIDTH_SHORT_PADDING:int = 49;

        private static const ITEM_WIDTH_PADDING_BIG:int = 82;

        private static const CONSUMABLES_PANEL_Y_OFFSET_BIG:int = 85;

        private static const POPUP_Y_OFFSET:int = -6;

        private static const DATA_SLOT_IDX:int = 0;

        private static const KEYCODE_IDX:int = 1;

        private static const KEY_IDX:int = 2;

        protected static const INVALIDATE_DRAW_LAYOUT:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;

        protected static const INVALIDATE_POSITION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;

        protected var stageWidth:int = 0;

        protected var stageHeight:int = 0;

        protected var renderers:Vector.<BattleButton>;

        protected var slotIdxMap:Vector.<int>;

        private var _shellCurrentIdx:int = -1;

        private var _shellNextIdx:int = -1;

        private var _expandedIdx:int = -1;

        private var _popUp:EntitiesStatePopup;

        private var _isExpand:Boolean = false;

        private var _isReplay:Boolean = false;

        private var _settings:Vector.<ConsumablesPanelSettings>;

        private var _bottomPadding:int = -1;

        private var _itemsPadding:int = -1;

        private var _settingsId:int = -1;

        private var _equipmentButtonLinkage:String = "";

        private var _basePanelWidth:Number = 0;

        public function ConsumablesPanel()
        {
            this.renderers = new Vector.<BattleButton>();
            this.slotIdxMap = new <int>[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];
            this._settings = new Vector.<ConsumablesPanelSettings>();
            super();
            App.stageSizeMgr.register(this);
        }

        private static function getItemWidthPadding(param1:int) : int
        {
            return param1 < StageSizeBoundaries.WIDTH_1280?ITEM_WIDTH_SHORT_PADDING:ITEM_WIDTH_PADDING;
        }

        override protected function configUI() : void
        {
            super.configUI();
            App.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onStageMouseDownHandler);
        }

        override protected function onPopulate() : void
        {
            super.onPopulate();
            var _loc1_:int = getItemWidthPadding(App.appWidth);
            this._settings[CONSUMABLES_PANEL_SETTINGS.DEFAULT_SETTINGS_ID] = new ConsumablesPanelSettings(CONSUMABLES_PANEL_Y_OFFSET,_loc1_,Linkages.EQUIPMENT_BUTTON);
            this._settings[CONSUMABLES_PANEL_SETTINGS.BIG_SETTINGS_ID] = new ConsumablesPanelSettings(CONSUMABLES_PANEL_Y_OFFSET_BIG,ITEM_WIDTH_PADDING_BIG,Linkages.BC_EQUIPMENT_BUTTON);
        }

        override protected function onDispose() : void
        {
            var _loc1_:BattleButton = null;
            App.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStageMouseDownHandler);
            if(this._popUp)
            {
                this._popUp.dispose();
                this._popUp = null;
            }
            for each(_loc1_ in this.renderers)
            {
                _loc1_.dispose();
            }
            this.renderers.splice(0,this.renderers.length);
            this.renderers = null;
            this.slotIdxMap = null;
            this._settings.splice(0,this._settings.length);
            this._settings = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(INVALIDATE_DRAW_LAYOUT))
            {
                this.drawLayout();
                invalidate(INVALIDATE_POSITION);
            }
            if(isInvalid(INVALIDATE_POSITION))
            {
                this.updatePosition();
            }
        }

        override protected function expandEquipmentSlot(param1:int, param2:Array) : void
        {
            this.collapsePopup();
            this.expandPopup(param1,param2);
        }

        override protected function setKeysToSlots(param1:Array) : void
        {
            var _loc2_:IConsumablesButton = null;
            var _loc3_:Array = null;
            for each(_loc3_ in param1)
            {
                _loc2_ = this.getRendererBySlotIdx(_loc3_[DATA_SLOT_IDX]);
                if(_loc2_)
                {
                    _loc2_.key = _loc3_[KEY_IDX];
                    _loc2_.consumablesVO.keyCode = _loc3_[KEYCODE_IDX];
                }
            }
        }

        public function as_addEquipmentSlot(param1:int, param2:Number, param3:Number, param4:String, param5:int, param6:Number, param7:Number, param8:String, param9:String) : void
        {
            if(param4 == null)
            {
                var param4:String = BATTLE_CONSUMABLES_PANEL_TAGS.WITHOUT_TAG;
            }
            var _loc10_:BattleEquipmentButton = App.utils.classFactory.getComponent(this._equipmentButtonLinkage,BattleEquipmentButton);
            addChild(_loc10_);
            var _loc11_:ConsumablesVO = _loc10_.consumablesVO;
            _loc11_.keyCode = param2;
            _loc11_.tag = param4;
            _loc11_.idx = param1;
            _loc10_.isReplay = this._isReplay;
            _loc10_.icon = param8;
            _loc10_.tooltipStr = param9;
            _loc10_.quantity = param5;
            _loc10_.key = param3;
            _loc10_.addClickCallBack(this);
            _loc10_.setCoolDownTime(param6,param7,param7 - param6,false);
            var _loc12_:int = this.renderers.length;
            this.renderers.push(_loc10_);
            this.slotIdxMap[param1] = _loc12_;
            invalidate(INVALIDATE_DRAW_LAYOUT);
        }

        public function as_addOptionalDeviceSlot(param1:int, param2:Number, param3:String, param4:String) : void
        {
            var _loc5_:BattleOptionalDeviceButton = App.utils.classFactory.getComponent(Linkages.OPTIONAL_DEVICE_BUTTON,BattleOptionalDeviceButton);
            addChild(_loc5_);
            _loc5_.icon = param3;
            _loc5_.tooltipStr = param4;
            _loc5_.setCoolDownTime(param2,param2,0,false);
            var _loc6_:int = this.renderers.length;
            this.renderers.push(_loc5_);
            this.slotIdxMap[param1] = _loc6_;
            invalidate(INVALIDATE_DRAW_LAYOUT);
        }

        public function as_addShellSlot(param1:int, param2:Number, param3:Number, param4:int, param5:Number, param6:String, param7:String, param8:String) : void
        {
            var _loc9_:BattleShellButton = App.utils.classFactory.getComponent(Linkages.SHELL_BUTTON_BATTLE,BattleShellButton);
            addChild(_loc9_);
            var _loc10_:ConsumablesVO = _loc9_.consumablesVO;
            _loc10_.shellIconPath = param6;
            _loc10_.noShellIconPath = param7;
            _loc10_.keyCode = param2;
            _loc10_.idx = param1;
            _loc9_.tooltipStr = param8;
            _loc9_.setQuantity(param4,true);
            _loc9_.key = param3;
            _loc9_.addClickCallBack(this);
            var _loc11_:int = this.renderers.length;
            this.renderers.push(_loc9_);
            this.slotIdxMap[param1] = _loc11_;
            invalidate(INVALIDATE_DRAW_LAYOUT);
        }

        public function as_collapseEquipmentSlot() : void
        {
            this.collapsePopup();
        }

        public function as_handleAsReplay() : void
        {
            this._isReplay = true;
        }

        public function as_hideGlow(param1:int) : void
        {
            var _loc2_:IConsumablesButton = this.getRendererBySlotIdx(param1);
            if(_loc2_)
            {
                _loc2_.hideGlow();
            }
        }

        public function as_isVisible() : Boolean
        {
            return this._isExpand;
        }

        public function as_reset() : void
        {
            var _loc1_:BattleButton = null;
            this._shellCurrentIdx = -1;
            this._shellNextIdx = -1;
            this.collapsePopup();
            for each(_loc1_ in this.renderers)
            {
                removeChild(_loc1_);
                _loc1_.dispose();
            }
            this.renderers.length = 0;
            this.slotIdxMap.length = 0;
            this.slotIdxMap = new <int>[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];
        }

        public function as_setCoolDownPosAsPercent(param1:int, param2:Number) : void
        {
            var _loc3_:IConsumablesButton = this.getRendererBySlotIdx(param1);
            if(_loc3_)
            {
                _loc3_.setCoolDownPosAsPercent(param2);
            }
        }

        public function as_setCoolDownTime(param1:int, param2:Number, param3:Number, param4:Number, param5:Boolean) : void
        {
            var _loc6_:IConsumablesButton = this.getRendererBySlotIdx(param1);
            if(_loc6_)
            {
                _loc6_.setCoolDownTime(param2,param3,param4,param5);
            }
        }

        public function as_setCoolDownTimeSnapshot(param1:int, param2:int, param3:Boolean, param4:Boolean) : void
        {
            var _loc5_:IConsumablesButton = this.getRendererBySlotIdx(param1);
            if(_loc5_)
            {
                _loc5_.setTimerSnapshot(param2,param3);
            }
        }

        public function as_setCurrentShell(param1:int) : void
        {
            var _loc2_:IBattleShellButton = null;
            if(this._shellNextIdx == param1)
            {
                _loc2_ = this.getRendererBySlotIdx(this._shellNextIdx) as BattleShellButton;
                if(_loc2_)
                {
                    _loc2_.setNext(false,true);
                }
                this._shellNextIdx = -1;
            }
            if(this._shellCurrentIdx >= 0)
            {
                _loc2_ = this.getRendererBySlotIdx(this._shellCurrentIdx) as BattleShellButton;
                if(_loc2_)
                {
                    _loc2_.clearCoolDownTime();
                    _loc2_.setCurrent(false,true);
                }
            }
            _loc2_ = this.getRendererBySlotIdx(param1) as BattleShellButton;
            if(_loc2_ && _loc2_.enabled && !_loc2_.empty)
            {
                this._shellCurrentIdx = param1;
                _loc2_.setCurrent(true);
            }
        }

        public function as_setEquipmentActivated(param1:int) : void
        {
            var _loc2_:IConsumablesButton = this.getRendererBySlotIdx(param1);
            if(_loc2_)
            {
                _loc2_.setActivated();
            }
        }

        public function as_setGlow(param1:int, param2:int) : void
        {
            var _loc3_:IConsumablesButton = this.getRendererBySlotIdx(param1);
            if(_loc3_)
            {
                _loc3_.showGlow(param2);
            }
        }

        public function as_setItemQuantityInSlot(param1:int, param2:int) : void
        {
            var _loc3_:IConsumablesButton = this.getRendererBySlotIdx(param1);
            if(_loc3_)
            {
                _loc3_.quantity = param2;
            }
        }

        public function as_setItemTimeQuantityInSlot(param1:int, param2:int, param3:Number, param4:Number) : void
        {
            var _loc5_:IConsumablesButton = this.getRendererBySlotIdx(param1);
            if(_loc5_)
            {
                _loc5_.setCoolDownTime(param3,param4,param4 - param3,false);
                _loc5_.quantity = param2;
            }
        }

        public function as_setNextShell(param1:int) : void
        {
            var _loc2_:IBattleShellButton = null;
            if(param1 == this._shellNextIdx)
            {
                return;
            }
            if(this._shellNextIdx >= 0)
            {
                _loc2_ = this.getRendererBySlotIdx(this._shellNextIdx) as BattleShellButton;
                if(_loc2_)
                {
                    _loc2_.setNext(false,true);
                }
            }
            _loc2_ = this.getRendererBySlotIdx(param1) as BattleShellButton;
            if(_loc2_ && _loc2_.enabled && !_loc2_.empty)
            {
                this._shellNextIdx = param1;
                _loc2_.setNext(true);
            }
        }

        public function as_setPanelSettings(param1:int) : void
        {
            if(this._settingsId == param1)
            {
                return;
            }
            this._settingsId = param1;
            var _loc2_:ConsumablesPanelSettings = this._settings[this._settingsId];
            this._bottomPadding = _loc2_.bottomPadding;
            this._itemsPadding = _loc2_.itemPadding;
            this._equipmentButtonLinkage = _loc2_.equipmentButtonLinkage;
            invalidate(INVALIDATE_DRAW_LAYOUT);
        }

        public function as_showEquipmentSlots(param1:Boolean) : void
        {
            var _loc2_:* = false;
            var _loc4_:IConsumablesButton = null;
            var _loc3_:int = this.renderers.length;
            var _loc5_:uint = 0;
            while(_loc5_ < _loc3_)
            {
                _loc4_ = this.getRenderer(_loc5_);
                if(_loc4_ is BattleEquipmentButton)
                {
                    _loc4_.visible = param1;
                    _loc2_ = true;
                }
                _loc5_++;
            }
            if(_loc2_)
            {
                invalidate();
            }
        }

        public function as_updateEntityState(param1:String, param2:String) : int
        {
            var _loc3_:* = -1;
            if(this._isExpand)
            {
                this._popUp.updateData(param1,param2);
                _loc3_ = this._expandedIdx;
            }
            return _loc3_;
        }

        public function getRendererBySlotIdx(param1:int) : IConsumablesButton
        {
            var _loc2_:int = this.slotIdxMap[param1];
            return _loc2_ >= 0?IConsumablesButton(this.renderers[_loc2_]):null;
        }

        public function onButtonClick(param1:Object) : void
        {
            onClickedToSlotS(param1.consumablesVO.keyCode,param1.consumablesVO.idx);
        }

        public function setStateSizeBoundaries(param1:int, param2:int) : void
        {
            if(this._settingsId == CONSUMABLES_PANEL_SETTINGS.DEFAULT_SETTINGS_ID)
            {
                this._itemsPadding = getItemWidthPadding(param1);
                this._settings[this._settingsId].updateItemPadding(this._itemsPadding);
                invalidate(INVALIDATE_DRAW_LAYOUT);
            }
        }

        public function updateStage(param1:Number, param2:Number) : void
        {
            this.stageWidth = param1;
            this.stageHeight = param2;
            invalidate(INVALIDATE_POSITION);
        }

        protected function drawLayout() : void
        {
            var _loc3_:IConsumablesButton = null;
            var _loc1_:int = this.slotIdxMap.length;
            var _loc2_:* = 0;
            var _loc4_:int = this._itemsPadding;
            var _loc5_:uint = 0;
            while(_loc5_ < _loc1_)
            {
                if(this.slotIdxMap[_loc5_] >= 0)
                {
                    _loc3_ = this.getRendererBySlotIdx(_loc5_);
                    if(_loc3_ && _loc3_.visible)
                    {
                        _loc3_.x = _loc2_;
                        _loc2_ = _loc2_ + _loc4_;
                    }
                }
                _loc5_++;
            }
            this._basePanelWidth = _loc2_;
        }

        protected function getRenderer(param1:int) : IConsumablesButton
        {
            return IConsumablesButton(this.renderers[param1]);
        }

        private function updatePosition() : void
        {
            x = this.stageWidth - this._basePanelWidth >> 1;
            y = this.stageHeight - this._bottomPadding;
            dispatchEvent(new ConsumablesPanelEvent(ConsumablesPanelEvent.UPDATE_POSITION));
        }

        private function expandPopup(param1:int, param2:Array) : void
        {
            this._expandedIdx = param1;
            if(!this._popUp)
            {
                this._popUp = App.utils.classFactory.getComponent(Linkages.ENTITIES_POPUP,EntitiesStatePopup);
                addChild(this._popUp);
                this._popUp.addClickHandler(this);
                this._popUp.createPopup(param2);
            }
            else
            {
                this._popUp.setData(param2);
            }
            this._popUp.visible = true;
            this._popUp.x = this._basePanelWidth - this._popUp.width >> 1;
            this._popUp.y = -CONSUMABLES_PANEL_Y_OFFSET - POPUP_Y_OFFSET ^ 0;
            this._isExpand = true;
            this.getRendererBySlotIdx(this._expandedIdx).showConsumableBorder = true;
            dispatchEvent(new ConsumablesPanelEvent(ConsumablesPanelEvent.SWITCH_POPUP));
            this.setColorTransformForRenderers();
        }

        private function collapsePopup() : void
        {
            if(!this._isExpand)
            {
                return;
            }
            this.getRendererBySlotIdx(this._expandedIdx).showConsumableBorder = false;
            onPopUpClosedS();
            this._expandedIdx = -1;
            this._isExpand = false;
            if(!this._popUp)
            {
                return;
            }
            this._popUp.visible = false;
            dispatchEvent(new ConsumablesPanelEvent(ConsumablesPanelEvent.SWITCH_POPUP));
            this.clearColorTransformForRenderers();
        }

        private function setColorTransformForRenderers() : void
        {
            var _loc2_:IConsumablesButton = null;
            var _loc1_:ColorTransform = COLOR_STATES.DARK_COLOR_TRANSFORM;
            var _loc3_:int = this.renderers.length;
            var _loc4_:uint = 0;
            while(_loc4_ < _loc3_)
            {
                if(_loc4_ != this.slotIdxMap[this._expandedIdx])
                {
                    _loc2_ = this.getRenderer(_loc4_);
                    if(_loc2_)
                    {
                        _loc2_.setColorTransform(_loc1_);
                    }
                }
                _loc4_++;
            }
        }

        private function clearColorTransformForRenderers() : void
        {
            var _loc1_:IConsumablesButton = null;
            var _loc2_:int = this.renderers.length;
            var _loc3_:uint = 0;
            while(_loc3_ < _loc2_)
            {
                _loc1_ = this.getRenderer(_loc3_);
                if(_loc1_)
                {
                    _loc1_.clearColorTransform();
                }
                _loc3_++;
            }
        }

        public function get isExpand() : Boolean
        {
            return this._isExpand;
        }

        public function get panelWidth() : Number
        {
            return this.x + this._basePanelWidth;
        }

        private function onStageMouseDownHandler(param1:MouseEvent) : void
        {
            var _loc2_:MouseEventEx = param1 as MouseEventEx;
            var _loc3_:uint = _loc2_ == null?0:_loc2_.buttonIdx;
            if(_loc3_ != 0)
            {
                return;
            }
            if(this._isExpand)
            {
                if(!(param1.target is EntityStateButton))
                {
                    this.collapsePopup();
                }
            }
        }
    }
}

class ConsumablesPanelSettings extends Object
{

    public var bottomPadding:int = -1;

    public var itemPadding:int = -1;

    public var equipmentButtonLinkage:String = "";

    function ConsumablesPanelSettings(param1:int, param2:int, param3:String)
    {
        super();
        this.bottomPadding = param1;
        this.itemPadding = param2;
        this.equipmentButtonLinkage = param3;
    }

    public function updateItemPadding(param1:int) : void
    {
        this.itemPadding = param1;
    }
}
