package net.wg.app.impl
{
   import net.wg.app.impl.base.AbstractApplication;
   import flash.display.MovieClip;
   import net.wg.gui.components.common.ManagedContainer;
   import net.wg.gui.components.common.MainViewContainer;
   import flash.display.Sprite;
   import flash.display.DisplayObjectContainer;
   import net.wg.utils.IUtils;
   import net.wg.infrastructure.managers.utils.impl.Utils;
   import net.wg.infrastructure.managers.utils.impl.Asserter;
   import net.wg.infrastructure.managers.utils.impl.Scheduler;
   import net.wg.infrastructure.managers.utils.impl.Locale;
   import net.wg.infrastructure.managers.utils.impl.WGJSON;
   import net.wg.infrastructure.managers.utils.impl.HelpLayout;
   import net.wg.infrastructure.managers.utils.impl.ClassFactory;
   import net.wg.infrastructure.managers.utils.impl.PopupManager;
   import net.wg.infrastructure.managers.utils.impl.Commons;
   import net.wg.infrastructure.managers.utils.impl.FocusHandlerEx;
   import net.wg.infrastructure.managers.utils.impl.EventCollector;
   import net.wg.infrastructure.managers.utils.impl.IME;
   import net.wg.infrastructure.managers.utils.impl.VOManager;
   import net.wg.infrastructure.managers.utils.impl.Icons;
   import net.wg.infrastructure.managers.utils.impl.Nations;
   import net.wg.data.constants.ContainerTypes;
   import net.wg.gui.components.common.CursorManagedContainer;
   import net.wg.gui.components.common.WaitingManagedContainer;
   import flash.display.DisplayObject;
   import __AS3__.vec.*;
   import net.wg.infrastructure.managers.IEnvironmentManager;
   import net.wg.infrastructure.managers.impl.EnvironmentManager;
   import net.wg.infrastructure.managers.ISoundManager;
   import net.wg.infrastructure.managers.impl.SoundManager;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.infrastructure.managers.impl.ToolTipManager;
   import net.wg.infrastructure.managers.IContainerManager;
   import net.wg.infrastructure.managers.impl.ContainerManager;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import net.wg.infrastructure.managers.impl.ColorSchemeManager;
   import net.wg.infrastructure.managers.IContextMenuManager;
   import net.wg.infrastructure.managers.impl.ContextMenuManager;
   import net.wg.infrastructure.managers.impl.ClassManager;
   import net.wg.infrastructure.managers.IGuiItemsManager;
   import net.wg.infrastructure.managers.impl.GuiItemsManager;
   import net.wg.infrastructure.managers.IVoiceChatManager;
   import net.wg.infrastructure.managers.impl.VoiceChatManager;
   import net.wg.utils.IGameInputManager;
   import net.wg.infrastructure.managers.impl.GameInputManager;
   import flash.events.Event;
   import scaleform.gfx.Extensions;
   import scaleform.clik.core.CLIK;


   public final class Application extends AbstractApplication
   {
          
      public function Application() {
         this.browserBgClassValue = Application_browserBgClassValue;
         this._librariesList = Vector.<String>(["windows.swf"]);
         super();
         Extensions.enabled = true;
         Extensions.noInvisibleAdvance = true;
         CLIK.disableNullFocusMoves = true;
      }

      public static const APP_REG_CMD:String = "registerApplication";

      public var browserBgClassValue:Class;

      private var _librariesList:Vector.<String>;

      private var _libraries:MovieClip;

      private var _serviceLayout:ManagedContainer;

      private var _views:MainViewContainer;

      private var _windows:ManagedContainer;

      private var _systemMessages:Sprite;

      private var _dialogs:ManagedContainer;

      private var _toolTips:MovieClip;

      private var _cursorCtnr:ManagedContainer;

      private var _waitingCtnr:ManagedContainer;

      public function as_traceObject(param1:*) : void {
         DebugUtils.LOG_DEBUG("traceObject",param1);
      }

      override public function get browserBgClass() : Class {
         return this.browserBgClassValue;
      }

      override public function get systemMessages() : DisplayObjectContainer {
         return this._systemMessages;
      }

      override protected function getNewUtils() : IUtils {
         var _loc1_:IUtils = new Utils(new Asserter(),new Scheduler(),new Locale(),new WGJSON(),new HelpLayout(),new ClassFactory(),new PopupManager(),new Commons(),new FocusHandlerEx(),new EventCollector(),new IME(),new VOManager(),new Icons());
         _loc1_.setNations(new Nations(_loc1_));
         return _loc1_;
      }

      override protected function createContainers() : void {
         this._libraries = new MovieClip();
         this._serviceLayout = new ManagedContainer();
         this._serviceLayout.type = ContainerTypes.SERVICE_LAYOUT;
         this._views = new MainViewContainer();
         this._views.type = ContainerTypes.VIEW;
         this._windows = new ManagedContainer();
         this._windows.type = ContainerTypes.WINDOW;
         this._systemMessages = new Sprite();
         this._dialogs = new ManagedContainer();
         this._dialogs.type = ContainerTypes.DIALOG;
         this._toolTips = new MovieClip();
         this._cursorCtnr = new CursorManagedContainer();
         this._waitingCtnr = new WaitingManagedContainer();
         super.createContainers();
      }

      override protected function disposeContainers() : void {
         super.disposeContainers();
         this._views.dispose();
         this._views = null;
         this._libraries = null;
         this._windows.dispose();
         this._windows = null;
         this._dialogs.dispose();
         this._dialogs = null;
         this._systemMessages = null;
         this._toolTips = null;
         this._serviceLayout.dispose();
         this._serviceLayout = null;
         this._cursorCtnr.dispose();
         this._cursorCtnr = null;
         this._waitingCtnr.dispose();
         this._waitingCtnr = null;
      }

      override protected function onDispose() : void {
         super.onDispose();
      }

      override protected function getContainers() : Vector.<DisplayObject> {
         new Vector.<DisplayObject>(10)[0] = this._libraries;
         new Vector.<DisplayObject>(10)[1] = this._views;
         new Vector.<DisplayObject>(10)[2] = this._windows;
         new Vector.<DisplayObject>(10)[3] = this._systemMessages;
         new Vector.<DisplayObject>(10)[4] = this._dialogs;
         new Vector.<DisplayObject>(10)[5] = utils.IME.getContainer();
         new Vector.<DisplayObject>(10)[6] = this._toolTips;
         new Vector.<DisplayObject>(10)[7] = this._serviceLayout;
         new Vector.<DisplayObject>(10)[8] = this._cursorCtnr;
         new Vector.<DisplayObject>(10)[9] = this._waitingCtnr;
         var _loc1_:Vector.<DisplayObject> = new Vector.<DisplayObject>(10);
         return _loc1_;
      }

      override protected function getNewEnvironment() : IEnvironmentManager {
         return EnvironmentManager.getInstance();
      }

      override protected function getNewSoundManager() : ISoundManager {
         return new SoundManager();
      }

      override protected function getNewTooltipManager() : ITooltipMgr {
         return new ToolTipManager(this._toolTips);
      }

      override protected function getNewContainerManager() : IContainerManager {
         return new ContainerManager();
      }

      override protected function getNewColorSchemeManager() : IColorSchemeManager {
         return new ColorSchemeManager();
      }

      override protected function getNewContextMenuManager() : IContextMenuManager {
         return new ContextMenuManager();
      }

      override protected function getNewClassManager() : Sprite {
         return new ClassManager();
      }

      override protected function getNewGuiItemsManager() : IGuiItemsManager {
         return new GuiItemsManager();
      }

      override protected function getNewVoiceChatManager() : IVoiceChatManager {
         return new VoiceChatManager();
      }

      override protected function getNewGameInputManager() : IGameInputManager {
         return new GameInputManager();
      }

      override protected function onAppConfiguring() : void {
         super.onAppConfiguring();
         libraryLoader.load(this._librariesList);
      }

      override protected function onBeforeAppConfiguring() : void {
         super.onBeforeAppConfiguring();
         libraryLoader.init(this._libraries);
      }

      override protected function onPopUpManagerInit() : void {
         super.onPopUpManagerInit();
         addChildAt(utils.popupMgr.popupCanvas,this.getTooltipsLayerIndex());
      }

      override protected function getRegCmdName() : String {
         return APP_REG_CMD;
      }

      override protected function initStage(param1:Event=null) : void {
         gameInputMgr.initStage(this.stage);
         super.initStage(param1);
      }

      private function getTooltipsLayerIndex() : Number {
         return getChildIndex(this._toolTips);
      }
   }

}