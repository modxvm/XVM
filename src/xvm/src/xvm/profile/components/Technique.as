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

        // PRIVATE FIELDS

        private var _disposed:Boolean = false;
        private var _waitForInitDoneTimeoutId:uint = 0;
        private var _initializeTechniqueStatisticTab:uint = 0;
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
                    // override renderers
                    page.listComponent.sortableButtonBar.itemRendererName = getQualifiedClassName(UI_ProfileSortingButton);
                    page.listComponent.techniqueList.itemRenderer = UI_TechniqueRenderer;

                    // add event handlers
                    page.listComponent.techniqueList.addEventListener(TechniqueList.SELECTED_DATA_CHANGED, listSelectedDataChanged);

                    Dossier.requestAccountDossier(null, null, PROFILE.PROFILE_DROPDOWN_LABELS_ALL, playerId);

                    waitForInitDone();
                }

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

        public function dispose():void
        {
            _disposed = true;
            if (_waitForInitDoneTimeoutId != 0)
            {
               clearTimeout(_waitForInitDoneTimeoutId);
               _waitForInitDoneTimeoutId = 0;
            }
            if (_initializeTechniqueStatisticTab != 0)
            {
               clearTimeout(_initializeTechniqueStatisticTab);
               _initializeTechniqueStatisticTab = 0;
            }
            App.utils.scheduler.cancelTask(startLoadStat);
            App.utils.scheduler.cancelTask(makeInitialSort);
            App.utils.scheduler.cancelTask(selectFirstItem);
        }

        // DAAPI

        public function as_responseVehicleDossierXvm(data:VehicleDossier):void
        {
            //Logger.addObject(data, 1, "as_responseVehicleDossierXvm");
            page.listComponent.techniqueList.invalidateData();
            dispatchEvent(new ObjectEvent(EVENT_VEHICLE_DOSSIER_LOADED, data));
        }

        // PRIVATE

        // INITIALIZATION

        private function waitForInitDone(depth:int = 0):void
        {
            //Logger.add("waitForInitDone: " + playerName);
            try
            {
                _waitForInitDoneTimeoutId = 0;

                if (depth > 10)
                {
                    Logger.add("WARNING: profile technique page initialization timeout");
                    return;
                }

                var bb:SortableHeaderButtonBar = page.listComponent.sortableButtonBar;
                if (bb.dataProvider.length == 0)
                {
                    var $this:Technique = this;
                    _waitForInitDoneTimeoutId = setTimeout(function():void { $this.waitForInitDone(depth + 1); }, 1);
                    return;
                }

                // Setup header
                setupHeader();
                // Load stat
                App.utils.scheduler.envokeInNextFrame(startLoadStat);

                // Focus filter
                //if (filter != null && filter.visible && Config.config.userInfo.filterFocused == true)
                //    filter.setFocus();
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

        private function startLoadStat():void
        {
            Stat.loadUserData(this, onStatLoaded, playerName, false);
        }

        private function onStatLoaded():void
        {
            //Logger.add("onStatLoaded: " + playerName);

            try
            {
                if (_disposed)
                    return;
                var vehicles:Array = page.listComponent.techniqueList.dataProvider as Array;
                for each (var data:TechniqueListVehicleVO in vehicles)
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

                page.listComponent.vehicles = vehicles;
                page.listComponent.dispatchEvent(new Event(TechniqueListComponent.DATA_CHANGED));
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function initializeTechniqueStatisticTab(depth:int = 0):void
        {
            //Logger.add("initializeTechniqueStatisticTab: " + playerName);
            try
            {
                _initializeTechniqueStatisticTab = 0;

                if (depth > 10)
                {
                    Logger.add("WARNING: profile technique statistic tab initialization timeout");
                    return;
                }

                var data:Array = page.stackComponent.buttonBar.dataProvider as Array;
                if (data == null || data.length == 0 || !(data[0].hasOwnProperty("linkage")))
                {
                    var $this:Technique = this;
                    _initializeTechniqueStatisticTab = setTimeout(function():void { $this.initializeTechniqueStatisticTab(depth + 1); }, 1);
                    return;
                }

                App.utils.scheduler.envokeInNextFrame(makeInitialSort);

                data[0].linkage = getQualifiedClassName(UI_TechniqueStatisticTab);
                page.stackComponent.buttonBar.selectedIndex = -1;
                page.stackComponent.buttonBar.selectedIndex = 0;
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // Initial sort
        // TODO: save sort order to userprofile
        private function makeInitialSort():void
        {
            var idx:int = Math.abs(Config.config.userInfo.sortColumn) - 1;
            var bb:SortableHeaderButtonBar = page.listComponent.sortableButtonBar;
            if (bb.dataProvider.length > 8)
                idx = idx == 7 ? 8 : idx == 8 ? 7 : idx; // swap 8 and 9 positions (mastery and xTE columns)
            if (idx > bb.dataProvider.length - 1)
                idx = 5;
            bb.selectedIndex = idx;
            var bi:NormalSortingBtnInfo = bb.dataProvider[idx] as NormalSortingBtnInfo;
            page.listComponent.techniqueList.sortByField(bi.iconId, Config.config.userInfo.sortColumn > 0);
            App.utils.scheduler.envokeInNextFrame(selectFirstItem);
        }

        private function selectFirstItem():void
        {
            page.listComponent.techniqueList.selectedIndex = 0;
        }

        // virtual
        //protected function createFilters():void
        //{
            //filter = new FilterControl();
            //filter.addEventListener(Event.CHANGE, applyFilter);
            //page.addChild(filter);
        //}

        // EVENT HANDLERS

        private var _techniqueStatisticTabInitialized:Boolean = false;
        private function listSelectedDataChanged(e:Event):void
        {
            //Logger.add("listSelectedDataChanged");

            if (_techniqueStatisticTabInitialized == false)
            {
                _techniqueStatisticTabInitialized = true;
                initializeTechniqueStatisticTab();
            }
        }
    }
}
