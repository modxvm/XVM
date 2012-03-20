/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.Logger;
import wot.utils.Stat;

class wot.PlayersPanel extends net.wargaming.ingame.PlayersPanel
{
  private var m_currentFieldType = "";
  private var m_currentData = null;
  private var m_currentItem = 0;
  //private var m_largePanelWidth: Number = -1;
  //private var m_largePanelOffset: Number = NaN;
  //private var m_widthTester: TextField = null;

  function PlayersPanel()
  {
    /*if (!_global.xvm)
      _global.xvm = [];
    if (wot.utils.Utils.indexOf(_global.xvm, "PlayersPanel") == -1)
      _global.xvm.push("PlayersPanel");
    wot.utils.Logger.add("--> " + _global.xvm.join(", "));*/

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

    if (!Config.s_config.battle.mirroredVehicleIcons)
      event.target.renderer.vehicleLevel._x = event.target._x + 15;
  }

  // override
  private var _initialized = false;
  function setData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount)
  {
    super.setData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount);

    if (!_initialized)
    {
      _initialized = true;
      for (var i = 0; i < m_list.renderers.length; ++i)
      {
        var renderer = m_list.renderers[i];
        renderer.iconLoader.addEventListener("complete", this, "completeLoad");
        renderer.iconLoader["renderer"] = renderer;
      }

      //m_largePanelWidth = Math.min(Config.s_config.playersPanel.large.width, 170);
    }

    players_bg._alpha = Config.s_config.playersPanel.alpha;

    //Logger.add(m_names.htmlText);
  }

  // override
  //private var _lastModeWasLarge = false;
  /*function update()
  {
    Logger.add("update()");
    super.update();

    /*if (m_state == "large" && m_largePanelWidth >= 0)
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
    }*/
  //}

  // override
  function onRecreateDevice(width, height)
  {
    super.onRecreateDevice(width, height);

    //if (m_state == "large" && m_largePanelWidth >= 0)
    //  this._x = (m_type == "left") ? this._x - m_largePanelOffset : this._x + m_largePanelOffset;
  }

  // override
  function _setVehiclesStr(data, sel, isColorBlind, knownPlayersCount)
  {
    try
    {
      m_currentFieldType = "vehicle";
      m_currentData = data;
      m_currentItem = 0;
      super._setVehiclesStr(data, sel, isColorBlind, knownPlayersCount);
    }
    finally
    {
      m_currentFieldType = "";
      m_currentData = null;
      m_currentItem = 0;
    }
  }
  
  // override
  function _setNamesStr(data, sel, isColorBlind, knownPlayersCount)
  {
    try
    {
      m_currentFieldType = "name";
      m_currentData = data;
      m_currentItem = 0;
      super._setNamesStr(data, sel, isColorBlind, knownPlayersCount);
    }
    finally
    {
      m_currentFieldType = "";
      m_currentData = null;
      m_currentItem = 0;
    }
  }

  function _getHTMLText(colorScheme, text)
  {
    if (m_currentFieldType != "")
    {
      //Logger.add("before: " + text);
      text = XVMFormatText(m_currentData[m_currentItem++], m_currentFieldType);
      //Logger.add("after: " + text);
    }

    return super._getHTMLText(colorScheme, text);
  }

  function XVMFormatText(data, fieldType)
  {
    var format: String = "";
    var name = data.label + ((data.clanAbbrev == "") ? "" : "[" + data.clanAbbrev + "]");
    switch (m_state)
    {
      case "medium":
        if (fieldType == "vehicle")
          return data.vehicle.toString();
        format = (m_type == "left")
          ? Config.s_config.playersPanel.medium.formatLeft
          : Config.s_config.playersPanel.medium.formatRight;
        break;
      case "medium2":
        if (fieldType == "name")
          return name;
        format = (m_type == "left")
          ? Config.s_config.playersPanel.medium2.formatLeft
          : Config.s_config.playersPanel.medium2.formatRight;
        break;
      case "large":
        if (fieldType == "name")
        {
          format = (m_type == "left")
            ? Config.s_config.playersPanel.large.nickFormatLeft
            : Config.s_config.playersPanel.large.nickFormatRight;
        }
        else
        {
          format = (m_type == "left")
            ? Config.s_config.playersPanel.large.vehicleFormatLeft
            : Config.s_config.playersPanel.large.vehicleFormatRight;
        }
        break;
      default:
        return (fieldType == "name") ? name : data.vehicle.toString();
    }

    format = format.split("{{nick}}").join(name);
    format = format.split("{{vehicle}}").join(data.vehicle.toString());
    format = Stat.FormatText(data, format);

      /*if (!m_widthTester)
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
        if (Stat.s_player_ratings)
        {
          str = Stat.DecorateField(data, str,
            m_type == "left" ? Config.s_config.playersPanel.formatLeft : Config.s_config.playersPanel.formatRight,
            m_type == "left" ? Defines.POSITION_LEFT : Defines.POSITION_RIGHT);
        }
        if (pname.length == 0)
          break;
        //m_widthTester.htmlText = str;
        //if (m_widthTester._width <= m_names._width)
          break;
        //pname = pname.substr(0, pname.length - 1);
      }
    }
    else
    {
      if (Stat.s_player_ratings)
      {
        var middleColor: String = Config.s_config.playersPanel.middleColor;
        if (middleColor)
          str = Stat.FormatText(data, "<font color='" + middleColor + "'>" + str + "</font>");
      }
    }*/
    return format;
  }

  // override
  /*function updateWidthOfLongestName()
  {
    // do nothing
  }

  // override
  function updatePanel()
  {
    // do nothing
  }*/

  /*  function updatePanel()
    {
        var _loc3 = 268;
        m_names._width = net.wargaming.ingame.PlayersPanel.ms_widthOfLongestName + 10;
        var _loc2 = m_names._width - _loc3;
        if (m_type == "left")
        {
            m_frags._x = m_names._x + m_names._width;
            m_vehicles._x = m_frags._x + m_frags._width;
            m_list._x = players_bg._x = _loc2;
            m_list.updateSquadIconPosition(-m_list._x);
        }
        else
        {
            m_list._x = players_bg._x = players_bg._width - _loc2;
            m_names._x = players_bg._width - m_names._width - net.wargaming.ingame.PlayersPanel.SQUAD_SIZE;
            m_frags._x = m_names._x - m_frags._width;
            m_vehicles._x = m_frags._x - m_vehicles._width;
            m_list.updateSquadIconPosition(-net.wargaming.ingame.PlayersPanel.SQUAD_SIZE - _loc2);
        } // end else if
    } // End of the function
*/
}
