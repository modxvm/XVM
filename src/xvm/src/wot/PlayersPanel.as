/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.Logger;
import wot.utils.Stat;
import wot.utils.Utils;

class wot.PlayersPanel extends net.wargaming.ingame.PlayersPanel
{
  static var DEBUG_TIMES = false;

  static private var s_widthTester: TextField;

  private var m_currentFieldType = "";
  private var m_currentData = null;
  private var m_currentItem = 0;

  private var m_textCache = {};
  private var m_panelSizesCache = null;
  
  function PlayersPanel()
  {
    /*if (!_global.xvm)
      _global.xvm = [];
    if (Utils.indexOf(_global.xvm, "PlayersPanel") == -1)
      _global.xvm.push("PlayersPanel");
    Logger.add("--> " + _global.xvm.join(", "));*/

    super();

    Config.LoadConfigAndStatLegacy("XVM.xvmconf", "PlayersPanel.as");
  }

  // override
  private var _initialized = false;
  function setData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount)
  {
    var start = new Date();
    super.setData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount);

    players_bg._alpha = Config.s_config.playersPanel.alpha;
    m_list._alpha = Config.s_config.playersPanel.iconAlpha;

    XVMAdjustPanelSize();

    if (DEBUG_TIMES)
      Logger.add("DEBUG TIME: PlayersPanel: setData(): " + Utils.elapsedMSec(start, new Date()) + " ms");
  }

  // override
  function onRecreateDevice(width, height)
  {
    super.onRecreateDevice(width, height);

    XVMAdjustPanelSize();
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

  // override
  function updateWidthOfLongestName()
  {
    // do nothing
  }
  
  // override
  function _getHTMLText(colorScheme, text)
  {
    if (m_currentFieldType != "")
    {
      //Logger.add("before: " + text);
      text = XVMFormatText(m_currentData[m_currentItem++], m_currentFieldType, Utils.endsWith("dead", colorScheme));
      //Logger.add("after: " + text);
    }

    return super._getHTMLText(colorScheme, text);
  }

  /**
   * XVM
   */
  
  function XVMFormatText(data, fieldType, isDead)
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

    var key = (isDead ? "d" : "a") + " " + data.label + " " + format;
    if (!m_textCache.hasOwnProperty(key))
    {
      format = format.split("{{vehicle}}").join(data.vehicle.toString());
      format = Stat.FormatText(data, format, isDead);

      // cut player name for field width
      if (format.indexOf("{{nick}}") > -1)
      {
        var str: String = name;
        var pname: String = name;
        if (m_state == "medium" || m_state == "medium2" || m_state == "large")
        {
          var configWidth = Config.s_config.playersPanel[m_state].width;
          if (s_widthTester == null)
          {
            s_widthTester = _root.createTextField("widthTester", _root.getNextHighestDepth(), 0, 0, 268, 20);
            s_widthTester.autoSize = false;
            s_widthTester.html = true;
            s_widthTester._visible = false;
            var tf: TextFormat = m_names.getNewTextFormat();
            s_widthTester.setNewTextFormat(tf);
          }
          while (pname.length > 0)
          {
            str = (pname == name || m_state != "large") ? pname : pname + "...";
            s_widthTester.htmlText = format.split("{{nick}}").join(str);
            if (Math.round(s_widthTester.getLineMetrics(0).width) + 4 <= configWidth) // 4 is a size of gutters
            {
              //Logger.add("configWidth=" + configWidth + " _width=" + s_widthTester._width + " lineWidth=" + Math.round(s_widthTester.getLineMetrics(0).width) + " " + str);
              break;
            }
            pname = pname.substr(0, pname.length - 1);
          }
        }
        format = format.split("{{nick}}").join(pname.length == 0 ? "" : str);
      }

      m_textCache[key] = Utils.trim(format);
    }

    return m_textCache[key];
  }

  function XVMAdjustPanelSize()
  {
    if (!m_panelSizesCache)
    {
      m_panelSizesCache = {
        medium: Math.max(XVMGetMaximumFieldWidth(m_names), Config.s_config.playersPanel.medium.width),
        large_names: Math.max(XVMGetMaximumFieldWidth(m_names), Config.s_config.playersPanel.large.width),
        large_vehicles: XVMGetMaximumFieldWidth(m_vehicles)
      }
    }

    //Logger.add("XVMAdjustPanelSize()");
    var namesWidthDefault = 46;
    var namesWidth = namesWidthDefault;
    var vehiclesWidthDefault = 65;
    var vehiclesWidth = vehiclesWidthDefault;
    var widthDelta = 0;
    var squadSize = 0;
    switch (m_state)
    {
      case "medium":
        namesWidth = m_panelSizesCache.medium;
        widthDelta = namesWidthDefault - namesWidth;
        break;
      case "medium2":
        vehiclesWidth = Config.s_config.playersPanel.medium2.width;
        widthDelta = vehiclesWidthDefault - vehiclesWidth;
        break;
      case "large":
        namesWidthDefault = 296;
        namesWidth = m_panelSizesCache.large_names;
        vehiclesWidth = m_panelSizesCache.large_vehicles;
        squadSize = Config.s_config.playersPanel.removeSquadIcon ? 0 : SQUAD_SIZE;
        widthDelta = namesWidthDefault - namesWidth + vehiclesWidthDefault - vehiclesWidth - squadSize + SQUAD_SIZE;
        break;
      default:
        m_list._x = players_bg._x = (m_type == "left") ? STATES[m_state].bg_x : players_bg._width - STATES[m_state].bg_x;
        return;
    }

    m_names._width = namesWidth;
    m_vehicles._width = vehiclesWidth;

    if (m_type == "left")
    {
      m_names._x = squadSize;
      m_frags._x = m_names._x + m_names._width;
      m_vehicles._x = m_frags._x + m_frags._width;
      m_list._x = players_bg._x = STATES[m_state].bg_x - widthDelta;
      if (squadSize > 0)
        m_list.updateSquadIconPosition(-m_list._x);
    }
    else
    {
      m_names._x = players_bg._width - m_names._width - squadSize;
      m_frags._x = m_names._x - m_frags._width;
      m_vehicles._x = m_frags._x - m_vehicles._width;
      m_list._x = players_bg._x = players_bg._width - STATES[m_state].bg_x + widthDelta;
      if (squadSize > 0)
        m_list.updateSquadIconPosition(-440 + m_names._width + m_frags._width + m_vehicles._width + squadSize);
    }
  }

  function XVMGetMaximumFieldWidth(field: TextField)
  {
    var max_width = 0;
    for (var i = 0; i < field.numLines; ++i)
    {
      var w = Math.round(field.getLineMetrics(i).width) + 4; // 4 is a size of gutters
      if (w > max_width)
        max_width = w;
    }
    return max_width;
  }
}
