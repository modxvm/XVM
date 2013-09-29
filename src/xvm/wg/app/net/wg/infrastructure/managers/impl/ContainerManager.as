package net.wg.infrastructure.managers.impl
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.common.*;
    import net.wg.infrastructure.base.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import net.wg.infrastructure.managers.*;

    public class ContainerManager extends net.wg.infrastructure.base.meta.impl.ContainerManagerMeta implements net.wg.infrastructure.managers.IContainerManager, net.wg.infrastructure.base.meta.IContainerManagerMeta
    {
        public function ContainerManager()
        {
            this.tokenToView = {};
            this.nameToView = {};
            super();
            this._containersMap = new flash.utils.Dictionary();
            return;
        }

        public function registerContainer(arg1:net.wg.infrastructure.interfaces.IManagedContainer):void
        {
            assert(!this.containersMap.hasOwnProperty(arg1.type), "ContainerManager.registerContainer container for type " + arg1.type + " is already registered");
            this.containersMap[arg1.type] = arg1;
            arg1.addEventListener(flash.events.FocusEvent.FOCUS_OUT, this.onContainerFocusOut);
            return;
        }

        public function updateStage(arg1:Number, arg2:Number):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this.containersMap;
            for (loc1 in loc4)
            {
                if (!(loc2 = this.containersMap[loc1]).manageSize)
                {
                    continue;
                }
                loc2.updateStage(arg1, arg2);
            }
            return;
        }

        public function as_getView(arg1:String):Boolean
        {
            var loc2:*=null;
            var loc1:*=false;
            if (this.nameToView.hasOwnProperty(arg1))
            {
                loc2 = this.nameToView[arg1];
                loc2.setFocused();
                loc1 = true;
            }
            return loc1;
        }

        public function as_show(arg1:String, arg2:int=0, arg3:int=0):Boolean
        {
            var loc1:*=false;
            var loc2:*;
            if ((loc2 = this.tokenToView[arg1]) && loc2.view)
            {
                loc2.view.x = arg2;
                loc2.view.y = arg3;
                loc2.addView();
                this.updateFocus();
                this.nameToView[loc2.view.as_name] = loc2;
                loc1 = true;
                if (loc2.view.as_config.type == net.wg.data.constants.ContainerTypes.CURSOR)
                {
                    dispatchEvent(new net.wg.infrastructure.events.LoaderEvent(net.wg.infrastructure.events.LoaderEvent.CURSOR_LOADED, loc2.view.as_config, arg1, loc2.view));
                }
                if (loc2.view.as_config.type == net.wg.data.constants.ContainerTypes.WAITING)
                {
                    dispatchEvent(new net.wg.infrastructure.events.LoaderEvent(net.wg.infrastructure.events.LoaderEvent.WAITING_LOADED, loc2.view.as_config, arg1, loc2.view));
                }
            }
            else
            {
                throw new Error("net.wg.infrastructure.base.BaseView is not found using token = " + arg1);
            }
            return loc1;
        }

        public function as_hide(arg1:String):Boolean
        {
            var loc1:*=false;
            var loc2:*=this.tokenToView[arg1];
            if (loc2)
            {
                delete this.nameToView[loc2.view.as_name];
                delete this.tokenToView[arg1];
                loc2.removeView();
                loc2.dispose();
                loc1 = true;
                this.updateFocus();
            }
            else
            {
                throw new Error("net.wg.infrastructure.base.AbstractView is not found using token = " + arg1);
            }
            return loc1;
        }

        public function as_registerContainer(arg1:String, arg2:String):void
        {
            assert(!this.containersMap.hasOwnProperty(arg1), "ContainerManager.as_registerContainer container for type " + arg1 + " is already registered");
            var loc1:*=this.tokenToView[arg2];
            var loc2:*=loc1.view;
            assert(!(loc1 == null) && !(loc1.view == null), "ContainerManager.as_registerContainer view not found for token " + arg2);
            var loc3:*=loc2.getSubContainer();
            assert(!(loc3 == null), "ContainerManager.as_registerContainer container is null for type " + arg1 + " in view for token " + arg2);
            this.containersMap[arg1] = loc3;
            loc3.addEventListener(flash.events.FocusEvent.FOCUS_OUT, this.onContainerFocusOut);
            return;
        }

        public function as_unregisterContainer(arg1:String):void
        {
            assert(this.containersMap.hasOwnProperty(arg1), "ContainerManager.as_unregisterContainer container for type " + arg1 + " is not registered");
            var loc1:*=this.getContainer(arg1);
            assert(!(loc1 == null), "ContainerManager.as_unregisterContainer container is null for type " + arg1);
            delete this.containersMap[loc1.type];
            loc1.removeEventListener(flash.events.FocusEvent.FOCUS_OUT, this.onContainerFocusOut);
            return;
        }

        public function as_closePopUps():void
        {
            App.toolTipMgr.hide();
            App.utils.popupMgr.removeAll();
            return;
        }

        public function as_isOnTop(arg1:String, arg2:String):Boolean
        {
            var cType:String;
            var vName:String;
            var result:Boolean;
            var obj:flash.display.DisplayObject;

            var loc1:*;
            obj = null;
            cType = arg1;
            vName = arg2;
            result = false;
            try
            {
                obj = net.wg.gui.components.common.ManagedContainer(this._containersMap[cType]).getTopmostView();
                result = obj && vName == this.getViewName(obj);
            }
            catch (e:Error)
            {
                DebugUtils.LOG_ERROR(e.message, e.getStackTrace());
            }
            return result;
        }

        public function as_bringToFront(arg1:String, arg2:String):void
        {
            var cType:String;
            var vName:String;
            var container:net.wg.gui.components.common.ManagedContainer;
            var currentView:flash.display.DisplayObject;
            var childrenCount:int;
            var i:int;

            var loc1:*;
            container = null;
            currentView = null;
            childrenCount = 0;
            i = 0;
            cType = arg1;
            vName = arg2;
            try
            {
                container = net.wg.gui.components.common.ManagedContainer(this._containersMap[cType]);
                currentView = null;
                childrenCount = container.numChildren;
                i = 0;
                while (i < childrenCount)
                {
                    currentView = container.getChildAt(i);
                    if (this.getViewName(currentView) == vName)
                    {
                        container.setFocusedView(currentView);
                        return;
                    }
                    ++i;
                }
            }
            catch (e:Error)
            {
                DebugUtils.LOG_ERROR(e.message, e.getStackTrace());
            }
            return;
        }

        public function get containersMap():flash.utils.Dictionary
        {
            return this._containersMap;
        }

        public function set containersMap(arg1:flash.utils.Dictionary):void
        {
            var loc1:*=null;
            var loc2:*=null;
            this._containersMap = arg1;
            var loc3:*=0;
            var loc4:*=this.containersMap;
            for (loc1 in loc4)
            {
                loc2 = this.containersMap[loc1];
                loc2.addEventListener(flash.events.FocusEvent.FOCUS_OUT, this.onContainerFocusOut);
            }
            return;
        }

        public function get loader():net.wg.infrastructure.base.meta.ILoaderManagerMeta
        {
            return this._loader;
        }

        public function set loader(arg1:net.wg.infrastructure.base.meta.ILoaderManagerMeta):void
        {
            this._loader = arg1;
            if (this._loader)
            {
                this._loader.addEventListener(net.wg.infrastructure.events.LoaderEvent.VIEW_LOADED, this.handleViewLoaded);
            }
            return;
        }

        public function get lastFocusedView():net.wg.infrastructure.interfaces.IView
        {
            return this._lastFocusedView;
        }

        public function set lastFocusedView(arg1:net.wg.infrastructure.interfaces.IView):void
        {
            if (this._lastFocusedView && !(this._lastFocusedView == arg1))
            {
                this.lastFocusedView.removeFocus();
            }
            this._lastFocusedView = arg1;
            return;
        }

        protected override function onPopulate():void
        {
            return;
        }

        protected override function onDispose():void
        {
            var key:String;
            var container:net.wg.infrastructure.interfaces.IManagedContainer;

            var loc1:*;
            key = null;
            container = null;
            try
            {
                var loc2:* = 0;
                var loc3:*=this.tokenToView;
                for (key in loc3)
                {
                    if (this.as_hide(key))
                    {
                        continue;
                    }
                    delete this.tokenToView[key];
                }
                this.tokenToView = null;
                loc2 = 0;
                loc3 = this.containersMap;
                for (key in loc3)
                {
                    container = this.getContainer(key);
                    assert(!(container == null), "ContainerManager.onDispose container is null for type " + key);
                    container.removeEventListener(flash.events.FocusEvent.FOCUS_OUT, this.onContainerFocusOut);
                    (container as net.wg.infrastructure.interfaces.entity.IDisposable).dispose();
                    delete this.containersMap[key];
                }
                this.containersMap = null;
                this._lastFocusedView = null;
                if (this.loader)
                {
                    this.loader.removeEventListener(net.wg.infrastructure.events.LoaderEvent.VIEW_LOADED, this.handleViewLoaded);
                    this.loader = null;
                }
            }
            catch (e:Error)
            {
                DebugUtils.LOG_ERROR("ContainerManager.onDispose", e.getStackTrace());
            }
            return;
        }

        internal function getContainer(arg1:String):net.wg.infrastructure.interfaces.IManagedContainer
        {
            var loc1:*=null;
            if (this.containersMap.hasOwnProperty(arg1))
            {
                loc1 = this.containersMap[arg1] as net.wg.infrastructure.interfaces.IManagedContainer;
            }
            return loc1;
        }

        internal function getViewName(arg1:flash.display.DisplayObject):String
        {
            return arg1 is net.wg.infrastructure.interfaces.IAbstractWindowView ? net.wg.infrastructure.interfaces.IAbstractWindowView(arg1).as_name : net.wg.infrastructure.interfaces.IWindow(arg1).sourceView.as_name;
        }

        internal function handleViewLoaded(arg1:net.wg.infrastructure.events.LoaderEvent):void
        {
            var e:net.wg.infrastructure.events.LoaderEvent;
            var container:net.wg.infrastructure.interfaces.IManagedContainer;

            var loc1:*;
            container = null;
            e = arg1;
            try
            {
                container = this.getContainer(e.view.as_config.type);
                assert(!(container == null), "ContainerManager.handleViewLoaded container is null for type " + e.view.as_config.type);
                this.tokenToView[e.token] = new ViewInfo(container, e.view as net.wg.infrastructure.base.AbstractView);
            }
            catch (err:Error)
            {
                DebugUtils.LOG_ERROR("ContainerManager.onLoaded", err.getStackTrace());
            }
            return;
        }

        internal function onContainerFocusOut(arg1:flash.events.FocusEvent):void
        {
            if (arg1.target == arg1.currentTarget)
            {
                this.updateFocus(arg1.target);
            }
            return;
        }

        public function updateFocus(arg1:Object=null):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=net.wg.data.constants.ContainerTypes.CTNR_ORDER;
            for each (loc1 in loc4)
            {
                loc2 = this.getContainer(loc1);
                if (!(loc2 && !(loc2 == arg1) && loc2.setFocused(true)))
                {
                    continue;
                }
                break;
            }
            return;
        }

        internal var tokenToView:Object;

        internal var nameToView:Object;

        internal var _lastFocusedView:net.wg.infrastructure.interfaces.IView=null;

        internal var _containersMap:flash.utils.Dictionary;

        internal var _loader:net.wg.infrastructure.base.meta.ILoaderManagerMeta;
    }
}

import flash.display.*;
import net.wg.infrastructure.base.*;
import net.wg.infrastructure.interfaces.*;


class ViewInfo extends Object
{
    public function ViewInfo(arg1:net.wg.infrastructure.interfaces.IManagedContainer, arg2:net.wg.infrastructure.base.AbstractView)
    {
        super();
        this.container = arg1;
        this.view = arg2;
        return;
    }

    public function dispose():void
    {
        this.container = null;
        this.view = null;
        return;
    }

    public function addView():void
    {
        this.container.addChild(this.view);
        return;
    }

    public function setFocused():void
    {
        this.container.setFocusedView(this.view);
        return;
    }

    public function removeView():void
    {
        var loc1:*=this.view is net.wg.infrastructure.interfaces.IAbstractWindowView ? flash.display.DisplayObject((this.view as net.wg.infrastructure.interfaces.IAbstractWindowView).window) : this.view;
        if (this.container.contains(loc1))
        {
            this.container.removeChild(this.view);
        }
        return;
    }

    public var view:net.wg.infrastructure.base.AbstractView;

    public var container:net.wg.infrastructure.interfaces.IManagedContainer;
}
