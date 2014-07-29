package net.wg.gui.lobby.techtree.controls
{
    import flash.text.TextField;
    import net.wg.gui.components.controls.WalletResourcesStatus;
    import net.wg.gui.lobby.techtree.interfaces.IRenderer;
    import net.wg.gui.lobby.techtree.TechTreeEvent;
    import net.wg.gui.lobby.techtree.constants.TTInvalidationType;
    import net.wg.gui.lobby.techtree.constants.XpTypeStrings;
    import net.wg.gui.lobby.techtree.constants.NodeState;
    
    public class ExperienceInformation extends NodeComponent
    {
        
        public function ExperienceInformation()
        {
            super();
        }
        
        private var _freeXP:Number = 0;
        
        public var vehXPLabel:TextField;
        
        public var vehXPIcon:XPIcon;
        
        public var vehXPField:TextField;
        
        public var freeXPLabel:TextField;
        
        public var freeXPField:TextField;
        
        public var totalXPLabel:TextField;
        
        public var vehXPInTotalIcon:XPIcon;
        
        public var totalXPField:TextField;
        
        public var haveNotFreeXp:WalletResourcesStatus;
        
        override protected function onDispose() : void
        {
            this.haveNotFreeXp.dispose();
            this.haveNotFreeXp = null;
            super.onDispose();
        }
        
        override public function setOwner(param1:IRenderer, param2:Boolean = false) : void
        {
            if(_owner != null)
            {
                _owner.removeEventListener(TechTreeEvent.STATE_CHANGED,this.handleOwnerStateChanged);
            }
            super.setOwner(param1);
            if(_owner != null)
            {
                _owner.addEventListener(TechTreeEvent.STATE_CHANGED,this.handleOwnerStateChanged,false,0,true);
            }
            invalidate(TTInvalidationType.ELITE,TTInvalidationType.VEH_XP);
        }
        
        public function setFreeXP(param1:Number) : void
        {
            if(this._freeXP == param1)
            {
                return;
            }
            this._freeXP = param1;
            invalidate(TTInvalidationType.FREE_XP);
        }
        
        public function setWalletStatus() : void
        {
            this.freeXPField.visible = !this.haveNotFreeXp.updateStatus(App.utils.voMgr.walletStatusVO.freeXpStatus);
        }
        
        override protected function configUI() : void
        {
            if(this.vehXPLabel != null)
            {
                this.vehXPLabel.text = MENU.RESEARCH_LABELS_VEHXP;
            }
            if(this.freeXPLabel != null)
            {
                this.freeXPLabel.text = MENU.RESEARCH_LABELS_FREEXP;
            }
            if(this.totalXPLabel != null)
            {
                this.totalXPLabel.text = MENU.RESEARCH_LABELS_TOTALXP;
            }
            super.configUI();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(_owner == null)
            {
                return;
            }
            if(isInvalid(TTInvalidationType.ELITE))
            {
                this.changeStars();
            }
            var _loc1_:Boolean = isInvalid(TTInvalidationType.VEH_XP,TTInvalidationType.FREE_XP);
            if(_loc1_)
            {
                this.makeVehXPString();
                this.makeFreeXPString();
                this.makeTotalXPString();
            }
        }
        
        private function changeStars() : void
        {
            var _loc1_:String = _owner.isElite()?XpTypeStrings.ELITE_XP_TYPE:XpTypeStrings.EARNED_XP_TYPE;
            this.vehXPIcon.type = _loc1_;
            this.vehXPInTotalIcon.type = _loc1_;
        }
        
        private function makeVehXPString() : void
        {
            var _loc2_:String = null;
            var _loc1_:Number = _owner.getEarnedXP();
            if(App.utils != null)
            {
                _loc2_ = App.utils.locale.integer(_loc1_);
            }
            else
            {
                _loc2_ = _loc1_.toString();
            }
            this.vehXPField.text = _loc2_;
        }
        
        private function makeFreeXPString() : void
        {
            var _loc1_:String = null;
            if(App.utils != null)
            {
                _loc1_ = App.utils.locale.integer(this._freeXP);
            }
            else
            {
                _loc1_ = this._freeXP.toString();
            }
            this.freeXPField.text = _loc1_;
        }
        
        private function makeTotalXPString() : void
        {
            var _loc2_:String = null;
            var _loc1_:Number = _owner.getEarnedXP() + Math.max(0,this._freeXP);
            if(App.utils != null)
            {
                _loc2_ = App.utils.locale.integer(_loc1_);
            }
            else
            {
                _loc2_ = _loc1_.toString();
            }
            this.totalXPField.text = _loc2_;
        }
        
        private function handleOwnerStateChanged(param1:TechTreeEvent) : void
        {
            if(param1.primary == NodeState.ELITE)
            {
                invalidate(TTInvalidationType.ELITE);
            }
            else if(param1.primary == 0)
            {
                invalidate(TTInvalidationType.VEH_XP);
            }
            
        }
    }
}
