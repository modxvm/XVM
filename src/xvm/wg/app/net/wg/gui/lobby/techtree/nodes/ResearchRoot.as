package net.wg.gui.lobby.techtree.nodes
{
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.lobby.techtree.controls.NameAndXpField;
    import net.wg.gui.lobby.techtree.controls.TypeAndLevelField;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.SoundButtonEx;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.techtree.TechTreeEvent;
    import net.wg.gui.utils.VehicleStateString;
    import flash.display.DisplayObjectContainer;
    import net.wg.gui.lobby.techtree.MenuHandler;
    import net.wg.gui.lobby.techtree.interfaces.IRenderer;
    import net.wg.gui.lobby.techtree.constants.ColorIndex;
    import net.wg.gui.lobby.techtree.constants.NodeEntityType;
    import net.wg.gui.lobby.techtree.constants.TTSoundID;
    import net.wg.data.constants.Tooltips;
    import flash.events.MouseEvent;
    
    public class ResearchRoot extends Renderer
    {
        
        public function ResearchRoot()
        {
            super();
        }
        
        private var statusString:String = "";
        
        public var vIconLoader:UILoaderAlt;
        
        public var nameAndXp:NameAndXpField;
        
        public var typeAndLevel:TypeAndLevelField;
        
        public var statusField:TextField;
        
        public var flag:MovieClip;
        
        public var btnShowInHangar:SoundButtonEx;
        
        public function setupEx(param1:String) : void
        {
            this.statusString = param1;
            invalidateData();
        }
        
        override public function cleanUp() : void
        {
            if(this.btnShowInHangar != null)
            {
                this.btnShowInHangar.removeEventListener(ButtonEvent.CLICK,this.btnShowInHangarClickHandler);
                this.btnShowInHangar.dispose();
            }
            if(this.nameAndXp != null)
            {
                this.nameAndXp.dispose();
            }
            if(this.typeAndLevel != null)
            {
                this.typeAndLevel.dispose();
            }
            if(this.vIconLoader != null)
            {
                this.vIconLoader.dispose();
            }
            super.cleanUp();
        }
        
        override public function click2Info() : void
        {
            dispatchEvent(new TechTreeEvent(TechTreeEvent.CLICK_2_VEHICLE_INFO,0,_index,_entityType));
        }
        
        override public function isParentUnlocked(param1:Number) : Boolean
        {
            return (dataInited) && !(_valueObject.unlockProps == null) && (_valueObject.unlockProps.hasID(param1));
        }
        
        override public function populateUI() : void
        {
            var _loc2_:String = null;
            var _loc1_:String = _container.getNation();
            if(!(this.flag == null) && !(this.flag.currentFrameLabel == _loc1_))
            {
                this.flag.gotoAndStop(_loc1_);
            }
            if(!(this.statusField == null) && !(this.statusString == null))
            {
                VehicleStateString.appendText(this.statusField,this.statusString);
            }
            if(this.vIconLoader != null)
            {
                _loc2_ = getIconPath();
                this.vIconLoader.alpha = stateProps.icoAlpha;
                if(_loc2_ != this.vIconLoader.source)
                {
                    this.vIconLoader.source = _loc2_;
                    this.vIconLoader.visible = true;
                }
            }
            if(this.typeAndLevel != null)
            {
                this.typeAndLevel.setOwner(this,_doValidateNow);
            }
            if(this.nameAndXp != null)
            {
                this.nameAndXp.setIsInAction((actionPrice) && (isInAction()));
                this.nameAndXp.setOwner(this,_doValidateNow);
            }
            if(button != null)
            {
                button.label = getNamedLabel(stateProps.label);
                button.enabled = isActionEnabled();
                button.visible = stateProps.visible;
                button.setOwner(this,_doValidateNow);
            }
            if(this.btnShowInHangar)
            {
                this.btnShowInHangar.label = App.utils.locale.makeString(MENU.RESEARCH_LABELS_BUTTON_SHOWINHANGAR);
                this.btnShowInHangar.enabled = isVehicleCanBeChanged();
                this.btnShowInHangar.addEventListener(ButtonEvent.CLICK,this.btnShowInHangarClickHandler,false,0,true);
            }
            super.populateUI();
        }
        
        override protected function getMouseEnabledChildren() : Vector.<DisplayObjectContainer>
        {
            var _loc1_:Vector.<DisplayObjectContainer> = super.getMouseEnabledChildren();
            if(this.btnShowInHangar)
            {
                _loc1_.push(this.btnShowInHangar);
            }
            return _loc1_;
        }
        
        private function btnShowInHangarClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new TechTreeEvent(TechTreeEvent.CLICK_2_SELECT_IN_HANGAR,0,_index,_entityType));
        }
        
        override public function showContextMenu() : void
        {
            if(button != null)
            {
                button.endAnimation(true);
            }
            MenuHandler.getInstance().showResearchRootMenu(this);
        }
        
        override public function getColorIdxEx(param1:IRenderer) : Number
        {
            var _loc2_:Number = ColorIndex.LOCKED;
            if(isUnlocked())
            {
                if(param1 == null || (this.isParentUnlocked(param1.getID())))
                {
                    _loc2_ = ColorIndex.UNLOCKED;
                }
            }
            else if(isNext2Unlock())
            {
                if(param1 == null || (this.isParentUnlocked(param1.getID())))
                {
                    _loc2_ = ColorIndex.NEXT2UNLOCK;
                }
            }
            
            return _loc2_;
        }
        
        override public function toString() : String
        {
            return "[ResearchRoot " + index + ", " + name + "]";
        }
        
        override protected function preInitialize() : void
        {
            super.preInitialize();
            _entityType = NodeEntityType.RESEARCH_ROOT;
            soundId = TTSoundID.RESEARCH_ROOT;
            _tooltipID = Tooltips.TECHTREE_VEHICLE;
            isDelegateEvents = true;
        }
        
        override protected function draw() : void
        {
            super.draw();
        }
        
        override protected function handleMouseRollOver(param1:MouseEvent) : void
        {
            super.handleMouseRollOver(param1);
            if(button != null)
            {
                button.startAnimation();
            }
        }
        
        override protected function handleMouseRollOut(param1:MouseEvent) : void
        {
            super.handleMouseRollOut(param1);
            if(button != null)
            {
                button.endAnimation(false);
            }
        }
        
        override protected function handleClick(param1:uint = 0) : void
        {
            super.handleClick(param1);
            MenuHandler.getInstance().hideMenu();
            if(button != null)
            {
                button.endAnimation(true);
            }
            dispatchEvent(new TechTreeEvent(TechTreeEvent.CLICK_2_OPEN,0,_index,_entityType));
        }
    }
}
