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


   public class Utils extends UtilsManagerMeta implements IUtils
   {
          
      public function Utils(param1:IAssertable, param2:IScheduler, param3:ILocale, param4:ISerializable, param5:IHelpLayout, param6:IClassFactory, param7:IPopUpManager, param8:ICommons, param9:IFocusHandler, param10:IEventCollector, param11:IIME, param12:IVOManager) {
         super();
         this._asserter = param1;
         this._scheduler = param2;
         this._locale = param3;
         this._JSON = param4;
         this._helpLayout = param5;
         this._classFactory = param6;
         this._popupManager = param7;
         this._commons = param8;
         this._focusHandler = param9;
         this._events = param10;
         this._ime = param11;
         this._voManager = param12;
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
   }

}