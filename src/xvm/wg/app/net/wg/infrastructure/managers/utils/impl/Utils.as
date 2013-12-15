package net.wg.infrastructure.managers.utils.impl
{
   import net.wg.infrastructure.base.meta.impl.UtilsManagerMeta;
   import net.wg.utils.IUtils;
   import net.wg.utils.IAssertable;
   import net.wg.utils.IScheduler;
   import net.wg.utils.ILocale;
   import net.wg.infrastructure.interfaces.entity.ISerializable;
   import net.wg.utils.IHelpLayout;
   import net.wg.utils.IClassFactory;
   import net.wg.utils.IPopUpManager;
   import net.wg.utils.ICommons;
   import net.wg.utils.INations;
   import net.wg.utils.IFocusHandler;
   import net.wg.utils.IEventCollector;
   import net.wg.utils.IIME;
   import net.wg.utils.IVOManager;
   import net.wg.utils.IIcons;
   import net.wg.infrastructure.interfaces.IStrCaseProperties;
   import net.wg.data.StrCaseProperties;


   public class Utils extends UtilsManagerMeta implements IUtils
   {
          
      public function Utils(param1:IAssertable, param2:IScheduler, param3:ILocale, param4:ISerializable, param5:IHelpLayout, param6:IClassFactory, param7:IPopUpManager, param8:ICommons, param9:IFocusHandler, param10:IEventCollector, param11:IIME, param12:IVOManager, param13:IIcons) {
         var asserter:IAssertable = param1;
         var scheduler:IScheduler = param2;
         var locale:ILocale = param3;
         var JSON:ISerializable = param4;
         var helpLayout:IHelpLayout = param5;
         var classFactory:IClassFactory = param6;
         var popupManager:IPopUpManager = param7;
         var commons:ICommons = param8;
         var focusHandler:IFocusHandler = param9;
         var events:IEventCollector = param10;
         var ime:IIME = param11;
         var voManager:IVOManager = param12;
         var icons:IIcons = param13;
         super();
         this._asserter = asserter;
         this._scheduler = scheduler;
         this._scheduler.scheduleTask(function():void
         {
            
         },50);
         this._scheduler.scheduleTask(function():void
         {
            
         },750);
         this._scheduler.scheduleTask(function():void
         {
            
         },500);
         this._scheduler.scheduleTask(function():void
         {
            
         },250);
         this._locale = locale;
         this._JSON = JSON;
         this._helpLayout = helpLayout;
         this._classFactory = classFactory;
         this._popupManager = popupManager;
         this._commons = commons;
         this._focusHandler = focusHandler;
         this._events = events;
         this._ime = ime;
         this._voManager = voManager;
         this._icons = icons;
      }

      private var _asserter:IAssertable = null;

      private var _scheduler:IScheduler = null;

      private var _locale:ILocale = null;

      private var _JSON:ISerializable = null;

      private var _helpLayout:IHelpLayout = null;

      private var _classFactory:IClassFactory = null;

      private var _popupManager:IPopUpManager = null;

      private var _commons:ICommons = null;

      private var _nations:INations = null;

      private var _focusHandler:IFocusHandler = null;

      private var _events:IEventCollector = null;

      private var _ime:IIME = null;

      private var _voManager:IVOManager = null;

      private var _icons:IIcons = null;

      public function setNations(param1:INations) : void {
         this._nations = param1;
      }

      public function dispose() : void {
         this._events.dispose();
         this._events = null;
         this._scheduler.dispose();
         this._scheduler = null;
         this._helpLayout.dispose();
         this._helpLayout = null;
         this._focusHandler.dispose();
         this._focusHandler = null;
         this._asserter = null;
         this._locale = null;
         this._JSON = null;
         this._classFactory = null;
         this._popupManager = null;
         this._nations = null;
         this._ime.dispose();
         this._ime = null;
         this._voManager.dispose();
         this._voManager = null;
         this._icons = null;
      }

      public function toUpperOrLowerCase(param1:String, param2:Boolean, param3:IStrCaseProperties=null) : String {
         return changeStringCasing(param1,param2,param3);
      }

      public function getStrCaseProperties() : IStrCaseProperties {
         return new StrCaseProperties();
      }

      public function get asserter() : IAssertable {
         return this._asserter;
      }

      public function get scheduler() : IScheduler {
         return this._scheduler;
      }

      public function get locale() : ILocale {
         return this._locale;
      }

      public function get JSON() : ISerializable {
         return this._JSON;
      }

      public function get helpLayout() : IHelpLayout {
         return this._helpLayout;
      }

      public function get classFactory() : IClassFactory {
         return this._classFactory;
      }

      public function get popupMgr() : IPopUpManager {
         return this._popupManager;
      }

      public function get commons() : ICommons {
         return this._commons;
      }

      public function get nations() : INations {
         return this._nations;
      }

      public function get focusHandler() : IFocusHandler {
         return this._focusHandler;
      }

      public function get events() : IEventCollector {
         return this._events;
      }

      public function get IME() : IIME {
         return this._ime;
      }

      public function get voMgr() : IVOManager {
         return this._voManager;
      }

      public function get icons() : IIcons {
         return this._icons;
      }
   }

}