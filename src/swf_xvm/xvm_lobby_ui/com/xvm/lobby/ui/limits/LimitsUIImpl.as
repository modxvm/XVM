/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ui.limits
{
    import com.xfw.*;
    import com.xfw.XfwAccess;
    import com.xvm.*;
    import com.xvm.lobby.limits.*;
    import com.xvm.lobby.ui.limits.controls.*;
    import flash.events.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.lobby.*;
    CLIENT::LESTA {
        import net.wg.gui.lobby.header.vo.*;
    }
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

        CLIENT::LESTA {
            private var _processed:Boolean = false;
        }

        private var crystalLocker:LockerControl = null;
        private var goldLocker:LockerControl = null;
        private var freeXpLocker:LockerControl = null;

        private var _disposed:Boolean = false;

        public function LimitsUIImpl()
        {
            //Logger.add("LimitsUIImpl");
        }

        // ILimitsUI implementation

        public function init(page:LobbyPage):void
        {
            this.page = page;
            var headerButtonsHelper:HeaderButtonsHelper = XfwAccess.getPrivateField(page.header, "_headerButtonsHelper");

            if (Config.config.hangar.enableCrystalLocker)
            {
                crystalLocker = page.header.addChild(new LockerControl()) as LockerControl;
                crystalLocker.name = CURRENCIES_CONSTANTS.CRYSTAL;
                crystalLocker.addEventListener(Event.SELECT, onCrystalLockerSwitched, false, 0, true);
                CLIENT::LESTA {
                    crystalLocker.addEventListener(MouseEvent.ROLL_OVER, onLockerMouseRollOver, false, 0, true);
                    crystalLocker.addEventListener(MouseEvent.ROLL_OUT, onLockerMouseRollOut, false, 0, true);
                }
                crystalLocker.toolTip = Locale.get(L10N_CRYSTAL_UNLOCKED_TOOLTIP);
                crystalLocker.selected = Xfw.cmd(XvmCommands.LOAD_SETTINGS, SETTINGS_CRYSTAL_LOCK_STATUS, false);
                crystalLocker.visible = false;
            }

            if (Config.config.hangar.enableGoldLocker)
            {
                goldLocker = page.header.addChild(new LockerControl()) as LockerControl;
                goldLocker.name = CURRENCIES_CONSTANTS.GOLD;
                goldLocker.addEventListener(Event.SELECT, onGoldLockerSwitched, false, 0, true);
                CLIENT::LESTA {
                    goldLocker.addEventListener(MouseEvent.ROLL_OVER, onLockerMouseRollOver, false, 0, true);
                    goldLocker.addEventListener(MouseEvent.ROLL_OUT, onLockerMouseRollOut, false, 0, true);
                }
                goldLocker.toolTip = Locale.get(L10N_GOLD_UNLOCKED_TOOLTIP);
                goldLocker.selected = Xfw.cmd(XvmCommands.LOAD_SETTINGS, SETTINGS_GOLD_LOCK_STATUS, false);
                goldLocker.visible = false;
            }

            if (Config.config.hangar.enableFreeXpLocker)
            {
                freeXpLocker = page.header.addChild(new LockerControl()) as LockerControl;
                freeXpLocker.name = CURRENCIES_CONSTANTS.FREE_XP;
                freeXpLocker.addEventListener(Event.SELECT, onFreeXpLockerSwitched, false, 0, true);
                CLIENT::LESTA {
                    freeXpLocker.addEventListener(MouseEvent.ROLL_OVER, onLockerMouseRollOver, false, 0, true);
                    freeXpLocker.addEventListener(MouseEvent.ROLL_OUT, onLockerMouseRollOut, false, 0, true);
                }
                freeXpLocker.toolTip = Locale.get(L10N_FREEXP_UNLOCKED_TOOLTIP);
                freeXpLocker.selected = Xfw.cmd(XvmCommands.LOAD_SETTINGS, SETTINGS_FREEXP_LOCK_STATUS, false);
                freeXpLocker.visible = false;
            }

            page.header.headerButtonBar.addEventListener(HeaderEvents.HEADER_ITEMS_REPOSITION, this.onHeaderButtonsReposition, false, 0, true);
        }

        public function dispose():void
        {
            var headerButtonsHelper:HeaderButtonsHelper = XfwAccess.getPrivateField(page.header, "_headerButtonsHelper");

            if (crystalLocker)
            {
                CLIENT::LESTA {
                    var crystalControl:HeaderButton = headerButtonsHelper.searchButtonById(CURRENCIES_CONSTANTS.CRYSTAL);
                    if (crystalControl)
                    {
                        crystalControl.removeEventListener(MouseEvent.ROLL_OVER, onControlMouseRollOver);
                        crystalControl.removeEventListener(MouseEvent.ROLL_OUT, onControlMouseRollOut);
                    }

                    goldLocker.removeEventListener(MouseEvent.ROLL_OVER, onLockerMouseRollOver);
                    goldLocker.removeEventListener(MouseEvent.ROLL_OUT, onLockerMouseRollOut);
                }
                crystalLocker.removeEventListener(Event.SELECT, onCrystalLockerSwitched);
                crystalLocker.dispose();
                crystalLocker = null;
            }

            if (goldLocker)
            {
                CLIENT::LESTA {
                    var goldControl:HeaderButton = headerButtonsHelper.searchButtonById(CURRENCIES_CONSTANTS.GOLD);
                    if (goldControl)
                    {
                        goldControl.removeEventListener(MouseEvent.ROLL_OVER, onControlMouseRollOver);
                        goldControl.removeEventListener(MouseEvent.ROLL_OUT, onControlMouseRollOut);
                    }

                    crystalLocker.removeEventListener(MouseEvent.ROLL_OVER, onLockerMouseRollOver);
                    crystalLocker.removeEventListener(MouseEvent.ROLL_OUT, onLockerMouseRollOut);
                }
                goldLocker.removeEventListener(Event.SELECT, onGoldLockerSwitched);
                goldLocker.dispose();
                goldLocker = null;
            }

            if (freeXpLocker)
            {
                CLIENT::LESTA {
                    var freeXpControl:HeaderButton = headerButtonsHelper.searchButtonById(CURRENCIES_CONSTANTS.FREE_XP);
                    if (freeXpControl)
                    {
                        freeXpControl.removeEventListener(MouseEvent.ROLL_OVER, onControlMouseRollOver);
                        freeXpControl.removeEventListener(MouseEvent.ROLL_OUT, onControlMouseRollOut);
                    }

                    freeXpLocker.removeEventListener(MouseEvent.ROLL_OVER, onLockerMouseRollOver);
                    freeXpLocker.removeEventListener(MouseEvent.ROLL_OUT, onLockerMouseRollOut);
                }
                freeXpLocker.removeEventListener(Event.SELECT, onFreeXpLockerSwitched);
                freeXpLocker.dispose();
                freeXpLocker = null;
            }

            _disposed = true;
        }

        public final function isDisposed(): Boolean
        {
            return _disposed;
        }

        // PRIVATE

        private function onHeaderButtonsReposition(e:HeaderEvents):void
        {
            try
            {
                var minWidth:int;
                var headerButtonsHelper:HeaderButtonsHelper = XfwAccess.getPrivateField(page.header, "_headerButtonsHelper");

                if (goldLocker)
                {
                    var goldControl:HeaderButton = headerButtonsHelper.searchButtonById(CURRENCIES_CONSTANTS.GOLD);
                    if (goldControl)
                    {
                        var goldContent:HBC_Finance = goldControl.content as HBC_Finance;
                        if (goldContent)
                        {
                            CLIENT::WG {
                                goldLocker.visible = true;
                            }
                            goldLocker.x = goldControl.x + goldContent.x + goldContent.moneyIconText.x + 3;
                            goldLocker.y = goldControl.y + goldContent.y + goldContent.moneyIconText.y + 17;
                            CLIENT::LESTA {
                                goldLocker.y -= 7;
                            }
                            goldContent.doItTextField.x = 20;
                            minWidth = goldContent.doItTextField.x + goldContent.doItTextField.textWidth;
                            if (goldContent.bounds.width < minWidth)
                            {
                                goldContent.bounds.width = minWidth;
                                goldContent.dispatchEvent(new HeaderEvents(HeaderEvents.HBC_SIZE_UPDATED, goldContent.bounds.width, XfwAccess.getPrivateField(goldContent, "leftPadding"), XfwAccess.getPrivateField(goldContent, "rightPadding")));
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
                            CLIENT::WG {
                                freeXpLocker.visible = true;
                            }
                            freeXpLocker.x = freeXpControl.x + freeXpContent.x + freeXpContent.moneyIconText.x + 3;
                            freeXpLocker.y = freeXpControl.y + freeXpContent.y + freeXpContent.moneyIconText.y + 17;
                            CLIENT::LESTA {
                                freeXpLocker.y -= 7;
                            }
                            freeXpContent.doItTextField.x = 20;
                            minWidth = freeXpContent.doItTextField.x + freeXpContent.doItTextField.textWidth;
                            if (freeXpContent.bounds.width < minWidth)
                            {
                                freeXpContent.bounds.width = minWidth;
                                freeXpContent.dispatchEvent(new HeaderEvents(HeaderEvents.HBC_SIZE_UPDATED, freeXpContent.bounds.width, XfwAccess.getPrivateField(freeXpContent, "leftPadding"), XfwAccess.getPrivateField(freeXpContent, "rightPadding")));
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
                            CLIENT::WG {
                                crystalLocker.visible = true;
                            }
                            crystalLocker.x = crystalControl.x + crystalContent.x + crystalContent.moneyIconText.x + 3;
                            crystalLocker.y = crystalControl.y + crystalContent.y + crystalContent.moneyIconText.y + 17;
                            CLIENT::LESTA {
                                crystalLocker.y -= 7;
                            }
                            crystalContent.doItTextField.x = 20;
                            minWidth = crystalContent.doItTextField.x + crystalContent.doItTextField.textWidth;
                            if (crystalContent.bounds.width < minWidth)
                            {
                                crystalContent.bounds.width = minWidth;
                                crystalContent.dispatchEvent(new HeaderEvents(HeaderEvents.HBC_SIZE_UPDATED, crystalContent.bounds.width, XfwAccess.getPrivateField(crystalContent, "leftPadding"), XfwAccess.getPrivateField(crystalContent, "rightPadding")));
                            }
                        }
                    }
                }

                CLIENT::LESTA {
                    processControls();
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        CLIENT::LESTA {
            private function processControls():void
            {
                if (_processed)
                    return;

                var headerButtonsHelper:HeaderButtonsHelper = XfwAccess.getPrivateField(page.header, "_headerButtonsHelper");

                if (crystalLocker)
                {
                    var crystalControl:HeaderButton = headerButtonsHelper.searchButtonById(CURRENCIES_CONSTANTS.CRYSTAL);
                    if (!crystalControl)
                        return;

                    crystalControl.addEventListener(MouseEvent.ROLL_OVER, onControlMouseRollOver);
                    crystalControl.addEventListener(MouseEvent.ROLL_OUT, onControlMouseRollOut);
                }

                if (goldLocker)
                {
                    var goldControl:HeaderButton = headerButtonsHelper.searchButtonById(CURRENCIES_CONSTANTS.GOLD);
                    if (!goldControl)
                        return;

                    goldControl.addEventListener(MouseEvent.ROLL_OVER, onControlMouseRollOver);
                    goldControl.addEventListener(MouseEvent.ROLL_OUT, onControlMouseRollOut);
                }

                if (freeXpLocker)
                {
                    var freeXpControl:HeaderButton = headerButtonsHelper.searchButtonById(CURRENCIES_CONSTANTS.FREE_XP);
                    if (!freeXpControl)
                        return;

                    freeXpControl.addEventListener(MouseEvent.ROLL_OVER, onControlMouseRollOver);
                    freeXpControl.addEventListener(MouseEvent.ROLL_OUT, onControlMouseRollOut);
                }

                _processed = true;
            }

            private function onControlMouseRollOver(e:MouseEvent):void
            {
                var button:HeaderButton = e.target as HeaderButton;
                var data:HeaderButtonVo = button.headerButtonData;
                var locker:LockerControl = page.header.getChildByName(data.id) as LockerControl;
                locker.visible = true;
            }

            private function onControlMouseRollOut(e:MouseEvent):void
            {
                var button:HeaderButton = e.target as HeaderButton;
                var data:HeaderButtonVo = button.headerButtonData;
                var locker:LockerControl = page.header.getChildByName(data.id) as LockerControl;
                locker.visible = false;
            }

            private function onLockerMouseRollOver(e:MouseEvent):void
            {
                var locker:LockerControl = e.target as LockerControl;
                var headerButtonsHelper:HeaderButtonsHelper = XfwAccess.getPrivateField(page.header, "_headerButtonsHelper");
                var button:HeaderButton = headerButtonsHelper.searchButtonById(locker.name);
                locker.visible = true;
                button.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
            }

            private function onLockerMouseRollOut(e:MouseEvent):void
            {
                var locker:LockerControl = e.target as LockerControl;
                var headerButtonsHelper:HeaderButtonsHelper = XfwAccess.getPrivateField(page.header, "_headerButtonsHelper");
                var button:HeaderButton = headerButtonsHelper.searchButtonById(locker.name);
                locker.visible = false;
                button.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));
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
