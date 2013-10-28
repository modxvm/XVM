package xvm.profile.components
{
    import com.xvm.*;
    import com.xvm.events.*;
    import com.xvm.l10n.Locale;
    import flash.events.*;
    import net.wg.data.gui_items.dossier.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.lobby.profile.pages.technique.*;
    import net.wg.gui.lobby.profile.pages.technique.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;

    // Add summary item to the first line of technique list
    public final class TechniqueListAdjuster extends EventDispatcher
    {
        private var page:ProfileTechnique;

        private var currentFilter:String = "";

        private var initialized:Boolean;
        private var updatingActive:Boolean;
        private var sortingActive:Boolean;
        private var selectedId:int;

        public function TechniqueListAdjuster(page:ProfileTechnique):void
        {
            this.page = page;

            initialized = false;
            updatingActive = false;
            sortingActive = false;
            selectedId = 0;

            list.addEventListener(TechniqueList.SELECTED_DATA_CHANGED, listSelectedDataChanged);
            page.listComponent.sortableButtonBar.addEventListener(SortingButton.SORT_DIRECTION_CHANGED, sortDirectionChanged);
            page.listComponent.addEventListener(ListEvent.INDEX_CHANGE, listComponentIndexChange);
        }

        // PUBLIC

        public function applyFilter(e:Event):void
        {
            currentFilter = (e.currentTarget as FilterControl).filter;
            App.utils.scheduler.cancelTask(applyFilterTimer);
            App.utils.scheduler.scheduleTask(applyFilterTimer, 500);
        }

        private function applyFilterTimer():void
        {
            Logger.add("applyFilter: " + currentFilter);
        }

        // PROPERTIES

        private function get list():TechniqueList
        {
            return page.listComponent.techniqueList;
        }

        private function get tech():Technique
        {
            return page.getChildByName("xvm_extension") as Technique;
        }

        // EVENT HANDLERS

        private function listSelectedDataChanged(e:Event):void
        {
            //Logger.add("listSelectedDataChanged");

            if (sortingActive || updatingActive)
                return;
            if (list.dataProvider == null || list.dataProvider.length <= 0)
                return;
            if (tech.accountDossier == null)
                return;

            try
            {
                updatingActive = true;

                addSummaryItem();

                if (!initialized)
                {
                    initialized = true;
                    selectedId = 0;
                    dispatchEvent(new Event(Event.INIT));
                }
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
                throw ex;
            }
            finally
            {
                updatingActive = false;
            }
        }

        private function sortDirectionChanged(e:Event):void
        {
            //Logger.add("sortDirectionChanged");
            e.stopImmediatePropagation(); // do not call original sorting
            sortList(e.target as SortingButton);
        }

        private function listComponentIndexChange(e:Event):void
        {
            //Logger.add("listComponentIndexChange");

            if (sortingActive)
                return;

            selectedId = list.selectedItem.id;
            //Logger.add("selectedId: " + selectedId);

            updateStackComponentButtonBar();
        }

        // PRIVATE

        private function addSummaryItem():void
        {
            //Logger.add("addSummaryItem");
            var data:Array = list.dataProvider as Array;
            if (data == null || data.length <= 0)
                return;
            if (getSummaryItemIndex() == -1)
            {
                list.validateNow();
                setList();
                data.unshift(summaryItem);
                sortList();
            }
        }

        private function updateStackComponentButtonBar():void
        {
            page.stackComponent.buttonBar.getButtonAt(1).visible = selectedId != 0;
            if (selectedId == 0)
                page.stackComponent.buttonBar.selectedIndex = 0;
        }

        private function setList():void
        {
            // TODO
        }

        private function sortList(btn:SortingButton = null):void
        {
            if (btn == null)
                btn = page.listComponent.sortableButtonBar.getButtonAt(page.listComponent.sortableButtonBar.selectedIndex) as SortingButton;
            if (btn.sortDirection == SortingButton.WITHOUT_SORT)
                return;
            if (sortingActive)
                return;

            try
            {
                sortingActive = true;

                //Logger.add("sort " + btn.id + " " + btn.sortDirection)

                var data:Array = list.dataProvider as Array;
                if (data == null || data.length <= 0)
                    return;

                var summaryItemIndex:int = getSummaryItemIndex();
                if (summaryItemIndex >= 0)
                    data.splice(summaryItemIndex, 1);

                TechniqueListSorting.sort(data, btn);

                data.unshift(summaryItem);

                list.invalidateData();
                list.validateNow();

                list.selectedIndex = 0;
                for (var i:int = 0; i < data.length; ++i)
                {
                    if (TechniqueListVehicleVO(data[i]).id == selectedId)
                    {
                        list.selectedIndex = i;
                        break;
                    }
                }
                //Logger.add("idx: " + list.selectedIndex + " id: " + selectedId)

                list.validateNow();

                list.dispatchEvent(new Event(TechniqueList.SELECTED_DATA_CHANGED));

                updateStackComponentButtonBar();
            }
            finally
            {
                sortingActive = false;
            }
        }

        private function getSummaryItemIndex():int
        {
            var dp:IDataProvider = list.dataProvider;
            if (dp != null)
            {
                for (var i:int = 0; i < dp.length; ++i)
                {
                    if (dp[i].id == 0)
                        return i;
                }
            }
            return -1;
        }

        private function get summaryItem():TechniqueListVehicleVO
        {
            var accountDossier:AccountDossier = tech.accountDossier;
            return new TechniqueListVehicleVO(
            {
                "id": 0,
                "level": 0,
                "markOfMastery": 0,
                "typeIndex": 0,
                "typeIconPath": "../maps/icons/filters/tanks/all.png",
                "tankIconPath": "../maps/icons/filters/empty.png",
                "nationIndex": -1,
                "userName": "",
                "shortUserName": Locale.get("Summary"),
                "isInHangar": true,
                "nationID": -1,
                "inventoryID": -1,
                "battlesCount": (accountDossier == null) ? 0 : accountDossier.getBattlesCount(),
                "winsEfficiency": (accountDossier == null) ? 0 : Math.round(accountDossier.getWinsEfficiency() * 100),
                "avgExperience": (accountDossier == null) ? "" : accountDossier.getAvgXPStr()
            });
        }
    }
}
