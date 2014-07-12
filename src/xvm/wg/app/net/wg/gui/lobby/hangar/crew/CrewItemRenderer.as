package net.wg.gui.lobby.hangar.crew
{
   import scaleform.clik.controls.DropdownMenu;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.data.DataProvider;
   import net.wg.gui.components.controls.UILoaderAlt;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.TileList;
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import scaleform.clik.data.ListData;
   import net.wg.gui.events.CrewEvent;
   import scaleform.clik.utils.Padding;
   import flash.utils.getDefinitionByName;
   import scaleform.clik.controls.CoreList;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.managers.PopUpManager;
   import net.wg.gui.lobby.hangar.CrewDropDownEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ComponentEvent;
   import flash.text.TextFieldAutoSize;
   import flash.events.MouseEvent;
   import flash.display.DisplayObject;
   import net.wg.utils.ICommons;
   import net.wg.infrastructure.interfaces.IContextItem;
   import net.wg.data.components.UserContextItem;
   import net.wg.data.VO.SeparateItem;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.MouseEventEx;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import net.wg.gui.events.ContextMenuEvent;
   import flash.events.Event;
   import scaleform.clik.events.InputEvent;
   
   public class CrewItemRenderer extends DropdownMenu implements IListItemRenderer
   {
      
      public function CrewItemRenderer() {
         super();
      }
      
      private static const MAX_ICONS:Number = 5;
      
      private static const MENU_WIDTH:Number = 368;
      
      private static const SCROLLBAR_PADDING:Number = 13;
      
      private static const BUFF:String = "#00FF00";
      
      private static const DEBUFF:String = "#FF0000";
      
      private static function setupDataProvider(param1:Array) : IDataProvider {
         var _loc3_:Object = null;
         var _loc2_:DataProvider = new DataProvider();
         for each(_loc3_ in param1)
         {
            _loc2_.push(new RecruitRendererVO(_loc3_));
         }
         return _loc2_;
      }
      
      private static function createSkillObj(param1:RecruitRendererVO, param2:Number) : SkillsVO {
         var _loc3_:SkillsVO = new SkillsVO({});
         var _loc4_:SkillsVO = SkillsVO(param1.skills[param2]);
         if(!_loc4_.buy)
         {
            _loc3_.icon = "../maps/icons/tankmen/skills/small/" + _loc4_.icon;
            _loc3_.inprogress = param2 == param1.skills.length - 1 && !(param1.lastSkillLevel == 100);
            _loc3_.name = _loc4_.name;
            _loc3_.desc = _loc4_.desc;
            _loc3_.active = _loc4_.active;
         }
         else
         {
            _loc3_.icon = "../maps/icons/tankmen/skills/small/new_skill.png";
            _loc3_.tankmanID = param1.tankmanID;
            _loc3_.buy = true;
            _loc3_.active = _loc4_.active;
         }
         return _loc3_;
      }
      
      public var soundType:String = "rendererNormal";
      
      public var soundId:String = "";
      
      public var icon:UILoaderAlt;
      
      public var iconRole:TankmenIcons;
      
      public var iconRank:TankmenIcons;
      
      public var bg:MovieClip;
      
      public var roles:TileList;
      
      public var skills:TileList;
      
      public var goups_icons:MovieClip;
      
      public var speed_xp_bg:UIComponent;
      
      public var new_skill_anim:MovieClip;
      
      public var levelSpecializationMain:MovieClip;
      
      public var tankmenName:MovieClip;
      
      public var rank:MovieClip;
      
      public var role:MovieClip;
      
      public var vehicleType:TextField;
      
      public var lastSkillLevel:TextField;
      
      public var closeOnlyClickItem:Boolean = false;
      
      protected var _index:uint = 0;
      
      protected var _selectable:Boolean = true;
      
      private var itemClicked:Boolean = false;
      
      public function setListData(param1:ListData) : void {
         this.index = param1.index;
         selected = param1.selected;
         label = param1.label || "empty";
      }
      
      public function setData(param1:Object) : void {
         var rendererData:RecruitRendererVO = null;
         var listHeight:Number = NaN;
         var posY:Number = NaN;
         var listTop:Number = NaN;
         var data:Object = param1;
         this.data = data;
         if(!data)
         {
            this.visible = false;
            return;
         }
         this.visible = true;
         rendererData = RecruitRendererVO(data);
         if(rendererData.recruitList)
         {
            this.dataProvider = setupDataProvider(rendererData.recruitList.sort(function(param1:Object, param2:Object):Number
            {
               if((param1.personalCase) && !param2.personalCase)
               {
                  return -1;
               }
               if(!param1.personalCase && (param2.personalCase))
               {
                  return 1;
               }
               if((param1.recruit) && !param2.recruit)
               {
                  return -1;
               }
               if(!param1.recruit && (param2.recruit))
               {
                  return 1;
               }
               if((param1.selected) && !param2.selected)
               {
                  return -1;
               }
               if(!param1.selected && (param2.selected))
               {
                  return 1;
               }
               if(param1.specializationLevel > param2.specializationLevel)
               {
                  return -1;
               }
               if(param1.specializationLevel < param2.specializationLevel)
               {
                  return 1;
               }
               return 0;
            }));
            listHeight = _height * (rendererData.recruitList.length < menuRowCount?rendererData.recruitList.length:menuRowCount);
            posY = _height / 2 - listHeight / 2 - _height;
            listTop = parent.parent.y - y - _height;
            menuOffset.top = Math.round(posY >= listTop?posY:listTop) - 3;
         }
         if(!(rendererData.iconFile == this.icon.source) && (rendererData.iconFile))
         {
            this.icon.visible = true;
            this.icon.source = "../maps/icons/tankmen/icons/small/" + rendererData.iconFile;
         }
         if(!(rendererData.rankIconFile == this.iconRank.imageLoader.source) && (rendererData.rankIconFile))
         {
            this.iconRank.imageLoader.visible = true;
            this.iconRank.imageLoader.source = "../maps/icons/tankmen/ranks/small/" + rendererData.rankIconFile;
         }
         else
         {
            this.iconRank.imageLoader.visible = false;
         }
         if(!(rendererData.roleIconFile == this.iconRole.imageLoader.source) && (rendererData.roleIconFile))
         {
            this.iconRole.imageLoader.visible = true;
            this.iconRole.imageLoader.source = rendererData.roleIconFile;
         }
         if(rendererData.role)
         {
            this.role.textfield.htmlText = rendererData.role;
         }
         var levelText:String = rendererData.specializationLevel + "%";
         var ttype:String = App.utils.locale.makeString(MENU.tankmen(rendererData.tankType),{});
         if(isNaN(rendererData.tankmanID))
         {
            this.levelSpecializationMain.textfield.htmlText = "";
            this.role.textfield.htmlText = this.role.textfield.htmlText + (", " + ttype + " " + rendererData.vehicleType);
         }
         else if(rendererData.curVehicleType != rendererData.tankType)
         {
            this.levelSpecializationMain.textfield.htmlText = " <font color=\'" + DEBUFF + "\'>" + levelText + "</font>";
            this.role.textfield.htmlText = this.role.textfield.htmlText + (", <font color=\'" + DEBUFF + "\'>" + ttype + " " + rendererData.vehicleType + "</font>");
         }
         else if(rendererData.curVehicleName != rendererData.vehicleType)
         {
            if(!rendererData.vehicleElite)
            {
               this.levelSpecializationMain.textfield.htmlText = " <font color=\'" + DEBUFF + "\'>" + levelText + "</font>";
            }
            else
            {
               this.levelSpecializationMain.textfield.htmlText = levelText;
            }
            this.role.textfield.htmlText = this.role.textfield.htmlText + (", " + ttype + " <font color=\'" + DEBUFF + "\'> " + rendererData.vehicleType + "</font>");
         }
         else
         {
            this.levelSpecializationMain.textfield.htmlText = rendererData.isLessMastered?"<font color=\'#ffd387\'>" + levelText + "</font>":levelText;
            this.role.textfield.htmlText = this.role.textfield.htmlText + (", " + ttype + " " + rendererData.vehicleType);
         }
         
         
         var rls:Array = [];
         var len:int = rendererData.roles.length;
         var i:int = 0;
         while(i < len)
         {
            rls.push(new SkillsVO({"icon":"../maps/icons/tankmen/roles/small/" + rendererData.roles[i] + ".png"}));
            i++;
         }
         this.roles.dataProvider = new DataProvider(rls);
         this.speed_xp_bg.visible = rendererData.isLessMastered;
         this.updateSkills(rendererData);
         selected = false;
         visible = true;
      }
      
      public function getData() : Object {
         return this.data;
      }
      
      public function updateSkills(param1:RecruitRendererVO) : void {
         var _loc2_:Array = null;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         if(param1.skills)
         {
            _loc2_ = [];
            this.new_skill_anim.alpha = 0;
            if(param1.skills.length <= MAX_ICONS)
            {
               this.goups_icons.alpha = 0;
               this.goups_icons.visible = false;
               _loc3_ = param1.skills.length;
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  _loc2_.push(createSkillObj(param1,_loc4_));
                  _loc4_++;
               }
            }
            else
            {
               this.goups_icons.alpha = 1;
               this.goups_icons.visible = true;
               _loc5_ = 0;
               if(param1.lastSkillLevel == 100 && param1.availableSkillsCount == param1.skills.length && !param1.skills[param1.skills.length - 1].buy)
               {
                  _loc5_ = 1;
               }
               _loc6_ = param1.skills.length - 2;
               this.goups_icons.skillsGroupNum.text = "x" + (_loc6_ + 1 + _loc5_);
               _loc7_ = param1.skills.length - 1 - _loc5_;
               while(_loc7_ >= _loc6_)
               {
                  if(_loc7_ == _loc6_)
                  {
                     _loc2_.push(new SkillsVO({}));
                     _loc2_.push(new SkillsVO({}));
                  }
                  _loc2_.push(createSkillObj(param1,_loc7_ + _loc5_));
                  _loc7_--;
               }
               _loc2_ = _loc2_.reverse();
            }
            this.skills.dataProvider = new DataProvider(_loc2_);
            this.lastSkillLevel.text = "";
            if(param1.skills.length > 0 && !param1.skills[0].buy && !isNaN(param1.lastSkillLevel) && !(param1.lastSkillLevel == 100))
            {
               this.lastSkillLevel.text = param1.lastSkillLevel + "%";
            }
            this.lastSkillLevel.x = this.skills.x + (this.skills.columnWidth + this.skills.paddingRight) * _loc2_.length;
         }
         else
         {
            this.skills.dataProvider = new DataProvider([]);
            this.lastSkillLevel.text = "";
            this.goups_icons.alpha = 0;
            this.goups_icons.visible = false;
         }
      }
      
      public function openPersonalCase(param1:uint = 0) : void {
         dispatchEvent(new CrewEvent(CrewEvent.OPEN_PERSONAL_CASE,this.data,false,param1));
      }
      
      public function playSound(param1:String) : void {
         App.soundMgr.playControlsSnd(param1,this.soundType,this.soundId);
      }
      
      override public function get data() : Object {
         return _data;
      }
      
      override public function set data(param1:Object) : void {
         _data = param1;
      }
      
      override public function set dataProvider(param1:IDataProvider) : void {
         dropdown = param1.length > 1?"RecruitScrollingList":"RecruitScrollingList2";
         menuRowCount = param1.length < 5?param1.length:5;
         if(param1.length > this.menuRowCount)
         {
            super.scrollBar = "ScrollBar";
         }
         else
         {
            super.scrollBar = null;
         }
         super.dataProvider = param1;
      }
      
      public function get index() : uint {
         return this._index;
      }
      
      public function set index(param1:uint) : void {
         this._index = param1;
      }
      
      public function get selectable() : Boolean {
         return this._selectable;
      }
      
      public function set selectable(param1:Boolean) : void {
         this._selectable = param1;
      }
      
      public function get hasData() : Boolean {
         var _loc1_:* = !isNaN(RecruitRendererVO(this.data).tankmanID);
         return _loc1_;
      }
      
      override protected function configUI() : void {
         super.configUI();
         buttonMode = true;
         this.componentInspectorSetting = true;
         dropdown = "RecruitScrollingList";
         itemRenderer = "RecruitItemRenderer";
         menuPadding = new Padding(4,3,3,4);
         menuMargin = 0;
         this.new_skill_anim.alpha = 0;
         menuOffset.left = width - 1;
         this.inspectableThumbOffset = 
            {
               "top":0,
               "bottom":0
            };
         this.visible = false;
      }
      
      override protected function showDropdown() : void {
         var _loc1_:MovieClip = null;
         var _loc2_:Class = null;
         if(dropdown == null)
         {
            return;
         }
         if(dropdown is String && !(dropdown == ""))
         {
            _loc2_ = getDefinitionByName(dropdown.toString()) as Class;
            if(_loc2_ != null)
            {
               _loc1_ = new _loc2_() as CoreList;
            }
         }
         if(_loc1_)
         {
            if(itemRenderer is String && !(itemRenderer == ""))
            {
               _loc1_.itemRenderer = getDefinitionByName(itemRenderer.toString()) as Class;
            }
            else if(itemRenderer is Class)
            {
               _loc1_.itemRenderer = itemRenderer as Class;
            }
            
            if(scrollBar is String && !(scrollBar == ""))
            {
               _loc1_.scrollBar = getDefinitionByName(scrollBar.toString()) as Class;
            }
            else if(scrollBar is Class)
            {
               _loc1_.scrollBar = scrollBar as Class;
            }
            
            _loc1_.selectedIndex = RecruitRendererVO(this.data).tankmanID?1:0;
            _loc1_.width = menuWidth == -1?width + menuOffset.left + menuOffset.right:menuWidth;
            _loc1_.dataProvider = _dataProvider;
            _loc1_.padding = menuPadding;
            _loc1_.wrapping = menuWrapping;
            _loc1_.margin = menuMargin;
            _loc1_.thumbOffset = 
               {
                  "top":thumbOffsetTop,
                  "bottom":thumbOffsetBottom
               };
            _loc1_.focusTarget = this;
            _loc1_.rowCount = menuRowCount < 1?5:menuRowCount;
            _loc1_.labelField = _labelField;
            _loc1_.labelFunction = _labelFunction;
            _loc1_.canCleanDataProvider = false;
            _dropdownRef = _loc1_;
            _dropdownRef.addEventListener(ListEvent.ITEM_CLICK,handleMenuItemClick,false,0,true);
            PopUpManager.show(_dropdownRef,x + menuOffset.left,menuDirection == "down"?y + height + menuOffset.top:y - _dropdownRef.height + menuOffset.bottom,parent);
         }
         if(_dropdownRef)
         {
            dispatchEvent(new CrewDropDownEvent(CrewDropDownEvent.SHOW_DROP_DOWN,_dropdownRef));
         }
      }
      
      override protected function hideDropdown() : void {
         App.toolTipMgr.hide();
         if(_dropdownRef)
         {
            _dropdownRef.removeEventListener(ListEvent.ITEM_CLICK,handleMenuItemClick,false);
            if(_dropdownRef is IDisposable)
            {
               IDisposable(_dropdownRef).dispose();
            }
            App.utils.commons.releaseReferences(_dropdownRef);
            _dropdownRef.parent.removeChild(_dropdownRef);
            _dropdownRef = null;
         }
      }
      
      override protected function updateAfterStateChange() : void {
         var _loc1_:RecruitRendererVO = null;
         super.updateAfterStateChange();
         if(this.data)
         {
            _loc1_ = RecruitRendererVO(this.data);
            this.tankmenName.textfield.text = _loc1_.rank + " " + _loc1_.firstname + " " + _loc1_.lastname;
            if(_state == "up" || _state == "disabled" || ["out","toggle","kb_release"].indexOf(_state) > -1 && !selected)
            {
               this.tankmenName.textfield.text = _loc1_.rank + " " + _loc1_.lastname;
            }
         }
      }
      
      override protected function draw() : void {
         if((isInvalid(InvalidationType.SELECTED_INDEX)) || (isInvalid(InvalidationType.DATA)))
         {
            _dataProvider.requestItemAt(_selectedIndex,populateText);
            invalidateData();
            if(_dataProvider.length > 5)
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
         if(isInvalid(InvalidationType.STATE))
         {
            if(_newFrame)
            {
               gotoAndPlay(_newFrame);
               if(_baseDisposed)
               {
                  return;
               }
               _newFrame = null;
            }
            if((focusIndicator) && (_newFocusIndicatorFrame))
            {
               focusIndicator.gotoAndPlay(_newFocusIndicatorFrame);
               _newFocusIndicatorFrame = null;
            }
            this.updateAfterStateChange();
            dispatchEvent(new ComponentEvent(ComponentEvent.STATE_CHANGE));
            invalidate(InvalidationType.DATA,InvalidationType.SIZE);
         }
         if(isInvalid(InvalidationType.DATA))
         {
            updateText();
            if(autoSize != TextFieldAutoSize.NONE)
            {
               invalidateSize();
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            if(!constraintsDisabled)
            {
               if(constraints)
               {
                  constraints.update(_width,_height);
               }
            }
         }
      }
      
      override protected function handleMouseRelease(param1:MouseEvent) : void {
         var _loc4_:* = 0;
         var _loc5_:DisplayObject = null;
         var _loc6_:* = NaN;
         var _loc7_:RecruitRendererVO = null;
         var _loc2_:ICommons = App.utils.commons;
         var _loc3_:RecruitRendererVO = RecruitRendererVO(this.data);
         if(_loc2_.isLeftButton(param1))
         {
            if(this.skills.dataProvider)
            {
               _loc4_ = 0;
               while(_loc4_ < this.skills.dataProvider.length)
               {
                  if(this.skills.dataProvider[_loc4_].buy)
                  {
                     _loc5_ = this.skills.getRendererAt(_loc4_) as DisplayObject;
                     _loc6_ = _loc5_.width;
                     if(_loc5_.mouseX > 0 && _loc5_.mouseX < _loc6_ && _loc5_.mouseY > 0 && _loc5_.mouseY < _loc6_)
                     {
                        if(selected)
                        {
                           close();
                        }
                        if(_loc3_.tankmanID > 0)
                        {
                           this.openPersonalCase(2);
                           setState("out");
                           return;
                        }
                     }
                  }
                  _loc4_++;
               }
            }
            if(dataProvider)
            {
               for each(_loc7_ in _dataProvider)
               {
                  _loc7_.slot = this.data.slot;
                  _loc7_.parentTankmanID = _loc3_.tankmanID;
                  _loc7_.curVehicleType = _loc3_.curVehicleType;
                  _loc7_.curVehicleName = _loc3_.curVehicleName;
                  _loc7_.vehicleElite = _loc3_.vehicleElite;
               }
            }
         }
         if(_loc2_.isRightButton(param1))
         {
            if(_loc3_.tankmanID > 0 && (this.enabled))
            {
               App.contextMenuMgr.show(Vector.<IContextItem>([new UserContextItem("personalCase"),new SeparateItem(),new UserContextItem("tankmanUnload")]),this,this.onContextMenuAction);
               App.toolTipMgr.hide();
            }
         }
         super.handleMouseRelease(param1);
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void {
         super.handleMouseRollOver(param1);
         this.playSound("over");
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void {
         super.handleMouseRollOut(param1);
         this.playSound("out");
      }
      
      override protected function handleMousePress(param1:MouseEvent) : void {
         var _loc5_:ButtonEvent = null;
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null?0:_loc2_.mouseIdx;
         var _loc4_:uint = _loc2_ == null?0:_loc2_.buttonIdx;
         if(_loc4_ == 0)
         {
            _mouseDown = _mouseDown | 1 << _loc3_;
            if(enabled)
            {
               setState("down");
               if((autoRepeat) && _repeatTimer == null)
               {
                  _autoRepeatEvent = new ButtonEvent(ButtonEvent.CLICK,true,false,_loc3_,_loc4_,false,true);
                  _repeatTimer = new Timer(repeatDelay,1);
                  _repeatTimer.addEventListener(TimerEvent.TIMER_COMPLETE,beginRepeat,false,0,true);
                  _repeatTimer.start();
               }
               _loc5_ = new ButtonEvent(ButtonEvent.PRESS,true,false,_loc3_,_loc4_,false,false);
               dispatchEvent(_loc5_);
               this.playSound("press");
            }
         }
      }
      
      private function onContextMenuAction(param1:ContextMenuEvent) : void {
         switch(param1.id)
         {
            case "personalCase":
               this.openPersonalCase();
               break;
            case "tankmanUnload":
               dispatchEvent(new CrewEvent(CrewEvent.UNLOAD_TANKMAN,this.data));
               break;
         }
      }
      
      override protected function onDispose() : void {
         removeEventListener(Event.ADDED,addToAutoGroup,false);
         removeEventListener(Event.REMOVED,addToAutoGroup,false);
         removeEventListener(MouseEvent.ROLL_OVER,this.handleMouseRollOver,false);
         removeEventListener(MouseEvent.ROLL_OUT,this.handleMouseRollOut,false);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.handleMousePress,false);
         removeEventListener(MouseEvent.CLICK,this.handleMouseRelease,false);
         removeEventListener(MouseEvent.DOUBLE_CLICK,this.handleMouseRelease,false);
         removeEventListener(InputEvent.INPUT,handleInput,false);
         if(_repeatTimer)
         {
            _repeatTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,beginRepeat,false);
            _repeatTimer.removeEventListener(TimerEvent.TIMER,handleRepeat,false);
         }
         if(_dropdownRef)
         {
            _dropdownRef.removeEventListener(ListEvent.ITEM_CLICK,handleMenuItemClick,false);
            if(_dropdownRef is IDisposable)
            {
               IDisposable(_dropdownRef).dispose();
            }
            _dropdownRef.parent.removeChild(_dropdownRef);
            _dropdownRef = null;
         }
         if((scrollBar) && scrollBar is IDisposable)
         {
            IDisposable(scrollBar).dispose();
         }
         scrollBar = null;
         if(this.icon)
         {
            this.icon.dispose();
            this.icon = null;
         }
         if(this.iconRole)
         {
            this.iconRole.imageLoader.dispose();
            this.iconRole.imageLoader = null;
            this.iconRole = null;
         }
         if(this.iconRank)
         {
            this.iconRank.imageLoader.dispose();
            this.iconRank.imageLoader = null;
            this.iconRank = null;
         }
         this.bg = null;
         if(this.roles)
         {
            this.roles.dispose();
            this.roles = null;
         }
         if(this.skills)
         {
            this.skills.dispose();
            this.skills = null;
         }
         this.goups_icons = null;
         if(this.speed_xp_bg)
         {
            this.speed_xp_bg.dispose();
            this.speed_xp_bg = null;
         }
         if((_data) && _data is IDisposable)
         {
            IDisposable(_data).dispose();
            _data = null;
         }
         this.new_skill_anim = null;
         this.levelSpecializationMain = null;
         this.tankmenName = null;
         this.rank = null;
         this.role = null;
         this.vehicleType = null;
         this.lastSkillLevel = null;
         super.onDispose();
      }
   }
}
