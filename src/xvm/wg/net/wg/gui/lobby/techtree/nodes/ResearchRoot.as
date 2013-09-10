package net.wg.gui.lobby.techtree.nodes 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.techtree.*;
    import net.wg.gui.lobby.techtree.constants.*;
    import net.wg.gui.lobby.techtree.controls.*;
    import net.wg.gui.lobby.techtree.interfaces.*;
    import net.wg.gui.utils.*;
    
    public class ResearchRoot extends net.wg.gui.lobby.techtree.nodes.Renderer
    {
        public function ResearchRoot()
        {
            super();
            return;
        }

        public function setupEx(arg1:String):void
        {
            this.statusString = arg1;
            invalidateData();
            return;
        }

        public override function cleanUp():void
        {
            if (this.nameAndXp != null) 
                this.nameAndXp.dispose();
            if (this.typeAndLevel != null) 
                this.typeAndLevel.dispose();
            if (this.vIconLoader != null) 
                this.vIconLoader.dispose();
            super.cleanUp();
            return;
        }

        public override function click2Info():void
        {
            dispatchEvent(new net.wg.gui.lobby.techtree.TechTreeEvent(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_VEHICLE_INFO, 0, _index, _entityType));
            return;
        }

        public override function isParentUnlocked(arg1:Number):Boolean
        {
            return dataInited && !(_valueObject.unlockProps == null) && _valueObject.unlockProps.hasID(arg1);
        }

        public override function populateUI():void
        {
            var loc2:*=null;
            var loc1:*=_container.getNation();
            if (!(this.flag == null) && !(this.flag.currentFrameLabel == loc1)) 
                this.flag.gotoAndStop(loc1);
            if (!(this.statusField == null) && !(this.statusString == null)) 
                net.wg.gui.utils.VehicleStateString.appendText(this.statusField, this.statusString);
            if (this.vIconLoader != null) 
            {
                loc2 = getIconPath();
                this.vIconLoader.alpha = stateProps.icoAlpha;
                if (loc2 != this.vIconLoader.source) 
                {
                    this.vIconLoader.source = loc2;
                    this.vIconLoader.visible = true;
                }
            }
            if (this.nameAndXp != null) 
                this.nameAndXp.setOwner(this, _doValidateNow);
            if (this.typeAndLevel != null) 
                this.typeAndLevel.setOwner(this, _doValidateNow);
            if (button != null) 
            {
                button.label = getNamedLabel(stateProps.label);
                button.enabled = isActionEnabled();
                button.visible = stateProps.visible;
                button.setOwner(this, _doValidateNow);
            }
            super.populateUI();
            return;
        }

        public override function showContextMenu():void
        {
            if (button != null) 
                button.endAnimation(true);
            net.wg.gui.lobby.techtree.MenuHandler.getInstance().showResearchRootMenu(this);
            return;
        }

        public override function getColorIdxEx(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer):Number
        {
            var loc1:*=net.wg.gui.lobby.techtree.constants.ColorIndex.LOCKED;
            if (isUnlocked()) 
                if (arg1 == null || this.isParentUnlocked(arg1.getID())) 
                    loc1 = net.wg.gui.lobby.techtree.constants.ColorIndex.UNLOCKED;
            else if (isNext2Unlock()) 
                if (arg1 == null || this.isParentUnlocked(arg1.getID())) 
                    loc1 = net.wg.gui.lobby.techtree.constants.ColorIndex.NEXT2UNLOCK;
            return loc1;
        }

        public override function toString():String
        {
            return "[ResearchRoot " + index + ", " + name + "]";
        }

        protected override function preInitialize():void
        {
            super.preInitialize();
            _entityType = net.wg.gui.lobby.techtree.constants.NodeEntityType.RESEARCH_ROOT;
            soundId = net.wg.gui.lobby.techtree.constants.TTSoundID.RESEARCH_ROOT;
            _tooltipID = net.wg.data.constants.Tooltips.TECHTREE_VEHICLE;
            isDelegateEvents = true;
            return;
        }

        protected override function draw():void
        {
            super.draw();
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

        protected override function handleClick(arg1:uint=0):void
        {
            super.handleClick(arg1);
            net.wg.gui.lobby.techtree.MenuHandler.getInstance().hideMenu();
            if (button != null) 
                button.endAnimation(true);
            dispatchEvent(new net.wg.gui.lobby.techtree.TechTreeEvent(net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_OPEN, 0, _index, _entityType));
            return;
        }

        internal var statusString:String="";

        public var vIconLoader:net.wg.gui.components.controls.UILoaderAlt;

        public var nameAndXp:net.wg.gui.lobby.techtree.controls.NameAndXpField;

        public var typeAndLevel:net.wg.gui.lobby.techtree.controls.TypeAndLevelField;

        public var statusField:flash.text.TextField;

        public var flag:flash.display.MovieClip;
    }
}
