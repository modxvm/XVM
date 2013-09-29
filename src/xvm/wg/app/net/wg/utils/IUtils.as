package net.wg.utils 
{
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public interface IUtils extends net.wg.infrastructure.base.meta.IUtilsManagerMeta, net.wg.infrastructure.interfaces.entity.IDisposable
    {
        function get asserter():net.wg.utils.IAssertable;

        function get scheduler():net.wg.utils.IScheduler;

        function get locale():net.wg.utils.ILocale;

        function get JSON():net.wg.infrastructure.interfaces.entity.ISerializable;

        function get helpLayout():net.wg.utils.IHelpLayout;

        function get classFactory():net.wg.utils.IClassFactory;

        function get popupMgr():net.wg.utils.IPopUpManager;

        function get commons():net.wg.utils.ICommons;

        function get nations():net.wg.utils.INations;

        function get focusHandler():net.wg.utils.IFocusHandler;

        function get events():net.wg.utils.IEventCollector;

        function get IME():net.wg.utils.IIME;

        function setNations(arg1:net.wg.utils.INations):void;
    }
}
