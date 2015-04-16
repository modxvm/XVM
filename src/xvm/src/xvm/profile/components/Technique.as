/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.profile.components
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.dossier.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.SortableScrollingList;
    import net.wg.gui.components.controls.NormalSortingBtnInfo;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.lobby.profile.pages.technique.*;
    import scaleform.clik.data.*;
    import xvm.profile.UI.*;

    public class Technique extends Sprite
    {
        // PROPERTIES

        private var _page:ProfileTechnique;
        public function get page():ProfileTechnique
        {
            return _page;
        }

        private var _playerName:String;
        public function get playerName():String
        {
            return _playerName;
        }

        private var _playerId:int;
        public function get playerId():int
        {
            return _playerId;
        }

        public function get accountDossier():AccountDossier
        {
            return Dossier.getAccountDossier(playerId);
        }

        // PRIVATE FIELDS

        //protected var filter:FilterControl;
        //private var techniqueListAdjuster:TechniqueListAdjuster;

        // CTOR

        public function Technique(page:ProfileTechnique, playerName:String, playerId:int):void
        {
            try
            {
                this.name = "xvm_extension";
                this._page = page;
                this._playerName = playerName;
                this._playerId = playerId;

                // Change row height: 34 -> 32
                page.listComponent.techniqueList.rowHeight = 32;

                // remove upper/lower shadow
                page.listComponent.upperShadow.visible = false;
                page.listComponent.lowerShadow.visible = false;

                // override renderers
                page.listComponent.sortableButtonBar.itemRendererName = getQualifiedClassName(UI_ProfileSortingButton);
                page.listComponent.techniqueList.itemRenderer = UI_TechniqueRenderer;

                // Initialize TechniqueStatisticsTab
                page.listComponent.techniqueList.addEventListener(TechniqueList.SELECTED_DATA_CHANGED, initializeTechniqueStatisticTab);

                Dossier.loadAccountDossier(null, null, PROFILE.PROFILE_DROPDOWN_LABELS_ALL, playerId);

                waitForInitDone();

                // Add summary item to the first line of technique list
                //techniqueListAdjuster = new TechniqueListAdjuster(page);

                // create filter controls
                //filter = null;
                //if (Config.config.userInfo.showFilters)
                //    createFilters();

            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // PRIVATE

        private function waitForInitDone(depth:int = 0):void
        {
            Logger.add("waitForInitDone: " + playerName);

            try
            {
                if (depth > 10)
                {
                    Logger.add("WARNING: profile technique page initialization timeout");
                    return;
                }

                if (page.listComponent.sortableButtonBar.dataProvider.length == 0)
                {
                    var $this:Technique = this;
                    setTimeout(function():void { $this.waitForInitDone(depth + 1); }, 1);
                    return;
                }

                // Setup header
                if (Config.networkServicesSettings.statAwards)
                    setupHeader();

                waitForSortingDone();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function waitForSortingDone(depth:int = 0):void
        {
            Logger.add("waitForSortingDone: " + playerName);

            try
            {
                if (depth > 10)
                {
                    Logger.add("WARNING: profile technique page sorting timeout");
                    return;
                }

                // userInfo.sortColumn
                var bb:SortableHeaderButtonBar = page.listComponent.sortableButtonBar;
                var b:SortingButton = bb.getButtonAt(0) as SortingButton;
                if (b == null)
                {
                    var $this:Technique = this;
                    setTimeout(function():void { $this.waitForSortingDone(depth + 1); }, 1);
                    return;
                }

                // Apply sorting
                bb.selectedIndex = -1;
                bb.selectedIndex = Math.abs(Config.config.userInfo.sortColumn) - 1;
                b.sortDirection = Config.config.userInfo.sortColumn < 0 ? SortingInfo.DESCENDING_SORT : SortingInfo.ASCENDING_SORT;
                page.listComponent.techniqueList.selectedIndex = 0;

                // Focus filter
                //if (filter != null && filter.visible && Config.config.userInfo.filterFocused == true)
                //    filter.setFocus();

                // stat
                if (Config.networkServicesSettings.statAwards)
                    Stat.loadUserData(this, onStatLoaded, playerName, false);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function initializeTechniqueStatisticTab():void
        {
            page.listComponent.techniqueList.removeEventListener(TechniqueList.SELECTED_DATA_CHANGED, initializeTechniqueStatisticTab);
            initializeTechniqueStatisticTab2();
        }

        private function initializeTechniqueStatisticTab2(depth:int = 0):void
        {
            Logger.add("initializeTechniqueStatisticTab: " + playerName);

            try
            {
                if (depth > 10)
                {
                    Logger.add("WARNING: profile technique statistic tab initialization timeout");
                    return;
                }

                var data:Array = page.stackComponent.buttonBar.dataProvider as Array;
                if (data == null || data.length == 0 || !(data[0].hasOwnProperty("linkage")))
                {
                    var $this:Technique = this;
                    setTimeout(function():void { $this.initializeTechniqueStatisticTab2(depth + 1); }, 1);
                    return;
                }
                data[0].linkage = getQualifiedClassName(UI_TechniqueStatisticTab);
                page.stackComponent.buttonBar.selectedIndex = -1;
                page.stackComponent.buttonBar.selectedIndex = 0;
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function setupHeader():void
        {
            var bi:NormalSortingBtnInfo = new NormalSortingBtnInfo();
            bi.buttonWidth = 50;
            bi.sortOrder = 8;
            bi.toolTip = "xvm_xte";
            bi.iconId = "";
            bi.defaultSortDirection = SortingInfo.DESCENDING_SORT;
            bi.ascendingIconSource = RES_ICONS.MAPS_ICONS_BUTTONS_TAB_SORT_BUTTON_ASCPROFILESORTARROW;
            bi.descendingIconSource = RES_ICONS.MAPS_ICONS_BUTTONS_TAB_SORT_BUTTON_DESCPROFILESORTARROW;
            bi.buttonHeight = 40;
            bi.enabled = true;
            bi.label = "xTE";

            var dp:Array = page.listComponent.sortableButtonBar.dataProvider as Array;
            dp[4].buttonWidth = 64; // BATTLES_COUNT,74
            dp[5].buttonWidth = 64; // WINS_EFFICIENCY,74
            dp[6].buttonWidth = 75; // AVG_EXPERIENCE,90
            dp.push(dp[7]);
            dp[7] = bi;             // xvm_xte
            dp[8].buttonWidth = 68; // MARK_OF_MASTERY,83

            page.listComponent.sortableButtonBar.dataProvider = new DataProvider(dp);
            page.listComponent.techniqueList.columnsData = page.listComponent.sortableButtonBar.dataProvider;
        }

        private function onStatLoaded():void
        {
            //Logger.add("onStatLoaded: " + playerName);
            page.listComponent.dispatchEvent(new Event(TechniqueListComponent.DATA_CHANGED));
        }

        // virtual
        //protected function createFilters():void
        //{
            //filter = new FilterControl();
            //filter.addEventListener(Event.CHANGE, techniqueListAdjuster.applyFilter);
            //page.addChild(filter);
        //}
    }
}
