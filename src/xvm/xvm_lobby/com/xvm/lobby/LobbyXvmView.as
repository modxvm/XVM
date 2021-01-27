/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import net.wg.gui.lobby.*;
    import net.wg.gui.lobby.header.headerButtonBar.HeaderButtonsHelper;
    import net.wg.gui.lobby.header.headerButtonBar.*;
    import net.wg.gui.lobby.header.vo.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;

    public class LobbyXvmView extends XvmViewBase
    {
        public function LobbyXvmView(view:IView)
        {
            super(view);
        }

        public function get page():LobbyPage
        {
            return super.view as LobbyPage;
        }

        override public function onBeforePopulate(e:LifeCycleEvent):void
        {
            super.onBeforePopulate(e);
            Config.setNetworkServicesSettings(new NetworkServicesSettings(Xfw.cmd(XvmCommands.GET_SVC_SETTINGS)));
        }

        override public function onAfterPopulate(e:LifeCycleEvent):void
        {
            super.onAfterPopulate(e);
            setup();
            page.header.addEventListener(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE, onGraphicsRectanglesUpdateHandler);
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            page.header.removeEventListener(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE, onGraphicsRectanglesUpdateHandler);
            super.onBeforeDispose(e);
        }

        override public function onConfigLoaded(e:Event):void
        {
            super.onConfigLoaded(e);
            setup();
        }

        // PRIVATE

        public function setup():void
        {
            setupServerInfo();
            setupHeaderButtons();
        }

        // server info

        private var _orig_onlineCounter_x:Number = NaN;
        private var _orig_onlineCounter_y:Number = NaN;
        private function setupServerInfo():void
        {
            var cfg:CHangarElement = Config.config.hangar.serverInfo;
            if (!cfg.enabled)
            {
                page.header.onlineCounter.mouseEnabled = false;
                page.header.onlineCounter.mouseChildren = false;
                page.header.onlineCounter.alpha = 0;
            }
            else
            {
                page.header.onlineCounter.mouseEnabled = true;
                page.header.onlineCounter.mouseChildren = true;
                if (isNaN(_orig_onlineCounter_x))
                {
                    _orig_onlineCounter_x = page.header.onlineCounter.x;
                    _orig_onlineCounter_y = page.header.onlineCounter.y;
                }
                page.header.onlineCounter.x = _orig_onlineCounter_x + cfg.offsetX;
                page.header.onlineCounter.y = _orig_onlineCounter_y + cfg.offsetY;
                page.header.onlineCounter.alpha = cfg.alpha / 100.0;
                page.header.onlineCounter.rotation = cfg.rotation;
            }
        }

        // prem and premShop buttons

        private function setupHeaderButtons():void
        {
            App.utils.scheduler.scheduleOnNextFrame(function():void
            {
                onGraphicsRectanglesUpdateHandler(null);

                var btn:HeaderButton;
				
				var headerButtonsHelper:HeaderButtonsHelper = XfwUtils.getPrivateField(page.header, "xfw_headerButtonsHelper");

                btn = XfwUtils.getPrivateField(headerButtonsHelper, 'xfw_searchButtonById')(HeaderButtonsHelper.ITEM_ID_PREM);
                if (btn)
                {
                    btn.mouseEnabled = Config.config.hangar.showBuyPremiumButton;
                    btn.mouseChildren = Config.config.hangar.showBuyPremiumButton;
                    btn.alpha = Config.config.hangar.showBuyPremiumButton ? 1 : 0;
                }

                btn = XfwUtils.getPrivateField(headerButtonsHelper, 'xfw_searchButtonById')(HeaderButtonsHelper.ITEM_ID_PREMSHOP);
                if (btn)
                {
                    btn.mouseEnabled = Config.config.hangar.showPremiumShopButton;
                    btn.mouseChildren = Config.config.hangar.showPremiumShopButton;
                    btn.alpha = Config.config.hangar.showPremiumShopButton ? 1 : 0;
                }

                btn = XfwUtils.getPrivateField(headerButtonsHelper, 'xfw_searchButtonById')(HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR);
                if (btn)
                {
                    btn.headerButtonData.isUseFreeSize = false;
                }
            });
        }

        private function onGraphicsRectanglesUpdateHandler(e:Event):void
        {
            var btn:HeaderButton;

			var headerButtonsHelper:HeaderButtonsHelper = XfwUtils.getPrivateField(page.header, "xfw_headerButtonsHelper");

            if (!Config.config.hangar.showCreateSquadButtonText)
            {
                btn = XfwUtils.getPrivateField(headerButtonsHelper, 'xfw_searchButtonById')(HeaderButtonsHelper.ITEM_ID_SQUAD);
                if (btn)
                {
                    var ctxSquad:HBC_Squad = btn.content as HBC_Squad;
                    ctxSquad.wideScreenPrc = 0;
                }
            }

            if (!Config.config.hangar.showBattleTypeSelectorText)
            {
                btn = XfwUtils.getPrivateField(headerButtonsHelper, 'xfw_searchButtonById')(HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR);
                if (btn)
                {
                    var ctxBattleSelector:HBC_BattleSelector = btn.content as HBC_BattleSelector;
                    ctxBattleSelector.wideScreenPrc = 0;
                    ctxBattleSelector.availableWidth = 0;
                }
            }
        }
    }
}
