package xvm.hangar.components.Profile
{
    import flash.events.*;
    import scaleform.clik.data.DataProvider;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.lobby.profile.pages.summary.*;
    import net.wg.gui.lobby.profile.pages.technique.*;
    import com.xvm.*;
    import com.xvm.events.*;
    import com.xvm.l10n.Locale;

    // Add summary item to the first line of technique list
    public final class TechniqueListAdjuster
    {
        private var page:ProfileTechnique;
        private var summary:ProfileSummary;

        public function TechniqueListAdjuster(page:ProfileTechnique, summary:ProfileSummary):void
        {
            this.page = page;
            this.summary = summary;

            list.addEventListener(TechniqueList.SELECTED_DATA_CHANGED, listSelectedDataChanged);
            page.listComponent.addEventListener(ListEvent.INDEX_CHANGE, listComponentIndexChange);
            page.listComponent.sortableButtonBar.addEventListener(SortingButton.SORT_DIRECTION_CHANGED, sortDirectionChanged);
        }

        private function get list():TechniqueList
        {
            return page.listComponent.techniqueList;
        }

        private function listComponentIndexChange(e:Event):void
        {
            //Logger.add("listComponentIndexChange");
            //adjustSummaryItem();

            //page.stackComponent.buttonBar.getButtonAt(1).visible = list.selectedItem.id != -1;
            //if (list.selectedItem.id == -1)
            //    page.stackComponent.buttonBar.selectedIndex = 0;
                /*if (list.selectedIndex == idx)
                    list.selectedIndex = 0;
                else if (list.selectedIndex < idx)
                    list.selectedIndex++;*/
        }

        private function listSelectedDataChanged(e:Event):void
        {
            //Logger.add("listSelectedDataChanged");
            addSummaryItem();
            //if (getSummaryItemIndex() != 0)
            //    sortDirectionChanged(e);
        }

        private function sortDirectionChanged(e:Event):void
        {
            //Logger.add("sortDirectionChanged");
            e.stopImmediatePropagation(); // do not call original sorting
            sortList(e.target as SortingButton);
        }

        private function addSummaryItem():void
        {
            var data:Array = list.dataProvider as Array;
            if (data == null || data.length <= 0)
                return;
            if (getSummaryItemIndex() == -1)
            {
                data.unshift(summaryItem);
                list.validateNow();
            }
        }

        private function sortList(btn:SortingButton):void
        {
            var data:Array = list.dataProvider as Array;
            if (data == null || data.length <= 0)
                return;

            var selectedId:int = -1;
            var renderer:IListItemRenderer = list.getRendererAt(list.selectedIndex);
            if (renderer != null)
                selectedId = TechniqueListVehicleVO(data[list.selectedIndex]).id;

            var summaryItemIndex:int = getSummaryItemIndex();
            if (summaryItemIndex >= 0)
                data.splice(summaryItemIndex, 1);

            TechniqueListSorting.sort(data, btn);

            data.unshift(summaryItem);

            list.invalidateData();

            for (var i:int = 0; i < data.length; ++i)
            {
                if (TechniqueListVehicleVO(data[i]).id == selectedId)
                {
                    list.selectedIndex = i;
                    break;
                }
            }
        }

        private function getSummaryItemIndex():int
        {
            var dp:IDataProvider = list.dataProvider;
            if (dp != null)
            {
                for (var i:int = 0; i < dp.length; ++i)
                {
                    if (dp[i].id == -1)
                        return i;
                }
            }
            return -1;
        }

        private function get summaryItem():TechniqueListVehicleVO
        {
            return new TechniqueListVehicleVO(
            {
                "id": -1,
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
                "battlesCount": ProfileUtils.extractNumber(summary.tfTotalBattles.text),
                "winsEfficiency": ProfileUtils.extractNumber(summary.tfWins.text),
                "avgExperience": summary.tfAvgExperience.text
            });
        }
    }
}
