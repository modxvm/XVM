package net.wg.gui.lobby.techtree.nodes 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.techtree.*;
    import net.wg.gui.lobby.techtree.constants.*;
    import net.wg.gui.lobby.techtree.controls.*;
    import net.wg.gui.lobby.techtree.data.state.*;
    import net.wg.gui.lobby.techtree.data.vo.*;
    import net.wg.gui.lobby.techtree.interfaces.*;
    import net.wg.gui.lobby.techtree.math.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    import scaleform.gfx.*;
    
    public class Renderer extends net.wg.gui.components.controls.SoundListItemRenderer implements net.wg.gui.lobby.techtree.interfaces.IRenderer
    {
        public function Renderer()
        {
            scaleform.gfx.Extensions.enabled = true;
            super();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (!_baseDisposed) 
            {
                if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
                {
                    if (this._valueObject == null) 
                    {
                        visible = false;
                    }
                    else 
                    {
                        visible = true;
                        this.populateUI();
                    }
                }
            }
            return;
        }

        protected function getMouseEnabledChildren():__AS3__.vec.Vector.<flash.display.DisplayObjectContainer>
        {
            var loc1:*=new Vector.<flash.display.DisplayObjectContainer>();
            if (this.hit != null) 
            {
                loc1.push(this.hit);
            }
            if (this.button != null) 
            {
                loc1.push(this.button);
            }
            return loc1;
        }

        protected function disableMouseChildren():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=this.getMouseEnabledChildren();
            var loc4:*=0;
            while (loc4 < numChildren) 
            {
                loc1 = getChildAt(loc4);
                if (loc1 is flash.display.DisplayObjectContainer && loc3.indexOf(loc1) == -1) 
                {
                    loc2 = flash.display.DisplayObjectContainer(loc1);
                    var loc5:*;
                    loc2.mouseChildren = loc5 = false;
                    loc2.mouseEnabled = loc5;
                }
                ++loc4;
            }
            return;
        }

        protected function delegateEventsHandlers():void
        {
            mouseEnabled = false;
            this.disableMouseChildren();
            var loc1:*;
            this.hit.mouseEnabled = loc1 = true;
            this.hit.buttonMode = loc1;
            this.hit.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.handleMouseRollOver, false, 0, true);
            this.hit.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.handleMouseRollOut, false, 0, true);
            this.hit.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.handleMousePress, false, 0, true);
            this.hit.addEventListener(flash.events.MouseEvent.CLICK, this.handleMouseRelease, false, 0, true);
            this.hit.addEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.handleMouseRelease, false, 0, true);
            this.hit.addEventListener(scaleform.clik.events.InputEvent.INPUT, handleInput, false, 0, true);
            return;
        }

        protected function removeEventsHandlers():void
        {
            this.hit.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.handleMouseRollOver, false);
            this.hit.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.handleMouseRollOut, false);
            this.hit.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.handleMousePress, false);
            this.hit.removeEventListener(flash.events.MouseEvent.CLICK, this.handleMouseRelease, false);
            this.hit.removeEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.handleMouseRelease, false);
            this.hit.removeEventListener(scaleform.clik.events.InputEvent.INPUT, handleInput, false);
            return;
        }

        protected override function updateAfterStateChange():void
        {
            if (this.isDelegateEvents) 
            {
                this.disableMouseChildren();
            }
            super.updateAfterStateChange();
            return;
        }

        protected override function handleMouseRollOver(arg1:flash.events.MouseEvent):void
        {
            if (App.soundMgr) 
            {
                App.soundMgr.playControlsSnd(net.wg.data.constants.SoundManagerStates.SND_OVER, soundId, soundType);
            }
            if (this._tooltipID && !(App.toolTipMgr == null)) 
            {
                App.toolTipMgr.showSpecial(this._tooltipID, null, this._valueObject, this._container == null ? null : this._container.getRootNode().getID());
            }
            super.handleMouseRollOver(arg1);
            return;
        }

        public function cleanUp():void
        {
            this.container = null;
            if (this.button != null) 
            {
                this.button.dispose();
            }
            if (this.isDelegateEvents && !(this.hit == null)) 
            {
                this.removeEventsHandlers();
            }
            this.dataInited = false;
            this._valueObject = null;
            super.dispose();
            return;
        }

        protected override function handleMouseRollOut(arg1:flash.events.MouseEvent):void
        {
            if (App.soundMgr) 
            {
                App.soundMgr.playControlsSnd(net.wg.data.constants.SoundManagerStates.SND_OUT, soundId, soundType);
            }
            if (App.toolTipMgr != null) 
            {
                App.toolTipMgr.hide();
            }
            super.handleMouseRollOut(arg1);
            return;
        }

        protected override function handleMouseRelease(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRelease(arg1);
            if (arg1.eventPhase == flash.events.EventPhase.AT_TARGET && arg1 is scaleform.gfx.MouseEventEx && (arg1 as scaleform.gfx.MouseEventEx).buttonIdx == scaleform.gfx.MouseEventEx.RIGHT_BUTTON) 
            {
                this.showContextMenu();
            }
            return;
        }

        protected override function handleMousePress(arg1:flash.events.MouseEvent):void
        {
            if (App.soundMgr) 
            {
                App.soundMgr.playControlsSnd(net.wg.data.constants.SoundManagerStates.SND_PRESS, soundId, soundType);
            }
            if (App.toolTipMgr != null) 
            {
                App.toolTipMgr.hide();
            }
            super.handleMousePress(arg1);
            return;
        }

        public function get container():net.wg.gui.lobby.techtree.interfaces.INodesContainer
        {
            return this._container;
        }

        public function set container(arg1:net.wg.gui.lobby.techtree.interfaces.INodesContainer):void
        {
            this._container = arg1;
            return;
        }

        public function get matrixPosition():net.wg.gui.lobby.techtree.math.MatrixPosition
        {
            return this._matrixPosition;
        }

        public function setup(arg1:uint, arg2:net.wg.gui.lobby.techtree.data.vo.NodeData, arg3:uint=0, arg4:net.wg.gui.lobby.techtree.math.MatrixPosition=null):void
        {
            var loc2:*=null;
            if (arg3 != 0) 
            {
                this._entityType = arg3;
            }
            this._index = arg1;
            this._matrixPosition = arg4;
            if (this._valueObject == arg2 || arg2 == null) 
            {
                return;
            }
            this._valueObject = arg2;
            this.dataInited = true;
            this.updateStatesProps();
            setState(state);
            var loc1:*;
            if (!((loc1 = this.getDisplayInfo()) == null) && loc1 is net.wg.gui.lobby.techtree.data.vo.NTDisplayInfo) 
            {
                if ((loc2 = (loc1 as net.wg.gui.lobby.techtree.data.vo.NTDisplayInfo).position) != null) 
                {
                    this.setPosition(loc2);
                }
            }
            return;
        }

        internal function updateStatesProps():void
        {
            this.stateProps = net.wg.gui.lobby.techtree.data.state.NodeStateCollection.getStateProps(this._entityType, this.dataInited ? this._valueObject.state : 0, this.getExtraState());
            var loc1:*=net.wg.gui.lobby.techtree.data.state.NodeStateCollection.getStatePrefix(this.stateProps.index);
            statesSelected = Vector.<String>(["selected_", loc1]);
            statesDefault = Vector.<String>([loc1]);
            return;
        }

        public function getEntityType():uint
        {
            return this._entityType;
        }

        public function getID():Number
        {
            return this.dataInited ? this._valueObject.id : 0;
        }

        public function getItemName():String
        {
            return this.dataInited ? this._valueObject.nameString : "";
        }

        public function getItemType():String
        {
            return this.dataInited ? this._valueObject.primaryClass.name : "";
        }

        public function getLevel():int
        {
            return this.dataInited ? this._valueObject.level : -1;
        }

        public function getIconPath():String
        {
            return this.dataInited ? this._valueObject.iconPath : "";
        }

        public function getDisplayInfo():Object
        {
            return this.dataInited ? this._valueObject.displayInfo : null;
        }

        public function isNext2Unlock():Boolean
        {
            return this.dataInited && (this._valueObject.state & net.wg.gui.lobby.techtree.constants.NodeState.NEXT_2_UNLOCK) > 0;
        }

        public function isUnlocked():Boolean
        {
            return this.dataInited && (this._valueObject.state & net.wg.gui.lobby.techtree.constants.NodeState.UNLOCKED) > 0;
        }

        public function isElite():Boolean
        {
            return this.dataInited && (this._valueObject.state & net.wg.gui.lobby.techtree.constants.NodeState.ELITE) > 0;
        }

        public function isPremium():Boolean
        {
            return this.dataInited && (this._valueObject.state & net.wg.gui.lobby.techtree.constants.NodeState.PREMIUM) > 0;
        }

        public function inInventory():Boolean
        {
            return this.dataInited && (this._valueObject.state & net.wg.gui.lobby.techtree.constants.NodeState.IN_INVENTORY) > 0;
        }

        public function isAvailable4Unlock():Boolean
        {
            if (!this.dataInited) 
            {
                return false;
            }
            var loc1:*=this._valueObject.state;
            return (loc1 & net.wg.gui.lobby.techtree.constants.NodeState.NEXT_2_UNLOCK) > 0 && (loc1 & net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_XP) > 0;
        }

        public function isAvailable4Buy():Boolean
        {
            if (!this.dataInited) 
            {
                return false;
            }
            var loc1:*=this._valueObject.state;
            return (loc1 & net.wg.gui.lobby.techtree.constants.NodeState.UNLOCKED) > 0 && (loc1 & net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_MONEY) > 0 && (loc1 & net.wg.gui.lobby.techtree.constants.NodeState.IN_INVENTORY) == 0;
        }

        public function isAvailable4Sell():Boolean
        {
            return this.dataInited && (this._valueObject.state & net.wg.gui.lobby.techtree.constants.NodeState.CAN_SELL) > 0;
        }

        public function isActionEnabled():Boolean
        {
            if (!this.dataInited) 
            {
                return false;
            }
            return this.stateProps.enough == 0 || (this._valueObject.state & this.stateProps.enough) > 0;
        }

        public function isButtonVisible():Boolean
        {
            return this.stateProps.visible && this.stateProps.animation == null;
        }

        public function isSelected():Boolean
        {
            return this.dataInited && (this._valueObject.state & net.wg.gui.lobby.techtree.constants.NodeState.SELECTED) > 0;
        }

        public function isFake():Boolean
        {
            return false;
        }

        public function getEarnedXP():Number
        {
            return this.dataInited ? this._valueObject.earnedXP : 0;
        }

        public function getNamedLabel(arg1:String):String
        {
            var loc1:*=null;
            if (!this.dataInited) 
            {
                return "";
            }
            var loc2:*=arg1;
            switch (loc2) 
            {
                case net.wg.gui.lobby.techtree.constants.NamedLabels.XP_COST:
                {
                    loc1 = this._valueObject.unlockProps.xpCostLabel;
                    break;
                }
                case net.wg.gui.lobby.techtree.constants.NamedLabels.EARNED_XP:
                {
                    loc1 = this._valueObject.earnedXPLabel;
                    break;
                }
                case net.wg.gui.lobby.techtree.constants.NamedLabels.CREDITS_PRICE:
                {
                    loc1 = this._valueObject.shopPrice.creditsLabel;
                    break;
                }
                case net.wg.gui.lobby.techtree.constants.NamedLabels.GOLD_PRICE:
                {
                    loc1 = this._valueObject.shopPrice.goldLabel;
                    break;
                }
                default:
                {
                    loc1 = "";
                }
            }
            return loc1;
        }

        public function validateNowEx():void
        {
            this._doValidateNow = true;
            super.validateNow();
            return;
        }

        public function invalidateNodeState(arg1:Number):void
        {
            this.updateStatesProps();
            setState(state);
            if (arg1 > -1) 
            {
                net.wg.gui.lobby.techtree.MenuHandler.getInstance().hideMenu();
                dispatchEvent(new net.wg.gui.lobby.techtree.TechTreeEvent(net.wg.gui.lobby.techtree.TechTreeEvent.STATE_CHANGED, arg1, _index, this._entityType));
            }
            return;
        }

        public function getColorIdx(arg1:Number=-1):Number
        {
            var loc1:*=net.wg.gui.lobby.techtree.constants.ColorIndex.LOCKED;
            if (this.isUnlocked()) 
            {
                if (arg1 == -1 || arg1 > 0 && this.isParentUnlocked(arg1)) 
                {
                    loc1 = net.wg.gui.lobby.techtree.constants.ColorIndex.UNLOCKED;
                }
            }
            else if (this.isNext2Unlock()) 
            {
                if (arg1 == -1 || arg1 > 0 && this.isParentUnlocked(arg1)) 
                {
                    loc1 = net.wg.gui.lobby.techtree.constants.ColorIndex.NEXT2UNLOCK;
                }
            }
            return loc1;
        }

        public function getColorIdxEx(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer):Number
        {
            var loc1:*=net.wg.gui.lobby.techtree.constants.ColorIndex.LOCKED;
            if (this.isUnlocked()) 
            {
                if (arg1 == null || arg1.isUnlocked()) 
                {
                    loc1 = net.wg.gui.lobby.techtree.constants.ColorIndex.UNLOCKED;
                }
            }
            else if (this.isNext2Unlock()) 
            {
                if (arg1 == null || arg1.isUnlocked()) 
                {
                    loc1 = net.wg.gui.lobby.techtree.constants.ColorIndex.NEXT2UNLOCK;
                }
            }
            return loc1;
        }

        public function click2Unlock():void
        {
            dispatchEvent(new net.wg.gui.lobby.techtree.TechTreeEvent(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_UNLOCK, 0, _index, this._entityType));
            return;
        }

        public function click2Buy():void
        {
            dispatchEvent(new net.wg.gui.lobby.techtree.TechTreeEvent(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_BUY, 0, _index, this._entityType));
            return;
        }

        public function click2Sell():void
        {
            dispatchEvent(new net.wg.gui.lobby.techtree.TechTreeEvent(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_SELL, 0, _index, this._entityType));
            return;
        }

        public function click2Info():void
        {
            dispatchEvent(new net.wg.gui.lobby.techtree.TechTreeEvent(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_MODULE_INFO, 0, _index, this._entityType));
            return;
        }

        public function getInX():Number
        {
            return Math.round(x + (this.hit == null ? 0 : this.hit.x));
        }

        public function getOutX():Number
        {
            return x + (this.hit == null ? Math.round(_width) : this.hit.x + Math.round(this.hit.width));
        }

        public function getY():Number
        {
            return y + (this.hit == null ? Math.round(_height) >> 1 : this.hit.y + (Math.round(this.hit.height) >> 1));
        }

        public function getRatioY():Number
        {
            return this.hit == null ? Math.round(_height) >> 1 : Math.round(this.hit.height) >> 1;
        }

        public function getActualWidth():Number
        {
            return this.hit == null ? _width : this.hit.width;
        }

        public function setPosition(arg1:flash.geom.Point):void
        {
            if (this.hit == null) 
            {
                this.x = arg1.x;
                this.y = arg1.y;
            }
            else 
            {
                this.x = Math.round(arg1.x - this.hit.x);
                this.y = Math.round(arg1.y - this.hit.y);
            }
            return;
        }

        public function getExtraState():Object
        {
            return null;
        }

        public function showContextMenu():void
        {
            return;
        }

        public function isParentUnlocked(arg1:Number):Boolean
        {
            return this._container == null ? true : this._container.isParentUnlocked(arg1, this._valueObject.id);
        }

        public function populateUI():void
        {
            this._doValidateNow = false;
            return;
        }

        protected override function preInitialize():void
        {
            preventAutosizing = false;
            constraintsDisabled = true;
            super.preInitialize();
            _state = "up";
            this.dataInited = false;
            soundType = net.wg.gui.lobby.techtree.constants.TTSoundID.SUPER_TYPE;
            soundId = net.wg.gui.lobby.techtree.constants.TTSoundID.UNDEFINED;
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this.updateStatesProps();
            return;
        }

        protected override function configUI():void
        {
            if (this.isDelegateEvents && !(this.hit == null)) 
            {
                this.delegateEventsHandlers();
            }
            else 
            {
                super.configUI();
            }
            return;
        }

        protected var _valueObject:net.wg.gui.lobby.techtree.data.vo.NodeData;

        protected var _matrixPosition:net.wg.gui.lobby.techtree.math.MatrixPosition;

        protected var stateProps:net.wg.gui.lobby.techtree.data.state.StateProperties;

        protected var dataInited:Boolean;

        protected var isDelegateEvents:Boolean=false;

        protected var _container:net.wg.gui.lobby.techtree.interfaces.INodesContainer=null;

        protected var _entityType:uint=0;

        protected var _doValidateNow:Boolean=false;

        public var hit:flash.display.MovieClip;

        public var button:net.wg.gui.lobby.techtree.controls.ActionButton;

        protected var _tooltipID:String=null;
    }
}
