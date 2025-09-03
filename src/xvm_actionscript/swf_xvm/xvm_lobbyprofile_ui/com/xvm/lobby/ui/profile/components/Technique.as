/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
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
    import flash.utils.*;
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.lobby.profile.pages.technique.*;
    import net.wg.gui.lobby.profile.pages.technique.data.*;

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

        // PRIVATE FIELDS

        private var _disposed:Boolean = false;
        private var _selectedItemCD:Number = -1;
        private var _vdossier:VehicleDossier = null;

        // CTOR

        public function Technique(page:ProfileTechnique, playerName:String, accountDBID:int):void
        {
            // https://ci.modxvm.com/sonarqube/coding_rules?open=flex%3AS1447&rule_key=flex%3AS1447
            _init(page, playerName, accountDBID);
        }

        private function _init(page:ProfileTechnique, playerName:String, accountDBID:int):void
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

            Dossier.requestAccountDossier(null, null, PROFILE_DROPDOWN_KEYS.ALL, accountDBID);

            page.listComponent.addEventListener(TechniqueListComponent.SELECTED_INDEX_CHANGED, onListComponentSelectedIndexChangedHandler, false, 0, true);

            // override renderers
            page.listComponent.sortableButtonBar.itemRendererName = getQualifiedClassName(UI_ProfileSortingButton);
            page.listComponent.techniqueList.itemRenderer = UI_TechniqueRenderer;

            if (Config.networkServicesSettings.statAwards)
            {
                Stat.instance.addEventListener(Stat.COMPLETE_USERDATA, onStatLoaded, false, 0, true);
                Stat.loadUserData(playerName);
            }
        }

        public function dispose():void
        {
            _disposed = true;
            page.listComponent.removeEventListener(TechniqueListComponent.SELECTED_INDEX_CHANGED, onListComponentSelectedIndexChangedHandler);
        }

        public function fixInitData(param1:Object):void
        {
            if (Config.networkServicesSettings.statAwards)
            {
                if (Config.config.userInfo.showXTEColumn)
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
        }

        public function setSelectedVehicleIntCD(itemCD:Number):void
        {
            _selectedItemCD = itemCD;
            //Logger.add("_selectedItemCD =" + _selectedItemCD);
        }

        // DAAPI

        public function as_responseVehicleDossierXvm(data:VehicleDossier):void
        {
            if (_disposed)
                return;

            //Logger.addObject(data, 1, "as_responseVehicleDossierXvm");
            _vdossier = data;
            page.listComponent.techniqueList.invalidateData();
            dispatchEvent(new ObjectEvent(EVENT_VEHICLE_DOSSIER_LOADED, data));
        }

        public function applyData(data:Object):void
        {
            //Logger.add("applyData=" + _selectedItemCD);
            page.listComponent.selectVehicleById(_selectedItemCD);
            if (_vdossier != null)
            {
                dispatchEvent(new ObjectEvent(EVENT_VEHICLE_DOSSIER_LOADED, _vdossier));
            }
        }

        public function fixStatData():void
        {
            if (_disposed)
                return;

            try
            {
                var stat:StatData = accountDBID == 0 ? Stat.getUserDataByName(playerName) : Stat.getUserDataById(accountDBID);
                if (stat)
                {
                    if (stat.vehicles)
                    {
                        for each (var data:Object in currentData)
                        {
                            if (data == null)
                                continue;
                            if (data.xvm_xte < 0)
                            {
                                var vdata:VData = stat.vehicles[data.id];
                                if (vdata)
                                {
                                    if (!isNaN(vdata.xte))
                                    {
                                        if (vdata.xte > 0)
                                        {
                                            data.xvm_xte = vdata.xte;
                                            if (vdata.b != data.battlesCount)
                                            {
                                                data.xvm_xte_flag |= 0x01;
                                            }
                                        }
                                    }
                                }
                            }
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

        // PRIVATE

        // stat

        private function onStatLoaded(e:ObjectEvent):void
        {
            //Logger.add("onStatLoaded: " + playerName + " " + e.result);

            if (_disposed)
                return;

            if (e.result != playerName)
                return;

            Stat.instance.removeEventListener(Stat.COMPLETE_USERDATA, onStatLoaded);

            fixStatData();
        }

        private function onListComponentSelectedIndexChangedHandler(e:Event):void
        {
            var data:TechniqueListVehicleVO = page.listComponent.getSelectedItem();
            //Logger.addObject(data, 2);
            if (data != null)
            {
                _selectedItemCD = data.id;
            }
        }
    }
}
