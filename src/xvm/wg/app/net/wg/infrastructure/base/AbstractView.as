package net.wg.infrastructure.base
{
   import net.wg.infrastructure.base.meta.impl.AbstractViewMeta;
   import net.wg.infrastructure.interfaces.IView;
   import net.wg.infrastructure.base.meta.IAbstractViewMeta;
   import flash.display.Loader;
   import net.wg.infrastructure.exceptions.base.WGGUIException;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import avmplus.getQualifiedClassName;
   import net.wg.infrastructure.interfaces.IManagedContainer;
   import flash.display.DisplayObject;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.exceptions.LifecycleException;


   public class AbstractView extends AbstractViewMeta implements IView, IAbstractViewMeta
   {
          
      public function AbstractView() {
         visible = false;
         super();
      }

      private var _disposed:Boolean = false;

      private var _token:String;

      private var _alias:String;

      private var _name:String;

      private var _config:Object;

      private var _loader:Loader;

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

      protected function nextFrameAfterPopulateHandler() : void {
         visible = true;
      }

      public final function as_dispose() : void {
         try
         {
            this.assert(!this._disposed,"view " + this.as_alias + " can not to dispose, because it already disposed.");
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_DISPOSE));
            this.onDispose();
            this.dispose();
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_DISPOSE));
            this.assertNotNull(this.loader,"loader in " + getQualifiedClassName(this) + "(" + this.as_alias + "alias)");
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

      public function playShowTween(param1:DisplayObject, param2:Function=null) : Boolean {
         return false;
      }

      public function playHideTween(param1:DisplayObject, param2:Function=null) : Boolean {
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

      public function setFocus() : void {
          
      }

      public function removeFocus() : void {
          
      }

      override protected function configUI() : void {
         super.configUI();
         if(this.allowHandleInput())
         {
            addEventListener(InputEvent.INPUT,handleInput,false,0,true);
         }
         initSize();
      }

      protected function allowHandleInput() : Boolean {
         return true;
      }

      override protected function draw() : void {
         super.draw();
         if((constraints) && (isInvalid(InvalidationType.SIZE)))
         {
            constraints.update(_width,_height);
         }
      }

      protected function onPopulate() : void {
         App.toolTipMgr.hide();
         App.contextMenuMgr.hide();
      }

      protected function onDispose() : void {
         App.toolTipMgr.hide();
         App.contextMenuMgr.hide();
         removeEventListener(InputEvent.INPUT,handleInput);
      }

      override public final function dispose() : void {
         super.dispose();
      }

      protected final function assert(param1:Boolean, param2:String="failed assert", param3:Class=null) : void {
         if(App.instance)
         {
            App.utils.asserter.assert(param1,param2,param3);
         }
      }

      protected final function assertLifeCycle() : void {
         this.assert(!this.disposed,Errors.HDLR_CORRUPT_INVOKE,LifecycleException);
      }

      protected final function assertNotNull(param1:Object, param2:String="object", param3:Class=null) : void {
         if(App.instance)
         {
            App.utils.asserter.assertNotNull(param1,param2 + Errors.CANT_NULL,param3);
         }
      }

      protected final function assertNull(param1:Object, param2:String="object", param3:Class=null) : void {
         if(App.instance)
         {
            App.utils.asserter.assertNull(param1,param2 + Errors.MUST_NULL,param3);
         }
      }
   }

}