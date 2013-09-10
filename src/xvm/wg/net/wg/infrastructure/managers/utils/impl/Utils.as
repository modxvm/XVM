package net.wg.infrastructure.managers.utils.impl 
{
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import net.wg.utils.*;
    
    public class Utils extends net.wg.infrastructure.base.meta.impl.UtilsManagerMeta implements net.wg.utils.IUtils
    {
        public function Utils(arg1:net.wg.utils.IAssertable, arg2:net.wg.utils.IScheduler, arg3:net.wg.utils.ILocale, arg4:net.wg.infrastructure.interfaces.entity.ISerializable, arg5:net.wg.utils.IHelpLayout, arg6:net.wg.utils.IClassFactory, arg7:net.wg.utils.IPopUpManager, arg8:net.wg.utils.ICommons, arg9:net.wg.utils.IFocusHandler, arg10:net.wg.utils.IEventCollector, arg11:net.wg.utils.IIME)
        {
            super();
            this._asserter = arg1;
            this._scheduler = arg2;
            this._locale = arg3;
            this._JSON = arg4;
            this._helpLayout = arg5;
            this._classFactory = arg6;
            this._popupManager = arg7;
            this._commons = arg8;
            this._focusHandler = arg9;
            this._events = arg10;
            this._ime = arg11;
            return;
        }

        public function setNations(arg1:net.wg.utils.INations):void
        {
            this._nations = arg1;
            return;
        }

        public function dispose():void
        {
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
            return;
        }

        public function get asserter():net.wg.utils.IAssertable
        {
            return this._asserter;
        }

        public function get scheduler():net.wg.utils.IScheduler
        {
            return this._scheduler;
        }

        public function get locale():net.wg.utils.ILocale
        {
            return this._locale;
        }

        public function get JSON():net.wg.infrastructure.interfaces.entity.ISerializable
        {
            return this._JSON;
        }

        public function get helpLayout():net.wg.utils.IHelpLayout
        {
            return this._helpLayout;
        }

        public function get classFactory():net.wg.utils.IClassFactory
        {
            return this._classFactory;
        }

        public function get popupMgr():net.wg.utils.IPopUpManager
        {
            return this._popupManager;
        }

        public function get commons():net.wg.utils.ICommons
        {
            return this._commons;
        }

        public function get nations():net.wg.utils.INations
        {
            return this._nations;
        }

        public function get focusHandler():net.wg.utils.IFocusHandler
        {
            return this._focusHandler;
        }

        public function get events():net.wg.utils.IEventCollector
        {
            return this._events;
        }

        public function get IME():net.wg.utils.IIME
        {
            return this._ime;
        }

        internal var _asserter:net.wg.utils.IAssertable=null;

        internal var _scheduler:net.wg.utils.IScheduler=null;

        internal var _locale:net.wg.utils.ILocale=null;

        internal var _JSON:net.wg.infrastructure.interfaces.entity.ISerializable=null;

        internal var _helpLayout:net.wg.utils.IHelpLayout=null;

        internal var _classFactory:net.wg.utils.IClassFactory=null;

        internal var _popupManager:net.wg.utils.IPopUpManager=null;

        internal var _commons:net.wg.utils.ICommons=null;

        internal var _nations:net.wg.utils.INations=null;

        internal var _focusHandler:net.wg.utils.IFocusHandler=null;

        internal var _events:net.wg.utils.IEventCollector=null;

        internal var _ime:net.wg.utils.IIME=null;
    }
}
