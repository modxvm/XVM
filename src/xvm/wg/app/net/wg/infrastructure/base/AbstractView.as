package net.wg.infrastructure.base
{
    import net.wg.infrastructure.base.meta.impl.AbstractViewMeta;
    import net.wg.infrastructure.interfaces.IView;
    import net.wg.infrastructure.base.meta.IAbstractViewMeta;
    import flash.display.Loader;
    import flash.display.InteractiveObject;
    import net.wg.infrastructure.exceptions.base.WGGUIException;
    import net.wg.infrastructure.events.LifeCycleEvent;
    import flash.utils.getQualifiedClassName;
    import net.wg.infrastructure.interfaces.IManagedContainer;
    import flash.display.DisplayObject;
    import net.wg.infrastructure.interfaces.IDAAPIModule;
    import net.wg.data.constants.Values;
    import net.wg.infrastructure.interfaces.IManagedContent;
    import scaleform.clik.events.InputEvent;
    import scaleform.clik.constants.InvalidationType;
    import flash.display.DisplayObjectContainer;
    import net.wg.infrastructure.exceptions.InfrastructureException;
    import scaleform.clik.core.UIComponent;
    import net.wg.utils.IUtils;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.LifecycleException;
    import scaleform.clik.events.FocusHandlerEvent;
    
    public class AbstractView extends AbstractViewMeta implements IView, IAbstractViewMeta
    {
        
        public function AbstractView() {
            visible = false;
            super();
        }
        
        private static var INVALID_MODAL_FOCUS:String = "invalidModalFocus";
        
        private var _disposed:Boolean = false;
        
        private var _token:String = null;
        
        private var _alias:String = null;
        
        private var _name:String = null;
        
        private var _config:Object = null;
        
        private var _loader:Loader = null;
        
        private var _lastFocusedElement:InteractiveObject = null;
        
        private var _waitingFocusToInitialization:Boolean = false;
        
        private var _firstModalFocusUpdating:Boolean = true;
        
        public final function as_populate() : void {
            try
            {
                dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_POPULATE));
                this.onPopulate();
                App.utils.scheduler.envokeInNextFrame(this.nextFrameAfterPopulateHandler);
                dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_POPULATE));
            }
            catch(error:WGGUIException)
            {
                DebugUtils.LOG_WARNING(error.getStackTrace());
            }
        }
        
        public final function as_dispose() : void {
            try
            {
                this.assert(!this._disposed,"view " + this.as_alias + " can not to dispose, because it already disposed.");
                dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_DISPOSE));
                this.setLastFocusedElement(null);
                dispose();
                dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_DISPOSE));
                this.assertNotNull(this.loader,"loader` in " + getQualifiedClassName(this) + "(" + this.as_alias + "alias)");
                this._loader.unloadAndStop();
                this._loader = null;
                App.utils.commons.releaseReferences(this);
                this._disposed = true;
            }
            catch(error:WGGUIException)
            {
                DebugUtils.LOG_WARNING(error.getStackTrace());
            }
        }
        
        public function getSubContainer() : IManagedContainer {
            return null;
        }
        
        public function setViewSize(param1:Number, param2:Number) : void {
            _originalWidth = param1;
            _originalHeight = param2;
            setActualSize(param1,param2);
            setActualScale(1,1);
        }
        
        public function playShowTween(param1:DisplayObject, param2:Function = null) : Boolean {
            return false;
        }
        
        public function playHideTween(param1:DisplayObject, param2:Function = null) : Boolean {
            return false;
        }
        
        public function updateStage(param1:Number, param2:Number) : void {
        }
        
        public function registerComponent(param1:IDAAPIModule, param2:String) : void {
            registerFlashComponent(param1,param2);
        }
        
        public function unregisterComponent(param1:String) : void {
            this.assertLifeCycle();
            unregisterFlashComponent(param1);
        }
        
        public final function setModalFocus() : void {
            invalidate(INVALID_MODAL_FOCUS);
        }
        
        public final function leaveModalFocus() : void {
            cancelValidation(INVALID_MODAL_FOCUS);
            this.onLeaveModalFocus();
        }
        
        override public final function get hasFocus() : Boolean {
            return App.utils.focusHandler.hasModalFocus(this);
        }
        
        public function get isModal() : Boolean {
            return false;
        }
        
        public function get modalAlpha() : Number {
            return Values.DEFAULT_ALPHA;
        }
        
        public function get sourceView() : IView {
            return this;
        }
        
        public function get containerContent() : IManagedContent {
            return this;
        }
        
        public function get disposed() : Boolean {
            return this._disposed;
        }
        
        public function get as_token() : String {
            return this._token;
        }
        
        public function set as_token(param1:String) : void {
            this._token = param1;
        }
        
        public function get as_alias() : String {
            return this._alias;
        }
        
        public function set as_alias(param1:String) : void {
            this._alias = param1;
        }
        
        public function get as_name() : String {
            return this._name;
        }
        
        public function set as_name(param1:String) : void {
            this._name = param1;
        }
        
        public function get as_config() : Object {
            return this._config;
        }
        
        public function set as_config(param1:Object) : void {
            this._config = param1;
        }
        
        public function get loader() : Loader {
            return this._loader;
        }
        
        public function set loader(param1:Loader) : void {
            this.assertNotNull(param1,"value");
            this._loader = param1;
        }
        
        override protected function configUI() : void {
            super.configUI();
            if(this.allowHandleInput())
            {
                addEventListener(InputEvent.INPUT,handleInput,false,0,true);
            }
            initSize();
        }
        
        override protected function draw() : void {
            var _loc1_:InteractiveObject = null;
            super.draw();
            if((constraints) && (isInvalid(InvalidationType.SIZE)))
            {
                constraints.update(_width,_height);
            }
            if((isInvalid(INVALID_MODAL_FOCUS)) && (this.hasFocus))
            {
                _loc1_ = this.getManualFocus();
                if(this._firstModalFocusUpdating)
                {
                    this._firstModalFocusUpdating = false;
                    this.onInitModalFocus(_loc1_);
                }
                this.onSetModalFocus(_loc1_);
                if(this.getManualFocus() == null && !this._waitingFocusToInitialization)
                {
                    this.setFocus(this);
                }
            }
        }
        
        protected function getViewContainer() : DisplayObjectContainer {
            return this;
        }
        
        protected function onInitModalFocus(param1:InteractiveObject) : void {
        }
        
        protected function onSetModalFocus(param1:InteractiveObject) : void {
            var _loc2_:String = null;
            if(!(this._lastFocusedElement == null) && (param1 == this._lastFocusedElement || param1 == null))
            {
                _loc2_ = "Last focused element is not on display list! Use setfocus before removing element " + this._lastFocusedElement + "!";
                App.utils.asserter.assertNotNull(this._lastFocusedElement.parent,_loc2_,InfrastructureException);
                this.setFocus(this._lastFocusedElement);
            }
            else
            {
                this.setLastFocusedElement(param1);
            }
        }
        
        protected function onLeaveModalFocus() : void {
            var _loc1_:InteractiveObject = this.getManualFocus();
            if(_loc1_ != null)
            {
                this.setLastFocusedElement(_loc1_);
            }
        }
        
        protected final function setFocus(param1:InteractiveObject) : void {
            this.assertNotNull(param1,"element");
            this.assert(!(param1.stage == null),"focus must be set to object in display list only.");
            App.utils.scheduler.cancelTask(this.setFocus);
            this._waitingFocusToInitialization = false;
            if(this.hasFocus)
            {
                if(param1 is UIComponent && !UIComponent(param1).initialized)
                {
                    App.utils.scheduler.envokeInNextFrame(this.setFocus,param1);
                    this._waitingFocusToInitialization = true;
                }
                else
                {
                    App.utils.focusHandler.setFocus(param1);
                }
            }
            this.setLastFocusedElement(param1);
        }
        
        protected function nextFrameAfterPopulateHandler() : void {
            if(this.canAutoShowView())
            {
                visible = true;
            }
        }
        
        protected function canAutoShowView() : Boolean {
            return true;
        }
        
        protected function allowHandleInput() : Boolean {
            return true;
        }
        
        protected function onPopulate() : void {
            App.toolTipMgr.hide();
            App.contextMenuMgr.hide();
        }
        
        override protected function onDispose() : void {
            super.onDispose();
            var _loc1_:IUtils = App.utils;
            App.toolTipMgr.hide();
            App.contextMenuMgr.hide();
            _loc1_.scheduler.cancelTask(this.setFocus);
            removeEventListener(InputEvent.INPUT,handleInput);
        }
        
        protected final function assert(param1:Boolean, param2:String = "failed assert", param3:Class = null) : void {
            if(App.instance)
            {
                App.utils.asserter.assert(param1,param2,param3);
            }
        }
        
        protected final function assertLifeCycle() : void {
            this.assert(!this.disposed,Errors.MTHD_CORRUPT_INVOKE,LifecycleException);
        }
        
        protected final function assertNotNull(param1:Object, param2:String = "object", param3:Class = null) : void {
            if(App.instance)
            {
                App.utils.asserter.assertNotNull(param1,param2 + Errors.CANT_NULL,param3);
            }
        }
        
        protected final function assertNull(param1:Object, param2:String = "object", param3:Class = null) : void {
            if(App.instance)
            {
                App.utils.asserter.assertNull(param1,param2 + Errors.MUST_NULL,param3);
            }
        }
        
        protected function get lastFocusedElement() : InteractiveObject {
            return this._lastFocusedElement;
        }
        
        private function getManualFocus() : InteractiveObject {
            var _loc2_:InteractiveObject = null;
            var _loc1_:InteractiveObject = App.utils.focusHandler.getFocus(0);
            if(!(_loc1_ == null) && !(_loc1_.stage == null))
            {
                _loc2_ = _loc1_;
                if(this._lastFocusedElement != _loc2_)
                {
                    while(_loc2_ != null)
                    {
                        if(_loc2_ == this.getViewContainer())
                        {
                            return _loc1_;
                        }
                        _loc2_ = _loc2_.parent;
                    }
                }
                else
                {
                    return _loc1_;
                }
            }
            return null;
        }
        
        private function setLastFocusedElement(param1:InteractiveObject) : void {
            if(this._lastFocusedElement != null)
            {
                this._lastFocusedElement.removeEventListener(FocusHandlerEvent.FOCUS_OUT,this.onFocusOutFromLastFocusedElementHandler);
            }
            this._lastFocusedElement = param1;
            if(this._lastFocusedElement != null)
            {
                this._lastFocusedElement.addEventListener(FocusHandlerEvent.FOCUS_OUT,this.onFocusOutFromLastFocusedElementHandler);
            }
        }
        
        private function onFocusOutFromLastFocusedElementHandler(param1:FocusHandlerEvent) : void {
            var _loc5_:String = null;
            var _loc2_:InteractiveObject = this.getManualFocus();
            var _loc3_:* = false;
            var _loc4_:InteractiveObject = App.utils.focusHandler.getFocus(0);
            if(_loc4_ != null)
            {
                _loc3_ = _loc4_.stage == null;
            }
            if((this.hasFocus) && !_loc3_)
            {
                _loc5_ = "modal-focused view \'" + this + "\' has lost a component focus!";
                this.assert(!(_loc2_ == null),_loc5_,InfrastructureException);
            }
            this.setLastFocusedElement(_loc2_);
        }
    }
}
