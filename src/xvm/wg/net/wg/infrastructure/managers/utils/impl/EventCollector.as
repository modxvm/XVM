package net.wg.infrastructure.managers.utils.impl 
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.exceptions.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import net.wg.utils.*;
    
    public class EventCollector extends Object implements net.wg.utils.IEventCollector
    {
        public function EventCollector()
        {
            super();
            this.initObj();
            return;
        }

        internal function removeRemovingFromStageListener(arg1:flash.display.DisplayObject):void
        {
            this._dynamicContents.splice(this._dynamicContents.indexOf(arg1), 1);
            this.doRemoveEventListener(arg1, flash.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStageHandler);
            return;
        }

        internal function onBeforeModuleDisposeHandler(arg1:net.wg.infrastructure.events.LifeCycleEvent):void
        {
            var loc1:*=arg1.target as net.wg.infrastructure.interfaces.IDAAPIModule;
            this.removeModuleEvents(loc1);
            return;
        }

        internal function onRemovedFromStageHandler(arg1:flash.events.Event):void
        {
            var loc1:*=null;
            if (arg1.eventPhase == flash.events.EventPhase.AT_TARGET) 
            {
                loc1 = flash.display.DisplayObject(arg1.target);
                this.removeCustomObjectEvents(loc1);
            }
            return;
        }

        
        {
            _addEventCnt = 0;
            _addEventTime = 0;
            _addEventCollCnt = 0;
            _addEventCollTime = 0;
            _remEventCnt = 0;
            _remEventTime = 0;
            _remEventCollCnt = 0;
            _remEventCollTime = 0;
            _remAllTime = 0;
            _remModEventslCnt = 0;
            _remModEventslTime = 0;
            _remObjEventslCnt = 0;
            _remObjEventslTime = 0;
            _hasRegEvntCnt = 0;
            _hasRegEvntTime = 0;
            _enableDispCnt = 0;
            _enableDispTime = 0;
            _disableDispCnt = 0;
            _disableDispTime = 0;
        }

        public function setEnabled(arg1:Boolean):void
        {
            this._isEnabled = arg1;
            return;
        }

        public function addOneShotEvent(arg1:flash.events.IEventDispatcher, arg2:String, arg3:Function, arg4:Boolean=false, arg5:int=0, arg6:Boolean=false):void
        {
            var obj:flash.events.IEventDispatcher;
            var event:String;
            var func:Function;
            var useCapture:Boolean=false;
            var priority:int=0;
            var useWeakReference:Boolean=false;
            var ec:net.wg.infrastructure.managers.utils.impl.EventCollector;
            var autoRemoveFunc:Function;

            var loc1:*;
            ec = null;
            autoRemoveFunc = null;
            obj = arg1;
            event = arg2;
            func = arg3;
            useCapture = arg4;
            priority = arg5;
            useWeakReference = arg6;
            ec = this;
            autoRemoveFunc = function (arg1:flash.events.Event):void
            {
                ec.removeEvent(obj, event, func);
                ec.removeEvent(obj, event, autoRemoveFunc);
                return;
            }
            this._addEvent(obj, event, func, useCapture, priority, useWeakReference);
            this._addEvent(obj, event, autoRemoveFunc);
            return;
        }

        public function addEvent(arg1:flash.events.IEventDispatcher, arg2:String, arg3:Function, arg4:Boolean=false, arg5:int=0, arg6:Boolean=false):void
        {
            var loc1:*=new Date().getTime();
            var loc2:*;
            _addEventCnt++;
            if (this._isEnabled) 
                this._addEvent(arg1, arg2, arg3, arg4, arg5, arg6);
            else 
                this.doAddEventListener(arg1, arg2, arg3, arg4, arg5, arg6);
            _addEventTime = _addEventTime + (new Date().getTime() - loc1);
            return;
        }

        public function addEventCollection(arg1:Array, arg2:String, arg3:Function, arg4:Boolean=false, arg5:int=0, arg6:Boolean=false):void
        {
            var loc3:*=null;
            var loc1:*=new Date().getTime();
            var loc4:*;
            _addEventCollCnt++;
            var loc2:*=(arg1.length - 1);
            while (loc2 >= 0) 
            {
                loc3 = arg1[loc2];
                this._addEvent(loc3, arg2, arg3, arg4, arg5, arg6);
                --loc2;
            }
            _addEventCollTime = _addEventCollTime + (new Date().getTime() - loc1);
            return;
        }

        public function removeEvent(arg1:Object, arg2:String, arg3:Function, arg4:Boolean=false):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            var loc1:*=new Date().getTime();
            var loc6:*;
            _remEventCnt++;
            this.checkObject(arg1);
            if (this._isEnabled) 
                if (this.objectIsRegistered(arg1)) 
                {
                    loc2 = this._objStack[arg1];
                    loc5 = ((loc3 = this._objStack[arg1][PROXIES]).length - 1);
                    while (loc5 >= 0) 
                    {
                        if ((loc4 = loc3[loc5]).event === arg2 && loc4.func == arg3 && loc4.useCapture == arg4) 
                            this.deleteProxy(loc4);
                        --loc5;
                    }
                }
            else 
                this.doRemoveEventListener(arg1, arg2, arg3, arg4);
            _remEventTime = _remEventTime + (new Date().getTime() - loc1);
            return;
        }

        public function removeEventCollection(arg1:Array, arg2:String, arg3:Function):void
        {
            var loc1:*=new Date().getTime();
            var loc3:*;
            _remEventCollCnt++;
            var loc2:*=(arg1.length - 1);
            while (loc2 > 0) 
            {
                this.removeEvent(arg1[loc2], arg2, arg3);
                --loc2;
            }
            _remEventCollTime = _remEventCollTime + (new Date().getTime() - loc1);
            return;
        }

        public function removeAllEvents():void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc6:*=null;
            var loc1:*=new Date().getTime();
            var loc5:*=0;
            var loc7:*=0;
            var loc8:*=this._moduleStack;
            for (loc2 in loc8) 
            {
                loc3 = this._moduleStack[loc2];
                loc3.splice(0);
                this.doRemoveEventListener(loc2, net.wg.infrastructure.events.LifeCycleEvent.ON_AFTER_DISPOSE, this.onBeforeModuleDisposeHandler);
                delete this._moduleStack[loc2];
            }
            loc6 = [];
            loc7 = 0;
            loc8 = this._objStack;
            for (loc2 in loc8) 
                loc6.push(loc2);
            loc7 = 0;
            loc8 = loc6;
            for each (loc2 in loc8) 
            {
                loc3 = this._objStack[loc2][PROXIES];
                loc5 = (loc3.length - 1);
                while (loc5 >= 0) 
                {
                    loc4 = loc3[loc5];
                    this.deleteProxy(loc4, false);
                    --loc5;
                }
            }
            _remAllTime = _remAllTime + (new Date().getTime() - loc1);
            return;
        }

        public function removeModuleEvents(arg1:net.wg.infrastructure.interfaces.IDAAPIModule):void
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=new Date().getTime();
            var loc6:*;
            _remModEventslCnt++;
            var loc2:*=this._moduleStack[arg1];
            var loc5:*=(loc2.length - 1);
            while (loc5 >= 0) 
            {
                loc4 = loc2[loc5];
                this.removeObjectEvents(loc4, false);
                --loc5;
            }
            loc2.splice(0);
            this.doRemoveEventListener(arg1, net.wg.infrastructure.events.LifeCycleEvent.ON_AFTER_DISPOSE, this.onBeforeModuleDisposeHandler);
            App.utils.commons.releaseReferences(arg1);
            delete this._moduleStack[arg1];
            _remModEventslTime = _remModEventslTime + (new Date().getTime() - loc1);
            return;
        }

        public function removeObjectEvents(arg1:Object, arg2:Boolean=true):void
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            var loc1:*=new Date().getTime();
            var loc6:*;
            _remObjEventslCnt++;
            this.checkObject(arg1);
            var loc2:*;
            if (loc2 = this._objStack[arg1]) 
            {
                if (loc3 = loc2[PROXIES]) 
                {
                    loc5 = (loc3.length - 1);
                    while (loc5 >= 0) 
                    {
                        loc4 = loc3[loc5];
                        this.deleteProxy(loc4, arg2);
                        --loc5;
                    }
                }
                _remObjEventslTime = _remObjEventslTime + (new Date().getTime() - loc1);
            }
            return;
        }

        public function hasRegisteredEvent(arg1:Object, arg2:String, arg3:Function, arg4:Boolean):Boolean
        {
            var loc3:*=null;
            var loc1:*=new Date().getTime();
            var loc5:*;
            _hasRegEvntCnt++;
            this.checkObject(arg1);
            var loc2:*;
            var loc4:*=((loc2 = this._objStack[arg1][PROXIES]).length - 1);
            while (loc4 >= 0) 
            {
                loc3 = loc2[loc4];
                if (this.checkProxy(loc3, arg1, arg2, arg3, arg4)) 
                {
                    _remObjEventslTime = _remObjEventslTime + (new Date().getTime() - loc1);
                    return true;
                }
                --loc4;
            }
            _hasRegEvntTime = _hasRegEvntTime + (new Date().getTime() - loc1);
            return false;
        }

        public function objectIsRegistered(arg1:Object):Boolean
        {
            return Boolean(this._objStack[arg1]);
        }

        public function logState():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*="";
            var loc6:*=0;
            var loc7:*=this._objStack;
            for (loc3 in loc7) ;
            loc6 = 0;
            loc7 = this._moduleStack;
            for (loc1 in loc7) 
            {
                loc4 = this._moduleStack[loc1];
                var loc8:*=0;
                var loc9:*=loc4;
                for each (loc3 in loc9) ;
            }
            loc6 = 0;
            loc7 = this._dynamicContents;
            for each (loc3 in loc7) ;
            return;
        }

        public function dispose():void
        {
            this.removeAllEvents();
            this._objStack = null;
            this._moduleStack = null;
            this._dynamicContents = null;
            return;
        }

        public function enableDisposingForObj(arg1:flash.display.DisplayObject):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=new Date().getTime();
            var loc5:*;
            _enableDispCnt++;
            if (this._isEnabled) 
            {
                loc2 = null;
                if (loc3 = this._objStack[arg1]) 
                    loc2 = loc3[DYN_CONTENT];
                else if (arg1 is flash.display.DisplayObject) 
                    loc2 = (loc4 = this.findModuleAndDynamicContent(flash.display.DisplayObject(arg1))).dynamicContent;
                if (loc2) 
                    this.addRemovingFromStageListener(flash.display.DisplayObject(loc2));
            }
            _enableDispTime = _enableDispTime + (new Date().getTime() - loc1);
            return;
        }

        public function disableDisposingForObj(arg1:flash.display.DisplayObject):void
        {
            var loc1:*=new Date().getTime();
            var loc2:*;
            _disableDispCnt++;
            if (this._isEnabled) 
                this.removeCustomObjectManaging(flash.display.DisplayObject(arg1));
            _disableDispTime = _disableDispTime + (new Date().getTime() - loc1);
            return;
        }

        internal function removeCustomObjectEvents(arg1:flash.display.DisplayObject):void
        {
            this.removeCustomObjectManaging(arg1);
            this.removeObjectEvents(arg1, false);
            App.utils.commons.releaseReferences(arg1);
            return;
        }

        internal function removeCustomObjectManaging(arg1:flash.display.DisplayObject):void
        {
            var loc1:*=NaN;
            this.removeRemovingFromStageListener(arg1);
            if (arg1 is flash.display.DisplayObjectContainer) 
            {
                loc1 = 0;
                while (loc1 < flash.display.DisplayObjectContainer(arg1).numChildren) 
                {
                    this.removeCustomObjectManaging(flash.display.DisplayObjectContainer(arg1).getChildAt(loc1));
                    ++loc1;
                }
            }
            return;
        }

        internal function traceObject(arg1:Object):String
        {
            var loc2:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*="";
            var loc3:*=arg1.toString();
            if (arg1 is flash.display.DisplayObject) 
            {
                loc4 = flash.display.DisplayObject(arg1).parent;
                while (loc4) 
                {
                    loc1 = loc4 + "." + loc1;
                    loc4 = loc4.parent;
                }
            }
            if (this._objStack[arg1]) 
            {
                loc5 = this._objStack[arg1][PROXIES];
                loc1 = loc1 + ("obj: " + loc3 + " (");
                var loc6:*=0;
                var loc7:*=loc5;
                for each (loc2 in loc7) 
                {
                    if (loc2) 
                    {
                        loc1 = loc1 + (loc2.event + ", ");
                        continue;
                    }
                    loc1 = loc1 + "null, ";
                }
                loc1 = loc1 + ")";
            }
            loc1 = loc1 + "\n";
            return loc1;
        }

        internal function initObj():void
        {
            this._objStack = new flash.utils.Dictionary(true);
            this._moduleStack = new flash.utils.Dictionary(true);
            this._dynamicContents = [];
            return;
        }

        internal function _addEvent(arg1:flash.events.IEventDispatcher, arg2:String, arg3:Function, arg4:Boolean=false, arg5:int=0, arg6:Boolean=false):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc5:*=null;
            var loc6:*=null;
            this.checkObject(arg1);
            var loc4:*=null;
            if (arg1 is flash.display.DisplayObject) 
            {
                loc3 = (loc6 = this.findModuleAndDynamicContent(flash.display.DisplayObject(arg1))).module;
                loc4 = loc6.dynamicContent;
                if (loc3 && loc3.disposed) 
                    return;
            }
            if (this._objStack[arg1] != undefined) 
                loc1 = this._objStack[arg1][PROXIES];
            else 
            {
                loc1 = [];
                this._objStack[arg1] = [loc3, loc4, loc1];
            }
            var loc7:*=0;
            var loc8:*=loc1;
            for each (loc2 in loc8) 
            {
                if (!this.checkProxy(loc2, arg1, arg2, arg3, arg4)) 
                    continue;
                return;
            }
            loc2 = new net.wg.infrastructure.managers.utils.impl.EventListnerProxy(arg1, arg2, arg3, arg4);
            this.doAddEventListener(arg1, arg2, arg3, arg4, arg5, arg6);
            loc1.push(loc2);
            if (loc3) 
                this.addCustomModuleManaging(loc3, arg1);
            else if (!(loc4 == null && arg1 is flash.display.DisplayObject)) ;
            return;
        }

        internal function addCustomModuleManaging(arg1:net.wg.infrastructure.interfaces.IDAAPIModule, arg2:flash.events.IEventDispatcher):void
        {
            var loc1:*=this._moduleStack[arg1];
            if (loc1) 
                loc1.push(arg2);
            else 
            {
                loc1 = [arg2];
                this._moduleStack[arg1] = loc1;
                this.doAddEventListener(arg1, net.wg.infrastructure.events.LifeCycleEvent.ON_AFTER_DISPOSE, this.onBeforeModuleDisposeHandler);
            }
            return;
        }

        internal function checkSlowWorking(arg1:Object):void
        {
            if (arg1 is net.wg.infrastructure.interfaces.IDynamicContent) 
                DebugUtils.LOG_WARNING("DAAPIModule \"" + flash.utils.getQualifiedClassName(arg1) + "\" is DynamicContent. It may provide to slow working in the EventCollector! ");
            return;
        }

        internal function findModuleAndDynamicContent(arg1:flash.display.DisplayObject):Object
        {
            var loc2:*=null;
            var loc1:*={"module":null, "dynamicContent":null};
            while (arg1 != null) 
            {
                if (arg1 is net.wg.infrastructure.interfaces.IDAAPIModule) 
                {
                    loc1.module = arg1;
                    this.checkSlowWorking(arg1);
                }
                else if (arg1 is net.wg.infrastructure.interfaces.IWindow) 
                {
                    loc1.module = net.wg.infrastructure.interfaces.IWindow(arg1).sourceView;
                    this.checkSlowWorking(arg1);
                }
                else if (arg1 is net.wg.infrastructure.interfaces.IDynamicContent) 
                {
                    if (loc1.dynamicContent) 
                    {
                        loc2 = "DynamicContent \'" + flash.utils.getQualifiedClassName(loc1.dynamicContent) + "\' +  already have parent DynamicContent \'" + flash.utils.getQualifiedClassName(arg1) + "\' dynamicContent!";
                        throw new net.wg.infrastructure.exceptions.InfrastructureException(loc2);
                    }
                    loc1.dynamicContent = arg1;
                }
                arg1 = arg1.parent;
            }
            return loc1;
        }

        internal function checkObject(arg1:Object):void
        {
            if (arg1 == null) 
                throw new net.wg.infrastructure.exceptions.NullPointerException();
            return;
        }

        internal function checkProxy(arg1:net.wg.infrastructure.managers.utils.impl.EventListnerProxy, arg2:Object, arg3:String, arg4:Function, arg5:Boolean):Boolean
        {
            return arg1.obj === arg2 && arg1.event === arg3 && arg1.func === arg4 && arg1.useCapture == arg5;
        }

        internal function deleteProxy(arg1:net.wg.infrastructure.managers.utils.impl.EventListnerProxy, arg2:Boolean=true):void
        {
            var loc3:*=null;
            var loc1:*=arg1.obj;
            var loc2:*=null;
            if (loc1) 
            {
                loc2 = this._objStack[loc1][MODULE];
                loc3 = this._objStack[loc1][PROXIES];
                loc3.splice(loc3.indexOf(arg1), 1);
                if (!(arg1.event == null) && !(arg1.func == null)) 
                    this.doRemoveEventListener(loc1, arg1.event, arg1.func, arg1.useCapture);
                else 
                    DebugUtils.LOG_ERROR("No event or func data in EventListnerProxy", arg1.obj, arg1.event, arg1.func);
                if (loc3.length == 0) 
                    delete this._objStack[loc1];
            }
            else 
                DebugUtils.LOG_ERROR("No object data in EventListnerProxy", arg1.obj, arg1.event, arg1.func);
            if (loc1 is flash.display.DisplayObject && !this.objectIsRegistered(loc1)) 
                if (loc2) 
                    if (arg2) 
                        this.cleanupInModuleStack(loc1, loc2);
                else 
                    this.removeRemovingFromStageListener(flash.display.DisplayObject(loc1));
            arg1.finalize();
            return;
        }

        internal function cleanupInModuleStack(arg1:Object, arg2:net.wg.infrastructure.interfaces.IDAAPIModule):void
        {
            var loc1:*=null;
            if (this._moduleStack[arg2]) 
            {
                loc1 = this._moduleStack[arg2];
                loc1.splice(loc1.indexOf(arg1), 1);
                if (loc1.length == 0) 
                {
                    this.doRemoveEventListener(arg2, net.wg.infrastructure.events.LifeCycleEvent.ON_AFTER_DISPOSE, this.onBeforeModuleDisposeHandler);
                    delete this._moduleStack[arg2];
                }
            }
            return;
        }

        internal function doRemoveEventListener(arg1:Object, arg2:String, arg3:Function, arg4:Boolean=false):void
        {
            if (arg1.hasOwnProperty("removeSuperEventListener")) 
                arg1.removeSuperEventListener(arg2, arg3, arg4);
            else 
                arg1.removeEventListener(arg2, arg3, arg4);
            return;
        }

        internal function doAddEventListener(arg1:Object, arg2:String, arg3:Function, arg4:Boolean=false, arg5:int=0, arg6:Boolean=false):void
        {
            if (arg1.hasOwnProperty("addSuperEventListener")) 
                arg1.addSuperEventListener(arg2, arg3, arg4, arg5, arg6);
            else 
                arg1.addEventListener(arg2, arg3, arg4, arg5, arg6);
            return;
        }

        internal function addRemovingFromStageListener(arg1:flash.display.DisplayObject):void
        {
            if (this._dynamicContents.indexOf(arg1) == -1) 
            {
                this._dynamicContents.push(arg1);
                this.doAddEventListener(arg1, flash.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStageHandler);
            }
            return;
        }

        public static const MODULE:uint=0;

        public static const DYN_CONTENT:uint=1;

        public static const PROXIES:uint=2;

        internal static const HAS_NO_DYNAMIC_CONTENT:String="HasNoDynamicContent";

        internal var _isEnabled:Boolean=false;

        internal var _objStack:flash.utils.Dictionary;

        internal var _moduleStack:flash.utils.Dictionary;

        internal var _dynamicContents:Array;

        internal static var _addEventTime:Number=0;

        internal static var _addEventCollCnt:Number=0;

        internal static var _addEventCollTime:Number=0;

        internal static var _remEventCnt:Number=0;

        internal static var _remEventTime:Number=0;

        internal static var _remEventCollCnt:Number=0;

        internal static var _remEventCollTime:Number=0;

        internal static var _remAllTime:Number=0;

        internal static var _addEventCnt:Number=0;

        internal static var _remModEventslTime:Number=0;

        internal static var _remObjEventslCnt:Number=0;

        internal static var _remObjEventslTime:Number=0;

        internal static var _hasRegEvntCnt:Number=0;

        internal static var _hasRegEvntTime:Number=0;

        internal static var _enableDispCnt:Number=0;

        internal static var _remModEventslCnt:Number=0;

        internal static var _disableDispCnt:Number=0;

        internal static var _disableDispTime:Number=0;

        internal static var _enableDispTime:Number=0;
    }
}
