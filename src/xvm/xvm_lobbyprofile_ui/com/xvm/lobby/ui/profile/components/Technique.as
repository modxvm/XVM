/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.ui.profile.components
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.*;
    import com.xvm.lobby.ui.profile.*;
    import com.xvm.types.dossier.*;
    import com.xvm.types.stat.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.events.*;
    import net.wg.gui.components.controls.SortableScrollingList;
    import net.wg.gui.components.controls.NormalSortingBtnVO;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.lobby.profile.pages.technique.*;
    import net.wg.gui.lobby.profile.pages.technique.data.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;

    public class Technique extends Sprite
    {
        // CONSTANTS

        private static const DEFAULT_SORTING_INVALID:String = "default_sorting_invalid";

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

        private var _accountDBID:int;
        public function get accountDBID():int
        {
            return _accountDBID;
        }

        public function get accountDossier():AccountDossier
        {
            return Dossier.getAccountDossier(accountDBID);
        }

        public function get currentData():Object
        {
            var p:UI_ProfileTechniquePage = page as UI_ProfileTechniquePage;
            if (p)
                return p.currentDataXvm;
            var w:UI_ProfileTechniqueWindow = page as UI_ProfileTechniqueWindow;
            if (w)
                return w.currentDataXvm;
            return null;
        }

        public function get battlesType():String
        {
            var p:UI_ProfileTechniquePage = page as UI_ProfileTechniquePage;
            if (p)
                return p.battlesTypeXvm;
            var w:UI_ProfileTechniqueWindow = page as UI_ProfileTechniqueWindow;
            if (w)
                return w.battlesTypeXvm;
            return null;
        }

        // PRIVATE FIELDS

        private var _disposed:Boolean = false;
        private var _selectedItemCD:Number = -1;
        private var _initialSortDone:Boolean = false;
        //protected var filter:FilterControl;

        // CTOR

        public function Technique(page:ProfileTechnique, playerName:String, accountDBID:int):void
        {
            try
            {
                this.name = "xvm_extension";
                this._page = page;
                this._playerName = playerName;
                this._accountDBID = accountDBID;

                // Change row height: 34 -> 32
                page.listComponent.techniqueList.rowHeight = 32;

                // remove upper/lower shadow
                page.listComponent.upperShadow.visible = false;
                page.listComponent.lowerShadow.visible = false;

                if (Config.networkServicesSettings.statAwards)
                {
                    Stat.instance.addEventListener(Stat.COMPLETE_USERDATA, onStatLoaded, false, 0, true);
                    Stat.loadUserData(playerName);

                    Dossier.requestAccountDossier(null, null, PROFILE_DROPDOWN_KEYS.ALL, accountDBID);

                    // override renderers
                    page.listComponent.sortableButtonBar.itemRendererName = getQualifiedClassName(UI_ProfileSortingButton);
                    page.listComponent.techniqueList.itemRenderer = UI_TechniqueRenderer;

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
            try
            {
                _disposed = true;
                App.utils.scheduler.cancelTask(makeInitialSort);
                App.utils.scheduler.cancelTask(makeSort);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        public function fixInitData(param1:Object):void
        {
            if (Config.networkServicesSettings.statAwards && Config.config.userInfo.showXTEColumn)
            {
                var bi:Object = {
                    id: "xvm_xte",
                    label: "xTE",
                    toolTip: "xvm_xte",
                    buttonWidth: 50,
                    sortOrder: 8,
                    defaultSortDirection: SortingInfo.DESCENDING_SORT,
                    ascendingIconSource: RES_ICONS.MAPS_ICONS_BUTTONS_TAB_SORT_BUTTON_ASCPROFILESORTARROW,
                    descendingIconSource: RES_ICONS.MAPS_ICONS_BUTTONS_TAB_SORT_BUTTON_DESCPROFILESORTARROW,
                    buttonHeight: 40,
                    enabled: true
                };

                var tableHeader:Array = param1.tableHeader;
                tableHeader[4].buttonWidth = 64; // BATTLES_COUNT,74
                tableHeader[5].buttonWidth = 64; // WINS_EFFICIENCY,74
                tableHeader[6].buttonWidth = 75; // AVG_EXPERIENCE,90
                tableHeader.push(tableHeader[7]);
                tableHeader[7] = bi;             // xvm_xte
                tableHeader[8].buttonWidth = 68; // MARK_OF_MASTERY,83
            }
        }

        public function applyData():void
        {
            makeInitialSort();
        }

        public function setSelectedVehicleIntCD(itemCD:Number):void
        {
            _selectedItemCD = itemCD;
        }


        // DAAPI

        public function as_responseVehicleDossierXvm(data:VehicleDossier):void
        {
            if (_disposed)
                return;

            try
            {
                //Logger.addObject(data, 1, "as_responseVehicleDossierXvm");
                page.listComponent.techniqueList.invalidateData();
                dispatchEvent(new ObjectEvent(EVENT_VEHICLE_DOSSIER_LOADED, data));
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // PRIVATE

        // filters

        // virtual
        //protected function createFilters():void
        //{
            //filter = new FilterControl();
            //filter.addEventListener(Event.CHANGE, applyFilter, false, 0, true);
            //page.addChild(filter);
        //}

        // Initial sort

        // TODO: save sort order to userprofile
        private function makeInitialSort():void
        {
            try
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
                var button:SortingButton = SortingButton(bb.getButtonAt(bb.selectedIndex));
                if (button == null)
                    return;
                button.sortDirection = Config.config.userInfo.sortColumn > 0 ? SortingInfo.ASCENDING_SORT : SortingInfo.DESCENDING_SORT;
                button.sortDirection = Config.config.userInfo.sortColumn > 0 ? SortingInfo.ASCENDING_SORT : SortingInfo.DESCENDING_SORT;
                page.listComponent.techniqueList.sortByField(button.id, Config.config.userInfo.sortColumn > 0);

                page.listComponent.techniqueList.validateNow();

                var dp:IDataProvider = page.listComponent.techniqueList.dataProvider;
                if (dp.length)
                {
                    var pg:ProfileTechniquePage = page as ProfileTechniquePage;
                    if (pg)
                    {
                        pg.as_setSelectedVehicleIntCD(_selectedItemCD);
                    }

                    var pw:ProfileTechniqueWindow = page as ProfileTechniqueWindow;
                    if (pw)
                    {
                        pw.listComponent.techniqueList.selectVehicleByIndex(0);
                    }
                }

                page.listComponent.techniqueList.sortByField(button.id, Config.config.userInfo.sortColumn > 0);

                _initialSortDone = true;
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function makeSort():void
        {
            try
            {
                var buttonBar:SortableHeaderButtonBar = page.listComponent.sortableButtonBar;
                var button:SortingButton = SortingButton(buttonBar.getButtonAt(buttonBar.selectedIndex));
                if (button.sortDirection != SortingInfo.WITHOUT_SORT)
                {
                    page.listComponent.techniqueList.sortByField(button.id, button.sortDirection == SortingInfo.ASCENDING_SORT);
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // stat

        private function onStatLoaded(e:ObjectEvent):void
        {
            //Logger.add("onStatLoaded: " + playerName);

            if (_disposed)
                return;

            if (e.result != playerName)
                return;

            try
            {
                for each (var data:Object in currentData)
                {
                    if (data == null)
                        continue;
                    var stat:StatData;
                    var vdata:Object;
                    if (data.xvm_xte < 0)
                    {
                        data.xvm_xte_flag |= 0x01;
                        stat = Stat.getUserDataById(accountDBID);
                        if (stat && stat.v)
                        {
                            vdata = stat.v[data.id];
                            if (vdata && !isNaN(vdata.xte) && vdata.xte > 0)
                                data.xvm_xte = vdata.xte;
                        }
                    }
                    if (data.xvm_xtdb < 0)
                    {
                        data.xvm_xtdb_flag |= 0x01;
                        stat = Stat.getUserDataById(accountDBID);
                        if (stat && stat.v)
                        {
                            vdata = stat.v[data.id];
                            if (vdata && !isNaN(vdata.xtdb) && vdata.xtdb > 0)
                                data.xvm_xtdb = vdata.xtdb;
                        }
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
