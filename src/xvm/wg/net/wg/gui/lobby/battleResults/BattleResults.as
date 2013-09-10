package net.wg.gui.lobby.battleResults 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.data.*;
    
    public class BattleResults extends net.wg.infrastructure.base.meta.impl.BattleResultsMeta implements net.wg.infrastructure.base.meta.IBattleResultsMeta
    {
        public function BattleResults()
        {
            super();
            showWindowBg = false;
            this.visible = false;
            isCentered = true;
            this.noResult.visible = false;
            return;
        }

        public function get data():Object
        {
            return this._data;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.noResult.text = BATTLE_RESULTS.NODATA;
            this.tabs_mc.addEventListener(flash.events.FocusEvent.FOCUS_IN, this.handleFocus);
            this.view_mc.addEventListener(net.wg.gui.events.ViewStackEvent.VIEW_CHANGED, this.handleView);
            this.tabs_mc.visible = false;
            this.line.visible = false;
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            as_showWaiting("", null);
            this.visible = true;
            window.title = MENU.FINALSTATISTIC_WINDOW_TITLE;
            window.getBackground().tabChildren = false;
            window.getBackground().tabEnabled = false;
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.tabs_mc.removeEventListener(flash.events.FocusEvent.FOCUS_IN, this.handleFocus);
            this.view_mc.removeEventListener(net.wg.gui.events.ViewStackEvent.VIEW_CHANGED, this.handleView);
            this.tabs_mc.dispose();
            this.view_mc.dispose();
            this._data = null;
            App.toolTipMgr.hide();
            return;
        }

        public function as_setData(arg1:Object):void
        {
            if (arg1) 
            {
                this._data = arg1;
                this.tabs_mc.dataProvider = new scaleform.clik.data.DataProvider([{"label":MENU.FINALSTATISTIC_TABS_COMMONSTATS, "linkage":"CommonStats"}, {"label":MENU.FINALSTATISTIC_TABS_TEAMSTATS, "linkage":"TeamStats"}, {"label":MENU.FINALSTATISTIC_TABS_DETAILSSTATS, "linkage":"DetailsStats"}]);
                this.tabs_mc.selectedIndex = 0;
                this.tabs_mc.validateNow();
                App.utils.focusHandler.setFocus(this.tabs_mc);
            }
            this._wasPopulated = true;
            as_hideWaiting();
            invalidate();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (this._wasPopulated) 
            {
                if (this._data) 
                {
                    this.tabs_mc.visible = true;
                    this.line.visible = true;
                    this.noResult.visible = false;
                }
                else 
                {
                    this.noResult.visible = true;
                }
                this._wasPopulated = false;
            }
            return;
        }

        internal function handleFocus(arg1:flash.events.FocusEvent):void
        {
            dispatchEvent(new net.wg.gui.events.FinalStatisticEvent(net.wg.gui.events.FinalStatisticEvent.HIDE_STATS_VIEW));
            return;
        }

        internal function handleView(arg1:net.wg.gui.events.ViewStackEvent):void
        {
            arg1.view.update(null);
            return;
        }

        public var tabs_mc:net.wg.gui.components.advanced.ButtonBarEx;

        public var view_mc:net.wg.gui.components.advanced.ViewStack;

        public var line:flash.display.Sprite;

        internal var _wasPopulated:Boolean=false;

        public var noResult:flash.text.TextField;

        internal var _data:Object=null;
    }
}
