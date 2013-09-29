package net.wg.gui.lobby.techtree.nodes 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.lobby.hangar.ammunitionPanel.*;
    import net.wg.gui.lobby.profile.components.*;
    import net.wg.gui.lobby.techtree.*;
    import net.wg.gui.lobby.techtree.constants.*;
    import net.wg.gui.lobby.techtree.controls.*;
    import net.wg.gui.lobby.techtree.interfaces.*;
    
    public class ResearchItem extends net.wg.gui.lobby.techtree.nodes.Renderer
    {
        public function ResearchItem()
        {
            super();
            return;
        }

        public override function cleanUp():void
        {
            if (this.xpLabel != null) 
            {
                this.xpLabel.dispose();
            }
            super.cleanUp();
            return;
        }

        public override function isAvailable4Buy():Boolean
        {
            if (!dataInited) 
            {
                return false;
            }
            return !(container == null) && this.containerEx.canInstallItems() && (_valueObject.state & net.wg.gui.lobby.techtree.constants.NodeState.INSTALLED) == 0 && super.isAvailable4Buy();
        }

        public override function isActionEnabled():Boolean
        {
            var loc1:*=super.isActionEnabled();
            if (loc1 && stateProps.enough == net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_MONEY) 
            {
                loc1 = !(container == null) && this.containerEx.canInstallItems() && (_valueObject.state & net.wg.gui.lobby.techtree.constants.NodeState.INSTALLED) == 0;
            }
            return loc1;
        }

        public override function populateUI():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            if (this.nameField != null) 
            {
                loc1 = getItemName();
                this.nameField.wordWrap = true;
                this.nameField.autoSize = flash.text.TextFieldAutoSize.CENTER;
                this.nameField.text = loc1;
            }
            if (this.typeIcon != null) 
            {
                loc2 = getItemType();
                if (loc2.length > 0) 
                {
                    this.typeIcon.visible = true;
                    this.typeIcon.gotoAndPlay(loc2);
                }
                else 
                {
                    this.typeIcon.visible = false;
                }
            }
            if (this.levelIcon != null) 
            {
                loc3 = getLevel();
                if (loc3 > -1) 
                {
                    this.levelIcon.gotoAndStop(loc3);
                }
            }
            if (this.xpLabel != null) 
            {
                this.xpLabel.visible = !this.isAutoUnlocked();
                if (this.xpLabel.visible) 
                {
                    this.xpLabel.setOwner(this, _doValidateNow);
                }
            }
            if (button != null) 
            {
                button.label = getNamedLabel(stateProps.label);
                button.enabled = this.isActionEnabled();
                if (button.setAnimation(stateProps.id, stateProps.animation)) 
                {
                    button.visible = stateProps.visible;
                }
                button.setOwner(this, _doValidateNow);
            }
            this.applyExtraSource();
            super.populateUI();
            return;
        }

        public override function getExtraState():Object
        {
            return {"rootState":this.containerEx == null ? 0 : this.containerEx.getRootState(), "isParentUnlocked":this.containerEx == null ? false : this.containerEx.hasUnlockedParent((matrixPosition.row - 1), index)};
        }

        public override function showContextMenu():void
        {
            if (button != null) 
            {
                button.endAnimation(true);
            }
            net.wg.gui.lobby.techtree.MenuHandler.getInstance().showResearchItemMenu(this);
            return;
        }

        public override function toString():String
        {
            return "[ResearchItem " + index + ", " + name + "]";
        }

        public function isAutoUnlocked():Boolean
        {
            return dataInited && (_valueObject.state & net.wg.gui.lobby.techtree.constants.NodeState.AUTO_UNLOCKED) > 0;
        }

        public function isInstalled():Boolean
        {
            return dataInited && (_valueObject.state & net.wg.gui.lobby.techtree.constants.NodeState.INSTALLED) > 0;
        }

        public function isAvailable4Install():Boolean
        {
            if (!dataInited) 
            {
                return false;
            }
            return !(container == null) && this.containerEx.canInstallItems() && inInventory() && (_valueObject.state & net.wg.gui.lobby.techtree.constants.NodeState.INSTALLED) == 0;
        }

        public function click2Install():void
        {
            dispatchEvent(new net.wg.gui.lobby.techtree.TechTreeEvent(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_INSTALL, 0, _index, _entityType));
            return;
        }

        public override function set container(arg1:net.wg.gui.lobby.techtree.interfaces.INodesContainer):void
        {
            if (arg1 is net.wg.gui.lobby.techtree.interfaces.IResearchContainer) 
            {
                _container = arg1;
            }
            return;
        }

        public function get containerEx():net.wg.gui.lobby.techtree.interfaces.IResearchContainer
        {
            return _container == null ? null : _container as net.wg.gui.lobby.techtree.interfaces.IResearchContainer;
        }

        protected override function preInitialize():void
        {
            super.preInitialize();
            _entityType = net.wg.gui.lobby.techtree.constants.NodeEntityType.RESEARCH_ITEM;
            soundId = net.wg.gui.lobby.techtree.constants.TTSoundID.RESEARCH_ITEM;
            _tooltipID = net.wg.data.constants.Tooltips.TECHTREE_MODULE;
            isDelegateEvents = true;
            return;
        }

        protected override function handleClick(arg1:uint=0):void
        {
            super.handleClick(arg1);
            net.wg.gui.lobby.techtree.MenuHandler.getInstance().hideMenu();
            if (button != null) 
            {
                button.endAnimation(true);
            }
            dispatchEvent(new net.wg.gui.lobby.techtree.TechTreeEvent(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_OPEN, 0, _index, _entityType));
            return;
        }

        internal function applyExtraSource():void
        {
            var loc1:*=_valueObject.extraInfo;
            if (!this.extraIcon && !(loc1 == null) && !(loc1 == "")) 
            {
                this.extraIcon = new net.wg.gui.lobby.hangar.ammunitionPanel.ExtraIcon();
                this.extraIcon.addEventListener(net.wg.gui.lobby.profile.components.SimpleLoader.LOADED, this.onExtraIconLoaded, false, 0, true);
                this.extraIcon.visible = false;
                addChild(this.extraIcon);
            }
            if (this.extraIcon) 
            {
                this.extraIcon.setSource(loc1);
                this.extraIcon.visible = !(button && button.visible || this.xpLabel && this.xpLabel.visible);
                if (this.extraIcon.visible) 
                {
                    this.extraIcon.alpha = stateProps.index != 0 ? 1 : 0.5;
                }
            }
            return;
        }

        internal function onExtraIconLoaded(arg1:flash.events.Event):void
        {
            this.extraIcon.x = this.typeIcon.x + this.typeIcon.width - this.extraIcon.width - 2;
            this.extraIcon.y = this.typeIcon.y + this.typeIcon.height - this.extraIcon.height - 2;
            return;
        }

        public var typeIcon:flash.display.MovieClip;

        public var levelIcon:flash.display.MovieClip;

        public var nameField:flash.text.TextField;

        public var xpLabel:net.wg.gui.lobby.techtree.controls.ExperienceLabel;

        internal var extraIcon:net.wg.gui.lobby.hangar.ammunitionPanel.ExtraIcon;
    }
}
