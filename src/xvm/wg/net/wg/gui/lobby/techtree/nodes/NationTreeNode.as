package net.wg.gui.lobby.techtree.nodes 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.techtree.*;
    import net.wg.gui.lobby.techtree.constants.*;
    import net.wg.gui.lobby.techtree.controls.*;
    import net.wg.gui.lobby.techtree.data.vo.*;
    import net.wg.gui.lobby.techtree.math.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public class NationTreeNode extends net.wg.gui.lobby.techtree.nodes.Renderer
    {
        public function NationTreeNode()
        {
            super();
            return;
        }

        public override function setup(arg1:uint, arg2:net.wg.gui.lobby.techtree.data.vo.NodeData, arg3:uint=0, arg4:net.wg.gui.lobby.techtree.math.MatrixPosition=null):void
        {
            super.setup(arg1, arg2, arg3, arg4);
            this.drawNavIndicator();
            return;
        }

        public override function cleanUp():void
        {
            removeEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.handleMouseMove, false);
            if (this.typeAndLevel != null) 
                this.typeAndLevel.dispose();
            if (this.nameAndXp != null) 
                this.nameAndXp.dispose();
            if (this.vIconLoader != null) 
                this.vIconLoader.dispose();
            super.cleanUp();
            return;
        }

        public override function getIconPath():String
        {
            return dataInited ? _valueObject.smallIconPath : "";
        }

        public override function hitTestPoint(arg1:Number, arg2:Number, arg3:Boolean=false):Boolean
        {
            var loc1:*=false;
            if (hit == null) 
                loc1 = super.hitTestPoint(arg1, arg2, arg3);
            else 
                loc1 = hit.hitTestPoint(arg1, arg2, arg3);
            return loc1 && (button == null || !button.visible || !button.hitTestPoint(arg1, arg2, arg3));
        }

        public override function click2Info():void
        {
            dispatchEvent(new net.wg.gui.lobby.techtree.TechTreeEvent(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_VEHICLE_INFO, 0, _index, _entityType));
            return;
        }

        public override function showContextMenu():void
        {
            if (button != null) 
                button.endAnimation(true);
            this.stopDragNode();
            net.wg.gui.lobby.techtree.MenuHandler.getInstance().showNationTreeMenu(this);
            return;
        }

        public override function populateUI():void
        {
            var loc1:*=null;
            if (this.vIconLoader != null) 
            {
                loc1 = this.getIconPath();
                this.vIconLoader.alpha = stateProps.icoAlpha;
                if (loc1 != this.vIconLoader.source) 
                {
                    this.vIconLoader.source = loc1;
                    this.vIconLoader.visible = true;
                }
            }
            if (this.typeAndLevel != null) 
                this.typeAndLevel.setOwner(this, _doValidateNow);
            if (this.nameAndXp != null) 
                this.nameAndXp.setOwner(this, _doValidateNow);
            if (button != null) 
            {
                button.label = getNamedLabel(stateProps.label);
                button.enabled = isActionEnabled();
                if (button.setAnimation(stateProps.id, stateProps.animation)) 
                    button.visible = stateProps.visible;
                button.setOwner(this, _doValidateNow);
            }
            super.populateUI();
            return;
        }

        public override function toString():String
        {
            return "[NationTreeNode " + index + ", " + name + "]";
        }

        protected override function preInitialize():void
        {
            super.preInitialize();
            _entityType = net.wg.gui.lobby.techtree.constants.NodeEntityType.NATION_TREE;
            soundId = net.wg.gui.lobby.techtree.constants.TTSoundID.NATION_TREE;
            _tooltipID = net.wg.data.constants.Tooltips.TECHTREE_VEHICLE;
            isDelegateEvents = true;
            return;
        }

        protected override function handleMouseRollOver(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOver(arg1);
            if (button != null) 
                button.startAnimation();
            return;
        }

        protected override function handleMouseRollOut(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOut(arg1);
            if (button != null) 
                button.endAnimation(false);
            return;
        }

        protected override function handleMousePress(arg1:flash.events.MouseEvent):void
        {
            super.handleMousePress(arg1);
            this.startDragNode();
            return;
        }

        protected override function handleReleaseOutside(arg1:flash.events.MouseEvent):void
        {
            super.handleReleaseOutside(arg1);
            if (button != null) 
                button.endAnimation(false);
            if (!this.hitTestPoint(stage.mouseX, stage.mouseY)) 
                this.stopDragNode();
            return;
        }

        protected override function handleClick(arg1:uint=0):void
        {
            net.wg.gui.lobby.techtree.MenuHandler.getInstance().hideMenu();
            if (button != null) 
                button.endAnimation(true);
            super.handleClick(arg1);
            if (!this.isMouseMoved) 
                dispatchEvent(new net.wg.gui.lobby.techtree.TechTreeEvent(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_OPEN, 0, _index, _entityType));
            this.stopDragNode();
            return;
        }

        internal function startDragNode():void
        {
            if (container is net.wg.infrastructure.interfaces.entity.IDraggable) 
                addEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.handleMouseMove, false, 0, true);
            return;
        }

        internal function stopDragNode():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (container is net.wg.infrastructure.interfaces.entity.IDraggable) 
            {
                removeEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.handleMouseMove, false);
                loc1 = net.wg.infrastructure.interfaces.entity.IDraggable(container);
                loc2 = loc1.getHitArea();
                this.isMouseMoved = false;
                loc2.dispatchEvent(new flash.events.MouseEvent(flash.events.MouseEvent.MOUSE_UP));
            }
            return;
        }

        internal function handleMouseMove(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (container as net.wg.infrastructure.interfaces.entity.IDraggable) 
            {
                loc1 = net.wg.infrastructure.interfaces.entity.IDraggable(container);
                loc2 = loc1.getHitArea();
                if (!this.isMouseMoved) 
                {
                    this.isMouseMoved = true;
                    loc2.dispatchEvent(new flash.events.MouseEvent(flash.events.MouseEvent.MOUSE_DOWN));
                }
                loc2.dispatchEvent(new flash.events.MouseEvent(flash.events.MouseEvent.MOUSE_MOVE));
            }
            return;
        }

        internal function drawNavIndicator():void
        {
            var loc1:*=null;
            if (this.navContainer != null) 
            {
                var loc2:*;
                this.navContainer.mouseChildren = loc2 = false;
                this.navContainer.mouseEnabled = loc2;
                if (!this.isNavContainerAdded && net.wg.gui.lobby.techtree.constants.NavIndicator.isDraw(_entityType)) 
                {
                    loc1 = App.utils.classFactory.getObject(net.wg.gui.lobby.techtree.constants.NavIndicator.getSource(_entityType)) as flash.display.BitmapData;
                    if (loc1 != null) 
                    {
                        this.navContainer.addChild(new flash.display.Bitmap(loc1));
                        this.isNavContainerAdded = true;
                    }
                }
            }
            return;
        }

        internal var isNavContainerAdded:Boolean=false;

        internal var isMouseMoved:Boolean=false;

        public var nameAndXp:net.wg.gui.lobby.techtree.controls.NameAndXpField;

        public var typeAndLevel:net.wg.gui.lobby.techtree.controls.TypeAndLevelField;

        public var vIconLoader:net.wg.gui.components.controls.UILoaderAlt;

        public var navContainer:flash.display.Sprite;
    }
}
