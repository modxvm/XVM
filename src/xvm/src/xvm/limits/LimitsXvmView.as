/**
 * XVM
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.limits
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.cfg.*;
    import flash.events.Event;
    import flash.utils.*;
    import net.wg.gui.lobby.*;
    import net.wg.gui.lobby.header.events.*;
    import net.wg.gui.lobby.header.headerButtonBar.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import xvm.limits.controls.*;

    public class LimitsXvmView extends XvmViewBase
    {
        private static const SETTINGS_GOLD_LOCK_STATUS:String = "xvm_limits/gold_lock_status";
        private static const SETTINGS_FREEXP_LOCK_STATUS:String = "xvm_limits/freexp_lock_status";

        private static const XFW_COMMAND_SET_GOLD_LOCK_STATUS:String = "xfw.set_gold_lock_status";
        private static const XFW_COMMAND_SET_FREEXP_LOCK_STATUS:String = "xfw.set_freexp_lock_status";

        private static const L10N_GOLD_LOCKED_TOOLTIP:String = "lobby/header/gold_locked_tooltip";
        private static const L10N_GOLD_UNLOCKED_TOOLTIP:String = "lobby/header/gold_unlocked_tooltip";
        private static const L10N_FREEXP_LOCKED_TOOLTIP:String = "lobby/header/freexp_locked_tooltip";
        private static const L10N_FREEXP_UNLOCKED_TOOLTIP:String = "lobby/header/freexp_unlocked_tooltip";

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
            init();
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            dispose();
        }

        // PRIVATE

        private var goldLocker:LockerControl = null;
        private var freeXpLocker:LockerControl = null;

        private function init():void
        {
            if (!Config.config.hangar.enableGoldLocker && !Config.config.hangar.enableFreeXpLocker)
                return;

            if (Config.config.hangar.enableGoldLocker)
            {
                goldLocker = page.header.addChild(new LockerControl()) as LockerControl;
                goldLocker.addEventListener(Event.SELECT, onGoldLockerSwitched);
                goldLocker.toolTip = Locale.get(L10N_GOLD_UNLOCKED_TOOLTIP);
                goldLocker.selected = Xvm.cmd(Defines.XVM_COMMAND_LOAD_SETTINGS, SETTINGS_GOLD_LOCK_STATUS, false);
            }

            if (Config.config.hangar.enableFreeXpLocker)
            {
                freeXpLocker = page.header.addChild(new LockerControl()) as LockerControl;
                freeXpLocker.addEventListener(Event.SELECT, onFreeXpLockerSwitched);
                freeXpLocker.toolTip = Locale.get(L10N_FREEXP_UNLOCKED_TOOLTIP);
                freeXpLocker.selected = Xvm.cmd(Defines.XVM_COMMAND_LOAD_SETTINGS, SETTINGS_FREEXP_LOCK_STATUS, false);
            }

            page.header.headerButtonBar.addEventListener(HeaderEvents.HEADER_ITEMS_REPOSITION, this.onHeaderButtonsReposition);
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

        private function onHeaderButtonsReposition(e:HeaderEvents):void
        {
            var goldControl:HeaderButton = page.header.xvm_headerButtonsHelper.xvm_searchButtonById(HeaderButtonsHelper.ITEM_ID_GOLD);
            if (goldControl)
            {
                var goldContent:HBC_Finance = goldControl.content as HBC_Finance;
                if (goldContent)
                {
                    goldLocker.x = goldControl.x + goldContent.x + goldContent.moneyIconText.x + 2;
                    goldLocker.y = goldControl.y + goldContent.y + goldContent.moneyIconText.y + 20;
                }
            }

            var freeXpControl:HeaderButton = page.header.xvm_headerButtonsHelper.xvm_searchButtonById(HeaderButtonsHelper.ITEM_ID_FREEXP);
            if (freeXpControl)
            {
                var freeXpContent:HBC_Finance = freeXpControl.content as HBC_Finance;
                if (freeXpContent)
                {
                    freeXpLocker.x = freeXpControl.x + freeXpContent.x + freeXpContent.moneyIconText.x + 2;
                    freeXpLocker.y = freeXpControl.y + freeXpContent.y + freeXpContent.moneyIconText.y + 20;
                }
            }
        }

        private function onGoldLockerSwitched(e:Event):void
        {
            Xvm.cmd(XFW_COMMAND_SET_GOLD_LOCK_STATUS, goldLocker.selected);
            Xvm.cmd(Defines.XVM_COMMAND_SAVE_SETTINGS, SETTINGS_GOLD_LOCK_STATUS, goldLocker.selected);
            goldLocker.toolTip = Locale.get(goldLocker.selected ? L10N_GOLD_LOCKED_TOOLTIP : L10N_GOLD_UNLOCKED_TOOLTIP);
        }

        private function onFreeXpLockerSwitched(e:Event):void
        {
            Xvm.cmd(XFW_COMMAND_SET_FREEXP_LOCK_STATUS, freeXpLocker.selected);
            Xvm.cmd(Defines.XVM_COMMAND_SAVE_SETTINGS, SETTINGS_FREEXP_LOCK_STATUS, freeXpLocker.selected);
            freeXpLocker.toolTip = Locale.get(freeXpLocker.selected ? L10N_FREEXP_LOCKED_TOOLTIP : L10N_FREEXP_UNLOCKED_TOOLTIP);
        }
    }
}
