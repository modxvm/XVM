package net.wg.gui.cyberSport.controls
{
   import net.wg.gui.components.controls.ListItemRendererWithFocusOnDis;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.UILoaderAlt;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.cyberSport.vo.VehicleSelectorItemVO;
   import __AS3__.vec.Vector;
   import flash.geom.Point;
   import net.wg.data.constants.Cursors;
   import flash.events.MouseEvent;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.MouseEventEx;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.gui.cyberSport.controls.events.VehicleSelectorItemEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.NavigationCode;


   public class VehicleSelectorItemRenderer extends ListItemRendererWithFocusOnDis
   {
          
      public function VehicleSelectorItemRenderer() {
         this.statesSelectedNotReady = Vector.<String>(["notReady_selected_",""]);
         this.statesNotReady = Vector.<String>(["notReady_",""]);
         super();
         this.notReadyAlert.visible = false;
         preventAutosizing = true;
         this.notReadyAlert.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverAlert);
         this.notReadyAlert.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutAlert);
      }

      private static const MODE_MULTI:String = "multiSelection";

      private static const MODE_SINGLE:String = "singleSelection";

      private static const LAYOUT_CONFIG:Object;

      public var checkBox:CheckBox;

      public var flagLoader:UILoaderAlt;

      public var tankIcon:UILoaderAlt;

      public var vehicleTypeIcon:MovieClip;

      public var levelIcon:MovieClip;

      public var vehicleNameTF:TextField;

      public var notReadyAlert:MovieClip;

      public var bg:MovieClip;

      protected var model:VehicleSelectorItemVO;

      private var _multiSelectionMode:Boolean = false;

      private var _userVehiclesMode:Boolean = false;

      private var _isVehicleReady:Boolean = true;

      protected var statesSelectedNotReady:Vector.<String>;

      protected var statesNotReady:Vector.<String>;

      override protected function getStatePrefixes() : Vector.<String> {
         var _loc2_:Vector.<String> = null;
         var _loc1_:Boolean = this.model?this.model.selected:false;
         _loc2_ = _loc1_?this._isVehicleReady?statesSelected:this.statesSelectedNotReady:this._isVehicleReady?statesDefault:this.statesNotReady;
         var _loc3_:Boolean = _loc2_ == this.statesSelectedNotReady || _loc2_ == this.statesNotReady;
         this.mouseChildren = true;
         if(this.bg)
         {
            this.bg.mouseEnabled = false;
         }
         this.notReadyAlert.visible = _loc3_;
         this.notReadyAlert.buttonMode = (_loc3_) && (enabled);
         this.notReadyAlert.mouseEnabled = true;
         return _loc2_;
      }

      override public function setData(param1:Object) : void {
         var _loc2_:Point = null;
         var _loc3_:* = false;
         var _loc4_:* = false;
         this.model = param1 as VehicleSelectorItemVO;
         if(this.model)
         {
            visible = true;
            enabled = this.checkBox.enabled = this.model.enabled;
            this._isVehicleReady = this._userVehiclesMode?this.model.isReadyToFight:true;
            setState(state);
            _loc2_ = new Point(mouseX,mouseY);
            _loc2_ = localToGlobal(_loc2_);
            _loc3_ = this.notReadyAlert.hitTestPoint(_loc2_.x,_loc2_.y,true);
            _loc4_ = this.hitTestPoint(_loc2_.x,_loc2_.y,true);
            if(_loc3_)
            {
               if(!this._isVehicleReady)
               {
                  if((this.notReadyAlert.mouseEnabled) && (this.notReadyAlert.buttonMode))
                  {
                     App.cursor.setCursor(Cursors.BUTTON);
                  }
                  else
                  {
                     App.cursor.setCursor(Cursors.ARROW);
                  }
                  App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_VEHICLESELECTOR_NOTREADY);
               }
               else
               {
                  App.toolTipMgr.hide();
               }
            }
            if((_loc4_) && !_loc3_)
            {
               if(((this.model) && (this.model.tooltip)) && (!enabled) && !this.mouseOverAlert)
               {
                  App.toolTipMgr.showComplex(this.model.tooltip);
               }
               else
               {
                  if((enabled) && !_loc3_)
                  {
                     App.toolTipMgr.hide();
                  }
               }
            }
            invalidateData();
         }
         else
         {
            visible = false;
         }
      }

      override protected function handleMouseRollOver(param1:MouseEvent) : void {
         super.handleMouseRollOver(param1);
         this.showDisabledToolTip();
      }

      private var mouseOverAlert:Boolean = false;

      override protected function handleMouseRollOut(param1:MouseEvent) : void {
         super.handleMouseRollOut(param1);
         if(!enabled)
         {
            App.toolTipMgr.hide();
         }
      }

      private function onRollOverAlert(param1:MouseEvent) : void {
         this.mouseOverAlert = true;
         if(!enabled)
         {
            App.toolTipMgr.hide();
         }
         App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_VEHICLESELECTOR_NOTREADY);
      }

      private function onRollOutAlert(param1:MouseEvent) : void {
         this.mouseOverAlert = false;
         App.toolTipMgr.hide();
         this.showDisabledToolTip();
      }

      private function showDisabledToolTip() : void {
         if(((this.model) && (this.model.tooltip)) && (!enabled) && !this.mouseOverAlert)
         {
            App.toolTipMgr.showComplex(this.model.tooltip);
         }
      }

      override protected function configUI() : void {
         super.configUI();
         this.checkBox.label = "";
         addEventListener(ButtonEvent.CLICK,this.onClick);
         addEventListener(MouseEvent.DOUBLE_CLICK,this.onDoubleClick);
         this.updateModeLayout();
      }

      private function updateModeLayout() : void {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         var _loc1_:VehicleSelector = owner.parent as VehicleSelector;
         if(_loc1_)
         {
            this._multiSelectionMode = _loc1_.multiSelection;
            this._userVehiclesMode = _loc1_.isUserVehiclesMode;
            _loc2_ = this._multiSelectionMode?MODE_MULTI:MODE_SINGLE;
            _loc3_ = LAYOUT_CONFIG[_loc2_];
            this.flagLoader.x = _loc3_.flagX;
            this.vehicleTypeIcon.x = _loc3_.vTypeX;
            this.checkBox.visible = this._multiSelectionMode;
         }
      }

      private function onClick(param1:ButtonEvent) : void {
         this.dispatchVehicleSelector(false);
      }

      private function onDoubleClick(param1:MouseEvent) : void {
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null?0:_loc2_.buttonIdx;
         if(_loc3_ != MouseEventEx.LEFT_BUTTON)
         {
            return;
         }
         if(!this._multiSelectionMode)
         {
            this.dispatchVehicleSelector(true);
         }
      }

      private function dispatchVehicleSelector(param1:Boolean=false) : void {
         this.model.selected = this._multiSelectionMode?!this.model.selected:true;
         setState(state);
         invalidate(InvalidationType.DATA);
         dispatchEvent(new VehicleSelectorItemEvent(VehicleSelectorItemEvent.SELECT_VEHICLE,this.model,true,false,param1));
         if(owner)
         {
            owner.invalidate(InvalidationType.STATE);
         }
      }

      override public function handleInput(param1:InputEvent) : void {
         super.handleInput(param1);
         var _loc2_:InputDetails = param1.details;
         if(!enabled)
         {
            return;
         }
         switch(_loc2_.navEquivalent)
         {
            case NavigationCode.ENTER:
               if(_loc2_.value == InputValue.KEY_DOWN && !this._multiSelectionMode)
               {
                  this.dispatchVehicleSelector(true);
               }
               break;
         }
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            if(this.bg)
            {
               this.bg.mouseEnabled = false;
            }
         }
         if((isInvalid(InvalidationType.DATA)) && (this.model))
         {
            this.checkBox.selected = this.model.selected;
            this.vehicleNameTF.text = this.model.shortUserName;
            this.vehicleTypeIcon.gotoAndStop(this.model.type);
            this.levelIcon.gotoAndStop(this.model.level);
            this.flagLoader.source = "../maps/icons/filters/nations/" + App.utils.nations.getNationName(this.model.nationID) + ".png";
            this.tankIcon.source = this.model.smallIconPath;
         }
      }

      override protected function onDispose() : void {
         removeEventListener(ButtonEvent.CLICK,this.onClick);
         removeEventListener(MouseEvent.DOUBLE_CLICK,this.onDoubleClick);
         if(this.model)
         {
            this.model.dispose();
         }
         this.notReadyAlert.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverAlert);
         this.notReadyAlert.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutAlert);
         this.checkBox.dispose();
         this.flagLoader.dispose();
         this.tankIcon.dispose();
         super.onDispose();
      }
   }

}