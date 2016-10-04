/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.battleresults.components
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xfw.events.*;
    import com.xvm.types.stat.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.gui.lobby.battleResults.*;
    import scaleform.gfx.*;

    public class WinChances
    {
        private var page:BattleResults;

        private var textField:TextField = null;

        private var arenaUniqueID:String = null;

        public function WinChances(page:BattleResults)
        {
            this.page = page;

            // Add stat loading handler
            // Load battle stat
            Stat.instance.addEventListener(Stat.COMPLETE_BATTLERESULTS, onStatLoaded, false, 0, true);
            arenaUniqueID = page.as_config.name.replace("battleResults_", "");
            Stat.loadBattleResultsStat(arenaUniqueID);
        }

        private function onStatLoaded(e:ObjectEvent):void
        {
            if (e.result != arenaUniqueID)
                return;

            //Logger.add("onStatLoaded()");
            if (textField == null)
            {
                textField = new TextField();
                textField.mouseEnabled = false;
                textField.selectable = false;
                TextFieldEx.setNoTranslate(textField, true);
                textField.antiAliasType = AntiAliasType.ADVANCED;
                textField.x = page.width - 405;
                textField.y = 2;
                textField.width = 400;
                textField.height = 30;
                textField.styleSheet = XfwUtils.createTextStyleSheet("txt", new TextFormat("$FieldFont", 16, XfwConst.UICOLOR_LABEL));
                page.addChild(textField);
            }

            // fix stat data
            //Logger.addObject(page.data, 3);
            var playerNames:Vector.<String> = new Vector.<String>();
            var stats:Dictionary = Stat.getBattleResultsStat(arenaUniqueID);
            for (var name:String in stats)
            {
                playerNames.push(name);
                var sd:StatData = stats[name];
                if (sd == null)
                    continue;
                sd.team = XfwConst.TEAM_ENEMY;
                for each (var pl:Object in page.xfw_data.team1)
                {
                    if (pl.userName == sd.name)
                    {
                        sd.team = XfwConst.TEAM_ALLY;
                        break;
                    }
                }
            }

            var chanceResults:Boolean = Config.networkServicesSettings.statBattle && Config.networkServicesSettings.chanceResults;
            var chanceText:String = Chance.GetChanceText(playerNames, stats, chanceResults, Config.config.battleResults.showBattleTier);
            if (chanceText)
            {
                chanceText = "<p class='txt' align='right'>" + chanceText + '</p>';
                textField.htmlText = chanceText;
            }
        }
    }
}
