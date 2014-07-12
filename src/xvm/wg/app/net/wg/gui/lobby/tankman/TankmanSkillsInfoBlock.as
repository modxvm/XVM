package net.wg.gui.lobby.tankman
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import net.wg.gui.components.advanced.DoubleProgressBar;
    
    public class TankmanSkillsInfoBlock extends UIComponent
    {
        
        public function TankmanSkillsInfoBlock() {
            super();
        }
        
        public var roleIcon:UILoaderAlt;
        
        public var nameField:TextField;
        
        public var roleLevelField:TextField;
        
        public var specLevelBar:DoubleProgressBar;
        
        public var mainSkillItem:SkillItemViewMini;
        
        public var additionalSkillItem:SkillItemViewMini;
        
        public var freeSkillItem1:SkillItemViewMini;
        
        public var freeSkillItem2:SkillItemViewMini;
        
        public var tankmanPic:UILoaderAlt;
        
        public var backgroundSwitcher:UIComponent;
        
        private var _nation:String;
        
        override protected function onDispose() : void {
            this.roleIcon.dispose();
            this.roleIcon = null;
            this.nameField = null;
            this.roleLevelField = null;
            this.specLevelBar.dispose();
            this.specLevelBar = null;
            this.mainSkillItem.dispose();
            this.mainSkillItem = null;
            this.additionalSkillItem.dispose();
            this.additionalSkillItem = null;
            this.tankmanPic.dispose();
            this.tankmanPic = null;
            this.backgroundSwitcher.dispose();
            this.backgroundSwitcher = null;
            super.onDispose();
        }
        
        override protected function configUI() : void {
            super.configUI();
        }
        
        private function setTestViewData() : void {
            this.tankmanPic.source = "../maps/icons/tankmen/icons/big/germany-13.png";
            this.roleIcon.source = "../maps/icons/tankmen/roles/small/commander.png";
            this.nameField.text = "Казимир Внуков";
            this.roleLevelField.text = "100%";
            this.specLevelBar.maximum = 100;
            this.specLevelBar.frontPosition = 51;
            this.specLevelBar.backPosition = 100;
            this.mainSkillItem.type = SkillItemViewMini.TYPE_SKILLS;
            this.mainSkillItem.iconSource = "../maps/icons/tankmen/skills/small/camouflage.png";
            this.mainSkillItem.count = 2;
            this.additionalSkillItem.type = SkillItemViewMini.TYPE_CURRENT_NEW_SKILL;
            this.additionalSkillItem.level = 87;
        }
        
        public function get portraitSource() : String {
            return this.tankmanPic.source;
        }
        
        public function set portraitSource(param1:String) : void {
            this.tankmanPic.source = param1;
        }
        
        public function get roleSource() : String {
            return this.roleIcon.source;
        }
        
        public function set roleSource(param1:String) : void {
            this.roleIcon.source = param1;
        }
        
        public function get tankmanName() : String {
            return this.nameField.text;
        }
        
        public function set tankmanName(param1:String) : void {
            this.nameField.text = param1;
        }
        
        public function get nation() : String {
            return this._nation;
        }
        
        public function set nation(param1:String) : void {
            this._nation = param1;
            this.backgroundSwitcher.gotoAndPlay(this._nation);
        }
        
        public function setRoleLevel(param1:Number, param2:Number = undefined) : void {
            var _loc3_:String = param1.toString();
            if(!isNaN(param2) && !(param2 - param1 == 0))
            {
                _loc3_ = _loc3_ + ("<font color=\'#ffffff\'>+" + (param2 - param1) + "%</font>");
            }
            else
            {
                _loc3_ = _loc3_ + "%";
            }
            this.roleLevelField.htmlText = _loc3_;
            this.specLevelBar.frontPosition = param1;
            this.specLevelBar.backPosition = param2;
        }
        
        public function setSkills(param1:int, param2:String, param3:String, param4:Number, param5:Boolean, param6:int = 0, param7:int = 0) : void {
            this.mainSkillItem.visible = false;
            this.additionalSkillItem.visible = false;
            this.freeSkillItem1.visible = false;
            this.freeSkillItem2.visible = false;
            if(param1 == 0)
            {
                this.buildCurrentSkill(this.mainSkillItem,SkillItemViewMini.TYPE_NEW_SKILL,NaN);
                return;
            }
            if(param1 == -1)
            {
                return;
            }
            if(param4 == 100)
            {
                this.buildSkillsPack(this.mainSkillItem,param3,param1 + 1);
                if(param6 > 0)
                {
                    if(param6 > 1)
                    {
                        this.buildSkillsPack(this.freeSkillItem1,SkillItemViewMini.TYPE_NEW_SKILL,param6);
                        this.buildCurrentSkill(this.freeSkillItem2,SkillItemViewMini.TYPE_NEW_SKILL,param7);
                    }
                    else
                    {
                        this.buildCurrentSkill(this.freeSkillItem1,SkillItemViewMini.TYPE_NEW_SKILL,param7);
                    }
                }
                else if(param5)
                {
                    this.buildCurrentSkill(this.additionalSkillItem,SkillItemViewMini.TYPE_NEW_SKILL,NaN);
                }
                
            }
            else if(param1 == 1)
            {
                this.buildCurrentSkill(this.mainSkillItem,param3,param4);
            }
            else
            {
                this.buildSkillsPack(this.mainSkillItem,param2,param1);
                this.buildCurrentSkill(this.additionalSkillItem,param3,param4);
            }
            
        }
        
        private function buildCurrentSkill(param1:SkillItemViewMini, param2:String, param3:Number) : void {
            if(param2 == SkillItemViewMini.TYPE_NEW_SKILL)
            {
                param1.type = SkillItemViewMini.TYPE_CURRENT_NEW_SKILL;
            }
            else
            {
                param1.type = SkillItemViewMini.TYPE_CURRENT_SKILL;
                param1.iconSource = param2;
            }
            param1.level = param3;
            param1.visible = true;
        }
        
        private function buildSkillsPack(param1:SkillItemViewMini, param2:String, param3:int) : void {
            if(param2 == SkillItemViewMini.TYPE_NEW_SKILL)
            {
                param1.type = param3 > 2?SkillItemViewMini.TYPE_NEW_SKILLS:SkillItemViewMini.TYPE_NEW_SKILL;
            }
            else
            {
                param1.type = param3 > 2?SkillItemViewMini.TYPE_SKILLS:SkillItemViewMini.TYPE_SKILL;
                param1.iconSource = param2;
            }
            param1.count = param3 - 1;
            param1.visible = true;
        }
    }
}
