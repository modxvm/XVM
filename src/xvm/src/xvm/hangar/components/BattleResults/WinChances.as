package xvm.hangar.components.BattleResults
{
    import com.xvm.*;
    import com.xvm.misc.*;
    import com.xvm.types.stat.StatData;
    import com.xvm.types.veh.VehicleData;
    import com.xvm.utils.*;
    import flash.display.Sprite;
    import flash.text.*;
    import net.wg.gui.lobby.battleResults.*;

    public class WinChances
    {
        private var page:BattleResults;

        private var textField:TextField = null;

        public function WinChances(page:BattleResults)
        {
            if (Config.config.rating.showPlayersStatistics == false)
                return;
            if (Config.config.battleResults.showChances == false)
                return;
            this.page = page;

            // Add stat loading handler
            Stat.loadBattleResultsStat(this, onStatLoaded, page.as_name.replace("battleResults", ""));
        }

        private function onStatLoaded(response:Object):void
        {
            //Logger.add("onStatLoaded()");
            if (textField == null)
            {
                textField = new TextField();
                textField.antiAliasType = AntiAliasType.ADVANCED;
                textField.selectable = false;
                textField.x = page.width - 405;
                textField.y = 2;
                textField.width = 400;
                textField.height = 30;
                textField.styleSheet = Utils.createTextStyleSheet("txt", new TextFormat("$FieldFont", 16, Defines.UICOLOR_LABEL));
                page.addChild(textField);
            }

            // fix stat data
            //Logger.addObject(page.data, 3);
            var myTeam:int = page.data.personal.team;
            var playerNames:Vector.<String> = new Vector.<String>();
            for (var name:String in response.players)
            {
                playerNames.push(name);
                var sd:StatData = Stat.getData(name);
                if (sd == null)
                    continue;
                var plTeam:int = 2;
                for each (var pl:Object in page.data.team1)
                {
                    if (pl.userName == sd.name)
                    {
                        plTeam = 1;
                        break;
                    }
                }
                sd.team = plTeam == myTeam ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY;
            }

            var chanceText:String = Chance.GetChanceText(playerNames, false);
            if (chanceText)
            {
                chanceText = "<p class='txt' align='right'>" + chanceText + '</p>';
                textField.htmlText = chanceText;
            }
        }
    }
}
