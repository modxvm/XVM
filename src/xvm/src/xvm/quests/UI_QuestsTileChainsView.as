package xvm.quests
{
    import com.xfw.*;
    import com.xfw.io.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.quests.data.*;
    import net.wg.gui.lobby.quests.data.questsTileChains.*;
    import net.wg.gui.lobby.quests.events.*;
    import org.idmedia.as3commons.util.*;

    public dynamic class UI_QuestsTileChainsView extends QuestsTileChainsViewUI
    {
        private static const SETTINGS_VERSION:String = "1.0";

        public function UI_QuestsTileChainsView()
        {
            //Logger.add("UI_QuestsTileChainsView");
            super();

            tasksScrollingList.addEventListener(ListEventEx.ITEM_CLICK, onListItemSelected);
        }

        override protected function onDispose():void
        {
            tasksScrollingList.removeEventListener(ListEventEx.ITEM_CLICK, onListItemSelected);
            super.onDispose();
        }

        override protected function configUI():void
        {
            try
            {
                super.configUI();
                taskFilters.hideCompletedTasks.y -= 18;
                createHideFullyCompletedTasksCheckBox();
                createHideUnavailableTasksCheckBox();
                setTimeout(function():void {
                    hideFullyCompletedTasks.x = taskFilters.hideCompletedTasks.x;
                    hideFullyCompletedTasks.visible = true;
                    hideUnavailableTasks.x = taskFilters.hideCompletedTasks.x;
                    hideUnavailableTasks.visible = true;
                }, 0);
                Cmd.loadSettings(this, restoreSettings, "questsTileChainsViewFilters");
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override protected function setHeaderData(param1:QuestsTileChainsViewVO):void
        {
            blockFiltersChangedEvent = true;
            super.setHeaderData(param1);
            blockFiltersChangedEvent = false;
        }

        override protected function updateTileData(data:QuestTileVO):void
        {
            //Logger.addObject(data);
            try
            {
                super.updateTileData(ApplyFilter(data));
                if (loadedSettings != null)
                {
                    var $this:* = this;
                    setTimeout(function():void { $this.applyLoadedSettings(); }, 1);
                }
                else
                {
                    saveSettings();
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override protected function updateChainProgress(param1:ChainProgressVO):void
        {
            //Logger.add("updateChainProgress: " + param1);
            super.updateChainProgress(param1);

            var $this:* = this;
            setTimeout(function():void { $this.updateChainProgressNextFrame(); }, 1);
        }

        // PRIVATE

        private var loadedSettings:Object = null;
        private var selectedId:Number = -1;
        private var hideFullyCompletedTasks:CheckBox;
        private var hideUnavailableTasks:CheckBox;
        private var blockFiltersChangedEvent:Boolean = false;

        private function onListItemSelected(e:ListEventEx) : void
        {
            selectedId = e.itemData.type == QuestTaskListRendererVO.TASK ? e.itemData.taskData.id : -1;
            //Logger.add("selectedId=" + selectedId);
        }

        private function createHideFullyCompletedTasksCheckBox():void
        {
            hideFullyCompletedTasks = App.utils.classFactory.getComponent("CheckBox", CheckBox);
            with (hideFullyCompletedTasks)
            {
                name = "hideFullyCompletedTasks";
                label = Locale.get("Hide with honors");
                autoSize = "left";
                x = taskFilters.hideCompletedTasks.x;
                y = taskFilters.hideCompletedTasks.y + 18;
                visible = false;
            }
            hideFullyCompletedTasks.addEventListener(Event.SELECT, onHideTasksChanged);
            taskFilters.addChild(hideFullyCompletedTasks);
        }

        private function createHideUnavailableTasksCheckBox():void
        {
            hideUnavailableTasks = App.utils.classFactory.getComponent("CheckBox", CheckBox);
            with (hideUnavailableTasks)
            {
                name = "hideUnavailableTasks";
                label = Locale.get("Hide unavailable");
                autoSize = "left";
                x = taskFilters.hideCompletedTasks.x;
                y = taskFilters.hideCompletedTasks.y + 36;
                visible = false;
            }
            hideUnavailableTasks.addEventListener(Event.SELECT, onHideTasksChanged);
            taskFilters.addChild(hideUnavailableTasks);
        }

        private function ApplyFilter(data:QuestTileVO):QuestTileVO
        {
            var fullCompleted:String = App.utils.locale.makeString("#quests:tileChainsView/taskType/fullCompleted/text");
            for each (var chain:QuestChainVO in data.chains)
            {
                var len:int = chain.tasks.length;
                for (var i:int = len - 1; i >= 0; --i)
                {
                    var task:QuestTaskVO = chain.tasks[i];
                    if (hideFullyCompletedTasks.selected && task.stateName.indexOf(">" + fullCompleted + "<") >= 0)
                    {
                        chain.tasks.splice(i, 1);
                    }
                    else if (hideUnavailableTasks.selected && StringUtils.contains(task.stateIconPath, "/notAvailableIcon."))
                    {
                        chain.tasks.splice(i, 1);
                    }
                    else
                    {
                        //Logger.addObject(task);
                    }
                }
            }

            return data;
        }

        private function onHideTasksChanged(param1:Event) : void
        {
            if (!blockFiltersChangedEvent)
            {
                taskFilters.dispatchEvent(new QuestsTileChainViewFiltersEvent(QuestsTileChainViewFiltersEvent.FILTERS_CHANGED));
            }
        }

        private function saveSettings():void
        {
            var settings:Object = {
                ver: SETTINGS_VERSION,
                vehicleTypeFilter: taskFilters.vehicleTypeFilter.selectedIndex,
                taskTypeFilter: taskFilters.taskTypeFilter.selectedIndex,
                hideCompletedTasks: taskFilters.hideCompletedTasks.selected,
                hideFullyCompletedTasks: this.hideFullyCompletedTasks.selected,
                hideUnavailableTasks: this.hideUnavailableTasks.selected
            };
            Cmd.saveSettings("questsTileChainsViewFilters", JSONx.stringify(settings));
        }

        private function restoreSettings(json_str:String):void
        {
            try
            {
                loadedSettings = (json_str == null || json_str == "") ? null : JSONx.parse(json_str);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function applyLoadedSettings():void
        {
            try
            {
                if (loadedSettings == null)
                    return;

                var selected:QuestTaskListRendererVO = tasksScrollingList.getSelectedVO() as QuestTaskListRendererVO;
                if (selected == null)
                    return;
                selectedId = selected.type == QuestTaskListRendererVO.TASK ? selected.taskData.id : -1;

                taskFilters.vehicleTypeFilter.selectedIndex = loadedSettings.vehicleTypeFilter;
                taskFilters.taskTypeFilter.selectedIndex = loadedSettings.taskTypeFilter;
                taskFilters.hideCompletedTasks.selected = loadedSettings.hideCompletedTasks;
                this.hideFullyCompletedTasks.selected = loadedSettings.hideFullyCompletedTasks;
                this.hideUnavailableTasks.selected = loadedSettings.hideUnavailableTasks;
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            finally
            {
                loadedSettings = null;
            }
        }

        private function updateChainProgressNextFrame():void
        {
            //Logger.add("id=" + selectedId);
            var idx:Number = 0;
            var item:QuestTaskListRendererVO = null;
            if (selectedId >= 0)
            {
                var len:int = tasksScrollingList.dataProvider.length;
                for (var i:int = 0; i < len; ++i)
                {
                    item = tasksScrollingList.dataProvider.requestItemAt(i) as QuestTaskListRendererVO;
                    if (item.type == QuestTaskListRendererVO.TASK && item.taskData.id == selectedId)
                    {
                        idx = i;
                        break;
                    }
                }
            }
            if (tasksScrollingList.selectedIndex != idx)
            {
                //Logger.add("idx=" + idx);
                tasksScrollingList.selectedIndex = idx;
                tasksScrollingList.dispatchEvent(new ListEventEx(ListEventEx.ITEM_CLICK, false, true, idx, -1, -1, tasksScrollingList.getRendererAt(idx), item));
            }
        }
    }
}
