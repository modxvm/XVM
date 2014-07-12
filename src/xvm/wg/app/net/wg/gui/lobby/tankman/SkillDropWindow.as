package net.wg.gui.lobby.tankman
{
    import net.wg.infrastructure.base.meta.impl.SkillDropMeta;
    import net.wg.infrastructure.base.meta.ISkillDropMeta;
    import scaleform.clik.controls.ButtonGroup;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.controls.TankmanTrainingSmallButton;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import scaleform.clik.events.ButtonEvent;
    
    public class SkillDropWindow extends SkillDropMeta implements ISkillDropMeta
    {
        
        public function SkillDropWindow() {
            super();
            isModal = true;
        }
        
        private static var INVALID_DATA:String = "invalidData";
        
        private static var INVALID_MONEY:String = "invalidMoney";
        
        protected var savingModeGroup:ButtonGroup;
        
        public var beforeBlock:TankmanSkillsInfoBlock;
        
        public var afterBlock:TankmanSkillsInfoBlock;
        
        public var buttonCancel:SoundButtonEx;
        
        public var buttonDrop:SoundButtonEx;
        
        public var goldButton:TankmanTrainingSmallButton;
        
        public var creditsButton:TankmanTrainingSmallButton;
        
        public var freeButton:TankmanTrainingSmallButton;
        
        public var model:SkillDropModel;
        
        private var gold:Number = NaN;
        
        private var credits:Number = NaN;
        
        private var isFirstInited:Boolean = false;
        
        override protected function configUI() : void {
            super.configUI();
            var _loc1_:* = "savingModeGroup";
            this.savingModeGroup = new ButtonGroup("savingModeGroup",this);
            this.goldButton.groupName = _loc1_;
            this.creditsButton.groupName = _loc1_;
            this.freeButton.groupName = _loc1_;
            this.savingModeGroup.addButton(this.goldButton);
            this.savingModeGroup.addButton(this.creditsButton);
            this.savingModeGroup.addButton(this.freeButton);
            this.savingModeGroup.addEventListener(Event.CHANGE,this.onSavingModeChanghed);
            this.goldButton.allowDeselect = this.creditsButton.allowDeselect = this.freeButton.allowDeselect = false;
            this.goldButton.doubleClickEnabled = this.creditsButton.doubleClickEnabled = this.freeButton.doubleClickEnabled = true;
            this.goldButton.retraining = this.creditsButton.retraining = this.freeButton.retraining = false;
            this.goldButton.scopeType = this.creditsButton.scopeType = this.freeButton.scopeType = "dropSkills";
            this.goldButton.addEventListener(MouseEvent.DOUBLE_CLICK,this.onSavingModeButtonDoubleClick);
            this.creditsButton.addEventListener(MouseEvent.DOUBLE_CLICK,this.onSavingModeButtonDoubleClick);
            this.freeButton.addEventListener(MouseEvent.DOUBLE_CLICK,this.onSavingModeButtonDoubleClick);
            this.buttonDrop.addEventListener(ButtonEvent.CLICK,this.onDropClick);
            this.buttonCancel.addEventListener(ButtonEvent.CLICK,this.onCancelClick);
        }
        
        private function onSavingModeChanghed(param1:Event) : void {
            this.recalculateData();
        }
        
        private function onSavingModeButtonDoubleClick(param1:MouseEvent) : void {
            this.onDropClick(null);
        }
        
        private function onCancelClick(param1:ButtonEvent) : void {
            onWindowCloseS();
        }
        
        private function onDropClick(param1:ButtonEvent) : void {
            dropSkillsS(this.getSelectedDropCostInfo().id);
        }
        
        override protected function onDispose() : void {
            super.onDispose();
            this.goldButton.removeEventListener(MouseEvent.DOUBLE_CLICK,this.onSavingModeButtonDoubleClick);
            this.creditsButton.removeEventListener(MouseEvent.DOUBLE_CLICK,this.onSavingModeButtonDoubleClick);
            this.freeButton.removeEventListener(MouseEvent.DOUBLE_CLICK,this.onSavingModeButtonDoubleClick);
            this.buttonDrop.removeEventListener(ButtonEvent.CLICK,this.onDropClick);
            this.buttonCancel.removeEventListener(ButtonEvent.CLICK,this.onCancelClick);
            if(this.savingModeGroup)
            {
                this.savingModeGroup.dispose();
                this.savingModeGroup = null;
            }
            if(this.model)
            {
                this.model.dispose();
                this.model = null;
            }
        }
        
        override protected function onPopulate() : void {
            super.onPopulate();
            window.useBottomBtns = true;
            this.window.title = MENU.SKILLDROPWINDOW_TITLE;
        }
        
        override protected function draw() : void {
            super.draw();
            if((isInvalid(INVALID_DATA)) && (this.model))
            {
                this.goldButton.level = Math.round(this.model.dropSkillGold.xpReuseFraction * 100);
                this.creditsButton.level = Math.round(this.model.dropSkillCredits.xpReuseFraction * 100);
                this.freeButton.level = Math.round(this.model.dropSkillFree.xpReuseFraction * 100);
                this.goldButton.nation = this.creditsButton.nation = this.freeButton.nation = this.model.nationID;
                this.updateSavingModes();
                this.beforeBlock.nation = this.afterBlock.nation = this.model.nation;
                this.beforeBlock.tankmanName = this.afterBlock.tankmanName = this.model.tankmanName;
                this.beforeBlock.portraitSource = this.afterBlock.portraitSource = this.model.tankmanIcon;
                this.beforeBlock.roleSource = this.afterBlock.roleSource = this.model.roleIcon;
                this.beforeBlock.setRoleLevel(this.model.roleLevel);
                if(!this.isFirstInited)
                {
                    this.autoSelectSavingMode();
                    this.isFirstInited = true;
                }
                this.recalculateData();
            }
            if(isInvalid(INVALID_MONEY))
            {
                this.updateSavingModes();
            }
        }
        
        private function updateSavingModes() : void {
            this.goldButton.setDataForDropSkills(this.model.dropSkillGold.gold,this.gold >= this.model.dropSkillGold.gold,this.model.dropSkillGold.actionPriceDataVo);
            this.creditsButton.setDataForDropSkills(this.model.dropSkillCredits.credits,this.credits > this.model.dropSkillCredits.credits,this.model.dropSkillCredits.actionPriceDataVo);
            this.freeButton.setDataForDropSkills(NaN,true,null);
        }
        
        private function autoSelectSavingMode() : void {
            var _loc1_:TankmanTrainingSmallButton = null;
            switch(this.model.defaultSavingMode)
            {
                case 2:
                    _loc1_ = this.goldButton;
                    break;
                case 1:
                    _loc1_ = this.creditsButton;
                    break;
                default:
                    _loc1_ = this.freeButton;
            }
            if(_loc1_.enabled)
            {
                _loc1_.selected = true;
            }
        }
        
        public function getSelectedDropCostInfo() : Object {
            var _loc1_:Object = null;
            switch(this.savingModeGroup.selectedButton)
            {
                case this.goldButton:
                    _loc1_ = this.model.dropSkillGold;
                    break;
                case this.creditsButton:
                    _loc1_ = this.model.dropSkillCredits;
                    break;
                case this.freeButton:
                    _loc1_ = this.model.dropSkillFree;
                    break;
            }
            return _loc1_;
        }
        
        private function recalculateData() : void {
            var _loc1_:Object = this.getSelectedDropCostInfo();
            var _loc2_:Array = calcDropSkillsParamsS(this.model.compactDescriptor,_loc1_.xpReuseFraction);
            var _loc3_:Number = _loc2_[0];
            var _loc4_:int = _loc3_ >= 100?_loc2_[1]:-1;
            var _loc5_:Number = _loc2_[2];
            this.beforeBlock.setSkills(this.model.skillsCount,this.model.preLastSkill,this.model.lastSkill,this.model.lastSkillLevel,this.model.hasNewSkill,this.model.newSkillsCount,this.model.lastNewSkillLevel);
            var _loc6_:String = _loc4_ > 1?SkillItemViewMini.TYPE_NEW_SKILL:null;
            var _loc7_:String = SkillItemViewMini.TYPE_NEW_SKILL;
            var _loc8_:* = this.model.skillsCount > _loc4_;
            this.afterBlock.setSkills(_loc4_,_loc6_,_loc7_,_loc5_,_loc8_);
            this.afterBlock.setRoleLevel(this.model.roleLevel,_loc3_);
        }
        
        public function as_setData(param1:Object) : void {
            this.model = SkillDropModel.parseFromObject(param1);
            this.gold = this.model.gold;
            this.credits = this.model.credits;
            invalidate(INVALID_DATA);
        }
        
        public function as_setGold(param1:Number) : void {
            this.gold = param1;
            invalidate(INVALID_MONEY);
        }
        
        public function as_setCredits(param1:Number) : void {
            this.credits = param1;
            invalidate(INVALID_MONEY);
        }
    }
}
