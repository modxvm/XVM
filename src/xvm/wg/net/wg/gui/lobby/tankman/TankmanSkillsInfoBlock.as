package net.wg.gui.lobby.tankman 
{
    import flash.text.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.core.*;
    
    public class TankmanSkillsInfoBlock extends scaleform.clik.core.UIComponent
    {
        public function TankmanSkillsInfoBlock()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        internal function setTestViewData():void
        {
            this.tankmanPic.source = "../maps/icons/tankmen/icons/big/germany-13.png";
            this.roleIcon.source = "../maps/icons/tankmen/roles/small/commander.png";
            this.nameField.text = "Казимир Внуков";
            this.roleLevelField.text = "100%";
            this.specLevelBar.maximum = 100;
            this.specLevelBar.frontPosition = 51;
            this.specLevelBar.backPosition = 100;
            this.mainSkillItem.type = net.wg.gui.lobby.tankman.SkillItemViewMini.TYPE_SKILLS;
            this.mainSkillItem.iconSource = "../maps/icons/tankmen/skills/small/camouflage.png";
            this.mainSkillItem.count = 2;
            this.additionalSkillItem.type = net.wg.gui.lobby.tankman.SkillItemViewMini.TYPE_CURRENT_NEW_SKILL;
            this.additionalSkillItem.level = 87;
            return;
        }

        public function get portraitSource():String
        {
            return this.tankmanPic.source;
        }

        public function set portraitSource(arg1:String):void
        {
            this.tankmanPic.source = arg1;
            return;
        }

        public function get roleSource():String
        {
            return this.roleIcon.source;
        }

        public function set roleSource(arg1:String):void
        {
            this.roleIcon.source = arg1;
            return;
        }

        public function get tankmanName():String
        {
            return this.nameField.text;
        }

        public function set tankmanName(arg1:String):void
        {
            this.nameField.text = arg1;
            return;
        }

        public function get nation():String
        {
            return this._nation;
        }

        public function set nation(arg1:String):void
        {
            this._nation = arg1;
            this.backgroundSwitcher.gotoAndPlay(this._nation);
            return;
        }

        public function setRoleLevel(arg1:Number, arg2:Number=NaN):void
        {
            var loc1:*=arg1.toString();
            if (!isNaN(arg2) && !(arg2 - arg1 == 0)) 
            {
                loc1 = loc1 + ("<font color=\'#ffffff\'>+" + (arg2 - arg1) + "%</font>");
            }
            else 
            {
                loc1 = loc1 + "%";
            }
            this.roleLevelField.htmlText = loc1;
            this.specLevelBar.frontPosition = arg1;
            this.specLevelBar.backPosition = arg2;
            return;
        }

        public function setSkills(arg1:int, arg2:String, arg3:String, arg4:Number, arg5:Boolean):void
        {
            this.mainSkillItem.visible = false;
            this.additionalSkillItem.visible = false;
            if (arg1 == 0) 
            {
                this.buildCurrentSkill(this.mainSkillItem, net.wg.gui.lobby.tankman.SkillItemViewMini.TYPE_NEW_SKILL, NaN);
                return;
            }
            if (arg4 != 100) 
            {
                if (arg1 != 1) 
                {
                    this.buildSkillsPack(this.mainSkillItem, arg2, arg1);
                    this.buildCurrentSkill(this.additionalSkillItem, arg3, arg4);
                }
                else 
                {
                    this.buildCurrentSkill(this.mainSkillItem, arg3, arg4);
                }
            }
            else 
            {
                this.buildSkillsPack(this.mainSkillItem, arg3, arg1 + 1);
                if (arg5) 
                {
                    this.buildCurrentSkill(this.additionalSkillItem, net.wg.gui.lobby.tankman.SkillItemViewMini.TYPE_NEW_SKILL, NaN);
                }
            }
            return;
        }

        internal function buildCurrentSkill(arg1:net.wg.gui.lobby.tankman.SkillItemViewMini, arg2:String, arg3:Number):void
        {
            if (arg2 != net.wg.gui.lobby.tankman.SkillItemViewMini.TYPE_NEW_SKILL) 
            {
                arg1.type = net.wg.gui.lobby.tankman.SkillItemViewMini.TYPE_CURRENT_SKILL;
                arg1.iconSource = arg2;
            }
            else 
            {
                arg1.type = net.wg.gui.lobby.tankman.SkillItemViewMini.TYPE_CURRENT_NEW_SKILL;
            }
            arg1.level = arg3;
            arg1.visible = true;
            return;
        }

        internal function buildSkillsPack(arg1:net.wg.gui.lobby.tankman.SkillItemViewMini, arg2:String, arg3:int):void
        {
            if (arg2 != net.wg.gui.lobby.tankman.SkillItemViewMini.TYPE_NEW_SKILL) 
            {
                arg1.type = arg3 > 2 ? net.wg.gui.lobby.tankman.SkillItemViewMini.TYPE_SKILLS : net.wg.gui.lobby.tankman.SkillItemViewMini.TYPE_SKILL;
                arg1.iconSource = arg2;
            }
            else 
            {
                arg1.type = arg3 > 2 ? net.wg.gui.lobby.tankman.SkillItemViewMini.TYPE_NEW_SKILLS : net.wg.gui.lobby.tankman.SkillItemViewMini.TYPE_NEW_SKILL;
            }
            arg1.count = (arg3 - 1);
            arg1.visible = true;
            return;
        }

        public var roleIcon:net.wg.gui.components.controls.UILoaderAlt;

        public var nameField:flash.text.TextField;

        public var roleLevelField:flash.text.TextField;

        public var specLevelBar:net.wg.gui.components.advanced.DoubleProgressBar;

        public var mainSkillItem:net.wg.gui.lobby.tankman.SkillItemViewMini;

        public var additionalSkillItem:net.wg.gui.lobby.tankman.SkillItemViewMini;

        public var tankmanPic:net.wg.gui.components.controls.UILoaderAlt;

        public var backgroundSwitcher:scaleform.clik.core.UIComponent;

        internal var _nation:String;
    }
}
