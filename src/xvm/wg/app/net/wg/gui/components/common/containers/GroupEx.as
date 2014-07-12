package net.wg.gui.components.common.containers
{
   import flash.display.DisplayObject;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.core.UIComponent;
   
   public class GroupEx extends Group
   {
      
      public function GroupEx() {
         super();
      }
      
      private var _dataProvider:Array;
      
      private var _itemRendererClass:Class;
      
      override protected function draw() : void {
         var _loc1_:* = 0;
         var _loc2_:DisplayObject = null;
         var _loc3_:Object = null;
         var _loc4_:* = 0;
         var _loc5_:* = undefined;
         if((isInvalid(InvalidationType.DATA)) && (this._itemRendererClass))
         {
            _loc1_ = this._dataProvider?this._dataProvider.length:0;
            while(_loc1_ < numChildren)
            {
               _loc2_ = removeChildAt(numChildren - 1);
               if(_loc2_ is IDisposable)
               {
                  IDisposable(_loc2_).dispose();
               }
            }
            _loc4_ = 0;
            while(_loc4_ < _loc1_)
            {
               _loc3_ = this._dataProvider[_loc4_];
               if(_loc4_ == numChildren)
               {
                  _loc5_ = new this._itemRendererClass();
                  addChild(_loc5_);
               }
               _loc2_ = getChildAt(_loc4_);
               if(_loc2_.hasOwnProperty("data"))
               {
                  _loc2_["data"] = _loc3_;
               }
               if(_loc5_)
               {
                  if(_loc5_ is UIComponent)
                  {
                     _loc5_.validateNow();
                  }
               }
               _loc4_++;
            }
         }
         super.draw();
      }
      
      public function get dataProvider() : Array {
         return this._dataProvider;
      }
      
      public function set dataProvider(param1:Array) : void {
         this._dataProvider = param1;
         invalidateData();
      }
      
      public function get itemRendererClass() : Class {
         return this._itemRendererClass;
      }
      
      public function set itemRendererClass(param1:Class) : void {
         if(this._itemRendererClass != param1)
         {
            this._itemRendererClass = param1;
            invalidateData();
         }
      }
      
      override protected function onDispose() : void {
         this._dataProvider = null;
         this._itemRendererClass = null;
         super.onDispose();
      }
   }
}
