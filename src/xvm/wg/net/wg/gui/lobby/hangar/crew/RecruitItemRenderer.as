package net.wg.gui.lobby.hangar.crew 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.ui.*;
    
    public class RecruitItemRenderer extends net.wg.gui.components.controls.SoundListItemRenderer
    {
        public function RecruitItemRenderer()
        {
            super();
            soundType = "rendererRecruit";
            this.goups_icons_prop = new net.wg.gui.lobby.hangar.crew.IconsProps();
            return;
        }

        public override function dispose():void
        {
            removeEventListener(flash.events.MouseEvent.CLICK, this.onItemClick);
            removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.showTooltip);
            removeEventListener(flash.events.MouseEvent.ROLL_OUT, hideTooltip);
            removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, hideTooltip);
            if (this.icon) 
            {
                this.icon.imageLoader.dispose();
                this.icon.imageLoader = null;
                this.icon = null;
            }
            if (this.iconRole) 
            {
                this.iconRole.imageLoader.dispose();
                this.iconRole.imageLoader = null;
                this.iconRole = null;
            }
            if (this.iconRank) 
            {
                this.iconRank.imageLoader.dispose();
                this.iconRank.imageLoader = null;
                this.iconRank = null;
            }
            if (this.skills) 
            {
                this.skills.dispose();
                this.skills = null;
            }
            this.bg = null;
            this.goups_icons = null;
            this.levelSpecializationMain = null;
            this.nameTF = null;
            this.rank = null;
            this.role = null;
            this.vehicleType = null;
            this.lastSkillLevel = null;
            this.textObj = null;
            focusIndicator = null;
            this.goups_icons_prop = null;
            _data = null;
            super.dispose();
            return;
        }

        internal function showTooltip(arg1:flash.events.MouseEvent):void
        {
            if (owner.visible) 
                App.toolTipMgr.showSpecial(net.wg.data.constants.Tooltips.TANKMAN, null, data.tankmanID, true);
            return;
        }

        public function onItemClick(arg1:flash.events.MouseEvent):void
        {
            if (App.utils.commons.isLeftButton(arg1)) 
                this.checkClick();
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            if (arg1.isDefaultPrevented()) 
                return;
            var loc1:*=arg1.details;
            var loc2:*=loc1.controllerIndex;
            var loc3:*=loc1.navEquivalent;
            switch (loc3) 
            {
                case scaleform.clik.constants.NavigationCode.ENTER:
                    if (loc1.value != scaleform.clik.constants.InputValue.KEY_DOWN) 
                        if (loc1.value == scaleform.clik.constants.InputValue.KEY_UP) 
                            if (_pressedByKeyboard) 
                            {
                                handleRelease(loc2);
                                arg1.handled = true;
                            }
                    else 
                    {
                        handlePress(loc2);
                        this.checkClick();
                        arg1.handled = true;
                    }
                    break;
            }
            return;
        }

        internal function checkClick():void
        {
            var loc1:*=null;
            if (this._recruit != true) 
                if (data) 
                {
                    loc1 = net.wg.gui.lobby.hangar.crew.RecruitRendererVO(data);
                    if (loc1.tankmanID == loc1.parentTankmanID) 
                        return;
                    if (loc1.tankmanID != loc1.parentTankmanID) 
                        dispatchEvent(new net.wg.gui.events.CrewEvent(net.wg.gui.events.CrewEvent.EQUIP_TANKMAN, data));
                }
            else 
                dispatchEvent(new net.wg.gui.events.CrewEvent(net.wg.gui.events.CrewEvent.SHOW_RECRUIT_WINDOW, data));
            return;
        }

        public override function setData(arg1:Object):void
        {
            var loc5:*=null;
            var loc6:*=0;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc9:*=0;
            if (!arg1) 
                return;
            this.data = arg1;
            var loc1:*=net.wg.gui.lobby.hangar.crew.RecruitRendererVO(arg1);
            this.recruit = loc1.recruit == true;
            this.personalCase = loc1.personalCase == true;
            var loc10:*;
            this.iconRole.visible = loc10 = !loc1.personalCase && !loc1.recruit;
            this.iconRank.visible = loc10 = loc10;
            this.icon.visible = loc10;
            if (!(loc1.iconFile == this.icon.imageLoader.source) && loc1.iconFile) 
            {
                this.icon.imageLoader.visible = true;
                this.icon.imageLoader.source = "../maps/icons/tankmen/icons/small/" + loc1.iconFile;
            }
            if (!(loc1.rankIconFile == this.iconRank.imageLoader.source) && loc1.rankIconFile) 
            {
                this.iconRank.imageLoader.visible = true;
                this.iconRank.imageLoader.source = "../maps/icons/tankmen/ranks/small/" + loc1.rankIconFile;
            }
            if (!(loc1.roleIconFile == this.iconRole.imageLoader.source) && loc1.roleIconFile) 
            {
                this.iconRole.imageLoader.visible = true;
                this.iconRole.imageLoader.source = loc1.roleIconFile;
            }
            if (this.skills) 
                if (loc1.skills) 
                {
                    loc5 = [];
                    if (loc1.skills.length <= MAX_ICONS) 
                    {
                        this.goups_icons_prop.alpha = 0;
                        this.goups_icons_prop.visible = false;
                        loc6 = 0;
                        while (loc6 < loc1.skills.length) 
                        {
                            loc5.push(createSkillObj(loc1, loc6));
                            ++loc6;
                        }
                    }
                    else 
                    {
                        this.goups_icons_prop.alpha = 1;
                        this.goups_icons_prop.visible = true;
                        loc7 = 0;
                        if (loc1.lastSkillLevel == 100 && loc1.availableSkillsCount == loc1.skills.length && !loc1.skills[(loc1.skills.length - 1)].buy) 
                            loc7 = 1;
                        loc8 = loc1.skills.length - 2;
                        this.goups_icons_prop.autoSize = flash.text.TextFieldAutoSize.LEFT;
                        this.goups_icons_prop.text = "x" + (loc8 + 1 + loc7);
                        loc9 = (loc1.skills.length - 1) - loc7;
                        while (loc9 >= loc8) 
                        {
                            if (loc9 == loc8) 
                            {
                                loc5.push(new net.wg.gui.lobby.hangar.crew.SkillsVO({}));
                                loc5.push(new net.wg.gui.lobby.hangar.crew.SkillsVO({}));
                            }
                            loc5.push(createSkillObj(loc1, loc9 + loc7));
                            --loc9;
                        }
                        loc5 = loc5.reverse();
                    }
                    invalidate(INVALIDATE_GROUP_PROPS);
                    this.skills.dataProvider = new scaleform.clik.data.DataProvider(loc5);
                }
            this.textObj = new net.wg.gui.lobby.hangar.crew.TextObject();
            this.textObj.nameTF = loc1.firstname + " " + loc1.lastname;
            this.textObj.rank = loc1.rank;
            this.textObj.roleHtml = loc1.role;
            var loc2:*=loc1.specializationLevel + "%";
            var loc3:*=App.utils.locale.makeString(MENU.tankmen(loc1.tankType), {});
            if (isNaN(loc1.tankmanID)) 
            {
                this.textObj.levelSpecializationMainHtml = "";
                this.textObj.roleHtml = this.textObj.roleHtml + (", " + loc3 + " " + loc1.vehicleType);
            }
            else if (loc1.curVehicleType == loc1.tankType) 
                if (loc1.curVehicleName == loc1.vehicleType) 
                {
                    this.textObj.levelSpecializationMainHtml = loc2;
                    this.textObj.roleHtml = this.textObj.roleHtml + (", " + loc3 + " " + loc1.vehicleType);
                }
                else 
                {
                    if (loc1.vehicleElite) 
                        this.textObj.levelSpecializationMainHtml = loc2;
                    else 
                        this.textObj.levelSpecializationMainHtml = " <font color=\'" + DEBUFF + "\'>" + loc2 + "</font>";
                    this.textObj.roleHtml = this.textObj.roleHtml + (", " + loc3 + " <font color=\'" + DEBUFF + "\'> " + loc1.vehicleType + "</font>");
                }
            else 
            {
                this.textObj.levelSpecializationMainHtml = " <font color=\'" + DEBUFF + "\'>" + loc2 + "</font>";
                this.textObj.roleHtml = this.textObj.roleHtml + (", <font color=\'" + DEBUFF + "\'>" + loc3 + " " + loc1.vehicleType + "</font>");
            }
            this.lastSkillLevel.text = "";
            this.lastSkillLevel.autoSize = flash.text.TextFieldAutoSize.LEFT;
            if (loc1.skills && loc1.skills.length > 0 && !loc1.skills[0].buy && !isNaN(loc1.lastSkillLevel) && !(loc1.lastSkillLevel == 100)) 
            {
                this.lastSkillLevel.visible = true;
                this.lastSkillLevel.text = loc1.lastSkillLevel + "%";
            }
            else 
                this.lastSkillLevel.visible = false;
            this.lastSkillLevel.x = this.skills.x + (this.skills.columnWidth + this.skills.paddingRight) * Math.min(5, this.skills.dataProvider.length);
            setState("up");
            var loc4:*=new flash.geom.Point(mouseX, mouseY);
            loc4 = this.localToGlobal(loc4);
            if (this.hitTestPoint(loc4.x, loc4.y, true)) 
                if (owner.visible) 
                    App.toolTipMgr.showSpecial(net.wg.data.constants.Tooltips.TANKMAN, null, loc1.tankmanID, true);
            return;
        }

        public override function setListData(arg1:scaleform.clik.data.ListData):void
        {
            index = arg1.index;
            selected = arg1.selected;
            setState("up");
            return;
        }

        protected override function draw():void
        {
            var loc2:*=null;
            super.draw();
            this.skills.validateNow();
            this.skills.visible = true;
            var loc1:*=net.wg.gui.lobby.hangar.crew.RecruitRendererVO(data);
            if (isInvalid(INVALIDATE_GROUP_PROPS)) 
            {
                this.goups_icons.alpha = this.goups_icons_prop.alpha;
                this.goups_icons.visible = this.goups_icons_prop.visible;
                if (this.goups_icons_prop.visible) 
                {
                    this.goups_icons.skillsGroupNum.autoSize = this.goups_icons_prop.autoSize;
                    this.goups_icons.skillsGroupNum.text = this.goups_icons_prop.text;
                }
            }
            if (this._recruit == true) 
            {
                this.role.text = MENU.tankmanrecruitrenderer(loc1.roleType);
                this.rank.text = MENU.TANKMANRECRUITRENDERER_DESCR;
                this.skills.visible = false;
                this.lastSkillLevel.text = "";
            }
            if (this._personalCase == true) 
            {
                this.role.text = MENU.TANKMANRECRUITRENDERER_PERSONALCASE;
                this.skills.visible = false;
                this.lastSkillLevel.text = "";
            }
            if (this.nameTF && this.rank && this.role && this.levelSpecializationMain) 
                if (this.textObj != null) 
                {
                    this.nameTF.text = this.textObj.nameTF;
                    this.rank.text = this.textObj.rank;
                    this.role.htmlText = this.textObj.roleHtml;
                    this.levelSpecializationMain.htmlText = this.textObj.levelSpecializationMainHtml;
                }
            this.visible = true;
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA) && data) 
            {
                loc2 = new flash.geom.Point(mouseX, mouseY);
                loc2 = this.localToGlobal(loc2);
                if (this.hitTestPoint(loc2.x, loc2.y, true)) 
                    if (owner.visible) 
                        App.toolTipMgr.showSpecial(net.wg.data.constants.Tooltips.TANKMAN, null, loc1.tankmanID, true);
            }
            return;
        }

        protected override function getStatePrefixes():__AS3__.vec.Vector.<String>
        {
            if (this._recruit) 
                return Vector.<String>(["recruit_"]);
            if (this._personalCase) 
                return Vector.<String>(["personalCase_"]);
            return _selected ? statesSelected : statesDefault;
        }

        public function get recruit():Boolean
        {
            return this._recruit;
        }

        public function set recruit(arg1:Boolean):void
        {
            this._recruit = arg1;
            setState("up");
            return;
        }

        public function get personalCase():Boolean
        {
            return this._personalCase;
        }

        public function set personalCase(arg1:Boolean):void
        {
            this._personalCase = arg1;
            setState("up");
            return;
        }

        public override function toString():String
        {
            return "[Scaleform RecruitItemRenderer " + name + "]";
        }

        internal static function hideTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        internal static function createSkillObj(arg1:net.wg.gui.lobby.hangar.crew.RecruitRendererVO, arg2:Number):net.wg.gui.lobby.hangar.crew.SkillsVO
        {
            var loc1:*=new net.wg.gui.lobby.hangar.crew.SkillsVO({});
            var loc2:*;
            if ((loc2 = net.wg.gui.lobby.hangar.crew.SkillsVO(arg1.skills[arg2])).buy) 
            {
                loc1.icon = "../maps/icons/tankmen/skills/small/new_skill.png";
                loc1.tankmanID = arg1.tankmanID;
                loc1.buy = true;
                loc1.active = loc2.active;
            }
            else 
            {
                loc1.icon = "../maps/icons/tankmen/skills/small/" + loc2.icon;
                loc1.inprogress = arg2 == (arg1.skills.length - 1) && !(arg1.lastSkillLevel == 100);
                loc1.name = loc2.name;
                loc1.desc = loc2.desc;
                loc1.active = loc2.active;
                loc1.selected = arg2 == (arg1.skills.length - 1);
            }
            return loc1;
        }

        
        {
            MAX_ICONS = 5;
        }

        protected override function configUI():void
        {
            this.visible = false;
            addEventListener(flash.events.MouseEvent.CLICK, this.onItemClick);
            addEventListener(flash.events.MouseEvent.ROLL_OVER, this.showTooltip);
            addEventListener(flash.events.MouseEvent.ROLL_OUT, hideTooltip);
            addEventListener(flash.events.MouseEvent.MOUSE_DOWN, hideTooltip);
            this.focusIndicator = this.focusIndicatorUI;
            super.configUI();
            return;
        }

        internal static const BUFF:String="#00FF00";

        internal static const DEBUFF:String="#FF0000";

        internal static const INVALIDATE_GROUP_PROPS:String="groups_icons_prop";

        public var icon:net.wg.gui.lobby.hangar.crew.TankmenIcons;

        public var iconRole:net.wg.gui.lobby.hangar.crew.TankmenIcons;

        public var iconRank:net.wg.gui.lobby.hangar.crew.TankmenIcons;

        public var skills:net.wg.gui.components.controls.TileList;

        public var bg:flash.display.MovieClip;

        public var goups_icons:flash.display.MovieClip;

        public var levelSpecializationMain:flash.text.TextField;

        public var nameTF:flash.text.TextField;

        public var rank:flash.text.TextField;

        public var role:flash.text.TextField;

        public var vehicleType:flash.text.TextField;

        public var lastSkillLevel:flash.text.TextField;

        internal var _recruit:Boolean=false;

        internal var _personalCase:Boolean=false;

        internal var goups_icons_prop:net.wg.gui.lobby.hangar.crew.IconsProps=null;

        internal var textObj:net.wg.gui.lobby.hangar.crew.TextObject;

        public var focusIndicatorUI:flash.display.MovieClip;

        public static var MAX_ICONS:Number=5;
    }
}
