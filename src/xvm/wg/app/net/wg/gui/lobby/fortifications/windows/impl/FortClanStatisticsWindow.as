package net.wg.gui.lobby.fortifications.windows.impl
{
    import net.wg.infrastructure.base.meta.impl.FortClanStatisticsWindowMeta;
    import net.wg.infrastructure.base.meta.IFortClanStatisticsWindowMeta;
    import net.wg.gui.lobby.fortifications.cmp.clanStatistics.impl.SortieStatisticsForm;
    import net.wg.gui.lobby.fortifications.cmp.clanStatistics.impl.PeriodDefenceStatisticForm;
    import net.wg.gui.components.advanced.ContentTabBar;
    import flash.display.DisplayObject;
    import net.wg.gui.lobby.fortifications.data.ClanStatsVO;
    import flash.display.MovieClip;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.events.IndexEvent;
    import scaleform.clik.data.DataProvider;
    
    public class FortClanStatisticsWindow extends FortClanStatisticsWindowMeta implements IFortClanStatisticsWindowMeta
    {
        
        public function FortClanStatisticsWindow()
        {
            super();
            isModal = false;
            isCentered = true;
        }
        
        public var sortieForm:SortieStatisticsForm;
        
        public var periodDefenceForm:PeriodDefenceStatisticForm;
        
        public var tabs:ContentTabBar;
        
        private var tabsDependences:Vector.<DisplayObject> = null;
        
        private var model:ClanStatsVO;
        
        public var mcLineAsset:MovieClip;
        
        public function as_setData(param1:Object) : void
        {
            this.model = new ClanStatsVO(param1);
            invalidateData();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.tabs.visible = App.globalVarsMgr.isFortificationBattleAvailableS();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (this.model))
            {
                window.title = App.utils.locale.makeString(FORTIFICATIONS.FORTCLANSTATISTICSWINDOW_TITLE,{"clanName":this.model.clanName});
                this.sortieForm.model = this.model;
                if(App.globalVarsMgr.isFortificationBattleAvailableS())
                {
                    this.periodDefenceForm.model = this.model;
                }
            }
        }
        
        override protected function onDispose() : void
        {
            this.sortieForm.dispose();
            this.sortieForm = null;
            this.periodDefenceForm.dispose();
            this.periodDefenceForm = null;
            if(this.model)
            {
                this.model.dispose();
                this.model = null;
            }
            this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabChange);
            this.tabs.dispose();
            this.tabs = null;
            if(this.tabsDependences != null)
            {
                while(this.tabsDependences.length > 0)
                {
                    this.tabsDependences.pop();
                }
            }
            super.onDispose();
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            this.tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabChange);
            var _loc1_:Array = [{"label":FORTIFICATIONS.CLANSTATS_TABS_BUTTONLBL_SORTIE}];
            this.tabsDependences = new <DisplayObject>[this.sortieForm];
            var _loc2_:Boolean = App.globalVarsMgr.isFortificationBattleAvailableS();
            if(_loc2_)
            {
                _loc1_.push({"label":FORTIFICATIONS.CLANSTATS_TABS_BUTTONLBL_PERIODDEFENCE});
                this.tabsDependences.push(this.periodDefenceForm);
            }
            this.mcLineAsset.visible = _loc2_;
            this.tabs.dataProvider = new DataProvider(_loc1_);
        }
        
        private function updateCurrentTab() : void
        {
            var _loc1_:* = 0;
            while(_loc1_ < this.tabsDependences.length)
            {
                this.tabsDependences[_loc1_].visible = this.tabs.selectedIndex == _loc1_;
                _loc1_++;
            }
        }
        
        private function onTabChange(param1:IndexEvent) : void
        {
            if(initialized)
            {
                this.updateCurrentTab();
            }
        }
    }
}
