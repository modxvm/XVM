package xvm.profile.components
{
    import com.xvm.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.gui_items.dossier.*;
    import net.wg.gui.lobby.profile.pages.technique.*;
    import net.wg.gui.components.advanced.*;
    import xvm.profile.UI.*;

    UI_TechniqueStatisticTab;

    public class Technique extends Sprite
    {
        protected var _page:ProfileTechnique;
        protected var _playerName:String;
        protected var _accountDossier:AccountDossier;

        protected var filter:FilterControl;

        private var techniqueListAdjuster:TechniqueListAdjuster;

        public function Technique(page:ProfileTechnique, playerName:String):void
        {
            try
            {
                this._page = page;
                this._playerName = playerName;
                this._accountDossier = null;

                // override renderer
                list.itemRenderer = UI_TechniqueRenderer;

                // Add summary item to the first line of technique list
                techniqueListAdjuster = new TechniqueListAdjuster(page);

                // TODO: FIXIT: page.addEventListener(TechniquePageEvent.DATA_STATUS_CHANGED, viewChanged);

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

        public function get accountDossier():AccountDossier
        {
            return _accountDossier;
        }

        public function setAccountDossier(playerIdStr:String):void
        {
            if (_accountDossier == null)
            {
                _accountDossier = new AccountDossier(playerIdStr);
                page.listComponent.techniqueList.dispatchEvent(new Event(TechniqueList.SELECTED_DATA_CHANGED));
            }
        }

        private function delayedInit():void
        {
            //Logger.add("delayedInit");
            try
            {
                // userInfo.sortColumn
                var bb:SortableHeaderButtonBar = page.listComponent.sortableButtonBar;
                var btnIndex:int = Math.abs(Config.config.userInfo.sortColumn) - 1;
                bb.selectedIndex = -1;
                bb.selectedIndex = btnIndex;
                var b:SortingButton = bb.getButtonAt(btnIndex) as SortingButton;
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

        protected function viewChanged(e:Event):void
        {
            //page.removeEventListener(TechniquePageEvent.DATA_STATUS_CHANGED, viewChanged);

            try
            {
                var data:Array = page.stackComponent.buttonBar.dataProvider as Array;
                data[0].linkage = "xvm.UI.profileSections.UI_TechniqueStatisticTab";
                page.stackComponent.buttonBar.selectedIndex = -1;
                page.stackComponent.buttonBar.selectedIndex = 0;
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        // PRIVATE


        // STAT

        private function onStatLoaded():void
        {
            //Logger.add("onStatLoaded: " + playerName);
            page.listComponent.dispatchEvent(new Event(TechniqueListComponent.DATA_CHANGED));
        }
    }
}
