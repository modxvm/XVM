package net.wg.gui.lobby.techtree.nodes
{
    import net.wg.gui.lobby.techtree.controls.FadeComponent;
    import flash.text.TextField;
    import net.wg.gui.lobby.techtree.controls.TypeAndLevelField;
    import net.wg.infrastructure.interfaces.IImage;
    import net.wg.gui.lobby.techtree.controls.ActionButton;
    import flash.display.Sprite;
    import net.wg.gui.lobby.techtree.controls.XPField;
    import net.wg.gui.components.controls.TradeIco;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.gui.lobby.techtree.constants.NodeEntityType;
    import flash.geom.Point;
    import net.wg.gui.lobby.techtree.data.vo.NTDisplayInfo;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
    import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
    import net.wg.gui.lobby.techtree.constants.XpTypeStrings;
    import flash.events.MouseEvent;
    import flash.display.DisplayObject;
    import net.wg.data.constants.Linkages;
    import net.wg.gui.lobby.techtree.constants.NodeRendererState;
    import flash.geom.ColorTransform;
    import net.wg.gui.lobby.techtree.TechTreeEvent;

    public class NationTreeNode extends Renderer
    {

        private static const TRADE_POS_X:Number = 14;

        private static const TRADE_POS_Y:Number = 33;

        private static const XP_FIELD_DEFAULT_OFFSET_X:int = 20;

        private static const XP_FIELD_ACTION_OFFSET_X:int = 0;

        private static const PROGRESS_BAR_RESEARCH_AVAILABLE_ALPHA:Number = 1;

        private static const PROGRESS_BAR_RESEARCH_UNAVAILABLE_ALPHA:Number = 0.7;

        private static const BOTTOM_ARROW_OFFSET:Number = 6;

        private static const BOTTOM_ARROW_OFFSET_ACTION:Number = 8;

        private static const IN_X_OFFSET:Number = -3;

        private static const BLUEPRINT_PLUS_COLOR_OFFSET:int = 50;

        private static const NAME_TF_FULL_WIDTH:int = 124;

        private static const NAME_TF_SHORT_WIDTH_FOR_NATION_CHANGE_ICON:int = 108;

        public var blueprintProgressBar:FadeComponent = null;

        public var blueprintBorder:FadeComponent = null;

        public var blueprintCount:TextField = null;

        public var blueprintPlus:FadeComponent = null;

        public var typeAndLevel:TypeAndLevelField = null;

        public var vehicleImage:IImage = null;

        public var button:ActionButton = null;

        public var discountIcon:Sprite = null;

        public var nationChangeIcon:Sprite = null;

        public var xpField:XPField = null;

        public var nameTF:TextField = null;

        private var _trade:TradeIco = null;

        private var _tooltipMgr:ITooltipMgr;

        public function NationTreeNode()
        {
            this._tooltipMgr = App.toolTipMgr;
            super();
        }

        override public function getGraphicsName() : String
        {
            return LINES_AND_ARROWS_NAME + NodeEntityType.NATION_TREE + _index.toString();
        }

        override public function getIconPath() : String
        {
            return dataInited?valueObject.smallIconPath:"";
        }

        override public function getInX() : Number
        {
            return x + IN_X_OFFSET;
        }

        override public function invalidateNodeState() : void
        {
            var _loc2_:Point = null;
            super.invalidateNodeState();
            var _loc1_:Object = getDisplayInfo();
            if(_loc1_ && _loc1_ is NTDisplayInfo)
            {
                _loc2_ = NTDisplayInfo(_loc1_).position;
                if(_loc2_ != null)
                {
                    setPosition(_loc2_);
                }
            }
            if(isAnnouncement)
            {
                tooltipID = TOOLTIPS_CONSTANTS.TECHTREE_VEHICLE_ANNOUNCEMENT;
            }
            else
            {
                tooltipID = TOOLTIPS_CONSTANTS.TECHTREE_VEHICLE;
            }
        }

        override public function showContextMenu() : void
        {
            this.button.endAnimation(true);
            var _loc1_:Object = {
                "nodeCD":valueObject.id,
                "nodeState":valueObject.state
            };
            if(this.isBlueprintMode)
            {
                App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.BLUEPRINT_VEHICLE,this,_loc1_);
            }
            else
            {
                App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.RESEARCH_VEHICLE,this,_loc1_);
            }
        }

        override public function showTooltip() : void
        {
            if(this.isBlueprintMode && valueObject && valueObject.dataIsReady && this._tooltipMgr != null)
            {
                this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.BLUEPRINT_INFO,null,valueObject.id);
                return;
            }
            super.showTooltip();
        }

        override public function toString() : String
        {
            return "[NationTreeNode " + index + ", " + name + "]";
        }

        override protected function validateData() : void
        {
            var _loc2_:String = null;
            visible = !(this.isBlueprintMode && !canHaveBlueprint());
            if(!visible)
            {
                return;
            }
            super.validateData();
            var _loc1_:String = this.getIconPath();
            this.vehicleImage.alpha = stateProps.cmpAlpha;
            this.vehicleImage.source = _loc1_;
            this.typeAndLevel.setOwner(this);
            this.nameTF.text = getItemName();
            if(this.discountIcon)
            {
                this.discountIcon.visible = hasAction;
            }
            if(this.xpField)
            {
                this.xpField.visible = true;
                this.xpField.alpha = stateProps.cmpAlpha;
                if(isLocked())
                {
                    this.xpField.setData(valueObject.unlockProps.xpCost,XpTypeStrings.COST_XP_TYPE);
                }
                else if(getEarnedXP() > 0 && !stateProps.visible)
                {
                    _loc2_ = isElite()?XpTypeStrings.ELITE_XP_TYPE:XpTypeStrings.EARNED_XP_TYPE;
                    this.xpField.setData(getEarnedXP(),_loc2_);
                }
                else
                {
                    this.xpField.visible = false;
                }
                this.xpField.x = this.discountIcon && this.discountIcon.visible?XP_FIELD_ACTION_OFFSET_X:XP_FIELD_DEFAULT_OFFSET_X;
            }
            if(isRestoreAvailable())
            {
                this.button.label = App.utils.locale.makeString(MENU.RESEARCH_LABELS_BUTTON_RESTORE);
            }
            else
            {
                this.button.label = valueObject.costLabel;
            }
            this.button.action = stateProps.action;
            this.button.enabled = isActionEnabled();
            this.button.visible = stateProps.visible;
            this.button.setAnimation(stateProps.id,stateProps.animation);
            this.button.setOwner(this);
            if(this.isBlueprintMode)
            {
                this.blueprintBorder.enabled = isNext2Unlock();
                this.blueprintProgressBar.scaleX = blueprintProgress;
                this.blueprintProgressBar.alpha = isNext2Unlock()?PROGRESS_BAR_RESEARCH_AVAILABLE_ALPHA:PROGRESS_BAR_RESEARCH_UNAVAILABLE_ALPHA;
                this.blueprintProgressBar.enabled = !isUnlocked();
                this.blueprintCount.htmlText = blueprintLabel;
                this.blueprintCount.visible = !isUnlocked();
                this.blueprintPlus.enabled = blueprintCanConvert && !isUnlocked();
                this.blueprintPlus.buttonMode = true;
            }
            else
            {
                this.blueprintProgressBar.enabled = false;
                this.blueprintBorder.enabled = false;
                this.blueprintPlus.enabled = false;
            }
            this.nationChangeIcon.visible = valueObject.isNationChangeAvailable;
            this.nameTF.width = valueObject.isNationChangeAvailable?NAME_TF_SHORT_WIDTH_FOR_NATION_CHANGE_ICON:NAME_TF_FULL_WIDTH;
            this.setTradeIcon();
        }

        override protected function onDispose() : void
        {
            this.button.dispose();
            this.button = null;
            this.typeAndLevel.dispose();
            this.typeAndLevel = null;
            this.vehicleImage.dispose();
            this.vehicleImage = null;
            this.blueprintProgressBar.dispose();
            this.blueprintProgressBar = null;
            this.blueprintBorder.dispose();
            this.blueprintBorder = null;
            this.blueprintPlus.removeEventListener(MouseEvent.ROLL_OVER,this.onBlueprintPlusRollOverHandler);
            this.blueprintPlus.removeEventListener(MouseEvent.ROLL_OUT,this.onBlueprintPlusRollOutHandler);
            this.blueprintPlus.removeEventListener(MouseEvent.CLICK,this.onBlueprintPlusClickHandler);
            this.blueprintPlus.dispose();
            this.blueprintPlus = null;
            if(this.xpField)
            {
                this.xpField.dispose();
                this.xpField = null;
            }
            if(this._trade)
            {
                this.removeChild(this._trade);
                this._trade.dispose();
                this._trade = null;
            }
            this.blueprintCount = null;
            this.discountIcon = null;
            this.nameTF = null;
            this._tooltipMgr = null;
            this.nationChangeIcon = null;
            super.onDispose();
        }

        override protected function get mouseEnabledChildren() : Vector.<DisplayObject>
        {
            var _loc1_:Vector.<DisplayObject> = super.mouseEnabledChildren;
            _loc1_.push(this.button);
            _loc1_.push(this.blueprintPlus);
            if(this._trade != null)
            {
                _loc1_.push(this._trade);
            }
            return _loc1_;
        }

        override protected function initialize() : void
        {
            super.initialize();
            entityType = NodeEntityType.NATION_TREE;
            delegateToChildren();
        }

        override protected function addNodeEventHandlers() : void
        {
            super.addNodeEventHandlers();
            addEventListener(MouseEvent.ROLL_OVER,this.onNationNodeRollOverHandler,false,0,true);
            addEventListener(MouseEvent.ROLL_OUT,this.onNationNodeRollOutHandler,false,0,true);
            hit.addEventListener(MouseEvent.CLICK,this.onHitClickHandler,false,0,true);
        }

        override protected function removeNodeEventHandlers() : void
        {
            removeEventListener(MouseEvent.ROLL_OVER,this.onNationNodeRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onNationNodeRollOutHandler);
            hit.removeEventListener(MouseEvent.CLICK,this.onHitClickHandler);
            super.removeNodeEventHandlers();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.blueprintPlus.addEventListener(MouseEvent.ROLL_OVER,this.onBlueprintPlusRollOverHandler,false,0,true);
            this.blueprintPlus.addEventListener(MouseEvent.ROLL_OUT,this.onBlueprintPlusRollOutHandler,false,0,true);
            this.blueprintPlus.addEventListener(MouseEvent.CLICK,this.onBlueprintPlusClickHandler,false,0,true);
        }

        private function setTradeIcon() : void
        {
            if(isTradeIn())
            {
                if(this._trade == null)
                {
                    this._trade = App.utils.classFactory.getComponent(Linkages.TRADE_ICO_UI,TradeIco);
                    this._trade.x = TRADE_POS_X;
                    this._trade.y = TRADE_POS_Y;
                    this.addChildAt(this._trade,this.numChildren);
                    this._trade.setData(valueObject.id,label);
                }
            }
            else if(this._trade != null)
            {
                this.removeChild(this._trade);
                this._trade.dispose();
                this._trade = null;
            }
        }

        override public function get bottomArrowOffset() : Number
        {
            if(nodeState == NodeRendererState.LOCKED || nodeState == NodeRendererState.BLUEPRINTS_LOCKED)
            {
                return super.bottomArrowOffset;
            }
            if(stateProps.visible)
            {
                return BOTTOM_ARROW_OFFSET_ACTION;
            }
            return BOTTOM_ARROW_OFFSET;
        }

        public function get isBlueprintMode() : Boolean
        {
            return entityType == NodeEntityType.BLUEPRINT_TREE;
        }

        private function blueprintPlusHoverEffectEnable() : void
        {
            var _loc1_:ColorTransform = new ColorTransform();
            _loc1_.blueOffset = BLUEPRINT_PLUS_COLOR_OFFSET;
            _loc1_.greenOffset = BLUEPRINT_PLUS_COLOR_OFFSET;
            _loc1_.redOffset = BLUEPRINT_PLUS_COLOR_OFFSET;
            this.blueprintPlus.transform.colorTransform = _loc1_;
            App.utils.commons.setGlowFilter(this.blueprintPlus,4.283871231E9);
        }

        private function blueprintPlusHoverEffectDisable() : void
        {
            this.blueprintPlus.filters = [];
            this.blueprintPlus.transform.colorTransform = null;
        }

        private function onHitClickHandler(param1:MouseEvent) : void
        {
            if(!isNotClickable() && App.utils.commons.isLeftButton(param1))
            {
                dispatchEvent(new TechTreeEvent(TechTreeEvent.CLICK_2_OPEN,nodeState,_index,entityType));
            }
        }

        private function onNationNodeRollOverHandler(param1:MouseEvent) : void
        {
            if(this.button != null)
            {
                this.button.startAnimation();
            }
        }

        private function onNationNodeRollOutHandler(param1:MouseEvent) : void
        {
            if(this.button != null)
            {
                this.button.endAnimation(false);
            }
        }

        private function onBlueprintPlusRollOverHandler(param1:MouseEvent) : void
        {
            if(this._tooltipMgr)
            {
                this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.BLUEPRINT_CONVERT_INFO,null,valueObject.id);
            }
            this.blueprintPlusHoverEffectEnable();
        }

        private function onBlueprintPlusRollOutHandler(param1:MouseEvent) : void
        {
            if(this._tooltipMgr)
            {
                this._tooltipMgr.hide();
            }
            this.blueprintPlusHoverEffectDisable();
        }

        private function onBlueprintPlusClickHandler(param1:MouseEvent) : void
        {
            dispatchEvent(new TechTreeEvent(TechTreeEvent.GO_TO_BLUEPRINT_VIEW,nodeState,_index,entityType));
        }
    }
}
