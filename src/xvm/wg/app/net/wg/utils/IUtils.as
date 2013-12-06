package net.wg.utils
{
   import net.wg.infrastructure.base.meta.IUtilsManagerMeta;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.ISerializable;


   public interface IUtils extends IUtilsManagerMeta, IDisposable
   {
          
      function get asserter() : IAssertable;

      function get scheduler() : IScheduler;

      function get locale() : ILocale;

      function get JSON() : ISerializable;

      function get helpLayout() : IHelpLayout;

      function get classFactory() : IClassFactory;

      function get popupMgr() : IPopUpManager;

      function get commons() : ICommons;

      function get nations() : INations;

      function get focusHandler() : IFocusHandler;

      function get events() : IEventCollector;

      function get IME() : IIME;

      function setNations(param1:INations) : void;

      function get voMgr() : IVOManager;

      function get icons() : IIcons;
   }

}