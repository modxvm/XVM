package net.wg.gui.lobby.techtree.controls 
{
    import flash.text.*;
    import net.wg.gui.lobby.techtree.*;
    import net.wg.gui.lobby.techtree.constants.*;
    import net.wg.gui.lobby.techtree.interfaces.*;
    
    public class ExperienceInformation extends net.wg.gui.lobby.techtree.controls.NodeComponent
    {
        public function ExperienceInformation()
        {
            super();
            return;
        }

        public override function setOwner(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer, arg2:Boolean=false):void
        {
            if (_owner != null) 
            {
                _owner.removeEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.STATE_CHANGED, this.handleOwnerStateChanged);
            }
            super.setOwner(arg1);
            if (_owner != null) 
            {
                _owner.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.STATE_CHANGED, this.handleOwnerStateChanged, false, 0, true);
            }
            invalidate(net.wg.gui.lobby.techtree.constants.TTInvalidationType.ELITE, net.wg.gui.lobby.techtree.constants.TTInvalidationType.VEH_XP);
            return;
        }

        public function setFreeXP(arg1:Number):void
        {
            if (this._freeXP == arg1) 
            {
                return;
            }
            this._freeXP = arg1;
            invalidate(net.wg.gui.lobby.techtree.constants.TTInvalidationType.FREE_XP);
            return;
        }

        protected override function configUI():void
        {
            if (this.vehXPLabel != null) 
            {
                this.vehXPLabel.text = MENU.RESEARCH_LABELS_VEHXP;
            }
            if (this.freeXPLabel != null) 
            {
                this.freeXPLabel.text = MENU.RESEARCH_LABELS_FREEXP;
            }
            if (this.totalXPLabel != null) 
            {
                this.totalXPLabel.text = MENU.RESEARCH_LABELS_TOTALXP;
            }
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (_owner == null) 
            {
                return;
            }
            if (isInvalid(net.wg.gui.lobby.techtree.constants.TTInvalidationType.ELITE)) 
            {
                this.changeStars();
            }
            var loc1:*=isInvalid(net.wg.gui.lobby.techtree.constants.TTInvalidationType.VEH_XP, net.wg.gui.lobby.techtree.constants.TTInvalidationType.FREE_XP);
            if (loc1) 
            {
                this.makeVehXPString();
                this.makeFreeXPString();
                this.makeTotalXPString();
            }
            return;
        }

        internal function changeStars():void
        {
            var loc1:*=_owner.isElite() ? net.wg.gui.lobby.techtree.constants.XpTypeStrings.ELITE_XP_TYPE : net.wg.gui.lobby.techtree.constants.XpTypeStrings.EARNED_XP_TYPE;
            this.vehXPIcon.type = loc1;
            this.vehXPInTotalIcon.type = loc1;
            return;
        }

        internal function makeVehXPString():void
        {
            var loc2:*=null;
            var loc1:*=_owner.getEarnedXP();
            if (App.utils == null) 
            {
                loc2 = loc1.toString();
            }
            else 
            {
                loc2 = App.utils.locale.integer(loc1);
            }
            this.vehXPField.text = loc2;
            return;
        }

        internal function makeFreeXPString():void
        {
            var loc1:*=null;
            if (App.utils == null) 
            {
                loc1 = this._freeXP.toString();
            }
            else 
            {
                loc1 = App.utils.locale.integer(this._freeXP);
            }
            this.freeXPField.text = loc1;
            return;
        }

        internal function makeTotalXPString():void
        {
            var loc2:*=null;
            var loc1:*=_owner.getEarnedXP() + this._freeXP;
            if (App.utils == null) 
            {
                loc2 = loc1.toString();
            }
            else 
            {
                loc2 = App.utils.locale.integer(loc1);
            }
            this.totalXPField.text = loc2;
            return;
        }

        internal function handleOwnerStateChanged(arg1:net.wg.gui.lobby.techtree.TechTreeEvent):void
        {
            if (arg1.primary != net.wg.gui.lobby.techtree.constants.NodeState.ELITE) 
            {
                if (arg1.primary == 0) 
                {
                    invalidate(net.wg.gui.lobby.techtree.constants.TTInvalidationType.VEH_XP);
                }
            }
            else 
            {
                invalidate(net.wg.gui.lobby.techtree.constants.TTInvalidationType.ELITE);
            }
            return;
        }

        internal var _freeXP:Number=0;

        public var vehXPLabel:flash.text.TextField;

        public var vehXPIcon:net.wg.gui.lobby.techtree.controls.XPIcon;

        public var vehXPField:flash.text.TextField;

        public var freeXPLabel:flash.text.TextField;

        public var freeXPField:flash.text.TextField;

        public var totalXPLabel:flash.text.TextField;

        public var vehXPInTotalIcon:net.wg.gui.lobby.techtree.controls.XPIcon;

        public var totalXPField:flash.text.TextField;
    }
}
