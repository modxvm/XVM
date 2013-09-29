package net.wg.gui.lobby.questsWindow 
{
    import flash.display.*;
    import net.wg.data.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.data.*;
    
    public class QuestsWindow extends net.wg.infrastructure.base.meta.impl.QuestsWindowMeta implements net.wg.infrastructure.base.meta.IQuestsWindowMeta
    {
        public function QuestsWindow()
        {
            super();
            showWindowBg = false;
            isCentered = true;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.view_mc.addEventListener(net.wg.gui.events.ViewStackEvent.VIEW_CHANGED, this.handleView);
            this.tabs_mc.dataProvider = new scaleform.clik.data.DataProvider([{"label":QUESTS.QUESTS_TABS_CURRENT, "linkage":"CurrentTab_UI"}, {"label":QUESTS.QUESTS_TABS_FUTURE, "linkage":"FutureTab_UI"}]);
            this.tabs_mc.selectedIndex = 0;
            this.tabs_mc.validateNow();
            App.utils.focusHandler.setFocus(this.tabs_mc);
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            window.title = QUESTS.QUESTS_TITLE;
            return;
        }

        protected override function onDispose():void
        {
            this.view_mc.removeEventListener(net.wg.gui.events.ViewStackEvent.VIEW_CHANGED, this.handleView);
            super.onDispose();
            App.toolTipMgr.hide();
            return;
        }

        internal function handleView(arg1:net.wg.gui.events.ViewStackEvent):void
        {
            if (arg1.linkage == "CurrentTab_UI" && !this._currentTabRegistered) 
            {
                registerFlashComponentS(net.wg.infrastructure.interfaces.IDAAPIModule(arg1.view), net.wg.data.Aliases.QUESTS_CURRENT_TAB);
                this._currentTabRegistered = true;
            }
            if (arg1.linkage == "FutureTab_UI" && !this._futureTabRegistered) 
            {
                registerFlashComponentS(net.wg.infrastructure.interfaces.IDAAPIModule(arg1.view), net.wg.data.Aliases.QUESTS_FUTURE_TAB);
                this._futureTabRegistered = true;
            }
            return;
        }

        protected override function draw():void
        {
            super.draw();
            return;
        }

        public var tabs_mc:net.wg.gui.components.advanced.ButtonBarEx;

        public var view_mc:net.wg.gui.components.advanced.ViewStack;

        public var line:flash.display.Sprite;

        internal var _currentTabRegistered:Boolean=false;

        internal var _futureTabRegistered:Boolean=false;
    }
}
