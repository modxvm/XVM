package net.wg.infrastructure.base 
{
    import avmplus.*;
    import flash.display.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.exceptions.*;
    import net.wg.infrastructure.exceptions.base.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    
    public class AbstractView extends net.wg.infrastructure.base.meta.impl.AbstractViewMeta implements net.wg.infrastructure.interfaces.IView, net.wg.infrastructure.base.meta.IAbstractViewMeta
    {
        public function AbstractView()
        {
            visible = false;
            super();
            return;
        }

        protected function onDispose():void
        {
            App.toolTipMgr.hide();
            App.contextMenuMgr.hide();
            removeEventListener(scaleform.clik.events.InputEvent.INPUT, handleInput);
            return;
        }

        public final override function dispose():void
        {
            super.dispose();
            return;
        }

        protected final function assert(arg1:Boolean, arg2:String="failed assert", arg3:Class=null):void
        {
            if (App.instance) 
                App.utils.asserter.assert(arg1, arg2, arg3);
            return;
        }

        protected final function assertLifeCycle():void
        {
            this.assert(!this.disposed, net.wg.data.constants.Errors.HDLR_CORRUPT_INVOKE, net.wg.infrastructure.exceptions.LifecycleException);
            return;
        }

        protected final function assertNotNull(arg1:Object, arg2:String="object", arg3:Class=null):void
        {
            if (App.instance) 
                App.utils.asserter.assertNotNull(arg1, arg2 + net.wg.data.constants.Errors.CANT_NULL, arg3);
            return;
        }

        protected final function assertNull(arg1:Object, arg2:String="object", arg3:Class=null):void
        {
            if (App.instance) 
                App.utils.asserter.assertNull(arg1, arg2 + net.wg.data.constants.Errors.MUST_NULL, arg3);
            return;
        }

        public final function as_populate():void
        {
            var loc1:*;
            try 
            {
                dispatchEvent(new net.wg.infrastructure.events.LifeCycleEvent(net.wg.infrastructure.events.LifeCycleEvent.ON_BEFORE_POPULATE));
                this.onPopulate();
                App.utils.scheduler.envokeInNextFrame(this.nextFrameAfterPopulateHandler);
                dispatchEvent(new net.wg.infrastructure.events.LifeCycleEvent(net.wg.infrastructure.events.LifeCycleEvent.ON_AFTER_POPULATE));
            }
            catch (error:net.wg.infrastructure.exceptions.base.WGGUIException)
            {
                DebugUtils.LOG_WARNING(error.getStackTrace());
            }
            catch (error:Error)
            {
                DebugUtils.LOG_ERROR(error.getStackTrace());
            }
            return;
        }

        protected function nextFrameAfterPopulateHandler():void
        {
            visible = true;
            return;
        }

        public final function as_dispose():void
        {
            var loc1:*;
            try 
            {
                this.assert(!this._disposed, "view " + this.as_alias + " can not to dispose, because it already disposed.");
                dispatchEvent(new net.wg.infrastructure.events.LifeCycleEvent(net.wg.infrastructure.events.LifeCycleEvent.ON_BEFORE_DISPOSE));
                this.onDispose();
                this.dispose();
                dispatchEvent(new net.wg.infrastructure.events.LifeCycleEvent(net.wg.infrastructure.events.LifeCycleEvent.ON_AFTER_DISPOSE));
                this.assertNotNull(this.loader, "loader in " + avmplus.getQualifiedClassName(this) + "(" + this.as_alias + "alias)");
                this._loader.unloadAndStop();
                this._loader = null;
                App.utils.commons.releaseReferences(this);
                this._disposed = true;
            }
            catch (error:net.wg.infrastructure.exceptions.base.WGGUIException)
            {
                DebugUtils.LOG_WARNING(error.getStackTrace());
            }
            catch (error:Error)
            {
                DebugUtils.LOG_ERROR(error.getStackTrace());
            }
            return;
        }

        public function getSubContainer():net.wg.infrastructure.interfaces.IManagedContainer
        {
            return null;
        }

        public function setViewSize(arg1:Number, arg2:Number):void
        {
            _originalWidth = arg1;
            _originalHeight = arg2;
            setActualSize(arg1, arg2);
            setActualScale(1, 1);
            return;
        }

        public function playShowTween(arg1:flash.display.DisplayObject, arg2:Function=null):Boolean
        {
            return false;
        }

        public function playHideTween(arg1:flash.display.DisplayObject, arg2:Function=null):Boolean
        {
            return false;
        }

        public function updateStage(arg1:Number, arg2:Number):void
        {
            return;
        }

        public function registerComponent(arg1:net.wg.infrastructure.interfaces.IDAAPIModule, arg2:String):void
        {
            registerFlashComponent(arg1, arg2);
            return;
        }

        public function unregisterComponent(arg1:String):void
        {
            this.assertLifeCycle();
            unregisterFlashComponent(arg1);
            return;
        }

        public function get disposed():Boolean
        {
            return this._disposed;
        }

        public function get as_token():String
        {
            return this._token;
        }

        public function set as_token(arg1:String):void
        {
            this._token = arg1;
            return;
        }

        public function get as_alias():String
        {
            return this._alias;
        }

        public function set as_alias(arg1:String):void
        {
            this._alias = arg1;
            return;
        }

        public function get as_name():String
        {
            return this._name;
        }

        public function set as_name(arg1:String):void
        {
            this._name = arg1;
            return;
        }

        public function get as_config():Object
        {
            return this._config;
        }

        public function set as_config(arg1:Object):void
        {
            this._config = arg1;
            return;
        }

        public function get loader():flash.display.Loader
        {
            return this._loader;
        }

        public function set loader(arg1:flash.display.Loader):void
        {
            this.assertNotNull(arg1, "value");
            this._loader = arg1;
            return;
        }

        public function setFocus():void
        {
            return;
        }

        public function removeFocus():void
        {
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            addEventListener(scaleform.clik.events.InputEvent.INPUT, handleInput, false, 0, true);
            initSize();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (constraints && isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
                constraints.update(_width, _height);
            return;
        }

        protected function onPopulate():void
        {
            App.toolTipMgr.hide();
            App.contextMenuMgr.hide();
            return;
        }

        internal var _disposed:Boolean=false;

        internal var _token:String;

        internal var _alias:String;

        internal var _name:String;

        internal var _config:Object;

        internal var _loader:flash.display.Loader;
    }
}
