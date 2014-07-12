package net.wg.gui.rally.views.list
{
   import scaleform.clik.core.UIComponent;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.rally.interfaces.IRallyVO;
   import flash.events.MouseEvent;
   import net.wg.gui.rally.controls.RallyInvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.gui.rally.controls.RallySimpleSlotRenderer;
   import net.wg.gui.rally.events.RallyViewsEvent;
   
   public class BaseRallyDetailsSection extends UIComponent
   {
      
      public function BaseRallyDetailsSection() {
         super();
         this.slots = this.getSlots();
      }
      
      public var noRallyScreen:Sprite;
      
      public var headerTF:TextField;
      
      public var descriptionTF:TextField;
      
      public var rallyInfoTF:TextField;
      
      public var vehiclesInfoTF:TextField;
      
      public var joinInfoTF:TextField;
      
      public var joinButton:SoundButtonEx;
      
      protected var slots:Array;
      
      protected var model:IRallyVO;
      
      private var _vehiclesLabel:String = "";
      
      protected function getSlots() : Array {
         return [];
      }
      
      protected function onControlRollOver(param1:MouseEvent) : void {
      }
      
      public function setData(param1:IRallyVO) : void {
         this.model = param1;
         invalidateData();
      }
      
      public function set vehiclesLabel(param1:String) : void {
         this._vehiclesLabel = param1;
         invalidate(RallyInvalidationType.VEHICLE_LABEL);
      }
      
      override protected function configUI() : void {
         super.configUI();
         this.noRallyScreen.visible = false;
         if(this.joinButton)
         {
            this.joinButton.addEventListener(ButtonEvent.CLICK,this.onJoinClick);
            this.joinButton.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.joinButton.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         }
         if(this.headerTF)
         {
            this.headerTF.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.headerTF.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         }
         if(this.descriptionTF)
         {
            this.descriptionTF.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.descriptionTF.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         }
      }
      
      override protected function draw() : void {
         super.draw();
         if(isInvalid(RallyInvalidationType.VEHICLE_LABEL))
         {
            this.vehiclesInfoTF.htmlText = this._vehiclesLabel;
         }
         if(isInvalid(InvalidationType.DATA))
         {
            if((this.model) && (this.model.isAvailable()))
            {
               this.updateTitle(this.model);
               this.updateDescription(this.model);
               this.updateSlots(this.model);
               this.noRallyScreen.visible = false;
            }
            else
            {
               this.noRallyScreen.visible = true;
            }
         }
      }
      
      protected function updateTitle(param1:IRallyVO) : void {
         if((param1) && (param1.commanderVal))
         {
            App.utils.commons.formatPlayerName(this.headerTF,App.utils.commons.getUserProps(param1.commanderVal.userName,param1.commanderVal.clanAbbrev,param1.commanderVal.region));
         }
         else
         {
            this.headerTF.text = Values.EMPTY_STR;
         }
      }
      
      protected function updateDescription(param1:IRallyVO) : void {
         this.descriptionTF.text = param1.description;
      }
      
      protected function updateSlots(param1:IRallyVO) : void {
         var _loc3_:RallySimpleSlotRenderer = null;
         var _loc2_:Array = param1.slotsArray;
         for each(_loc3_ in this.slots)
         {
            _loc3_.slotData = _loc2_[this.slots.indexOf(_loc3_)];
         }
      }
      
      protected function onControlRollOut(param1:MouseEvent = null) : void {
         App.toolTipMgr.hide();
      }
      
      override protected function onDispose() : void {
         var _loc1_:RallySimpleSlotRenderer = null;
         if(this.joinButton)
         {
            this.joinButton.removeEventListener(ButtonEvent.CLICK,this.onJoinClick);
            this.joinButton.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.joinButton.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
            this.joinButton.dispose();
            this.joinButton = null;
         }
         if(this.headerTF)
         {
            this.headerTF.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.headerTF.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
            this.headerTF = null;
         }
         if(this.descriptionTF)
         {
            this.descriptionTF.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.descriptionTF.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
            this.descriptionTF = null;
         }
         for each(_loc1_ in this.slots)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         this.model = null;
         super.onDispose();
      }
      
      protected function onJoinClick(param1:ButtonEvent) : void {
         dispatchEvent(new RallyViewsEvent(RallyViewsEvent.JOIN_RALLY_REQUEST));
      }
   }
}
