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
    Config.LoadConfigAndStatLegacy("XVM.xvmconf", "PlayersPanel.as");
  }

  function completeLoad(event)
  {
    event.target.removeEventListener("complete", this, "completeLoad");

    if (Config.s_config.battle.mirroredVehicleIcons)
      return;

    if (m_type == "left")
      return;

    event.target._xscale = -event.target._xscale;
    event.target._x -= event.target.__width;

    if (!Config.s_config.battle.mirroredVehicleIcons && m_type == "right")
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

      players_bg.players_bg._alpha = Config.s_config.battle.playersPanelAlpha;

      m_largePanelWidth = Math.min(Config.s_config.battle.playersPanelLargeWidth, 170);
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
    var _loc9 = "";
    var _loc3 = "";
    var _loc8 = 0;

    for (var _loc2 = 0; _loc2 < data.length; ++_loc2)
    {
      _loc3 = data[_loc2].label.slice(0, net.wargaming.ingame.PlayersPanel.PLAYER_NAME_LENGTH[m_state]);

      _loc3 = XVMSetNamesStr(data[_loc2], _loc3);

      _loc9 = data[_loc2].clanAbbrev;
      _loc8 = data[_loc2].vehicleState;
      var _loc4 = (_loc8 & net.wargaming.ingame.VehicleStateInBattle.IS_AVATAR_READY) != 0;
      var _loc6 = (_loc8 & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) != 0;
      if (_loc9 != "")
      {
        _loc3 = _loc3 + ("[" + _loc9 + "]");
      }
      if (_loc2 == sel)
      {
        _loc7 = _loc7 + this._getHTMLText(_loc4 ? ("selected") : ("selected_dead"), _loc3);
        continue;
      }
      if (data[_loc2].VIP)
      {
        _loc7 = _loc7 + this._getHTMLText(_loc6 && _loc4 ? ("VIP") : ("VIP_dead"), _loc3);
        continue;
      }
      if (data[_loc2].squad > 10)
      {
        _loc7 = _loc7 + this._getHTMLText(_loc6 && _loc4 ? ("squad") : ("squad_dead"), _loc3);
        continue;
      }
      if (data[_loc2].teamKiller)
      {
        _loc7 = _loc7 + this._getHTMLText(_loc6 && _loc4 ? ("teamkiller") : ("teamkiller_dead"), _loc3);
        continue;
      }
      _loc7 = _loc7 + this._getHTMLText(_loc6 && _loc4 ? ("normal") : ("normal_dead"), _loc3);
    }

    m_names.htmlText = _loc7;
    this.updateWidthOfLongestName();
  }

  function XVMSetNamesStr(data, str)
  {
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

      var pname: String = data.label;
      while (pname.length >= 0)
      {
        str = (pname == data.label || pname.length == 0) ? pname : pname + "...";
        if (Stat.s_player_ratings && Config.s_config.rating.playersPanel.show)
        {
          str = Stat.DecorateField(data, str,
            Config.s_config.rating.playersPanel.format,
            m_type == "left" ? Defines.POSITION_LEFT : Defines.POSITION_RIGHT);
        }
        if (pname.length == 0)
          break;
        m_widthTester.htmlText = str;
        if (m_widthTester._width <= m_names._width)
          break;
        pname = pname.substr(0, pname.length - 1);
      }
    }
    else
    {
      if (Stat.s_player_ratings)
      {
        var middleColor: String = Config.s_config.rating.playersPanel.middleColor;
        if (middleColor)
          str = Stat.FormatText(data, "<font color='" + middleColor + "'>" + str + "</font>");
      }
    }
    return str;
  }
}
