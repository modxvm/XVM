/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ui.limits
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.lobby.limits.*;
    import com.xvm.lobby.ui.limits.controls.*;
    import flash.events.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.lobby.*;
    import net.wg.gui.lobby.header.events.*;
    import net.wg.gui.lobby.header.headerButtonBar.*;

    public class LimitsUIImpl implements ILimitsUI
    {
        private static const SETTINGS_GOLD_LOCK_STATUS:String = "users/{accountDBID}/limits/gold_lock_status";
        private static const SETTINGS_FREEXP_LOCK_STATUS:String = "users/{accountDBID}/limits/freexp_lock_status";
        private static const SETTINGS_CRYSTAL_LOCK_STATUS:String = "users/{accountDBID}/limits/crystal_lock_status";

        private static const XVM_LIMITS_COMMAND_SET_GOLD_LOCK_STATUS:String = "xvm_limits.set_gold_lock_status";
        private static const XVM_LIMITS_COMMAND_SET_FREEXP_LOCK_STATUS:String = "xvm_limits.set_freexp_lock_status";
        private static const XVM_LIMITS_COMMAND_SET_CRYSTAL_LOCK_STATUS:String = "xvm_limits.set_crystal_lock_status";

        private static const L10N_GOLD_LOCKED_TOOLTIP:String = "lobby/header/gold_locked_tooltip";
        private static const L10N_GOLD_UNLOCKED_TOOLTIP:String = "lobby/header/gold_unlocked_tooltip";
        private static const L10N_FREEXP_LOCKED_TOOLTIP:String = "lobby/header/freexp_locked_tooltip";
        private static const L10N_FREEXP_UNLOCKED_TOOLTIP:String = "lobby/header/freexp_unlocked_tooltip";
        private static const L10N_CRYSTAL_LOCKED_TOOLTIP:String = "lobby/header/crystal_locked_tooltip";
        private static const L10N_CRYSTAL_UNLOCKED_TOOLTIP:String = "lobby/header/crystal_unlocked_tooltip";

        private var page:LobbyPage = null;

        private var goldLocker:LockerControl = null;
        private var freeXpLocker:LockerControl = null;
        private var crystalLocker:LockerControl = null;

        public function LimitsUIImpl()
        {
            //Logger.add("LimitsUIImpl");
        }

        // ILimitsUI implementation

        public function init(page:LobbyPage):void
        {
            this.page = page;

            if (Config.config.hangar.enableGoldLocker)
            {
                goldLocker = page.header.addChild(new LockerControl()) as LockerControl;
                goldLocker.addEventListener(Event.SELECT, onGoldLockerSwitched, false, 0, true);
                goldLocker.toolTip = Locale.get(L10N_GOLD_UNLOCKED_TOOLTIP);
                goldLocker.selected = Xfw.cmd(XvmCommands.LOAD_SETTINGS, SETTINGS_GOLD_LOCK_STATUS, false);
                goldLocker.visible = false;
            }

            if (Config.config.hangar.enableFreeXpLocker)
            {
                freeXpLocker = page.header.addChild(new LockerControl()) as LockerControl;
                freeXpLocker.addEventListener(Event.SELECT, onFreeXpLockerSwitched, false, 0, true);
                freeXpLocker.toolTip = Locale.get(L10N_FREEXP_UNLOCKED_TOOLTIP);
                freeXpLocker.selected = Xfw.cmd(XvmCommands.LOAD_SETTINGS, SETTINGS_FREEXP_LOCK_STATUS, false);
                freeXpLocker.visible = false;
            }

            if (Config.config.hangar.enableCrystalLocker)
            {
                crystalLocker = page.header.addChild(new LockerControl()) as LockerControl;
                crystalLocker.addEventListener(Event.SELECT, onCrystalLockerSwitched, false, 0, true);
                crystalLocker.toolTip = Locale.get(L10N_CRYSTAL_UNLOCKED_TOOLTIP);
                crystalLocker.selected = Xfw.cmd(XvmCommands.LOAD_SETTINGS, SETTINGS_CRYSTAL_LOCK_STATUS, false);
                crystalLocker.visible = false;
            }

            page.header.headerButtonBar.addEventListener(HeaderEvents.HEADER_ITEMS_REPOSITION, this.onHeaderButtonsReposition, false, 0, true);
        }

        public function dispose():void
        {
            if (goldLocker)
            {
                goldLocker.dispose();
                goldLocker = null;
            }

            if (freeXpLocker)
            {
                freeXpLocker.dispose();
                freeXpLocker = null;
            }

            if (crystalLocker)
            {
                crystalLocker.dispose();
                crystalLocker = null;
            }
        }

        // PRIVATE

        private function onHeaderButtonsReposition(e:HeaderEvents):void
        {
            try
            {
                var minWidth:int;
                var headerButtonsHelper:HeaderButtonsHelper = XfwUtils.getPrivateField(page.header, "xfw_headerButtonsHelper");

                if (goldLocker)
                {
                    var goldControl:HeaderButton = headerButtonsHelper.searchButtonById(CURRENCIES_CONSTANTS.GOLD);
                    if (goldControl)
                    {
                        var goldContent:HBC_Finance = goldControl.content as HBC_Finance;
                        if (goldContent)
                        {
                            goldLocker.visible = true;
                            goldLocker.x = goldControl.x + goldContent.x + goldContent.moneyIconText.x + 3;
                            goldLocker.y = goldControl.y + goldContent.y + goldContent.moneyIconText.y + 17;
                            goldContent.doItTextField.x = 20;
                            minWidth = goldContent.doItTextField.x + goldContent.doItTextField.textWidth;
                            if (goldContent.bounds.width < minWidth)
                            {
                                goldContent.bounds.width = minWidth;
                                goldContent.dispatchEvent(new HeaderEvents(HeaderEvents.HBC_SIZE_UPDATED, goldContent.bounds.width, XfwUtils.getPrivateField(goldContent, "xfw_leftPadding"), XfwUtils.getPrivateField(goldContent, "xfw_rightPadding")));
                            }
                        }
                    }
                }

                if (freeXpLocker)
                {

                    var freeXpControl:HeaderButton = headerButtonsHelper.searchButtonById(CURRENCIES_CONSTANTS.FREE_XP);
                    if (freeXpControl)
                    {
                        var freeXpContent:HBC_Finance = freeXpControl.content as HBC_Finance;
                        if (freeXpContent)
                        {
                            freeXpLocker.visible = true;
                            freeXpLocker.x = freeXpControl.x + freeXpContent.x + freeXpContent.moneyIconText.x + 3;
                            freeXpLocker.y = freeXpControl.y + freeXpContent.y + freeXpContent.moneyIconText.y + 17;
                            freeXpContent.doItTextField.x = 20;
                            minWidth = freeXpContent.doItTextField.x + freeXpContent.doItTextField.textWidth;
                            if (freeXpContent.bounds.width < minWidth)
                            {
                                freeXpContent.bounds.width = minWidth;
                                freeXpContent.dispatchEvent(new HeaderEvents(HeaderEvents.HBC_SIZE_UPDATED, freeXpContent.bounds.width, XfwUtils.getPrivateField(freeXpContent, "xfw_leftPadding"), XfwUtils.getPrivateField(freeXpContent, "xfw_rightPadding")));
                            }
                        }
                    }
                }

                if (crystalLocker)
                {
                    var crystalControl:HeaderButton = headerButtonsHelper.searchButtonById(CURRENCIES_CONSTANTS.CRYSTAL);
                    if (crystalControl)
                    {
                        var crystalContent:HBC_Finance = crystalControl.content as HBC_Finance;
                        if (crystalContent)
                        {
                            crystalLocker.visible = true;
                            crystalLocker.x = crystalControl.x + crystalContent.x + crystalContent.moneyIconText.x + 3;
                            crystalLocker.y = crystalControl.y + crystalContent.y + crystalContent.moneyIconText.y + 17;
                            crystalContent.doItTextField.x = 20;
                            minWidth = crystalContent.doItTextField.x + crystalContent.doItTextField.textWidth;
                            if (crystalContent.bounds.width < minWidth)
                            {
                                crystalContent.bounds.width = minWidth;
                                crystalContent.dispatchEvent(new HeaderEvents(HeaderEvents.HBC_SIZE_UPDATED, crystalContent.bounds.width, XfwUtils.getPrivateField(crystalContent, "xfw_leftPadding"), XfwUtils.getPrivateField(crystalContent, "xfw_rightPadding")));
                            }
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

        private function onCrystalLockerSwitched(e:Event):void
        {
            Xfw.cmd(XVM_LIMITS_COMMAND_SET_CRYSTAL_LOCK_STATUS, crystalLocker.selected);
            Xfw.cmd(XvmCommands.SAVE_SETTINGS, SETTINGS_CRYSTAL_LOCK_STATUS, crystalLocker.selected);
            crystalLocker.toolTip = Locale.get(crystalLocker.selected ? L10N_CRYSTAL_LOCKED_TOOLTIP : L10N_CRYSTAL_UNLOCKED_TOOLTIP);
        }
    }
}
