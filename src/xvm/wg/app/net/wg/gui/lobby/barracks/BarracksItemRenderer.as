package net.wg.gui.lobby.barracks
{
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.ActionPrice;
   import flash.events.MouseEvent;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.events.CrewEvent;
   import net.wg.utils.ICommons;
   import scaleform.clik.events.ListEvent;
   import __AS3__.vec.Vector;
   import flash.geom.Point;
   import scaleform.clik.constants.InvalidationType;


   public class BarracksItemRenderer extends SoundListItemRenderer
   {
          
      public function BarracksItemRenderer() {
         super();
         buttonMode = true;
         this.soundType = SoundTypes.BARRACKS_TANKMAN_SOUND_TYPE;
         this.btnDissmiss.soundType = SoundTypes.NORMAL_BTN;
      }

      private static const INVALIDATE_PARAMS:String = "params";

      private static const INVALIDATE_IN_TANK:String = "inTank";

      private static const DEBUFF:String = "#FF0000";

      public var countField:TextField = null;

      public var btnDissmiss:SoundButtonEx;

      public var icon:UILoaderAlt;

      public var iconRole:UILoaderAlt;

      public var iconRank:UILoaderAlt;

      public var clickArea:MovieClip = null;

      public var selection:MovieClip = null;

      public var emptyPlacesTF:TextField;

      public var levelSpecializationMain:TextField = null;

      public var tankmanName:TextField = null;

      public var rank:TextField = null;

      public var role:TextField = null;

      public var lockMsg:TextField = null;

      public var vehicleType:TextField = null;

      public var price:IconText = null;

      public var actionPrice:ActionPrice = null;

      public var descrField:TextField = null;

      private var _inTank:Boolean = false;

      private var _inCurrentTank:Boolean = false;

      private var _empty:Boolean = false;

      private var _buy:Boolean = false;

      private var _isMouseOver:Boolean = false;

      public function set useHandCursorOnClickArea(param1:Boolean) : void {
         if(this.clickArea)
         {
            this.useHandCursor = param1;
            this.tabEnabled = param1;
         }
      }

      override public function dispose() : void {
         removeEventListener(MouseEvent.CLICK,this.onBarracksItemRendererClick,false);
         this.btnDissmiss.removeEventListener(ButtonEvent.CLICK,this.onBtnDissmissClick);
         this.btnDissmiss.removeEventListener(MouseEvent.ROLL_OVER,this.showTooltip,false);
         this.btnDissmiss.removeEventListener(MouseEvent.ROLL_OUT,this.hideTooltip,false);
         this.btnDissmiss.removeEventListener(MouseEvent.CLICK,this.hideTooltip,false);
         this.removeEventListener(MouseEvent.ROLL_OVER,this.rendererRollOver);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.rendererRollOut);
         this.btnDissmiss.focusTarget = null;
         if(this.icon)
         {
            this.icon.dispose();
            this.icon = null;
         }
         if(this.iconRole)
         {
            this.iconRole.dispose();
            this.iconRole = null;
         }
         if(this.iconRank)
         {
            this.iconRank.dispose();
            this.iconRank = null;
         }
         this.btnDissmiss.dispose();
         _data = null;
         this.countField = null;
         this.clickArea = null;
         this.selection = null;
         this.levelSpecializationMain = null;
         this.tankmanName = null;
         this.rank = null;
         this.role = null;
         this.lockMsg = null;
         this.vehicleType = null;
         if(this.price)
         {
            this.price.dispose();
         }
         if(this.actionPrice)
         {
            this.actionPrice.dispose();
         }
         this.descrField = null;
         super.dispose();
      }

      override protected function configUI() : void {
         super.configUI();
         tabChildren = false;
         this.btnDissmiss.focusTarget = this;
         this.btnDissmiss.addEventListener(ButtonEvent.CLICK,this.onBtnDissmissClick);
         this.icon.mouseEnabled = this.iconRole.mouseEnabled = this.iconRank.mouseEnabled = false;
         this.icon.mouseChildren = this.iconRole.mouseChildren = this.iconRank.mouseChildren = false;
         addEventListener(MouseEvent.CLICK,this.onBarracksItemRendererClick,false,0,true);
         this.addEventListener(MouseEvent.ROLL_OVER,this.rendererRollOver);
         this.addEventListener(MouseEvent.ROLL_OUT,this.rendererRollOut);
         this.btnDissmiss.addEventListener(MouseEvent.ROLL_OVER,this.showTooltip,false,0,true);
         this.btnDissmiss.addEventListener(MouseEvent.ROLL_OUT,this.hideTooltip,false,0,true);
         this.btnDissmiss.addEventListener(MouseEvent.CLICK,this.hideTooltip,false,0,true);
         mouseChildren = true;
         this.clickArea.buttonMode = true;
      }

      override protected function handleMouseRollOver(param1:MouseEvent) : void {
         super.handleMouseRollOver(param1);
         this._isMouseOver = true;
      }

      override protected function handleMouseRollOut(param1:MouseEvent) : void {
         super.handleMouseRollOut(param1);
         this._isMouseOver = false;
      }

      override public function setData(param1:Object) : void {
         if(!param1)
         {
            return;
         }
         this.btnDissmiss.focusTarget = this;
         this.data = param1;
         this.empty = param1.empty;
         this.buy = param1.buy;
         if((param1.iconFile) && !(param1.iconFile == this.icon.source))
         {
            this.icon.source = "../maps/icons/tankmen/icons/barracks/" + param1.iconFile;
         }
         if((param1.rankIconFile) && !(param1.rankIconFile == this.iconRank.source))
         {
            this.iconRank.source = "../maps/icons/tankmen/ranks/small/" + param1.rankIconFile;
         }
         if((param1.roleIconFile) && !(param1.roleIconFile == this.iconRole.source))
         {
            this.iconRole.source = param1.roleIconFile;
         }
         this.inCurrentTank = param1.inCurrentTank;
         if(!this.inCurrentTank)
         {
            this.inTank = param1.inTank;
         }
         this.btnDissmiss.enabled = !((param1.locked) || (param1.vehicleBroken));
         this.btnDissmiss.label = MENU.BARRACKS_BTNDISSMISS;
         this.btnDissmiss.soundId = "btnDissmiss";
         if((this.inTank) || (this.inCurrentTank))
         {
            this.btnDissmiss.label = MENU.BARRACKS_BTNUNLOAD;
            this.btnDissmiss.soundId = "btnUnload";
            this.btnDissmiss.enabled = !param1.locked;
         }
         this.btnDissmiss.soundType = SoundTypes.NORMAL_BTN;
         this.btnDissmiss.validateNow();
         invalidate(INVALIDATE_PARAMS);
         validateNow();
      }

      public function onBtnDissmissClick(param1:ButtonEvent) : void {
         if((this._inTank) || (this._inCurrentTank))
         {
            dispatchEvent(new CrewEvent(CrewEvent.UNLOAD_TANKMAN,data));
         }
         else
         {
            dispatchEvent(new CrewEvent(CrewEvent.DISMISS_TANKMAN,data));
         }
      }

      public function onBarracksItemRendererClick(param1:MouseEvent) : void {
         if(param1.target == this.btnDissmiss)
         {
            return;
         }
         var _loc2_:ICommons = App.utils.commons;
         if(_loc2_.isLeftButton(param1))
         {
            if(this._empty)
            {
               dispatchEvent(new CrewEvent(CrewEvent.SHOW_RECRUIT_WINDOW,null,true));
            }
            else
            {
               if(this._buy)
               {
                  dispatchEvent(new CrewEvent(CrewEvent.SHOW_BERTH_BUY_DIALOG));
               }
            }
         }
         if((_loc2_.isRightButton(param1)) && !this._buy && !this._empty)
         {
            dispatchEvent(new CrewEvent(CrewEvent.OPEN_PERSONAL_CASE,data,false,0));
         }
      }

      private function showTooltip(param1:MouseEvent) : void {
         setState("out");
         if((this._inTank) || (this._inCurrentTank))
         {
            App.toolTipMgr.showComplex(TOOLTIPS.BARRACKS_TANKMEN_UNLOAD);
         }
         else
         {
            App.toolTipMgr.showComplex(TOOLTIPS.BARRACKS_TANKMEN_DISMISS);
         }
      }

      private function hideTooltip(param1:MouseEvent) : void {
         setState("over");
         App.toolTipMgr.hide();
         dispatchEvent(new ListEvent(ListEvent.ITEM_ROLL_OVER,true,true,-1,-1,-1,null,data));
      }

      private function rendererRollOver(param1:MouseEvent) : void {
         dispatchEvent(new ListEvent(ListEvent.ITEM_ROLL_OVER,true,true,-1,-1,-1,null,data));
      }

      private function rendererRollOut(param1:MouseEvent) : void {
         dispatchEvent(new ListEvent(ListEvent.ITEM_ROLL_OUT,true,true,-1,-1,-1,null,data));
      }

      override protected function getStatePrefixes() : Vector.<String> {
         if(this._empty)
         {
            return Vector.<String>(["empty_"]);
         }
         if(this._buy)
         {
            return Vector.<String>(["buy_"]);
         }
         if(_selected)
         {
            return Vector.<String>(["selected_",""]);
         }
         return Vector.<String>([""]);
      }

      public function get inTank() : Boolean {
         return this._inTank;
      }

      public function set inTank(param1:Boolean) : void {
         if(this._inTank == param1)
         {
            return;
         }
         this._inTank = param1;
         invalidate(INVALIDATE_IN_TANK);
      }

      public function get inCurrentTank() : Boolean {
         return this._inCurrentTank;
      }

      public function set inCurrentTank(param1:Boolean) : void {
         if(this._inCurrentTank == param1)
         {
            return;
         }
         this._inCurrentTank = param1;
         invalidate(INVALIDATE_IN_TANK);
      }

      public function get buy() : Boolean {
         return this._buy;
      }

      public function set buy(param1:Boolean) : void {
         this._buy = param1;
         this.updateControlsState();
         setState("up");
      }

      public function get empty() : Boolean {
         return this._empty;
      }

      public function set empty(param1:Boolean) : void {
         this._empty = param1;
         this.updateControlsState();
         setState("up");
      }

      private function updateControlsState() : void {
         var _loc1_:* = !((this._buy) || (this._empty));
         this.icon.visible = this.iconRank.visible = this.iconRole.visible = _loc1_;
         this.btnDissmiss.visible = _loc1_;
         if(this.buy)
         {
            soundType = SoundTypes.BARRACKS_BUY_SOUND_TYPE;
         }
         else
         {
            if(this.empty)
            {
               soundType = SoundTypes.BARRACKS_EMPTY_SOUND_TYPE;
            }
            else
            {
               soundType = SoundTypes.BARRACKS_TANKMAN_SOUND_TYPE;
            }
         }
      }

      override public function toString() : String {
         return "[Scaleform BarracksItemRenderer " + name + "]";
      }

      override public function get enabled() : Boolean {
         return super.enabled;
      }

      override public function set enabled(param1:Boolean) : void {
         super.enabled = param1;
         mouseChildren = param1;
      }

      override protected function draw() : void {
         var _loc1_:String = null;
         var _loc2_:Point = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            if(this.actionPrice)
            {
               this.actionPrice.setup(this);
            }
         }
         if(!_baseDisposed)
         {
            if((isInvalid(INVALIDATE_IN_TANK)) && (this.selection))
            {
               _loc1_ = "barracks";
               if(this._inTank)
               {
                  _loc1_ = "tank";
               }
               if(this._inCurrentTank)
               {
                  _loc1_ = "current_tank";
               }
               this.selection.gotoAndPlay(_loc1_);
            }
            if((isInvalid(INVALIDATE_PARAMS)) && (data))
            {
               _loc2_ = new Point(mouseX,mouseY);
               _loc2_ = this.localToGlobal(_loc2_);
               if((this.hitTestPoint(_loc2_.x,_loc2_.y,true)) && (this._isMouseOver))
               {
                  if((this.btnDissmiss.hitTestPoint(_loc2_.x,_loc2_.y,true)) && !((this._buy) || (this.empty)))
                  {
                     this.showTooltip(null);
                  }
                  else
                  {
                     dispatchEvent(new ListEvent(ListEvent.ITEM_ROLL_OVER,true,true,-1,-1,-1,null,data));
                  }
               }
               this.countField.text = "";
               if(this._buy)
               {
                  if(this.price)
                  {
                     this.price.text = App.utils.locale.gold(data.price);
                     this.price.visible = true;
                  }
                  if(this.actionPrice)
                  {
                     if(data.hasOwnProperty("actionPrc"))
                     {
                        this.actionPrice.setData(data.actionPrc,data.price,data.defPrice,IconText.GOLD);
                     }
                     else
                     {
                        this.actionPrice.visible = false;
                     }
                     if(this.price)
                     {
                        this.price.visible = !this.actionPrice.visible;
                     }
                  }
                  this.countField.text = "+" + data.count;
                  this.descrField.text = App.utils.locale.makeString(MENU.BARRACKS_BTNBUYBERTHDECS);
                  this.descrField.replaceText(this.descrField.text.indexOf("{"),this.descrField.text.indexOf("}") + 1,String(data.count));
               }
               if(this.empty)
               {
                  this.emptyPlacesTF.text = App.utils.locale.makeString(MENU.BARRACKS_BARRACKSRENDERER_PLACESCOUNT) + " " + data.freePlaces;
               }
               if(this.role)
               {
                  this.role.htmlText = data.role;
               }
               if(!((this._buy) || (this.empty)))
               {
                  _loc3_ = data.specializationLevel + "%";
                  _loc4_ = App.utils.locale.makeString(MENU.tankmen(data.tankType));
                  if(!data.isInSelfVehicleClass)
                  {
                     this.levelSpecializationMain.htmlText = " <font color=\'" + DEBUFF + "\'>" + _loc3_ + "</font>";
                     this.role.htmlText = this.role.htmlText + (", <font color=\'" + DEBUFF + "\'>" + _loc4_ + " " + data.vehicleType + "</font>");
                  }
                  else
                  {
                     if(!data.isInSelfVehicleType)
                     {
                        this.levelSpecializationMain.htmlText = " <font color=\'" + DEBUFF + "\'>" + _loc3_ + "</font>";
                        this.role.htmlText = this.role.htmlText + (", " + _loc4_ + " <font color=\'" + DEBUFF + "\'> " + data.vehicleType + "</font>");
                     }
                     else
                     {
                        this.levelSpecializationMain.htmlText = _loc3_;
                        this.role.htmlText = this.role.htmlText + (", " + _loc4_ + " " + data.vehicleType);
                     }
                  }
                  this.tankmanName.text = data.firstname + " " + data.lastname;
                  this.rank.text = data.rank;
                  this.lockMsg.text = data.lockMessage;
               }
            }
         }
      }
   }

}