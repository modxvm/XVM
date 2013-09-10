package net.wg.gui.lobby.tankman 
{
    import flash.events.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.events.*;
    
    public class SkillDropWindow extends net.wg.infrastructure.base.meta.impl.SkillDropMeta implements net.wg.infrastructure.base.meta.ISkillDropMeta
    {
        public function SkillDropWindow()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.savingModeGroup = new scaleform.clik.controls.ButtonGroup("savingModeGroup", this);
            this.savingModeGroup.addButton(this.goldButton);
            this.savingModeGroup.addButton(this.creditsButton);
            this.savingModeGroup.addButton(this.freeButton);
            this.savingModeGroup.addEventListener(flash.events.Event.CHANGE, this.onSavingModeChanghed);
            var loc1:*;
            this.freeButton.allowDeselect = loc1 = false;
            this.creditsButton.allowDeselect = loc1 = loc1;
            this.goldButton.allowDeselect = loc1;
            this.freeButton.doubleClickEnabled = loc1 = true;
            this.creditsButton.doubleClickEnabled = loc1 = loc1;
            this.goldButton.doubleClickEnabled = loc1;
            this.freeButton.retraining = loc1 = false;
            this.creditsButton.retraining = loc1 = loc1;
            this.goldButton.retraining = loc1;
            this.freeButton.scopeType = loc1 = "dropSkills";
            this.creditsButton.scopeType = loc1 = loc1;
            this.goldButton.scopeType = loc1;
            this.goldButton.addEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.onSavingModeButtonDoubleClick);
            this.creditsButton.addEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.onSavingModeButtonDoubleClick);
            this.freeButton.addEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.onSavingModeButtonDoubleClick);
            this.buttonDrop.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onDropClick);
            this.buttonCancel.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onCancelClick);
            return;
        }

        internal function onSavingModeChanghed(arg1:flash.events.Event):void
        {
            this.recalculateData();
            return;
        }

        internal function onSavingModeButtonDoubleClick(arg1:flash.events.MouseEvent):void
        {
            this.onDropClick(null);
            return;
        }

        internal function onCancelClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            onWindowCloseS();
            return;
        }

        internal function onDropClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            dropSkillsS(this.getSelectedDropCostInfo().id);
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.goldButton.removeEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.onSavingModeButtonDoubleClick);
            this.creditsButton.removeEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.onSavingModeButtonDoubleClick);
            this.freeButton.removeEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.onSavingModeButtonDoubleClick);
            this.buttonDrop.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onDropClick);
            this.buttonCancel.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onCancelClick);
            if (this.savingModeGroup) 
            {
                this.savingModeGroup.dispose();
                this.savingModeGroup = null;
            }
            if (this.model) 
            {
                this.model.dispose();
                this.model = null;
            }
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            window.useBottomBtns = true;
            this.window.title = MENU.SKILLDROPWINDOW_TITLE;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALID_DATA) && this.model) 
            {
                this.goldButton.level = Math.round(this.model.dropSkillGold.xpReuseFraction * 100);
                this.creditsButton.level = Math.round(this.model.dropSkillCredits.xpReuseFraction * 100);
                this.freeButton.level = Math.round(this.model.dropSkillFree.xpReuseFraction * 100);
                var loc1:*;
                this.freeButton.nation = loc1 = this.model.nationID;
                this.creditsButton.nation = loc1 = loc1;
                this.goldButton.nation = loc1;
                this.updateSavingModes();
                this.afterBlock.nation = loc1 = this.model.nation;
                this.beforeBlock.nation = loc1;
                this.afterBlock.tankmanName = loc1 = this.model.tankmanName;
                this.beforeBlock.tankmanName = loc1;
                this.afterBlock.portraitSource = loc1 = this.model.tankmanIcon;
                this.beforeBlock.portraitSource = loc1;
                this.afterBlock.roleSource = loc1 = this.model.roleIcon;
                this.beforeBlock.roleSource = loc1;
                this.beforeBlock.setRoleLevel(this.model.roleLevel);
                if (!this.isFirstInited) 
                {
                    this.autoSelectSavingMode();
                    this.isFirstInited = true;
                }
                this.recalculateData();
            }
            if (isInvalid(INVALID_MONEY)) 
                this.updateSavingModes();
            return;
        }

        internal function updateSavingModes():void
        {
            this.goldButton.setDataForDropSkills(this.model.dropSkillGold.gold, this.gold > this.model.dropSkillGold.gold);
            this.creditsButton.setDataForDropSkills(this.model.dropSkillCredits.credits, this.credits > this.model.dropSkillCredits.credits);
            this.freeButton.setDataForDropSkills(NaN, true);
            return;
        }

        internal function autoSelectSavingMode():void
        {
            var loc1:*=null;
            var loc2:*=this.model.defaultSavingMode;
            switch (loc2) 
            {
                case 2:
                    loc1 = this.goldButton;
                    break;
                case 1:
                    loc1 = this.creditsButton;
                    break;
                default:
                    loc1 = this.freeButton;
                    break;
            }
            if (loc1.enabled) 
                loc1.selected = true;
            return;
        }

        public function getSelectedDropCostInfo():Object
        {
            var loc1:*=null;
            var loc2:*=this.savingModeGroup.selectedButton;
            switch (loc2) 
            {
                case this.goldButton:
                    loc1 = this.model.dropSkillGold;
                    break;
                case this.creditsButton:
                    loc1 = this.model.dropSkillCredits;
                    break;
                case this.freeButton:
                    loc1 = this.model.dropSkillFree;
                    break;
                default:
                    break;
            }
            return loc1;
        }

        internal function recalculateData():void
        {
            var loc1:*=this.getSelectedDropCostInfo();
            var loc2:*=calcDropSkillsParamsS(this.model.compactDescriptor, loc1.xpReuseFraction);
            var loc3:*=loc2[0];
            var loc4:*=loc2[1];
            var loc5:*=loc2[2];
            this.beforeBlock.setSkills(this.model.skillsCount, this.model.preLastSkill, this.model.lastSkill, this.model.lastSkillLevel, this.model.hasNewSkill);
            var loc6:*=loc4 > 1 ? net.wg.gui.lobby.tankman.SkillItemViewMini.TYPE_NEW_SKILL : null;
            var loc7:*=net.wg.gui.lobby.tankman.SkillItemViewMini.TYPE_NEW_SKILL;
            var loc8:*=this.model.skillsCount > loc4;
            this.afterBlock.setSkills(loc4, loc6, loc7, loc5, loc8);
            this.afterBlock.setRoleLevel(this.model.roleLevel, loc3);
            return;
        }

        public function as_setData(arg1:Object):void
        {
            this.model = net.wg.gui.lobby.tankman.SkillDropModel.parseFromObject(arg1);
            this.gold = this.model.gold;
            this.credits = this.model.credits;
            invalidate(INVALID_DATA);
            return;
        }

        public function as_setGold(arg1:Number):void
        {
            this.gold = arg1;
            invalidate(INVALID_MONEY);
            return;
        }

        public function as_setCredits(arg1:Number):void
        {
            this.credits = arg1;
            invalidate(INVALID_MONEY);
            return;
        }

        internal static const INVALID_DATA:String="invalidData";

        internal static const INVALID_MONEY:String="invalidMoney";

        protected var savingModeGroup:scaleform.clik.controls.ButtonGroup;

        public var beforeBlock:net.wg.gui.lobby.tankman.TankmanSkillsInfoBlock;

        public var afterBlock:net.wg.gui.lobby.tankman.TankmanSkillsInfoBlock;

        public var buttonCancel:net.wg.gui.components.controls.SoundButtonEx;

        public var buttonDrop:net.wg.gui.components.controls.SoundButtonEx;

        public var goldButton:net.wg.gui.components.controls.TankmanTrainingSmallButton;

        public var creditsButton:net.wg.gui.components.controls.TankmanTrainingSmallButton;

        public var freeButton:net.wg.gui.components.controls.TankmanTrainingSmallButton;

        public var model:net.wg.gui.lobby.tankman.SkillDropModel;

        internal var gold:Number=NaN;

        internal var credits:Number=NaN;

        internal var isFirstInited:Boolean=false;
    }
}
