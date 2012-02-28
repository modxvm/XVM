/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.Stat;

class wot.PlayersPanel extends net.wargaming.ingame.PlayersPanel
{
  private var m_largePanelWidth: Number = -1;
  private var m_largePanelOffset: Number = NaN;
  private var m_widthTester: TextField = null;
  
  function PlayersPanel()
  {
    super();
    Config.LoadConfigAndStat();
  }

  function completeLoad(event)
  {
    event.target.removeEventListener("complete", this, "completeLoad");

    if (Config.bool("battle/mirroredVehicleIcons", true))
      return;

    if (m_type == "left")
      return;

    event.target._xscale = -event.target._xscale;
    event.target._x -= event.target.__width;

    if (!Config.bool("battle/mirroredVehicleIcons", true) && m_type == "right")
      event.target["renderer"].vehicleLevel._x = event.target._x + 15;
  }

  // override
  private var _initialized = false;
  function setData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount)
  {
    if (!_initialized)
    {
      _initialized = true;
      for (var i = 0; i < m_list.renderers.length; ++i)
      {
        var renderer = m_list.renderers[i];
        renderer.iconLoader.addEventListener("complete", this, "completeLoad");
        renderer.iconLoader["renderer"] = renderer;
      }

      players_bg.players_bg._alpha = Config.int("battle/playersPanelAlpha", 100);

      m_largePanelWidth = Math.min(Config.int("battle/playersPanelLargeWidth", -1), 170);
    }
    super.setData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount);
  }

  // override
  private var _lastModeWasLarge = false;
  function update()
  {
    super.update();

    if (m_state == "large" && m_largePanelWidth >= 0)
    {
      if (m_largePanelOffset == NaN)
        m_largePanelOffset = m_names._width - m_largePanelWidth;

      m_names._width = m_largePanelWidth;

      if (!_lastModeWasLarge)
      {
        if (m_type == "left")
          m_names._x += m_largePanelOffset;
        this._x = (m_type == "left") ? this._x - m_largePanelOffset : this._x + m_largePanelOffset;
      }
      _lastModeWasLarge = true;
    }
    else
    {
      if (_lastModeWasLarge)
        this._x = (m_type == "left") ? this._x + m_largePanelOffset : this._x - m_largePanelOffset;
      _lastModeWasLarge = false;
    }
  }

  // override
  function onRecreateDevice(width, height)
  {
    super.onRecreateDevice(width, height);

    if (m_state == "large" && m_largePanelWidth >= 0)
      this._x = (m_type == "left") ? this._x - m_largePanelOffset : this._x + m_largePanelOffset;
  }

  // override
  function _setNamesStr(data, sel, isColorBlind, knownPlayersCount)
  {
    var _loc7 = "";
    var _loc5 = "";
    var _loc8 = 0;

    for (var _loc2 = 0; _loc2 < data.length; ++_loc2)
    {
      _loc5 = data[_loc2].label.slice(0, net.wargaming.ingame.PlayersPanel.PLAYER_NAME_LENGTH[m_state]);

      if (m_state == "large")
      {
        // What is the better way to cut player names?
        if (!m_widthTester)
        {
          m_widthTester = _root.createTextField("widthTester", _root.getNextHighestDepth(), 0, 0, m_names._width, m_names._height);
          m_widthTester.setTextFormat(m_names.getTextFormat());
          m_widthTester.autoSize = true;
          m_widthTester.html = true;
          m_widthTester._visible = false;
        }
        
        var pname: String = data[_loc2].label;
        while (pname.length >= 0)
        {
          _loc5 = (pname == data[_loc2].label || pname.length == 0) ? pname : pname + "...";
          if (Stat.s_player_ratings && Config.bool("rating/playersPanel/show", true))
          {
            _loc5 = Stat.DecorateField(data[_loc2], _loc5,
              Config.string("rating/playersPanel/format"),
              m_type == "left" ? Defines.POSITION_LEFT : Defines.POSITION_RIGHT);
          }
          m_widthTester.htmlText = _loc5;
          if (m_widthTester._width <= m_names._width)
            break;
          pname = pname.substr(0, pname.length - 1);
        }
      }
      else
      {
        if (Stat.s_player_ratings)
        {
          var middleColor: String = Config.string("rating/playersPanel/middleColor");
          if (middleColor)
            _loc5 = Stat.FormatText(data[_loc2], "<font color='" + middleColor + "'>" + _loc5 + "</font>");
        }
      }

      _loc8 = data[_loc2].vehicleState;
      var _loc3 = (_loc8 & net.wargaming.ingame.VehicleStateInBattle.IS_AVATAR_READY) != 0;
      var _loc4 = (_loc8 & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) != 0;
      if (_loc2 == sel)
      {
          _loc7 = _loc7 + this._getHTMLText(_loc4 && _loc3 ? ("selected") : ("selected_dead"), _loc5);
          continue;
      }
      if (data[_loc2].VIP)
      {
          _loc7 = _loc7 + this._getHTMLText(_loc4 && _loc3 ? ("VIP") : ("VIP_dead"), _loc5);
          continue;
      }
      if (data[_loc2].squad > 10)
      {
          _loc7 = _loc7 + this._getHTMLText(_loc4 && _loc3 ? ("squad") : ("squad_dead"), _loc5);
          continue;
      }
      if (data[_loc2].teamKiller)
      {
          _loc7 = _loc7 + this._getHTMLText(_loc4 && _loc3 ? ("teamkiller") : ("teamkiller_dead"), _loc5);
          continue;
      }
      _loc7 = _loc7 + this._getHTMLText(_loc4 && _loc3 ? ("normal") : ("normal_dead"), _loc5);
    }

    m_names.htmlText = _loc7;
  }
}
