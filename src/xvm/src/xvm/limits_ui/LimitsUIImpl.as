/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.limits_ui
{
    import com.xfw.*;
    import com.xvm.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.gui.lobby.*;
    import net.wg.gui.lobby.header.events.*;
    import net.wg.gui.lobby.header.headerButtonBar.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import xvm.limits.ILimitsUI;
    import xvm.limits_ui.controls.*;

    public class LimitsUIImpl implements ILimitsUI
    {
        private static const SETTINGS_GOLD_LOCK_STATUS:String = "xvm_limits/gold_lock_status";
        private static const SETTINGS_FREEXP_LOCK_STATUS:String = "xvm_limits/freexp_lock_status";

        private static const XVM_LIMITS_COMMAND_SET_GOLD_LOCK_STATUS:String = "xvm_limits.set_gold_lock_status";
        private static const XVM_LIMITS_COMMAND_SET_FREEXP_LOCK_STATUS:String = "xvm_limits.set_freexp_lock_status";

        private static const L10N_GOLD_LOCKED_TOOLTIP:String = "lobby/header/gold_locked_tooltip";
        private static const L10N_GOLD_UNLOCKED_TOOLTIP:String = "lobby/header/gold_unlocked_tooltip";
        private static const L10N_FREEXP_LOCKED_TOOLTIP:String = "lobby/header/freexp_locked_tooltip";
        private static const L10N_FREEXP_UNLOCKED_TOOLTIP:String = "lobby/header/freexp_unlocked_tooltip";

        private var page:LobbyPage = null;

        private var goldLocker:LockerControl = null;
        private var freeXpLocker:LockerControl = null;

        public function LimitsUIImpl()
        {
            Logger.add("LimitsUIImpl");
        }

        // ILimitsUI implementation

        public function init(page:LobbyPage):void
        {
            this.page = page;

            if (Config.config.hangar.enableGoldLocker)
            {
                goldLocker = page.header.addChild(new LockerControl()) as LockerControl;
                goldLocker.addEventListener(Event.SELECT, onGoldLockerSwitched);
                goldLocker.toolTip = Locale.get(L10N_GOLD_UNLOCKED_TOOLTIP);
                goldLocker.selected = Xfw.cmd(XvmCommands.LOAD_SETTINGS, SETTINGS_GOLD_LOCK_STATUS, false);
            }

            if (Config.config.hangar.enableFreeXpLocker)
            {
                freeXpLocker = page.header.addChild(new LockerControl()) as LockerControl;
                freeXpLocker.addEventListener(Event.SELECT, onFreeXpLockerSwitched);
                freeXpLocker.toolTip = Locale.get(L10N_FREEXP_UNLOCKED_TOOLTIP);
                freeXpLocker.selected = Xfw.cmd(XvmCommands.LOAD_SETTINGS, SETTINGS_FREEXP_LOCK_STATUS, false);
            }

            page.header.headerButtonBar.addEventListener(HeaderEvents.HEADER_ITEMS_REPOSITION, this.onHeaderButtonsReposition);
        }

        public function dispose():void
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

        // PRIVATE

        private function onHeaderButtonsReposition(e:HeaderEvents):void
        {
            try
            {
                if (goldLocker != null)
                {
                    var goldControl:HeaderButton = page.header.xfw_headerButtonsHelper.xfw_searchButtonById(HeaderButtonsHelper.ITEM_ID_GOLD);
                    if (goldControl != null)
                    {
                        var goldContent:HBC_Finance = goldControl.content as HBC_Finance;
                        if (goldContent != null)
                        {
                            goldLocker.x = goldControl.x + goldContent.x + goldContent.moneyIconText.x + 3;
                            goldLocker.y = goldControl.y + goldContent.y + goldContent.moneyIconText.y + 20;
                        }
                    }
                }

                if (freeXpLocker != null)
                {
                    var freeXpControl:HeaderButton = page.header.xfw_headerButtonsHelper.xfw_searchButtonById(HeaderButtonsHelper.ITEM_ID_FREEXP);
                    if (freeXpControl != null)
                    {
                        var freeXpContent:HBC_Finance = freeXpControl.content as HBC_Finance;
                        if (freeXpContent != null)
                        {
                            freeXpLocker.x = freeXpControl.x + freeXpContent.x + freeXpContent.moneyIconText.x + 3;
                            freeXpLocker.y = freeXpControl.y + freeXpContent.y + freeXpContent.moneyIconText.y + 20;
                        }
                    }
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function onGoldLockerSwitched(e:Event):void
        {
            Xfw.cmd(XVM_LIMITS_COMMAND_SET_GOLD_LOCK_STATUS, goldLocker.selected);
            Xfw.cmd(XvmCommands.SAVE_SETTINGS, SETTINGS_GOLD_LOCK_STATUS, goldLocker.selected);
            goldLocker.toolTip = Locale.get(goldLocker.selected ? L10N_GOLD_LOCKED_TOOLTIP : L10N_GOLD_UNLOCKED_TOOLTIP);
        }

        private function onFreeXpLockerSwitched(e:Event):void
        {
            Xfw.cmd(XVM_LIMITS_COMMAND_SET_FREEXP_LOCK_STATUS, freeXpLocker.selected);
            Xfw.cmd(XvmCommands.SAVE_SETTINGS, SETTINGS_FREEXP_LOCK_STATUS, freeXpLocker.selected);
            freeXpLocker.toolTip = Locale.get(freeXpLocker.selected ? L10N_FREEXP_LOCKED_TOOLTIP : L10N_FREEXP_UNLOCKED_TOOLTIP);
        }
    }
}
