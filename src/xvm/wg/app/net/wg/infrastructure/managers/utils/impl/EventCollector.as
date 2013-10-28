package net.wg.infrastructure.managers.utils.impl
{
   import net.wg.utils.IEventCollector;
   import flash.utils.Dictionary;
   import flash.events.IEventDispatcher;
   import flash.events.Event;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import flash.display.DisplayObject;
   import net.wg.infrastructure.interfaces.IDynamicContent;
   import flash.display.DisplayObjectContainer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import flash.utils.getQualifiedClassName;
   import net.wg.infrastructure.interfaces.IWindow;
   import net.wg.infrastructure.exceptions.InfrastructureException;
   import net.wg.infrastructure.exceptions.NullPointerException;
   import flash.events.EventPhase;


   public class EventCollector extends Object implements IEventCollector
   {
          
      public function EventCollector() {
         super();
         this.initObj();
      }

      public static const MODULE:uint = 0;

      public static const DYN_CONTENT:uint = 1;

      public static const PROXIES:uint = 2;

      private static const HAS_NO_DYNAMIC_CONTENT:String = "HasNoDynamicContent";

      private var _isEnabled:Boolean = false;

      private var _objStack:Dictionary;

      private var _moduleStack:Dictionary;

      private var _dynamicContents:Array;

      public function setEnabled(param1:Boolean) : void {
         this._isEnabled = param1;
      }

      public function addOneShotEvent(param1:IEventDispatcher, param2:String, param3:Function, param4:Boolean=false, param5:int=0, param6:Boolean=false) : void {
         var ec:EventCollector = null;
         var autoRemoveFunc:Function = null;
         var obj:IEventDispatcher = param1;
         var event:String = param2;
         var func:Function = param3;
         var useCapture:Boolean = param4;
         var priority:int = param5;
         var useWeakReference:Boolean = param6;
         ec = this;
         autoRemoveFunc = function(param1:Event):void
         {
            ec.removeEvent(obj,event,func);
            ec.removeEvent(obj,event,autoRemoveFunc);
         };
         this._addEvent(obj,event,func,useCapture,priority,useWeakReference);
         this._addEvent(obj,event,autoRemoveFunc);
      }

      public function addEvent(param1:IEventDispatcher, param2:String, param3:Function, param4:Boolean=false, param5:int=0, param6:Boolean=false) : void {
         if(this._isEnabled)
         {
            this._addEvent(param1,param2,param3,param4,param5,param6);
         }
         else
         {
            this.doAddEventListener(param1,param2,param3,param4,param5,param6);
         }
      }

      public function addEventCollection(param1:Array, param2:String, param3:Function, param4:Boolean=false, param5:int=0, param6:Boolean=false) : void {
         var _loc8_:IEventDispatcher = null;
         var _loc7_:int = param1.length-1;
         while(_loc7_ >= 0)
         {
            _loc8_ = param1[_loc7_];
            this._addEvent(_loc8_,param2,param3,param4,param5,param6);
            _loc7_--;
         }
      }

      public function removeEvent(param1:Object, param2:String, param3:Function, param4:Boolean=false) : void {
         var _loc5_:Object = null;
         var _loc6_:Array = null;
         var _loc7_:EventListnerProxy = null;
         var _loc8_:* = 0;
         this.checkObject(param1);
         if(this._isEnabled)
         {
            if(this.objectIsRegistered(param1))
            {
               _loc5_ = this._objStack[param1];
               _loc6_ = this._objStack[param1][PROXIES];
               _loc8_ = _loc6_.length-1;
               while(_loc8_ >= 0)
               {
                  _loc7_ = _loc6_[_loc8_];
                  if(_loc7_.event === param2 && _loc7_.func == param3 && _loc7_.useCapture == param4)
                  {
                     this.deleteProxy(_loc7_);
                     break;
                  }
                  _loc8_--;
               }
            }
         }
         else
         {
            this.doRemoveEventListener(param1,param2,param3,param4);
         }
      }

      public function removeEventCollection(param1:Array, param2:String, param3:Function) : void {
         var _loc4_:int = param1.length-1;
         while(_loc4_ > 0)
         {
            this.removeEvent(param1[_loc4_],param2,param3);
            _loc4_--;
         }
      }

      public function removeAllEvents() : void {
         var _loc2_:Object = null;
         var _loc3_:Array = null;
         var _loc4_:EventListnerProxy = null;
         var _loc6_:Array = null;
         var _loc1_:Number = new Date().getTime();
         var _loc5_:* = 0;
         for (_loc2_ in this._moduleStack)
         {
            _loc3_ = this._moduleStack[_loc2_];
            _loc3_.splice(0);
            this.doRemoveEventListener(_loc2_,LifeCycleEvent.ON_AFTER_DISPOSE,this.onBeforeModuleDisposeHandler);
            delete this._moduleStack[[_loc2_]];
         }
         _loc6_ = [];
         for (_loc2_ in this._objStack)
         {
            _loc6_.push(_loc2_);
         }
         for each (_loc2_ in _loc6_)
         {
            _loc3_ = this._objStack[_loc2_][PROXIES];
            _loc5_ = _loc3_.length-1;
            while(_loc5_ >= 0)
            {
               _loc4_ = _loc3_[_loc5_];
               this.deleteProxy(_loc4_,false);
               _loc5_--;
            }
         }
      }

      public function removeModuleEvents(param1:IDAAPIModule) : void {
         var _loc3_:EventListnerProxy = null;
         var _loc4_:Object = null;
         var _loc2_:Array = this._moduleStack[param1];
         var _loc5_:int = _loc2_.length-1;
         while(_loc5_ >= 0)
         {
            _loc4_ = _loc2_[_loc5_];
            this.removeObjectEvents(_loc4_,false);
            _loc5_--;
         }
         _loc2_.splice(0);
         this.doRemoveEventListener(param1,LifeCycleEvent.ON_AFTER_DISPOSE,this.onBeforeModuleDisposeHandler);
         App.utils.commons.releaseReferences(param1);
         delete this._moduleStack[[param1]];
      }

      public function removeObjectEvents(param1:Object, param2:Boolean=true) : void {
         var _loc4_:Array = null;
         var _loc5_:EventListnerProxy = null;
         var _loc6_:* = 0;
         this.checkObject(param1);
         var _loc3_:Array = this._objStack[param1];
         if(_loc3_)
         {
            _loc4_ = _loc3_[PROXIES];
            if(_loc4_)
            {
               _loc6_ = _loc4_.length-1;
               while(_loc6_ >= 0)
               {
                  _loc5_ = _loc4_[_loc6_];
                  this.deleteProxy(_loc5_,param2);
                  _loc6_--;
               }
            }
         }
      }

      public function hasRegisteredEvent(param1:Object, param2:String, param3:Function, param4:Boolean) : Boolean {
         var _loc6_:EventListnerProxy = null;
         this.checkObject(param1);
         var _loc5_:Array = this._objStack[param1][PROXIES];
         var _loc7_:int = _loc5_.length-1;
         while(_loc7_ >= 0)
         {
            _loc6_ = _loc5_[_loc7_];
            if(this.checkProxy(_loc6_,param1,param2,param3,param4))
            {
               return true;
            }
            _loc7_--;
         }
         return false;
      }

      public function objectIsRegistered(param1:Object) : Boolean {
         return Boolean(this._objStack[param1]);
      }

      public function logState() : void {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc5_:* = "";
         for (_loc3_ in this._objStack)
         {
         }
         for (_loc1_ in this._moduleStack)
         {
            _loc4_ = this._moduleStack[_loc1_];
            for each (_loc3_ in _loc4_)
            {
            }
         }
         for each (_loc3_ in this._dynamicContents)
         {
         }
      }

      public function dispose() : void {
         this.removeAllEvents();
         this._objStack = null;
         this._moduleStack = null;
         this._dynamicContents = null;
      }

      public function enableDisposingForObj(param1:DisplayObject) : void {
         var _loc2_:IDynamicContent = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(this._isEnabled)
         {
            _loc2_ = null;
            _loc3_ = this._objStack[param1];
            if(_loc3_)
            {
               _loc2_ = _loc3_[DYN_CONTENT];
            }
            else
            {
               if(param1  is  DisplayObject)
               {
                  _loc4_ = this.findModuleAndDynamicContent(DisplayObject(param1));
                  _loc2_ = _loc4_.dynamicContent;
               }
            }
            if(_loc2_)
            {
               this.addRemovingFromStageListener(DisplayObject(_loc2_));
            }
         }
      }

      public function disableDisposingForObj(param1:DisplayObject) : void {
         if(this._isEnabled)
         {
            this.removeCustomObjectManaging(DisplayObject(param1));
         }
      }

      private function removeCustomObjectEvents(param1:DisplayObject) : void {
         this.removeCustomObjectManaging(param1);
         this.removeObjectEvents(param1,false);
         App.utils.commons.releaseReferences(param1);
      }

      private function removeCustomObjectManaging(param1:DisplayObject) : void {
         var _loc2_:* = NaN;
         this.removeRemovingFromStageListener(param1);
         if(param1  is  DisplayObjectContainer)
         {
            _loc2_ = 0;
            while(_loc2_ < DisplayObjectContainer(param1).numChildren)
            {
               this.removeCustomObjectManaging(DisplayObjectContainer(param1).getChildAt(_loc2_));
               _loc2_++;
            }
         }
      }

      private function traceObject(param1:Object) : String {
         var _loc3_:EventListnerProxy = null;
         var _loc5_:DisplayObject = null;
         var _loc6_:Array = null;
         var _loc2_:* = "";
         var _loc4_:String = param1.toString();
         if(param1  is  DisplayObject)
         {
            _loc5_ = DisplayObject(param1).parent;
            while(_loc5_)
            {
               _loc2_ = _loc5_ + "." + _loc2_;
               _loc5_ = _loc5_.parent;
            }
         }
         if(this._objStack[param1])
         {
            _loc6_ = this._objStack[param1][PROXIES];
            _loc2_ = _loc2_ + ("obj: " + _loc4_ + " (");
            for each (_loc3_ in _loc6_)
            {
               if(_loc3_)
               {
                  _loc2_ = _loc2_ + (_loc3_.event + ", ");
               }
               else
               {
                  _loc2_ = _loc2_ + "null, ";
               }
            }
            _loc2_ = _loc2_ + ")";
         }
         _loc2_ = _loc2_ + "\n";
         return _loc2_;
      }

      private function initObj() : void {
         this._objStack = new Dictionary(true);
         this._moduleStack = new Dictionary(true);
         this._dynamicContents = [];
      }

      private function _addEvent(param1:IEventDispatcher, param2:String, param3:Function, param4:Boolean=false, param5:int=0, param6:Boolean=false) : void {
         var _loc7_:Array = null;
         var _loc8_:EventListnerProxy = null;
         var _loc9_:IDAAPIModule = null;
         var _loc11_:IDisposable = null;
         var _loc12_:Object = null;
         this.checkObject(param1);
         var _loc10_:IDynamicContent = null;
         if(param1  is  DisplayObject)
         {
            _loc12_ = this.findModuleAndDynamicContent(DisplayObject(param1));
            _loc9_ = _loc12_.module;
            _loc10_ = _loc12_.dynamicContent;
            if((_loc9_) && (_loc9_.disposed))
            {
               return;
            }
         }
         if(this._objStack[param1] == undefined)
         {
            _loc7_ = [];
            this._objStack[param1] = [_loc9_,_loc10_,_loc7_];
         }
         else
         {
            _loc7_ = this._objStack[param1][PROXIES];
         }
         for each (_loc8_ in _loc7_)
         {
            if(this.checkProxy(_loc8_,param1,param2,param3,param4))
            {
               return;
            }
         }
         _loc8_ = new EventListnerProxy(param1,param2,param3,param4);
         this.doAddEventListener(param1,param2,param3,param4,param5,param6);
         _loc7_.push(_loc8_);
         if(_loc9_)
         {
            this.addCustomModuleManaging(_loc9_,param1);
         }
         else
         {
            if(param1  is  DisplayObject)
            {
            }
         }
      }

      private function addCustomModuleManaging(param1:IDAAPIModule, param2:IEventDispatcher) : void {
         var _loc3_:Array = this._moduleStack[param1];
         if(!_loc3_)
         {
            _loc3_ = [param2];
            this._moduleStack[param1] = _loc3_;
            this.doAddEventListener(param1,LifeCycleEvent.ON_AFTER_DISPOSE,this.onBeforeModuleDisposeHandler);
         }
         else
         {
            _loc3_.push(param2);
         }
      }

      private function checkSlowWorking(param1:Object) : void {
         if(param1  is  IDynamicContent)
         {
            DebugUtils.LOG_WARNING("DAAPIModule \"" + getQualifiedClassName(param1) + "\" is DynamicContent. It may provide to slow working in the EventCollector! ");
         }
      }

      private function findModuleAndDynamicContent(param1:DisplayObject) : Object {
         var _loc3_:String = null;
         var _loc2_:Object =
            {
               "module":null,
               "dynamicContent":null
            }
         ;
         while(param1 != null)
         {
            if(param1  is  IDAAPIModule)
            {
               _loc2_.module = param1;
               this.checkSlowWorking(param1);
            }
            else
            {
               if(param1  is  IWindow)
               {
                  _loc2_.module = IWindow(param1).sourceView;
                  this.checkSlowWorking(param1);
               }
               else
               {
                  if(param1  is  IDynamicContent)
                  {
                     if(_loc2_.dynamicContent)
                     {
                        _loc3_ = "DynamicContent \'" + getQualifiedClassName(_loc2_.dynamicContent) + "\' +  already have parent DynamicContent \'" + getQualifiedClassName(param1) + "\' dynamicContent!";
                        throw new InfrastructureException(_loc3_);
                     }
                     else
                     {
                        _loc2_.dynamicContent = param1;
                     }
                  }
               }
            }
            param1 = param1.parent;
         }
         return _loc2_;
      }

      private function checkObject(param1:Object) : void {
         if(param1 == null)
         {
            throw new NullPointerException();
         }
         else
         {
            return;
         }
      }

      private function checkProxy(param1:EventListnerProxy, param2:Object, param3:String, param4:Function, param5:Boolean) : Boolean {
         return param1.obj === param2 && param1.event === param3 && param1.func === param4 && param1.useCapture == param5;
      }

      private function deleteProxy(param1:EventListnerProxy, param2:Boolean=true) : void {
         var _loc5_:Array = null;
         var _loc3_:Object = param1.obj;
         var _loc4_:IDAAPIModule = null;
         if(_loc3_)
         {
            _loc4_ = this._objStack[_loc3_][MODULE];
            _loc5_ = this._objStack[_loc3_][PROXIES];
            _loc5_.splice(_loc5_.indexOf(param1),1);
            if(!(param1.event == null) && !(param1.func == null))
            {
               this.doRemoveEventListener(_loc3_,param1.event,param1.func,param1.useCapture);
            }
            else
            {
               DebugUtils.LOG_ERROR("No event or func data in EventListnerProxy",param1.obj,param1.event,param1.func);
            }
            if(_loc5_.length == 0)
            {
               delete this._objStack[[_loc3_]];
            }
         }
         else
         {
            DebugUtils.LOG_ERROR("No object data in EventListnerProxy",param1.obj,param1.event,param1.func);
         }
         if(_loc3_  is  DisplayObject && !this.objectIsRegistered(_loc3_))
         {
            if(_loc4_)
            {
               if(param2)
               {
                  this.cleanupInModuleStack(_loc3_,_loc4_);
               }
            }
            else
            {
               this.removeRemovingFromStageListener(DisplayObject(_loc3_));
            }
         }
         param1.finalize();
      }

      private function cleanupInModuleStack(param1:Object, param2:IDAAPIModule) : void {
         var _loc3_:Array = null;
         if(this._moduleStack[param2])
         {
            _loc3_ = this._moduleStack[param2];
            _loc3_.splice(_loc3_.indexOf(param1),1);
            if(_loc3_.length == 0)
            {
               this.doRemoveEventListener(param2,LifeCycleEvent.ON_AFTER_DISPOSE,this.onBeforeModuleDisposeHandler);
               delete this._moduleStack[[param2]];
            }
         }
      }

      private function doRemoveEventListener(param1:Object, param2:String, param3:Function, param4:Boolean=false) : void {
         if(param1.hasOwnProperty("removeSuperEventListener"))
         {
            param1.removeSuperEventListener(param2,param3,param4);
         }
         else
         {
            param1.removeEventListener(param2,param3,param4);
         }
      }

      private function doAddEventListener(param1:Object, param2:String, param3:Function, param4:Boolean=false, param5:int=0, param6:Boolean=false) : void {
         if(param1.hasOwnProperty("addSuperEventListener"))
         {
            param1.addSuperEventListener(param2,param3,param4,param5,param6);
         }
         else
         {
            param1.addEventListener(param2,param3,param4,param5,param6);
         }
      }

      private function addRemovingFromStageListener(param1:DisplayObject) : void {
         if(this._dynamicContents.indexOf(param1) == -1)
         {
            this._dynamicContents.push(param1);
            this.doAddEventListener(param1,Event.REMOVED_FROM_STAGE,this.onRemovedFromStageHandler);
         }
      }

      private function removeRemovingFromStageListener(param1:DisplayObject) : void {
         this._dynamicContents.splice(this._dynamicContents.indexOf(param1),1);
         this.doRemoveEventListener(param1,Event.REMOVED_FROM_STAGE,this.onRemovedFromStageHandler);
      }

      private function onBeforeModuleDisposeHandler(param1:LifeCycleEvent) : void {
         var _loc2_:IDAAPIModule = param1.target as IDAAPIModule;
         this.removeModuleEvents(_loc2_);
      }

      private function onRemovedFromStageHandler(param1:Event) : void {
         var _loc2_:DisplayObject = null;
         if(param1.eventPhase == EventPhase.AT_TARGET)
         {
            _loc2_ = DisplayObject(param1.target);
            this.removeCustomObjectEvents(_loc2_);
         }
      }
   }

}