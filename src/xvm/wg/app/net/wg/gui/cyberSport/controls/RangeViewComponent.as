package net.wg.gui.cyberSport.controls
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.rally.vo.SettingRosterVO;
   import flash.display.Sprite;
   import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
   import flash.display.MovieClip;
   import flash.display.DisplayObject;
   
   public class RangeViewComponent extends UIComponent
   {
      
      public function RangeViewComponent() {
         super();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         this.container = new Sprite();
         this.addChild(this.container);
      }
      
      private static const UPDATE_ROSTER:String = "updateRoster";
      
      private static const PADDING_SEPARATOR:int = 3;
      
      private var model:SettingRosterVO;
      
      private var container:Sprite;
      
      private var lastPadding:int = 0;
      
      override protected function onDispose() : void {
         super.onDispose();
         this.removeChild(this.container);
         if(this.model)
         {
            this.model.dispose();
         }
      }
      
      public function setData(param1:SettingRosterVO) : void {
         if(param1 == null)
         {
            return;
         }
         this.model = param1;
         invalidate(UPDATE_ROSTER);
      }
      
      override protected function draw() : void {
         super.draw();
         if((isInvalid(UPDATE_ROSTER)) && (this.model))
         {
            this.cleanContainer();
            this.initializeComponents();
         }
      }
      
      private function cleanContainer() : void {
         while(this.container.numChildren > 0)
         {
            this.container.removeChildAt(0);
         }
      }
      
      private function initializeComponents() : void {
         this.componentDecorator(this.model.nationIDRange,CYBER_SPORT_ALIASES.ROSTER_FLAGS,[this.model.vTypeRange,this.model.vLevelRange],0);
         this.componentDecorator(this.model.vTypeRange,CYBER_SPORT_ALIASES.ROSTER_TYPES,[this.model.vLevelRange],-2);
         if((this.checkArrayRosters(this.model.vLevelRange)) && this.model.vLevelRange.length > 1)
         {
            if(this.model.vLevelRange[0] == this.model.vLevelRange[1])
            {
               this.componentDecorator([this.model.vLevelRange[0]],CYBER_SPORT_ALIASES.ROSTER_LEVELS,null,0);
            }
            else
            {
               this.componentDecorator([this.model.vLevelRange[0]],CYBER_SPORT_ALIASES.ROSTER_LEVELS,null,0);
               this.componentDecorator([],CYBER_SPORT_ALIASES.ROSTER_LEVEL_SEPARATOR,null,0);
               this.componentDecorator([this.model.vLevelRange[1]],CYBER_SPORT_ALIASES.ROSTER_LEVELS,null,0);
            }
         }
         else if(this.checkArrayRosters(this.model.vLevelRange))
         {
            this.componentDecorator(this.model.vLevelRange,CYBER_SPORT_ALIASES.ROSTER_LEVELS,null,0);
         }
         
         this.container.x = Math.round((this._width - this.container.width) / 2);
      }
      
      private function componentDecorator(param1:Array = null, param2:String = null, param3:Array = null, param4:int = 0) : void {
         if(!this.checkArrayRosters(param1) && !(param2 == CYBER_SPORT_ALIASES.ROSTER_LEVEL_SEPARATOR))
         {
            return;
         }
         this.classInitializator(param1,param2,param4);
         if(!this.checkArrayRosters(param3))
         {
            return;
         }
         var _loc5_:int = param3.length;
         var _loc6_:* = 0;
         while(_loc6_ < _loc5_)
         {
            if(this.checkArrayRosters(param3[_loc6_]))
            {
               this.createSeparator();
               break;
            }
            _loc6_++;
         }
      }
      
      private function classInitializator(param1:Array = null, param2:String = null, param3:int = 0) : void {
         var _loc4_:MovieClip = null;
         var _loc5_:uint = 0;
         var _loc6_:* = 0;
         if((param1) && param1.length > 0)
         {
            _loc5_ = param1.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc4_ = this.classFactory(param2);
               _loc4_.gotoAndStop(param1[_loc6_]);
               this.container.addChild(_loc4_);
               this.setComponentPosition(_loc4_,param3);
               _loc6_++;
            }
         }
         else
         {
            _loc4_ = this.classFactory(param2);
            this.container.addChild(_loc4_);
            this.setComponentPosition(_loc4_,param3);
         }
      }
      
      private function setComponentPosition(param1:DisplayObject, param2:int = 0) : void {
         var _loc3_:DisplayObject = null;
         if(this.container.numChildren > 1)
         {
            _loc3_ = this.container.getChildAt(this.container.numChildren - 2);
            param1.x = Math.round(_loc3_.x + _loc3_.width + param2 + this.lastPadding);
         }
         else
         {
            param1.x = 0;
         }
         if(this.lastPadding != 0)
         {
            this.lastPadding = 0;
         }
         param1.y = Math.round((this.height - param1.height) / 2);
      }
      
      private function checkArrayRosters(param1:Array) : Boolean {
         return (param1) && param1.length > 0;
      }
      
      private function createSeparator() : void {
         var _loc1_:MovieClip = this.classFactory(CYBER_SPORT_ALIASES.ROSTER_SEPARATOR);
         this.container.addChild(_loc1_);
         this.setComponentPosition(_loc1_,PADDING_SEPARATOR);
         this.lastPadding = PADDING_SEPARATOR;
      }
      
      private function classFactory(param1:String) : * {
         return App.utils.classFactory.getComponent(param1,MovieClip);
      }
   }
}
