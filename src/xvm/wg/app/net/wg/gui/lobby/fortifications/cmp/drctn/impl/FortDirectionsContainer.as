package net.wg.gui.lobby.fortifications.cmp.drctn.impl
{
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.gui.lobby.fortifications.cmp.drctn.IFortDirectionsContainer;
   import __AS3__.vec.Vector;
   import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
   import net.wg.gui.lobby.fortifications.data.BuildingVO;
   import flash.utils.Dictionary;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.gui.lobby.fortifications.utils.impl.FortCommonUtils;
   import net.wg.gui.lobby.fortifications.data.FunctionalStates;
   import net.wg.gui.lobby.fortifications.events.DirectionEvent;


   public class FortDirectionsContainer extends UIComponentEx implements IFortDirectionsContainer
   {
          
      public function FortDirectionsContainer() {
         super();
         this.directions = Vector.<BuildingDirection>([this.direction1,this.direction2,this.direction3,this.direction4]);
      }

      public var direction1:BuildingDirection = null;

      public var direction2:BuildingDirection = null;

      public var direction3:BuildingDirection = null;

      public var direction4:BuildingDirection = null;

      private var directions:Vector.<BuildingDirection>;

      override protected function configUI() : void {
         super.configUI();
         if(this.direction1)
         {
            this.direction1.uid = FORTIFICATION_ALIASES.FORT_DIRECTION_1;
         }
         if(this.direction2)
         {
            this.direction2.uid = FORTIFICATION_ALIASES.FORT_DIRECTION_2;
         }
         if(this.direction3)
         {
            this.direction3.uid = FORTIFICATION_ALIASES.FORT_DIRECTION_3;
         }
         if(this.direction4)
         {
            this.direction4.uid = FORTIFICATION_ALIASES.FORT_DIRECTION_4;
         }
      }

      public function update(param1:Vector.<BuildingVO>) : void {
         this.updateDirections(param1,this.directions);
      }

      protected function updateDirections(param1:Vector.<BuildingVO>, param2:Vector.<BuildingDirection>) : void {
         var _loc4_:* = 0;
         var _loc5_:BuildingVO = null;
         var _loc11_:BuildingDirection = null;
         var _loc3_:int = param1.length;
         var _loc6_:uint = 1;
         var _loc7_:Dictionary = new Dictionary();
         var _loc8_:int = _loc6_;
         while(_loc8_ < _loc3_)
         {
            _loc5_ = param1[_loc8_];
            _loc4_ = _loc5_.direction;
            _loc7_[_loc4_-1] = true;
            _loc8_++;
         }
         var _loc9_:uint = param2.length;
         var _loc10_:* = 0;
         while(_loc10_ < _loc9_)
         {
            _loc11_ = param2[_loc10_];
            _loc11_.isOpen = _loc7_[_loc10_];
            _loc10_++;
         }
      }

      public function updateTransportMode(param1:Boolean, param2:Boolean) : void {
         var _loc3_:BuildingDirection = null;
         if(!param2)
         {
            for each (_loc3_ in this.directions)
            {
               _loc3_.disabled = param1;
            }
         }
      }

      public function updateDirectionsMode(param1:Boolean, param2:Boolean) : void {
         var _loc3_:BuildingDirection = null;
         switch(FortCommonUtils.instance.getFunctionalState(param1,param2))
         {
            case FunctionalStates.ENTER:
            case FunctionalStates.ENTER_TUTORIAL:
               for each (_loc3_ in this.directions)
               {
                  if(!_loc3_.isOpen)
                  {
                     _loc3_.isActive = true;
                  }
                  else
                  {
                     _loc3_.disabled = true;
                  }
                  _loc3_.addEventListener(ButtonEvent.CLICK,this.dirClickHandler,false,0,true);
               }
               break;
            case FunctionalStates.LEAVE:
            case FunctionalStates.LEAVE_TUTORIAL:
               for each (_loc3_ in this.directions)
               {
                  _loc3_.isActive = false;
                  _loc3_.disabled = false;
                  _loc3_.removeEventListener(ButtonEvent.CLICK,this.dirClickHandler);
               }
               break;
         }
      }

      override protected function onDispose() : void {
         var _loc2_:BuildingDirection = null;
         var _loc1_:int = this.directions.length-1;
         while(_loc1_ >= 0)
         {
            _loc2_ = this.directions[0];
            _loc2_.removeEventListener(ButtonEvent.CLICK,this.dirClickHandler);
            _loc2_.dispose();
            this.directions.splice(0,1);
            _loc1_--;
         }
         this.direction1 = null;
         this.direction2 = null;
         this.direction3 = null;
         this.direction4 = null;
         this.directions = null;
         super.onDispose();
      }

      private function dirClickHandler(param1:ButtonEvent) : void {
         dispatchEvent(new DirectionEvent(DirectionEvent.OPEN_DIRECTION,BuildingDirection(param1.target).uid,true));
      }
   }

}