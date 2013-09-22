/**
 * XVM - battle resultes
 * @author Pavel Máca
 */
package xvm.hangar.views
{
    import com.xvm.*;
    import flash.events.*;
    import flash.text.TextField;
    import net.wg.gui.events.ViewStackEvent;
    import net.wg.gui.lobby.battleResults.BattleResults;
    import net.wg.gui.lobby.battleResults.CommonStats;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import xvm.hangar.components.BattleResultes.CommonView;
    import xvm.hangar.XvmModBase;

    public class BattleResults extends XvmModBase
    {
        public function BattleResults(view:IView)
        {
            super(view);
        }

        public function get page():net.wg.gui.lobby.battleResults.BattleResults
        {
            return super.view as net.wg.gui.lobby.battleResults.BattleResults;

        }

        override public function onAfterPopulate(e:LifeCycleEvent):void
        {
            try
            {
                page.view_mc.addEventListener(ViewStackEvent.VIEW_CHANGED, this.onViewChanged);
                //showChance();
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            page.view_mc.removeEventListener(ViewStackEvent.VIEW_CHANGED, this.onViewChanged);
        }

        private var processedViews:Array = [];

        private function onViewChanged(event:ViewStackEvent):void
        {
            try
            {
                if (processedViews.indexOf(event.linkage) != -1)
                {
                    // TODO: better fix for multiple modding one view
                    return;
                }

                // tabs: CommonStats, TeamStats, DetailsStats
                switch (event.linkage)
                {
                    case "CommonStats":
                        //Logger.add("View loaded: battleResults." + event.linkage);
                        CommonView.init(event.view as CommonStats);
                        break;
                }

                processedViews.push(event.linkage);
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function showChance():void
        {
            /*
            // Global stats switch
            if (!Config.config.rating.showPlayersStatistics)
                return;

            if (Config.config.battleResults.showChances)
            {

            }

            if (Config.config.battleResults.showChancesExp)
            {

            }
            // TODO: show win chance
            var tf:TextField = new TextField();
            tf.selectable = false;
            tf.text = "95145 %";
            tf.x = 200;
            tf.y = -20;
            page.addChild(tf);
            */
        }

        public function setStartPage(index:Number, currentView:IViewStackContent):void
        {
            // TODO: startPage
            /*
            var data:Object = page.tabs_mc.dataProvider[index - 1];
            if (data != null)
            {
                if (page.view_mc.currentView)
                {
                    page.view_mc.currentView.visible = false; // not working
                }
                page.tabs_mc.selectedIndex = index - 1;
                page.tabs_mc.invalidate();
            }
            else
            {
                Logger.add("BattleResults: startPage out of range (" + index + ")");
            }*/
        }
    }

}
