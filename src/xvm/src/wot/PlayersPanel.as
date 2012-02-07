/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.Stat;

class wot.PlayersPanel extends net.wargaming.ingame.PlayersPanel
{
  function PlayersPanel()
  {
    super();
    Config.LoadConfigAndStat();
  }

  // override
  function _setNamesStr(data, sel, isColorBlind, knownPlayersCount)
  {
/*    if (Config.value("battle/showPlayerStatictics/data") != "true")
    {
      super._setNamesStr(data, sel, isColorBlind, knownPlayersCount);
      return;
    }*/
/*    var p = "";
    for (var pp in this.m_list)
      p += pp + ", ";
    Logger.add(p);*/

    var _loc7 = "";
    var _loc5 = "";
    var _loc8 = 0;

    for (var _loc2 = 0; _loc2 < data.length; ++_loc2)
    {
      _loc5 = data[_loc2].label.slice(0, net.wargaming.ingame.PlayersPanel.PLAYER_NAME_LENGTH[m_state]);

      // FIXIT: Why Stat.Decorate return 'undefined'?
      //_loc5 = Stat.Decorate(data[_loc2].label, data[_loc2].label, m_type);
      if (Stat.s_player_ratings)
      {
        var pname = Stat.CleanPlayerName(data[_loc2].label);
        var rating = Stat.s_player_ratings[pname.toUpperCase()].rating;
        if (m_state == "large")
        {
          _loc5 = m_type == "left"
            ? Stat.GetPercentHtmlText(rating) + " " + _loc5
            : _loc5 + " " + Stat.GetPercentHtmlText(rating);
        }
        else
        {
          if (Config.value("battle/statColorizePanelPlayerNames/data") == "true" && rating)
          {
            var color = (rating < 49) ? 0xFF0000 : ((rating < 51) ? 0xFFFF00 : 0x00FF00);
            _loc5 = "<font color=\'#" + color.toString(16) + "\'>" + _loc5 + "</font>";
          }
        }
      }
              
      _loc8 = data[_loc2].vehicleState;
      var _loc3 = (_loc8 & net.wargaming.ingame.VehicleStateInBattle.IS_AVATAR_READY) != 0;
      var _loc4 = (_loc8 & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) != 0;
      if (_loc2 == sel)
      {
          _loc7 = _loc7 + this._getHTMLText(_loc4 && _loc3 ? ("selected") : ("selected_dead"), _loc5);
          continue;
      } // end if
      if (data[_loc2].VIP)
      {
          _loc7 = _loc7 + this._getHTMLText(_loc4 && _loc3 ? ("VIP") : ("VIP_dead"), _loc5);
          continue;
      } // end if
      if (data[_loc2].squad > 10)
      {
          _loc7 = _loc7 + this._getHTMLText(_loc4 && _loc3 ? ("squad") : ("squad_dead"), _loc5);
          continue;
      } // end if
      if (data[_loc2].teamKiller)
      {
          _loc7 = _loc7 + this._getHTMLText(_loc4 && _loc3 ? ("teamkiller") : ("teamkiller_dead"), _loc5);
          continue;
      } // end if
      _loc7 = _loc7 + this._getHTMLText(_loc4 && _loc3 ? ("normal") : ("normal_dead"), _loc5);
    } // end of for
    m_names.htmlText = _loc7;
  } // End of the function
}
