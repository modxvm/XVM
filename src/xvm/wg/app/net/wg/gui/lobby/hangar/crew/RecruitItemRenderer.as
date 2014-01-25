package net.wg.gui.lobby.hangar.crew
{
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.TileList;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.NavigationCode;
   import net.wg.gui.events.CrewEvent;
   import flash.text.TextFieldAutoSize;
   import scaleform.clik.data.DataProvider;
   import flash.geom.Point;
   import scaleform.clik.data.ListData;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.data.constants.Tooltips;
   import __AS3__.vec.Vector;


   public class RecruitItemRenderer extends SoundListItemRenderer
   {
          
      public function RecruitItemRenderer() {
         super();
         soundType = "rendererRecruit";
         this.goups_icons_prop = new IconsProps();
      }

      private static const BUFF:String = "#00FF00";

      private static const DEBUFF:String = "#FF0000";

      private static const INVALIDATE_GROUP_PROPS:String = "groups_icons_prop";

      public static var MAX_ICONS:Number = 5;

      private static function hideTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      private static function createSkillObj(param1:RecruitRendererVO, param2:Number) : SkillsVO {
         var _loc3_:SkillsVO = new SkillsVO({});
         var _loc4_:SkillsVO = SkillsVO(param1.skills[param2]);
         if(!_loc4_.buy)
         {
            _loc3_.icon = "../maps/icons/tankmen/skills/small/" + _loc4_.icon;
            _loc3_.inprogress = param2 == param1.skills.length-1 && !(param1.lastSkillLevel == 100);
            _loc3_.name = _loc4_.name;
            _loc3_.desc = _loc4_.desc;
            _loc3_.active = _loc4_.active;
            _loc3_.selected = param2 == param1.skills.length-1;
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

      public var icon:TankmenIcons;

      public var iconRole:TankmenIcons;

      public var iconRank:TankmenIcons;

      public var skills:TileList;

      public var bg:MovieClip;

      public var goups_icons:MovieClip;

      public var levelSpecializationMain:TextField;

      public var nameTF:TextField;

      public var rank:TextField;

      public var role:TextField;

      public var vehicleType:TextField;

      public var lastSkillLevel:TextField;

      private var _recruit:Boolean = false;

      private var _personalCase:Boolean = false;

      private var goups_icons_prop:IconsProps = null;

      private var textObj:TextObject;

      public var focusIndicatorUI:MovieClip;

      override protected function configUI() : void {
         this.visible = false;
         addEventListener(MouseEvent.CLICK,this.onItemClick);
         addEventListener(MouseEvent.ROLL_OVER,this.showTooltip);
         addEventListener(MouseEvent.ROLL_OUT,hideTooltip);
         addEventListener(MouseEvent.MOUSE_DOWN,hideTooltip);
         this.focusIndicator = this.focusIndicatorUI;
         super.configUI();
      }

      override protected function onDispose() : void {
         removeEventListener(MouseEvent.CLICK,this.onItemClick);
         removeEventListener(MouseEvent.ROLL_OVER,this.showTooltip);
         removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
         removeEventListener(MouseEvent.MOUSE_DOWN,hideTooltip);
         if(this.icon)
         {
            this.icon.imageLoader.dispose();
            this.icon.imageLoader = null;
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
         if(this.skills)
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
         super.onDispose();
      }

      private function showTooltip(param1:MouseEvent) : void {
         this.checkToolTipData(data);
      }

      public function onItemClick(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
         if(App.utils.commons.isLeftButton(param1))
         {
            this.checkClick();
         }
      }

      override public function handleInput(param1:InputEvent) : void {
         if(param1.isDefaultPrevented())
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         var _loc3_:uint = _loc2_.controllerIndex;
         switch(_loc2_.navEquivalent)
         {
            case NavigationCode.ENTER:
               if(_loc2_.value == InputValue.KEY_DOWN)
               {
                  handlePress(_loc3_);
                  this.checkClick();
                  param1.handled = true;
               }
               else
               {
                  if(_loc2_.value == InputValue.KEY_UP)
                  {
                     if(_pressedByKeyboard)
                     {
                        handleRelease(_loc3_);
                        param1.handled = true;
                     }
                  }
               }
               break;
         }
      }

      private function checkClick() : void {
         var _loc1_:RecruitRendererVO = null;
         if(this._recruit == true)
         {
            dispatchEvent(new CrewEvent(CrewEvent.SHOW_RECRUIT_WINDOW,data));
         }
         else
         {
            if(data)
            {
               _loc1_ = RecruitRendererVO(data);
               if(_loc1_.tankmanID == _loc1_.parentTankmanID)
               {
                  return;
               }
               if(_loc1_.tankmanID != _loc1_.parentTankmanID)
               {
                  dispatchEvent(new CrewEvent(CrewEvent.EQUIP_TANKMAN,data));
               }
            }
         }
      }

      override public function setData(param1:Object) : void {
         var _loc6_:Array = null;
         var _loc7_:* = 0;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:* = 0;
         if(!param1)
         {
            return;
         }
         this.data = param1;
         var _loc2_:RecruitRendererVO = RecruitRendererVO(param1);
         this.recruit = _loc2_.recruit == true;
         this.personalCase = _loc2_.personalCase == true;
         this.icon.visible = this.iconRank.visible = this.iconRole.visible = !_loc2_.personalCase && !_loc2_.recruit;
         if(!(_loc2_.iconFile == this.icon.imageLoader.source) && (_loc2_.iconFile))
         {
            this.icon.imageLoader.visible = true;
            this.icon.imageLoader.source = "../maps/icons/tankmen/icons/small/" + _loc2_.iconFile;
         }
         if(!(_loc2_.rankIconFile == this.iconRank.imageLoader.source) && (_loc2_.rankIconFile))
         {
            this.iconRank.imageLoader.visible = true;
            this.iconRank.imageLoader.source = "../maps/icons/tankmen/ranks/small/" + _loc2_.rankIconFile;
         }
         if(!(_loc2_.roleIconFile == this.iconRole.imageLoader.source) && (_loc2_.roleIconFile))
         {
            this.iconRole.imageLoader.visible = true;
            this.iconRole.imageLoader.source = _loc2_.roleIconFile;
         }
         if(this.skills)
         {
            if(_loc2_.skills)
            {
               _loc6_ = [];
               if(_loc2_.skills.length <= MAX_ICONS)
               {
                  this.goups_icons_prop.alpha = 0;
                  this.goups_icons_prop.visible = false;
                  _loc7_ = 0;
                  while(_loc7_ < _loc2_.skills.length)
                  {
                     _loc6_.push(createSkillObj(_loc2_,_loc7_));
                     _loc7_++;
                  }
               }
               else
               {
                  this.goups_icons_prop.alpha = 1;
                  this.goups_icons_prop.visible = true;
                  _loc8_ = 0;
                  if(_loc2_.lastSkillLevel == 100 && _loc2_.availableSkillsCount == _loc2_.skills.length && !_loc2_.skills[_loc2_.skills.length-1].buy)
                  {
                     _loc8_ = 1;
                  }
                  _loc9_ = _loc2_.skills.length - 2;
                  this.goups_icons_prop.autoSize = TextFieldAutoSize.LEFT;
                  this.goups_icons_prop.text = "x" + (_loc9_ + 1 + _loc8_);
                  _loc10_ = _loc2_.skills.length-1 - _loc8_;
                  while(_loc10_ >= _loc9_)
                  {
                     if(_loc10_ == _loc9_)
                     {
                        _loc6_.push(new SkillsVO({}));
                        _loc6_.push(new SkillsVO({}));
                     }
                     _loc6_.push(createSkillObj(_loc2_,_loc10_ + _loc8_));
                     _loc10_--;
                  }
                  _loc6_ = _loc6_.reverse();
               }
               invalidate(INVALIDATE_GROUP_PROPS);
               this.skills.dataProvider = new DataProvider(_loc6_);
            }
         }
         this.textObj = new TextObject();
         this.textObj.nameTF = _loc2_.firstname + " " + _loc2_.lastname;
         this.textObj.rank = _loc2_.rank;
         this.textObj.roleHtml = _loc2_.role;
         var _loc3_:* = _loc2_.specializationLevel + "%";
         var _loc4_:String = App.utils.locale.makeString(MENU.tankmen(_loc2_.tankType),{});
         if(isNaN(_loc2_.tankmanID))
         {
            this.textObj.levelSpecializationMainHtml = "";
            this.textObj.roleHtml = this.textObj.roleHtml + (", " + _loc4_ + " " + _loc2_.vehicleType);
         }
         else
         {
            if(_loc2_.curVehicleType != _loc2_.tankType)
            {
               this.textObj.levelSpecializationMainHtml = " <font color=\'" + DEBUFF + "\'>" + _loc3_ + "</font>";
               this.textObj.roleHtml = this.textObj.roleHtml + (", <font color=\'" + DEBUFF + "\'>" + _loc4_ + " " + _loc2_.vehicleType + "</font>");
            }
            else
            {
               if(_loc2_.curVehicleName != _loc2_.vehicleType)
               {
                  if(!_loc2_.vehicleElite)
                  {
                     this.textObj.levelSpecializationMainHtml = " <font color=\'" + DEBUFF + "\'>" + _loc3_ + "</font>";
                  }
                  else
                  {
                     this.textObj.levelSpecializationMainHtml = _loc3_;
                  }
                  this.textObj.roleHtml = this.textObj.roleHtml + (", " + _loc4_ + " <font color=\'" + DEBUFF + "\'> " + _loc2_.vehicleType + "</font>");
               }
               else
               {
                  this.textObj.levelSpecializationMainHtml = _loc3_;
                  this.textObj.roleHtml = this.textObj.roleHtml + (", " + _loc4_ + " " + _loc2_.vehicleType);
               }
            }
         }
         this.lastSkillLevel.text = "";
         this.lastSkillLevel.autoSize = TextFieldAutoSize.LEFT;
         if((((_loc2_.skills) && (_loc2_.skills.length > 0)) && (!_loc2_.skills[0].buy)) && (!isNaN(_loc2_.lastSkillLevel)) && !(_loc2_.lastSkillLevel == 100))
         {
            this.lastSkillLevel.visible = true;
            this.lastSkillLevel.text = _loc2_.lastSkillLevel + "%";
         }
         else
         {
            this.lastSkillLevel.visible = false;
         }
         this.lastSkillLevel.x = this.skills.x + (this.skills.columnWidth + this.skills.paddingRight) * Math.min(5,this.skills.dataProvider.length);
         setState("up");
         var _loc5_:Point = new Point(mouseX,mouseY);
         _loc5_ = this.localToGlobal(_loc5_);
         if(this.hitTestPoint(_loc5_.x,_loc5_.y,true))
         {
            this.checkToolTipData(_loc2_);
         }
      }

      override public function setListData(param1:ListData) : void {
         index = param1.index;
         selected = param1.selected;
         setState("up");
      }

      override protected function draw() : void {
         var _loc2_:Point = null;
         super.draw();
         this.skills.validateNow();
         this.skills.visible = true;
         var _loc1_:RecruitRendererVO = RecruitRendererVO(data);
         if(isInvalid(INVALIDATE_GROUP_PROPS))
         {
            this.goups_icons.alpha = this.goups_icons_prop.alpha;
            this.goups_icons.visible = this.goups_icons_prop.visible;
            if(this.goups_icons_prop.visible)
            {
               this.goups_icons.skillsGroupNum.autoSize = this.goups_icons_prop.autoSize;
               this.goups_icons.skillsGroupNum.text = this.goups_icons_prop.text;
            }
         }
         if(this._recruit == true)
         {
            this.role.text = MENU.tankmanrecruitrenderer(_loc1_.roleType);
            this.rank.text = MENU.TANKMANRECRUITRENDERER_DESCR;
            this.skills.visible = false;
            this.lastSkillLevel.text = "";
         }
         if(this._personalCase == true)
         {
            this.role.text = MENU.TANKMANRECRUITRENDERER_PERSONALCASE;
            this.skills.visible = false;
            this.lastSkillLevel.text = "";
         }
         if((this.nameTF) && (this.rank) && (this.role) && (this.levelSpecializationMain))
         {
            if(this.textObj != null)
            {
               this.nameTF.text = this.textObj.nameTF;
               this.rank.text = this.textObj.rank;
               this.role.htmlText = this.textObj.roleHtml;
               this.levelSpecializationMain.htmlText = this.textObj.levelSpecializationMainHtml;
            }
         }
         this.visible = true;
         if((isInvalid(InvalidationType.DATA)) && (data))
         {
            _loc2_ = new Point(mouseX,mouseY);
            _loc2_ = this.localToGlobal(_loc2_);
            if(this.hitTestPoint(_loc2_.x,_loc2_.y,true))
            {
               this.checkToolTipData(_loc1_);
            }
         }
      }

      private function checkToolTipData(param1:Object) : void {
         if(owner.visible)
         {
            if((param1) && (param1.tankmanID))
            {
               App.toolTipMgr.showSpecial(Tooltips.TANKMAN,null,param1.tankmanID,true);
            }
            else
            {
               App.toolTipMgr.hide();
            }
         }
      }

      override protected function getStatePrefixes() : Vector.<String> {
         if(this._recruit)
         {
            return Vector.<String>(["recruit_"]);
         }
         if(this._personalCase)
         {
            return Vector.<String>(["personalCase_"]);
         }
         return _selected?statesSelected:statesDefault;
      }

      public function get recruit() : Boolean {
         return this._recruit;
      }

      public function set recruit(param1:Boolean) : void {
         this._recruit = param1;
         setState("up");
      }

      public function get personalCase() : Boolean {
         return this._personalCase;
      }

      public function set personalCase(param1:Boolean) : void {
         this._personalCase = param1;
         setState("up");
      }

      override public function toString() : String {
         return "[Scaleform RecruitItemRenderer " + name + "]";
      }
   }

}