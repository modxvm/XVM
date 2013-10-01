package xvm.hangar.components.Profile
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.exceptions.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import net.wg.gui.lobby.profile.pages.summary.*;
    import net.wg.gui.lobby.profile.pages.technique.*;
    import net.wg.gui.components.advanced.*;
    import com.xvm.*;
    import com.xvm.events.*;
    import com.xvm.io.*;
    import com.xvm.types.cfg.*;
    import com.xvm.l10n.Locale;
    import xvm.UI.profileSections.UI_TechniqueRenderer;

    public class Technique extends Sprite
    {
        protected var page:ProfileTechnique;
        protected var summary:ProfileSummary;

        protected var tiFilter:TextInput;

        private var techniqueListAdjuster:TechniqueListAdjuster;

        public function Technique(page:ProfileTechnique, summary:ProfileSummary):void
        {
            this.page = page;
            this.summary = summary;

            /*var origSummaryGetGlobalRating:Function = summary.getGlobalRating;
            summary.getGlobalRating = function():Number
            {
                Logger.add("id: " + arguments[0]);
                return origSummaryGetGlobalRating.apply(summary, arguments);
            }

            var origRequestData:Function = page.requestData;
            page.requestData = function():void
            {
                Logger.addObject(arguments, "arguments", 2);
                origRequestData.apply(page, arguments);
            }*/

            // override renderer
            list.itemRenderer = UI_TechniqueRenderer;

            // Add summary item to the first line of technique list
            techniqueListAdjuster = new TechniqueListAdjuster(page, summary);

            // remove lower shadow (last item is looks bad with it)
            page.listComponent.lowerShadow.visible = false;

            // create filter controls
            if (Config.config.userInfo.showFilters)
                createControls();

            // stat
            if (Config.config.rating.showPlayersStatistics  && Config.config.rating.enableUserInfoStatistics)
                Stat.loadUserData(this, onStatLoaded, getPlayerName(), false);

            // post init
            list.addEventListener(TechniqueList.SELECTED_DATA_CHANGED, delayedInit);
        }

        private function delayedInit():void
        {
            list.removeEventListener(TechniqueList.SELECTED_DATA_CHANGED, delayedInit);

            // userInfo.sortColumn
            App.utils.scheduler.envokeInNextFrame(function():void
            {
                var bb:SortableHeaderButtonBar = page.listComponent.sortableButtonBar;
                bb.selectedIndex = Math.abs(Config.config.userInfo.sortColumn) - 1;
                var b:SortingButton = bb.getButtonAt(bb.selectedIndex) as SortingButton;
                b.sortDirection = Config.config.userInfo.sortColumn < 0 ? SortingButton.DESCENDING_SORT : SortingButton.ASCENDING_SORT;
                list.selectedIndex = 0;
            });
        }

        protected function get list():TechniqueList
        {
            return page.listComponent.techniqueList;
        }

        protected function getPlayerName():String
        {
            throw new AbstractException("Technique::getUserInfo() is abstract)");
        }

        protected function createControls():void
        {
            //"filterFocused": true,
        }

        // PRIVATE


        // STAT

        private function onStatLoaded(e:ObjectEvent):void
        {
            if (e == null)
                return;
        }

    }
}
