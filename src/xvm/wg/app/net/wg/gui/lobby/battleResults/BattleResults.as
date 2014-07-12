package net.wg.gui.lobby.battleResults
{
    import net.wg.infrastructure.base.meta.impl.BattleResultsMeta;
    import net.wg.infrastructure.base.meta.IBattleResultsMeta;
    import net.wg.gui.components.advanced.ButtonBarEx;
    import net.wg.gui.components.advanced.ViewStack;
    import flash.display.Sprite;
    import flash.text.TextField;
    import scaleform.clik.data.DataProvider;
    import flash.events.FocusEvent;
    import net.wg.gui.events.ViewStackEvent;
    import net.wg.infrastructure.events.FocusRequestEvent;
    import net.wg.gui.events.FinalStatisticEvent;
    
    public class BattleResults extends BattleResultsMeta implements IBattleResultsMeta
    {
        
        public function BattleResults() {
            this._clanEmblemCallbacks = {};
            super();
            showWindowBg = false;
            this.visible = false;
            isCentered = true;
            this.noResult.visible = false;
            addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onFocusRequestHandler,false,0,true);
        }
        
        public var tabs_mc:ButtonBarEx;
        
        public var view_mc:ViewStack;
        
        public var line:Sprite;
        
        public var noResult:TextField;
        
        private var _wasPopulated:Boolean = false;
        
        private var _data:Object = null;
        
        private var _clanEmblemCallbacks:Object;
        
        public function requestClanEmblem(param1:String, param2:Number, param3:Function) : void {
            this._clanEmblemCallbacks[param1] = param3;
            getClanEmblemS(param1,param2);
        }
        
        public function as_setData(param1:Object) : void {
            if(param1)
            {
                this._data = param1;
                this.tabs_mc.dataProvider = new DataProvider([{
                    "label":MENU.FINALSTATISTIC_TABS_COMMONSTATS,
                    "linkage":"CommonStats"
                },{
                "label":MENU.FINALSTATISTIC_TABS_TEAMSTATS,
                "linkage":"TeamStats"
            },{
            "label":MENU.FINALSTATISTIC_TABS_DETAILSSTATS,
            "linkage":"detailsStatsScrollPane"
        }]);
    this.tabs_mc.selectedIndex = 0;
    this.tabs_mc.validateNow();
    setFocus(this.tabs_mc);
}
this._wasPopulated = true;
as_hideWaiting();
invalidate();
}

public function as_setClanEmblem(param1:String, param2:String) : void {
var _loc3_:Function = null;
if(this._clanEmblemCallbacks.hasOwnProperty(param1))
{
    _loc3_ = this._clanEmblemCallbacks[param1];
    _loc3_.apply(null,[param1,param2]);
    delete this._clanEmblemCallbacks[param1];
}
}

public function get data() : Object {
return this._data;
}

override protected function configUI() : void {
super.configUI();
this.noResult.text = BATTLE_RESULTS.NODATA;
this.tabs_mc.addEventListener(FocusEvent.FOCUS_IN,this.handleFocus);
this.view_mc.addEventListener(ViewStackEvent.VIEW_CHANGED,this.handleView);
this.tabs_mc.visible = false;
this.line.visible = false;
}

override protected function onPopulate() : void {
super.onPopulate();
as_showWaiting("",null);
this.visible = true;
window.title = MENU.FINALSTATISTIC_WINDOW_TITLE;
window.getBackground().tabChildren = false;
window.getBackground().tabEnabled = false;
}

override protected function onDispose() : void {
var _loc1_:String = null;
removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onFocusRequestHandler);
for(_loc1_ in this._clanEmblemCallbacks)
{
    delete this._clanEmblemCallbacks[_loc1_];
}
this._clanEmblemCallbacks = null;
super.onDispose();
this.tabs_mc.removeEventListener(FocusEvent.FOCUS_IN,this.handleFocus);
this.view_mc.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.handleView);
this.tabs_mc.dispose();
this.view_mc.dispose();
this._data = null;
App.toolTipMgr.hide();
}

override protected function draw() : void {
super.draw();
if(this._wasPopulated)
{
    if(this._data)
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
}

private function onFocusRequestHandler(param1:FocusRequestEvent) : void {
setFocus(param1.focusContainer.getComponentForFocus());
}

private function handleFocus(param1:FocusEvent) : void {
dispatchEvent(new FinalStatisticEvent(FinalStatisticEvent.HIDE_STATS_VIEW));
}

private function handleView(param1:ViewStackEvent) : void {
param1.view.update(null);
}
}
}
