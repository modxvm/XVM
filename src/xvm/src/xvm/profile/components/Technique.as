package xvm.profile.components
{
    import com.xvm.*;
    import com.xvm.misc.*;
    import com.xvm.types.dossier.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.gui.lobby.profile.pages.technique.*;
    import net.wg.gui.components.advanced.*;
    import scaleform.clik.events.*;
    import xvm.profile.UI.*;

    UI_TechniqueStatisticTab;

    public class Technique extends Sprite
    {
        protected var _page:ProfileTechnique;
        protected var _playerName:String;
        protected var _playerId:int;

        protected var filter:FilterControl;

        private var techniqueListAdjuster:TechniqueListAdjuster;

        public function Technique(page:ProfileTechnique, playerName:String):void
        {
            try
            {
                this.name = "xvm_extension";
                this._page = page;
                this._playerName = playerName;
                this._playerId = 0;

                // override renderer
                list.itemRenderer = UI_TechniqueRenderer;

                return;

                // Initialize TechniqueStatisticsTab
                list.addEventListener(TechniqueList.SELECTED_DATA_CHANGED, listSelectedDataChanged);

                // Add summary item to the first line of technique list
                techniqueListAdjuster = new TechniqueListAdjuster(page);

                // remove upper/lower shadow
                page.listComponent.upperShadow.visible = false;
                page.listComponent.lowerShadow.visible = false;

                // create filter controls
                filter = null;
                if (Config.config.userInfo.showFilters)
                    createFilters();

                // post init
                techniqueListAdjuster.addEventListener(Event.INIT, delayedInit);
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        public function get page():ProfileTechnique
        {
            return _page;
        }

        public function get playerName():String
        {
            return _playerName;
        }

        public function get playerId():int
        {
            return _playerId;
        }

        public function get accountDossier():AccountDossier
        {
            return Dossier.getAccountDossier(playerId);
        }

        private function listSelectedDataChanged():void
        {
            //Logger.add("listSelectedDataChanged: " + playerName);

            list.removeEventListener(TechniqueList.SELECTED_DATA_CHANGED, listSelectedDataChanged);

            initializeTechniqueStatisticTab();
        }

        private function initializeTechniqueStatisticTab():void
        {
            try
            {
                var data:Array = page.stackComponent.buttonBar.dataProvider as Array;
                if (data == null || data.length == 0 || !(data[0].hasOwnProperty("linkage")))
                {
                    App.utils.scheduler.envokeInNextFrame(initializeTechniqueStatisticTab);
                    return;
                }
                data[0].linkage = getQualifiedClassName(UI_TechniqueStatisticTab);
                page.stackComponent.buttonBar.selectedIndex = -1;
                page.stackComponent.buttonBar.selectedIndex = 0;
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function delayedInit():void
        {
            //Logger.add("delayedInit: " + playerName);
            try
            {
                // userInfo.sortColumn
                var bb:SortableHeaderButtonBar = page.listComponent.sortableButtonBar;
                var btnIndex:int = Math.abs(Config.config.userInfo.sortColumn) - 1;
                var b:SortingButton = bb.getButtonAt(btnIndex) as SortingButton;
                if (b == null)
                {
                    App.utils.scheduler.envokeInNextFrame(delayedInit);
                    return;
                }
                bb.selectedIndex = -1;
                bb.selectedIndex = btnIndex;
                b.sortDirection = Config.config.userInfo.sortColumn < 0 ? SortingButton.DESCENDING_SORT : SortingButton.ASCENDING_SORT;
                list.selectedIndex = 0;

                // Focus filter
                if (filter != null && filter.visible && Config.config.userInfo.filterFocused == true)
                    filter.setFocus();

                // stat
                if (Config.config.rating.showPlayersStatistics  && Config.config.rating.enableUserInfoStatistics)
                    Stat.loadUserData(this, onStatLoaded, playerName, false);
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        protected function get list():TechniqueList
        {
            return page.listComponent.techniqueList;
        }

        // virtual
        protected function createFilters():void
        {
            filter = new FilterControl();
            filter.addEventListener(Event.CHANGE, techniqueListAdjuster.applyFilter);
            page.addChild(filter);
        }

        // PRIVATE

        // STAT

        private function onStatLoaded():void
        {
            //Logger.add("onStatLoaded: " + playerName);
            if (page != null && page.listComponent != null && page.listComponent.visible)
            {
                if (page is ProfileTechniqueWindow && page.listComponent.selectedItem.id == 0)
                    page.listComponent.dispatchEvent(new Event(ListEvent.INDEX_CHANGE));
                else
                    page.listComponent.dispatchEvent(new Event(TechniqueListComponent.DATA_CHANGED));
            }
        }
    }
}
