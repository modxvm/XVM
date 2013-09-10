package net.wg.gui.lobby.hangar.crew 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.data.VO.*;
    import net.wg.data.components.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.hangar.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import net.wg.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import scaleform.clik.managers.*;
    import scaleform.clik.utils.*;
    import scaleform.gfx.*;
    
    public class CrewItemRenderer extends scaleform.clik.controls.DropdownMenu implements scaleform.clik.interfaces.IListItemRenderer
    {
        public function CrewItemRenderer()
        {
            super();
            return;
        }

        public override function get data():Object
        {
            return _data;
        }

        public override function set data(arg1:Object):void
        {
            _data = arg1;
            return;
        }

        public override function set dataProvider(arg1:scaleform.clik.interfaces.IDataProvider):void
        {
            dropdown = arg1.length > 1 ? "RecruitScrollingList" : "RecruitScrollingList2";
            menuRowCount = arg1.length < 5 ? arg1.length : 5;
            if (arg1.length > this.menuRowCount) 
                super.scrollBar = "ScrollBar";
            else 
                super.scrollBar = null;
            super.dataProvider = arg1;
            return;
        }

        public function get index():uint
        {
            return this._index;
        }

        public function set index(arg1:uint):void
        {
            this._index = arg1;
            return;
        }

        public function get selectable():Boolean
        {
            return this._selectable;
        }

        public function set selectable(arg1:Boolean):void
        {
            this._selectable = arg1;
            return;
        }

        public function get hasData():Boolean
        {
            var loc1:*=!isNaN(net.wg.gui.lobby.hangar.crew.RecruitRendererVO(this.data).tankmanID);
            return loc1;
        }

        protected override function configUI():void
        {
            super.configUI();
            buttonMode = true;
            this.componentInspectorSetting = true;
            dropdown = "RecruitScrollingList";
            itemRenderer = "RecruitItemRenderer";
            menuPadding = new scaleform.clik.utils.Padding(4, 3, 3, 4);
            menuMargin = 0;
            this.new_skill_anim.alpha = 0;
            menuOffset.left = (width - 1);
            this.inspectableThumbOffset = {"top":0, "bottom":0};
            this.visible = false;
            return;
        }

        protected override function showDropdown():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (dropdown == null) 
                return;
            if (dropdown is String && !(dropdown == "")) 
            {
                loc2 = flash.utils.getDefinitionByName(dropdown.toString()) as Class;
                if (loc2 != null) 
                    loc1 = new loc2() as scaleform.clik.controls.CoreList;
            }
            if (loc1) 
            {
                if (itemRenderer is String && !(itemRenderer == "")) 
                    loc1.itemRenderer = flash.utils.getDefinitionByName(itemRenderer.toString()) as Class;
                else if (itemRenderer is Class) 
                    loc1.itemRenderer = itemRenderer as Class;
                if (scrollBar is String && !(scrollBar == "")) 
                    loc1.scrollBar = flash.utils.getDefinitionByName(scrollBar.toString()) as Class;
                else if (scrollBar is Class) 
                    loc1.scrollBar = scrollBar as Class;
                loc1.selectedIndex = 1;
                loc1.width = menuWidth != -1 ? menuWidth : width + menuOffset.left + menuOffset.right;
                loc1.dataProvider = _dataProvider;
                loc1.padding = menuPadding;
                loc1.wrapping = menuWrapping;
                loc1.margin = menuMargin;
                loc1.thumbOffset = {"top":thumbOffsetTop, "bottom":thumbOffsetBottom};
                loc1.focusTarget = this;
                loc1.rowCount = menuRowCount < 1 ? 5 : menuRowCount;
                loc1.labelField = _labelField;
                loc1.labelFunction = _labelFunction;
                _dropdownRef = loc1;
                _dropdownRef.addEventListener(scaleform.clik.events.ListEvent.ITEM_CLICK, handleMenuItemClick, false, 0, true);
                scaleform.clik.managers.PopUpManager.show(_dropdownRef, x + menuOffset.left, menuDirection != "down" ? y - _dropdownRef.height + menuOffset.bottom : y + height + menuOffset.top, parent);
            }
            if (_dropdownRef) 
                dispatchEvent(new net.wg.gui.lobby.hangar.CrewDropDownEvent(net.wg.gui.lobby.hangar.CrewDropDownEvent.SHOW_DROP_DOWN, _dropdownRef));
            return;
        }

        protected override function hideDropdown():void
        {
            if (_dropdownRef) 
            {
                _dropdownRef.removeEventListener(scaleform.clik.events.ListEvent.ITEM_CLICK, handleMenuItemClick, false);
                if (_dropdownRef is net.wg.infrastructure.interfaces.entity.IDisposable) 
                    net.wg.infrastructure.interfaces.entity.IDisposable(_dropdownRef).dispose();
                App.utils.commons.releaseReferences(_dropdownRef);
                _dropdownRef.parent.removeChild(_dropdownRef);
                _dropdownRef = null;
            }
            App.toolTipMgr.hide();
            return;
        }

        protected override function updateAfterStateChange():void
        {
            var loc1:*=null;
            super.updateAfterStateChange();
            if (this.data) 
            {
                loc1 = net.wg.gui.lobby.hangar.crew.RecruitRendererVO(this.data);
                this.tankmenName.textfield.text = loc1.rank + " " + loc1.firstname + " " + loc1.lastname;
                if (_state == "up" || _state == "disabled" || _state == "out" && !selected) 
                    this.tankmenName.textfield.text = loc1.rank + " " + loc1.lastname;
            }
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(scaleform.clik.constants.InvalidationType.SELECTED_INDEX) || isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                _dataProvider.requestItemAt(_selectedIndex, populateText);
                invalidateData();
                if (_dataProvider.length > 5) 
                {
                    menuPadding.right = 0;
                    menuWidth = MENU_WIDTH + SCROLLBAR_PADDING + menuPadding.right + menuPadding.left;
                }
                else 
                {
                    menuPadding.right = 4;
                    menuWidth = MENU_WIDTH + menuPadding.right + menuPadding.left;
                }
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.STATE)) 
            {
                if (_newFrame) 
                {
                    gotoAndPlay(_newFrame);
                    if (_baseDisposed) 
                        return;
                    _newFrame = null;
                }
                if (focusIndicator && _newFocusIndicatorFrame) 
                {
                    focusIndicator.gotoAndPlay(_newFocusIndicatorFrame);
                    _newFocusIndicatorFrame = null;
                }
                this.updateAfterStateChange();
                dispatchEvent(new scaleform.clik.events.ComponentEvent(scaleform.clik.events.ComponentEvent.STATE_CHANGE));
                invalidate(scaleform.clik.constants.InvalidationType.DATA, scaleform.clik.constants.InvalidationType.SIZE);
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                updateText();
                if (autoSize != flash.text.TextFieldAutoSize.NONE) 
                    invalidateSize();
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
                if (!constraintsDisabled) 
                    if (constraints) 
                        constraints.update(_width, _height);
            return;
        }

        protected override function handleMouseRelease(arg1:flash.events.MouseEvent):void
        {
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=NaN;
            var loc6:*=null;
            var loc1:*=App.utils.commons;
            var loc2:*=net.wg.gui.lobby.hangar.crew.RecruitRendererVO(this.data);
            if (loc1.isLeftButton(arg1)) 
            {
                if (this.skills.dataProvider) 
                {
                    loc3 = 0;
                    while (loc3 < this.skills.dataProvider.length) 
                    {
                        if (this.skills.dataProvider[loc3].buy) 
                        {
                            loc5 = (loc4 = this.skills.getRendererAt(loc3) as flash.display.DisplayObject).width;
                            if (loc4.mouseX > 0 && loc4.mouseX < loc5 && loc4.mouseY > 0 && loc4.mouseY < loc5) 
                            {
                                if (selected) 
                                    close();
                                if (loc2.tankmanID > 0) 
                                {
                                    this.openPersonalCase(2);
                                    setState("out");
                                    return;
                                }
                            }
                        }
                        ++loc3;
                    }
                }
                if (dataProvider) 
                {
                    var loc7:*=0;
                    var loc8:*=_dataProvider;
                    for each (loc6 in loc8) 
                    {
                        loc6.slot = this.data.slot;
                        loc6.parentTankmanID = loc2.tankmanID;
                        loc6.curVehicleType = loc2.curVehicleType;
                        loc6.curVehicleName = loc2.curVehicleName;
                        loc6.vehicleElite = loc2.vehicleElite;
                    }
                }
            }
            if (loc1.isRightButton(arg1)) 
                if (loc2.tankmanID > 0 && this.enabled) 
                {
                    App.contextMenuMgr.show(Vector.<net.wg.infrastructure.interfaces.IContextItem>([new net.wg.data.components.UserContextItem("personalCase"), new net.wg.data.VO.SeparateItem(), new net.wg.data.components.UserContextItem("tankmanUnload"), new net.wg.data.components.UserContextItem("tankmanUnloadAll")]), this, this.onContextMenuAction);
                    App.toolTipMgr.hide();
                }
            super.handleMouseRelease(arg1);
            return;
        }

        protected override function handleMouseRollOver(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOver(arg1);
            this.playSound("over");
            return;
        }

        protected override function handleMouseRollOut(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOut(arg1);
            this.playSound("out");
            return;
        }

        protected override function handleMousePress(arg1:flash.events.MouseEvent):void
        {
            var loc4:*=null;
            var loc1:*=arg1 as scaleform.gfx.MouseEventEx;
            var loc2:*=loc1 != null ? loc1.mouseIdx : 0;
            var loc3:*;
            if ((loc3 = loc1 != null ? loc1.buttonIdx : 0) == 0) 
            {
                _mouseDown = _mouseDown | 1 << loc2;
                if (enabled) 
                {
                    setState("down");
                    if (autoRepeat && _repeatTimer == null) 
                    {
                        _autoRepeatEvent = new scaleform.clik.events.ButtonEvent(scaleform.clik.events.ButtonEvent.CLICK, true, false, loc2, loc3, false, true);
                        _repeatTimer = new flash.utils.Timer(repeatDelay, 1);
                        _repeatTimer.addEventListener(flash.events.TimerEvent.TIMER_COMPLETE, beginRepeat, false, 0, true);
                        _repeatTimer.start();
                    }
                    loc4 = new scaleform.clik.events.ButtonEvent(scaleform.clik.events.ButtonEvent.PRESS, true, false, loc2, loc3, false, false);
                    dispatchEvent(loc4);
                    this.playSound("press");
                }
            }
            return;
        }

        internal function onContextMenuAction(arg1:net.wg.gui.events.ContextMenuEvent):void
        {
            var loc1:*=arg1.id;
            switch (loc1) 
            {
                case "personalCase":
                    this.openPersonalCase();
                    break;
                case "tankmanUnload":
                    dispatchEvent(new net.wg.gui.events.CrewEvent(net.wg.gui.events.CrewEvent.UNLOAD_TANKMAN, this.data));
                    break;
                case "tankmanUnloadAll":
                    dispatchEvent(new net.wg.gui.events.CrewEvent(net.wg.gui.events.CrewEvent.UNLOAD_ALL_TANKMAN, this.data));
                    break;
            }
            return;
        }

        public override function dispose():void
        {
            removeEventListener(flash.events.Event.ADDED, addToAutoGroup, false);
            removeEventListener(flash.events.Event.REMOVED, addToAutoGroup, false);
            removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.handleMouseRollOver, false);
            removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.handleMouseRollOut, false);
            removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.handleMousePress, false);
            removeEventListener(flash.events.MouseEvent.CLICK, this.handleMouseRelease, false);
            removeEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.handleMouseRelease, false);
            removeEventListener(scaleform.clik.events.InputEvent.INPUT, handleInput, false);
            if (_repeatTimer) 
            {
                _repeatTimer.removeEventListener(flash.events.TimerEvent.TIMER_COMPLETE, beginRepeat, false);
                _repeatTimer.removeEventListener(flash.events.TimerEvent.TIMER, handleRepeat, false);
            }
            if (_dropdownRef) 
            {
                _dropdownRef.removeEventListener(scaleform.clik.events.ListEvent.ITEM_CLICK, handleMenuItemClick, false);
                if (_dropdownRef is net.wg.infrastructure.interfaces.entity.IDisposable) 
                    net.wg.infrastructure.interfaces.entity.IDisposable(_dropdownRef).dispose();
                _dropdownRef.parent.removeChild(_dropdownRef);
                _dropdownRef = null;
            }
            if (_dataProvider) 
            {
                _dataProvider.removeEventListener(flash.events.Event.CHANGE, handleDataChange, false);
                _dataProvider.cleanUp();
                _dataProvider = null;
            }
            if (scrollBar && scrollBar is net.wg.infrastructure.interfaces.entity.IDisposable) 
                net.wg.infrastructure.interfaces.entity.IDisposable(scrollBar).dispose();
            scrollBar = null;
            if (this.icon) 
            {
                this.icon.dispose();
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
            this.bg = null;
            if (this.roles) 
            {
                this.roles.dispose();
                this.roles = null;
            }
            if (this.skills) 
            {
                this.skills.dispose();
                this.skills = null;
            }
            this.goups_icons = null;
            if (this.speed_xp_bg) 
            {
                this.speed_xp_bg.dispose();
                this.speed_xp_bg = null;
            }
            if (_data && _data is net.wg.infrastructure.interfaces.entity.IDisposable) 
            {
                net.wg.infrastructure.interfaces.entity.IDisposable(_data).dispose();
                _data = null;
            }
            this.new_skill_anim = null;
            this.levelSpecializationMain = null;
            this.tankmenName = null;
            this.rank = null;
            this.role = null;
            this.vehicleType = null;
            this.lastSkillLevel = null;
            super.dispose();
            return;
        }

        public function playSound(arg1:String):void
        {
            App.soundMgr.playControlsSnd(arg1, this.soundType, this.soundId);
            return;
        }

        internal static function setupDataProvider(arg1:Array):scaleform.clik.interfaces.IDataProvider
        {
            var loc2:*=null;
            var loc1:*=new scaleform.clik.data.DataProvider();
            var loc3:*=0;
            var loc4:*=arg1;
            for each (loc2 in loc4) 
                loc1.push(new net.wg.gui.lobby.hangar.crew.RecruitRendererVO(loc2));
            return loc1;
        }

        public function setListData(arg1:scaleform.clik.data.ListData):void
        {
            this.index = arg1.index;
            selected = arg1.selected;
            label = arg1.label || "empty";
            return;
        }

        public function setData(arg1:Object):void
        {
            var data:Object;
            var rendererData:net.wg.gui.lobby.hangar.crew.RecruitRendererVO;
            var levelText:String;
            var ttype:String;
            var rls:Array;
            var len:int;
            var i:int;
            var listHeight:Number;
            var posY:Number;
            var listTop:Number;

            var loc1:*;
            listHeight = NaN;
            posY = NaN;
            listTop = NaN;
            data = arg1;
            this.data = data;
            if (!data) 
            {
                this.visible = false;
                return;
            }
            this.visible = true;
            rendererData = net.wg.gui.lobby.hangar.crew.RecruitRendererVO(data);
            if (rendererData.recruitList) 
            {
                this.dataProvider = setupDataProvider(rendererData.recruitList.sort(function (arg1:Object, arg2:Object):Number
                {
                    if (arg1.personalCase && !arg2.personalCase) 
                        return -1;
                    if (!arg1.personalCase && arg2.personalCase) 
                        return 1;
                    if (arg1.recruit && !arg2.recruit) 
                        return -1;
                    if (!arg1.recruit && arg2.recruit) 
                        return 1;
                    if (arg1.selected && !arg2.selected) 
                        return -1;
                    if (!arg1.selected && arg2.selected) 
                        return 1;
                    if (arg1.specializationLevel > arg2.specializationLevel) 
                        return -1;
                    if (arg1.specializationLevel < arg2.specializationLevel) 
                        return 1;
                    return 0;
                }))
                listHeight = _height * (rendererData.recruitList.length < menuRowCount ? rendererData.recruitList.length : menuRowCount);
                posY = _height / 2 - listHeight / 2 - _height;
                listTop = parent.parent.y - y - _height;
                menuOffset.top = Math.round(posY >= listTop ? posY : listTop) - 3;
            }
            if (!(rendererData.iconFile == this.icon.source) && rendererData.iconFile) 
            {
                this.icon.visible = true;
                this.icon.source = "../maps/icons/tankmen/icons/small/" + rendererData.iconFile;
            }
            if (!(rendererData.rankIconFile == this.iconRank.imageLoader.source) && rendererData.rankIconFile) 
            {
                this.iconRank.imageLoader.visible = true;
                this.iconRank.imageLoader.source = "../maps/icons/tankmen/ranks/small/" + rendererData.rankIconFile;
            }
            else 
                this.iconRank.imageLoader.visible = false;
            if (!(rendererData.roleIconFile == this.iconRole.imageLoader.source) && rendererData.roleIconFile) 
            {
                this.iconRole.imageLoader.visible = true;
                this.iconRole.imageLoader.source = rendererData.roleIconFile;
            }
            if (rendererData.role) 
                this.role.textfield.htmlText = rendererData.role;
            levelText = rendererData.specializationLevel + "%";
            ttype = App.utils.locale.makeString(MENU.tankmen(rendererData.tankType), {});
            if (isNaN(rendererData.tankmanID)) 
            {
                this.levelSpecializationMain.textfield.htmlText = "";
                this.role.textfield.htmlText = this.role.textfield.htmlText + (", " + ttype + " " + rendererData.vehicleType);
            }
            else if (rendererData.curVehicleType == rendererData.tankType) 
                if (rendererData.curVehicleName == rendererData.vehicleType) 
                {
                    this.levelSpecializationMain.textfield.htmlText = rendererData.isLessMastered ? "<font color=\'#ffd387\'>" + levelText + "</font>" : levelText;
                    this.role.textfield.htmlText = this.role.textfield.htmlText + (", " + ttype + " " + rendererData.vehicleType);
                }
                else 
                {
                    if (rendererData.vehicleElite) 
                        this.levelSpecializationMain.textfield.htmlText = levelText;
                    else 
                        this.levelSpecializationMain.textfield.htmlText = " <font color=\'" + DEBUFF + "\'>" + levelText + "</font>";
                    this.role.textfield.htmlText = this.role.textfield.htmlText + (", " + ttype + " <font color=\'" + DEBUFF + "\'> " + rendererData.vehicleType + "</font>");
                }
            else 
            {
                this.levelSpecializationMain.textfield.htmlText = " <font color=\'" + DEBUFF + "\'>" + levelText + "</font>";
                this.role.textfield.htmlText = this.role.textfield.htmlText + (", <font color=\'" + DEBUFF + "\'>" + ttype + " " + rendererData.vehicleType + "</font>");
            }
            rls = [];
            len = rendererData.roles.length;
            i = 0;
            while (i < len) 
            {
                rls.push(new net.wg.gui.lobby.hangar.crew.SkillsVO({"icon":"../maps/icons/tankmen/roles/small/" + rendererData.roles[i] + ".png"}));
                ++i;
            }
            this.roles.dataProvider = new scaleform.clik.data.DataProvider(rls);
            this.speed_xp_bg.visible = rendererData.isLessMastered;
            this.updateSkills(rendererData);
            selected = false;
            visible = true;
            return;
        }

        public function updateSkills(arg1:net.wg.gui.lobby.hangar.crew.RecruitRendererVO):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=NaN;
            if (arg1.skills) 
            {
                loc1 = [];
                this.new_skill_anim.alpha = 0;
                if (arg1.skills.length <= MAX_ICONS) 
                {
                    this.goups_icons.alpha = 0;
                    this.goups_icons.visible = false;
                    loc2 = arg1.skills.length;
                    loc3 = 0;
                    while (loc3 < loc2) 
                    {
                        loc1.push(createSkillObj(arg1, loc3));
                        ++loc3;
                    }
                }
                else 
                {
                    this.goups_icons.alpha = 1;
                    this.goups_icons.visible = true;
                    loc4 = 0;
                    if (arg1.lastSkillLevel == 100 && arg1.availableSkillsCount == arg1.skills.length && !arg1.skills[(arg1.skills.length - 1)].buy) 
                        loc4 = 1;
                    loc5 = arg1.skills.length - 2;
                    this.goups_icons.skillsGroupNum.text = "x" + (loc5 + 1 + loc4);
                    loc6 = (arg1.skills.length - 1) - loc4;
                    while (loc6 >= loc5) 
                    {
                        if (loc6 == loc5) 
                        {
                            loc1.push(new net.wg.gui.lobby.hangar.crew.SkillsVO({}));
                            loc1.push(new net.wg.gui.lobby.hangar.crew.SkillsVO({}));
                        }
                        loc1.push(createSkillObj(arg1, loc6 + loc4));
                        --loc6;
                    }
                    loc1 = loc1.reverse();
                }
                this.skills.dataProvider = new scaleform.clik.data.DataProvider(loc1);
                this.lastSkillLevel.text = "";
                if (arg1.skills.length > 0 && !arg1.skills[0].buy && !isNaN(arg1.lastSkillLevel) && !(arg1.lastSkillLevel == 100)) 
                    this.lastSkillLevel.text = arg1.lastSkillLevel + "%";
                this.lastSkillLevel.x = this.skills.x + (this.skills.columnWidth + this.skills.paddingRight) * loc1.length;
            }
            else 
            {
                this.skills.dataProvider = new scaleform.clik.data.DataProvider([]);
                this.lastSkillLevel.text = "";
                this.goups_icons.alpha = 0;
                this.goups_icons.visible = false;
            }
            return;
        }

        public function openPersonalCase(arg1:uint=0):void
        {
            dispatchEvent(new net.wg.gui.events.CrewEvent(net.wg.gui.events.CrewEvent.OPEN_PERSONAL_CASE, this.data, false, arg1));
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
            }
            return loc1;
        }

        internal static const MENU_WIDTH:Number=368;

        internal static const SCROLLBAR_PADDING:Number=13;

        internal static const BUFF:String="#00FF00";

        internal static const DEBUFF:String="#FF0000";

        internal static const MAX_ICONS:Number=5;

        public var soundType:String="rendererNormal";

        public var soundId:String="";

        public var icon:net.wg.gui.components.controls.UILoaderAlt;

        public var iconRole:net.wg.gui.lobby.hangar.crew.TankmenIcons;

        public var iconRank:net.wg.gui.lobby.hangar.crew.TankmenIcons;

        public var roles:net.wg.gui.components.controls.TileList;

        public var skills:net.wg.gui.components.controls.TileList;

        public var goups_icons:flash.display.MovieClip;

        public var speed_xp_bg:scaleform.clik.core.UIComponent;

        public var new_skill_anim:flash.display.MovieClip;

        public var levelSpecializationMain:flash.display.MovieClip;

        public var tankmenName:flash.display.MovieClip;

        public var rank:flash.display.MovieClip;

        public var role:flash.display.MovieClip;

        public var vehicleType:flash.text.TextField;

        public var lastSkillLevel:flash.text.TextField;

        public var closeOnlyClickItem:Boolean=false;

        protected var _index:uint=0;

        internal var itemClicked:Boolean=false;

        public var bg:flash.display.MovieClip;

        protected var _selectable:Boolean=true;
    }
}
