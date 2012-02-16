/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.Stat;

class wot.PlayersPanel extends net.wargaming.ingame.PlayersPanel
{
  function PlayersPanel()
  {
    super();
    Config.LoadConfigAndStat();
  }

  function completeLoad(event)
  {
    event.target.removeEventListener("complete", this, "completeLoad");

    if (!Config.bool("battle/disableMirroredVehicleIcons"))
      return;

    if (m_type == "left")
      return;

    event.target._xscale = -event.target._xscale;
    event.target._x -= event.target.__width;
  }

  // override
  private var _iconLoaderProcessed = false;
  function setData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount)
  {
    if (!_iconLoaderProcessed)
    {
      _iconLoaderProcessed = true;
      for (var i = 0; i < m_list.renderers.length; ++i)
        m_list.renderers[i].iconLoader.addEventListener("complete", this, "completeLoad");
    }
    super.setData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount);
  }

  // override
  function _setNamesStr(data, sel, isColorBlind, knownPlayersCount)
  {
    if (!Config.bool("rating/showPlayersStatistics"))
    {
      super._setNamesStr(data, sel, isColorBlind, knownPlayersCount);
      return;
    }

    var _loc7 = "";
    var _loc5 = "";
    var _loc8 = 0;

    for (var _loc2 = 0; _loc2 < data.length; ++_loc2)
    {
      _loc5 = data[_loc2].label.slice(0, net.wargaming.ingame.PlayersPanel.PLAYER_NAME_LENGTH[m_state]);

      if (Stat.s_player_ratings)
      {
        if (m_state == "large")
        {
          if (Config.bool("rating/playersPanel/show", true))
          {
            _loc5 = Stat.DecorateField(data[_loc2].label, data[_loc2].label,
              Config.value("rating/playersPanel/format"),
              m_type == "left" ? Defines.POSITION_LEFT : Defines.POSITION_RIGHT);
          }
        }
        else
        {
          if (Config.bool("rating/playersPanel/colorizeMiddle", true))
          {
            var pname = Stat.CleanPlayerName(data[_loc2].label);
            var rating = Stat.s_player_ratings[pname.toUpperCase()].rating;
            if (rating)
            {
              var color = (rating < 49) ? 0xFF0000 : ((rating < 51) ? 0xFFFF00 : 0x00FF00);
              _loc5 = "<font color=\'#" + color.toString(16) + "\'>" + _loc5 + "</font>";
            }
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
