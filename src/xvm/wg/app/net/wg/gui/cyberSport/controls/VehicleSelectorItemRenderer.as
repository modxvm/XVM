package net.wg.gui.cyberSport.controls
{
   import net.wg.gui.components.controls.ListItemRendererWithFocusOnDis;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.UILoaderAlt;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.cyberSport.vo.VehicleSelectorItemVO;
   import __AS3__.vec.Vector;
   import scaleform.clik.events.ButtonEvent;
   import flash.events.MouseEvent;
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
         preventAutosizing = true;
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

      protected var model:VehicleSelectorItemVO;

      private var _multiSelectionMode:Boolean = false;

      private var _userVehiclesMode:Boolean = false;

      private var _isVehicleReady:Boolean = true;

      protected var statesSelectedNotReady:Vector.<String>;

      protected var statesNotReady:Vector.<String>;

      override protected function getStatePrefixes() : Vector.<String> {
         var _loc1_:Boolean = this.model?this.model.selected:false;
         return _loc1_?this._isVehicleReady?statesSelected:this.statesSelectedNotReady:this._isVehicleReady?statesDefault:this.statesNotReady;
      }

      override public function setData(param1:Object) : void {
         this.model = param1 as VehicleSelectorItemVO;
         if(this.model)
         {
            visible = true;
            enabled = this.checkBox.enabled = this.model.enabled;
            this._isVehicleReady = this._userVehiclesMode?this.model.isReadyToFight:true;
            setState(state);
            invalidateData();
         }
         else
         {
            visible = false;
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

      override public function dispose() : void {
         removeEventListener(ButtonEvent.CLICK,this.onClick);
         removeEventListener(MouseEvent.DOUBLE_CLICK,this.onDoubleClick);
         if(this.model)
         {
            this.model.dispose();
         }
         super.dispose();
      }
   }

}