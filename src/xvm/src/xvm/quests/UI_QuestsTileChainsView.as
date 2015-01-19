package xvm.quests
{
    import com.xvm.*;
    import com.xvm.io.*;
    import flash.events.*;
    import net.wg.gui.components.controls.*;
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
        }

        override protected function configUI():void
        {
            try
            {
                super.configUI();
                taskFilters.hideCompletedTasks.y -= 18;
                createHideFullyCompletedTasksCheckBox();
                createHideNotAvailableTasksCheckBox();
                Cmd.loadSettings(this, restoreSettings, "questsTileChainsViewFilters");
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        override protected function updateTileData(data:QuestTileVO):void
        {
            //Logger.addObject(data);
            try
            {
                saveSettings();
                super.updateTileData(ApplyFilter(data));
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        override protected function setHeaderData(param1:QuestsTileChainsViewVO):void
        {
            blockFiltersChangedEvent = true;
            super.setHeaderData(param1);
            blockFiltersChangedEvent = false;
        }

        // PRIVATE

        private var hideFullyCompletedTasks:CheckBox;
        private var hideNotAvailableTasks:CheckBox;
        private var blockFiltersChangedEvent:Boolean = false;

        private function createHideFullyCompletedTasksCheckBox():void
        {
            hideFullyCompletedTasks = App.utils.classFactory.getComponent("CheckBox", CheckBox);
            with (hideFullyCompletedTasks)
            {
                name = "hideFullyCompletedTasks";
                label = Locale.get("Hide with honors");
                autoSize = "left";
                x = taskFilters.hideCompletedTasks.x + 3;
                y = taskFilters.hideCompletedTasks.y + 18;
            }
            hideFullyCompletedTasks.addEventListener(Event.SELECT, onHideTasksChanged);
            taskFilters.addChild(hideFullyCompletedTasks);
        }

        private function createHideNotAvailableTasksCheckBox():void
        {
            hideNotAvailableTasks = App.utils.classFactory.getComponent("CheckBox", CheckBox);
            with (hideNotAvailableTasks)
            {
                name = "hideNotAvailableTasks";
                label = Locale.get("Hide not available");
                autoSize = "left";
                x = taskFilters.hideCompletedTasks.x + 3;
                y = taskFilters.hideCompletedTasks.y + 36;
            }
            hideNotAvailableTasks.addEventListener(Event.SELECT, onHideTasksChanged);
            taskFilters.addChild(hideNotAvailableTasks);
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
                    else if (hideNotAvailableTasks.selected && StringUtils.contains(task.stateIconPath, "/notAvailableIcon."))
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
                hideNotAvailableTasks: this.hideNotAvailableTasks.selected
            };
            Cmd.saveSettings("questsTileChainsViewFilters", JSONx.stringify(settings));
        }

        private function restoreSettings(json_str:String):void
        {
            if (json_str == null || json_str == "")
                return;
            try
            {
                var settings:Object = JSONx.parse(json_str);
                taskFilters.vehicleTypeFilter.selectedIndex = settings.vehicleTypeFilter;
                taskFilters.taskTypeFilter.selectedIndex = settings.taskTypeFilter;
                taskFilters.hideCompletedTasks.selected = settings.hideCompletedTasks;
                this.hideFullyCompletedTasks.selected = settings.hideFullyCompletedTasks;
                this.hideNotAvailableTasks.selected = settings.hideNotAvailableTasks;
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }
    }
}
