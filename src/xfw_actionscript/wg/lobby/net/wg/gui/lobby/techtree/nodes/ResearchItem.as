package net.wg.gui.lobby.techtree.nodes
{
    import net.wg.gui.components.advanced.ModuleTypesUIWithFill;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.gui.lobby.techtree.controls.ActionButton;
    import net.wg.gui.lobby.techtree.controls.XPField;
    import net.wg.gui.lobby.techtree.interfaces.IResearchContainer;
    import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
    import net.wg.data.Aliases;
    import scaleform.clik.constants.InvalidationType;
    import flash.display.BlendMode;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.lobby.techtree.constants.XpTypeStrings;
    import net.wg.gui.lobby.techtree.constants.NodeEntityType;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.techtree.constants.NodeRendererState;
    import flash.display.DisplayObject;
    import net.wg.data.constants.generated.NODE_STATE_FLAGS;
    import net.wg.gui.lobby.techtree.TechTreeEvent;

    public class ResearchItem extends Renderer
    {

        private static const DEFAULT_EXTRA_ICON_X:int = 41;

        private static const DEFAULT_EXTRA_ICON_Y:int = 41;

        private static const EXTRA_ICON_ALPHA_TRANSPARENT:Number = 0.5;

        private static const EXTRA_ICON_ALPHA:Number = 1;

        public var typeIcon:ModuleTypesUIWithFill;

        public var levelIcon:MovieClip;

        public var nameField:TextField;

        public var button:ActionButton;

        public var xpField:XPField;

        public function ResearchItem()
        {
            super();
        }

        override public function getExtraState() : Object
        {
            return {
                "isRootInInventory":(container != null?container.rootRenderer.inInventory():0),
                "isParentUnlocked":(container != null?IResearchContainer(container).hasUnlockedParent(matrixPosition.row - 1,index):false)
            };
        }

        override public function showContextMenu() : void
        {
            if(this.button != null)
            {
                this.button.endAnimation(true);
            }
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.RESEARCH_ITEM,this,{
                "nodeCD":valueObject.id,
                "rootCD":container.rootRenderer.getID(),
                "nodeState":valueObject.state,
                "previewAlias":Aliases.RESEARCH
            });
        }

        override public function toString() : String
        {
            return "[ResearchItem " + index + ", " + name + "]";
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.STATE))
            {
                this.nameField.blendMode = BlendMode.ADD;
            }
        }

        override protected function validateData() : void
        {
            var _loc2_:String = null;
            var _loc1_:String = getItemName();
            this.nameField.wordWrap = true;
            this.nameField.autoSize = TextFieldAutoSize.CENTER;
            this.nameField.text = _loc1_;
            _loc2_ = getItemType();
            if(_loc2_.length > 0)
            {
                this.typeIcon.visible = true;
                App.utils.asserter.assertFrameExists(_loc2_,this.typeIcon);
                this.typeIcon.gotoAndStop(_loc2_);
            }
            else
            {
                this.typeIcon.visible = false;
            }
            var _loc3_:int = getLevel();
            if(_loc3_ > -1)
            {
                this.levelIcon.gotoAndStop(_loc3_);
            }
            if(this.xpField)
            {
                if(!this.isAutoUnlocked)
                {
                    this.xpField.setData(valueObject.unlockProps.xpCost,XpTypeStrings.COST_XP_TYPE);
                }
                else
                {
                    this.xpField.visible = false;
                }
            }
            if(this.button != null)
            {
                this.button.action = stateProps.action;
                this.button.label = valueObject.costLabel;
                this.button.enabled = isActionEnabled();
                this.button.visible = stateProps.visible;
                this.button.setAnimation(stateProps.id,stateProps.animation);
                this.button.setOwner(this);
            }
            this.applyExtraSource();
            super.validateData();
        }

        override protected function onDispose() : void
        {
            if(this.button)
            {
                this.button.dispose();
                this.button = null;
            }
            this.typeIcon.dispose();
            this.typeIcon = null;
            if(this.xpField != null)
            {
                this.xpField.dispose();
                this.xpField = null;
            }
            this.levelIcon = null;
            this.nameField = null;
            super.onDispose();
        }

        override protected function initialize() : void
        {
            super.initialize();
            entityType = NodeEntityType.RESEARCH_ITEM;
            tooltipID = TOOLTIPS_CONSTANTS.TECHTREE_MODULE;
            delegateToChildren();
        }

        override protected function addNodeEventHandlers() : void
        {
            super.addNodeEventHandlers();
            hit.addEventListener(MouseEvent.CLICK,this.onHitClickHandler,false,0,true);
        }

        override protected function removeNodeEventHandlers() : void
        {
            hit.removeEventListener(MouseEvent.CLICK,this.onHitClickHandler);
            super.removeNodeEventHandlers();
        }

        private function applyExtraSource() : void
        {
            var _loc1_:String = valueObject.extraInfo;
            this.typeIcon.hideExtraIcon();
            if(_loc1_ && _loc1_.length > 0)
            {
                this.setExtraIcon(_loc1_);
            }
        }

        private function setExtraIcon(param1:String) : void
        {
            this.typeIcon.setExtraIconBySource(param1);
            this.typeIcon.extraIconX = DEFAULT_EXTRA_ICON_X;
            this.typeIcon.extraIconY = DEFAULT_EXTRA_ICON_Y;
            if((this.button && this.button.visible || this.xpField && this.xpField.visible) != true)
            {
                this.typeIcon.showExtraIcon();
                this.typeIcon.extraIconAlpha = nodeState == NodeRendererState.LOCKED?EXTRA_ICON_ALPHA_TRANSPARENT:EXTRA_ICON_ALPHA;
            }
        }

        override protected function get mouseEnabledChildren() : Vector.<DisplayObject>
        {
            var _loc1_:Vector.<DisplayObject> = super.mouseEnabledChildren;
            if(this.button)
            {
                _loc1_.push(this.button);
            }
            return _loc1_;
        }

        private function get isAutoUnlocked() : Boolean
        {
            return dataInited && (valueObject.state & NODE_STATE_FLAGS.AUTO_UNLOCKED) > 0;
        }

        private function onHitClickHandler(param1:MouseEvent) : void
        {
            if(App.utils.commons.isLeftButton(param1))
            {
                dispatchEvent(new TechTreeEvent(TechTreeEvent.CLICK_2_OPEN,nodeState,_index,entityType));
            }
        }
    }
}
