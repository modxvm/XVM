/**
 * XVM
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.limits
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.cfg.*;
    import flash.utils.*;
    import net.wg.gui.lobby.*;
    import net.wg.gui.lobby.header.headerButtonBar.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import xvm.limits.controls.*;

    public class LimitsXvmView extends XvmViewBase
    {
        public function LimitsXvmView(view:IView)
        {
            super(view);
        }

        public function get page():LobbyPage
        {
            return super.view as LobbyPage;
        }

        override public function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.add("onAfterPopulate: " + view.as_alias);
            init();
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            //Logger.add("onBeforeDispose: " + view.as_alias);
            dispose();
        }

        // PRIVATE

        private var goldLocker:LockerControl = null;
        private var freeXpLocker:LockerControl = null;

        private function init():void
        {
            var goldControl:HeaderButton = page.header.xvm_headerButtonsHelper.xvm_searchButtonById(HeaderButtonsHelper.ITEM_ID_GOLD);
            var freeXpControl:HeaderButton = page.header.xvm_headerButtonsHelper.xvm_searchButtonById(HeaderButtonsHelper.ITEM_ID_FREEXP);

            if (goldControl == null || freeXpControl == null)
            {
                var self:LimitsXvmView = this;
                setTimeout(function():void { self.init(); }, 1);
                return;
            }

            if (Config.config.hangar.enableGoldLocker)
            {
                var goldContent:HBC_Finance = goldControl.content as HBC_Finance;
                goldLocker = goldContent.addChild(new LockerControl()) as LockerControl;
                goldLocker.x = goldContent.moneyIconText.x;
                goldLocker.y = goldContent.moneyIconText.y + 20;
                //goldLocker.addEventListener(
            }

            if (Config.config.hangar.enableFreeXpLocker)
            {
                var freeXpContent:HBC_Finance = freeXpControl.content as HBC_Finance;
                freeXpLocker = freeXpContent.addChild(new LockerControl()) as LockerControl;
                freeXpLocker.x = freeXpContent.moneyIconText.x;
                freeXpLocker.y = freeXpContent.moneyIconText.y + 20;
            }
        }

        private function dispose():void
        {
            if (goldLocker != null)
            {
                goldLocker.dispose();
                goldLocker = null;
            }
            if (freeXpLocker != null)
            {
                freeXpLocker.dispose();
                freeXpLocker = null;
            }
        }
    }

}
