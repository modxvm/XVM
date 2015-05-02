/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.profile.components
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.*;
    import com.xvm.types.dossier.*;
    import com.xvm.types.stat.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.gui.events.*;
    import net.wg.gui.components.controls.SortableScrollingList;
    import net.wg.gui.components.controls.NormalSortingBtnInfo;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.lobby.profile.pages.technique.*;
    import net.wg.gui.lobby.profile.pages.technique.data.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import xvm.profile.UI.*;

    public class Technique extends Sprite
    {
        // CONSTANTS

        public static const EVENT_VEHICLE_DOSSIER_LOADED:String = "vehicle_dossier_loaded";

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

        public function get currentData():Object
        {
            var p:UI_ProfileTechniquePage = page as UI_ProfileTechniquePage;
            if (p != null)
                return p.currentDataXvm;
            var w:UI_ProfileTechniqueWindow = page as UI_ProfileTechniqueWindow;
            if (w != null)
                return w.currentDataXvm;
            return null;
        }

        public function get battlesType():String
        {
            var p:UI_ProfileTechniquePage = page as UI_ProfileTechniquePage;
            if (p != null)
                return p.battlesTypeXvm;
            var w:UI_ProfileTechniqueWindow = page as UI_ProfileTechniqueWindow;
            if (w != null)
                return w.battlesTypeXvm;
            return null;
        }

        // PRIVATE FIELDS

        private var _disposed:Boolean = false;
        //protected var filter:FilterControl;

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

                if (Config.networkServicesSettings.statAwards)
                {
                    Dossier.requestAccountDossier(null, null, PROFILE.PROFILE_DROPDOWN_LABELS_ALL, playerId);

                    // override renderers
                    page.listComponent.sortableButtonBar.itemRendererName = getQualifiedClassName(UI_ProfileSortingButton);
                    page.listComponent.techniqueList.itemRenderer = UI_TechniqueRenderer;

                    // add event handlers
                    page.listComponent.sortableButtonBar.addEventListener(IndexEvent.INDEX_CHANGE, initializeListComponent);
                    page.stackComponent.buttonBar.addEventListener(IndexEvent.INDEX_CHANGE, initializeTechniqueStatisticTab);

                    // create filter controls
                    //filter = null;
                    //if (Config.config.userInfo.showFilters)
                    //    createFilters();
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        public function dispose():void
        {
            _disposed = true;
            App.utils.scheduler.cancelTask(makeInitialSort);
        }

        // DAAPI

        public function as_responseDossierXvm(battlesType:String, vehicles:Object):void
        {
            if (_disposed)
                return;
            page.as_responseDossier(battlesType, vehicles);
            initializeListComponentVehicles();
        }

        public function as_responseVehicleDossierXvm(data:VehicleDossier):void
        {
            if (_disposed)
                return;
            //Logger.addObject(data, 1, "as_responseVehicleDossierXvm");
            page.listComponent.techniqueList.invalidateData();
            dispatchEvent(new ObjectEvent(EVENT_VEHICLE_DOSSIER_LOADED, data));
        }

        // PRIVATE

        // filters

        // virtual
        //protected function createFilters():void
        //{
            //filter = new FilterControl();
            //filter.addEventListener(Event.CHANGE, applyFilter);
            //page.addChild(filter);
        //}

        // stackComponent

        private function initializeTechniqueStatisticTab():void
        {
            //Logger.add("initializeTechniqueStatisticTab: " + playerName);
            if (_disposed)
                return;

            page.stackComponent.buttonBar.removeEventListener(IndexEvent.INDEX_CHANGE, initializeTechniqueStatisticTab);

            var data:Array = page.stackComponent.buttonBar.dataProvider as Array;
            data[0].linkage = getQualifiedClassName(UI_TechniqueStatisticTab);
        }

        // listComponent

        private function initializeListComponent():void
        {
            //Logger.add("initializeListComponent: " + playerName);
            try
            {
                page.listComponent.sortableButtonBar.removeEventListener(IndexEvent.INDEX_CHANGE, initializeListComponent);

                setupSortableButtonBar();

                // Sort
                App.utils.scheduler.envokeInNextFrame(makeInitialSort);

                // Focus filter
                //if (filter != null && filter.visible && Config.config.userInfo.filterFocused == true)
                //    filter.setFocus();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function initializeListComponentVehicles():void
        {
            //Logger.add("initializeListComponentVehicles: " + playerName);
            try
            {
                // Load stat
                Stat.loadUserData(this, onStatLoaded, playerName, false);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function setupSortableButtonBar():void
        {
            if (Config.config.userInfo.showXTEColumn)
            {
                var bi:NormalSortingBtnInfo = new NormalSortingBtnInfo();
                bi.buttonWidth = 50;
                bi.sortOrder = 8;
                bi.toolTip = "xvm_xte";
                bi.iconId = "xvm_xte";
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
        }

        // Initial sort

        // TODO: save sort order to userprofile
        private function makeInitialSort():void
        {
            var idx:int = Math.abs(Config.config.userInfo.sortColumn) - 1;
            var bb:SortableHeaderButtonBar = page.listComponent.sortableButtonBar;
            if (Config.config.userInfo.showXTEColumn)
            {
                if (bb.dataProvider.length > 8)
                    idx = idx == 7 ? 8 : idx == 8 ? 7 : idx; // swap 8 and 9 positions (mastery and xTE columns)
            }
            if (idx > bb.dataProvider.length - 1)
                idx = 5;
            bb.selectedIndex = idx;
            var bi:NormalSortingBtnInfo = bb.dataProvider[idx] as NormalSortingBtnInfo;
            page.listComponent.techniqueList.sortByField(bi.iconId, Config.config.userInfo.sortColumn > 0);
        }

        // stat

        private function onStatLoaded():void
        {
            //Logger.add("onStatLoaded: " + playerName);
            if (_disposed)
                return;

            try
            {
                for each (var data:Object in currentData)
                {
                    if (data == null || data.xvm_xte >= 0)
                        continue;
                    data.xvm_xte_flag |= 0x01;
                    var stat:StatData = Stat.getUserDataById(playerId);
                    if (stat != null && stat.v != null)
                    {
                        var vdata:Object = stat.v[data.id];
                        if (vdata != null && !isNaN(vdata.xte) && vdata.xte > 0)
                            data.xvm_xte = vdata.xte;
                    }
                }
                page.invalidate("ddInvalid");
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
