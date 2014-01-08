/**
 * XVM - battle resultes
 * @author Pavel Máca
 */
package xvm.hangar.views
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.events.ViewStackEvent;
    import net.wg.gui.lobby.battleResults.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.events.IndexEvent;
    import xvm.hangar.components.BattleResults.CommonView;

    public class BattleResults extends XvmViewBase
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
            page.view_mc.addEventListener(ViewStackEvent.VIEW_CHANGED, this.onViewChanged);
            page.tabs_mc.addEventListener(IndexEvent.INDEX_CHANGE, this.onTabIndexChange);
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            page.view_mc.removeEventListener(ViewStackEvent.VIEW_CHANGED, this.onViewChanged);
        }

        private var processedViews:Array = [];

        private function onViewChanged(e:ViewStackEvent):void
        {
            try
            {
                if (processedViews.indexOf(e.linkage) != -1)
                {
                    // TODO: better fix for multiple modding one view
                    return;
                }

                // tabs: CommonStats, TeamStats, DetailsStats
                //Logger.add("View loaded: battleResults." + e.linkage);
                switch (e.linkage)
                {
                    case "CommonStats":
                        CommonView.init(e.view as CommonStats);
                        break;
                }

                processedViews.push(e.linkage);
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function onTabIndexChange(e:IndexEvent):void
        {
            page.tabs_mc.removeEventListener(IndexEvent.INDEX_CHANGE, this.onTabIndexChange);

            // set startPage
            var startPage:Number = Config.config.battleResults.startPage - 1;

            if (page.tabs_mc.dataProvider[startPage] != null)
                page.tabs_mc.selectedIndex = startPage;
            else
                Logger.add("battleResults: startPage \"" + startPage + "\" is out of range.");

            // display win chance
            if (Config.config.rating.showPlayersStatistics && Config.config.battleResults.showChances)
                loadStats(page.data.team1, page.data.team2);
        }

        private function loadStats(allyTeam:Array, enemyTeam:Array):void
        {
        /** {
           "playerName": "Assassik [APO]",
           "name": "Assassik",
           "accountDBID": 504298250,
           "userName": "Assassik",
           "playerId": 504298250,
           .... and more
         }*/ /*
           for each(var ally:Object in allyTeam)
           {
           ally.userName;
           }

           for each(var enemy:Object in enemyTeam)
           {
           enemy.userName;
           }

           onStatsLoaded();
         */
        }

        private function onStatsLoaded():void
        {
            //var chance:String = Chance.GetChanceText(Config.config.battleResults.showChancesExp);
            //createWinChanceField(chance);
        }

        private function createWinChanceField(chanceText:String):void
        {
            var tf:TextField = new TextField();
            tf.selectable = false;
            tf.autoSize = TextFieldAutoSize.LEFT;
            tf.htmlText = "<font face='$TitleFont' size='16' color='#E9E7D6'>" + chanceText + "</font>";
            tf.x = 200;
            tf.y = -25;
            page.addChild(tf);
        }

    }

}
