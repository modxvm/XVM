/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.Logger;
import wot.utils.TextCache;
import wot.utils.Utils;

class wot.PlayersPanel extends net.wargaming.ingame.PlayersPanel
{
  static var DEBUG_TIMES = false;

  private var m_fieldType: Number = 0;
  private var m_data: Object = null;
  private var m_item: Number = 0;

  private var m_knownPlayersCount = 0; // for Fog of War mode.
  
  function PlayersPanel()
  {
    super();

    Utils.TraceXvmModule("PlayersPanel");

    Config.LoadConfig("PlayersPanel.as");
  }

  // override
  private var _initialized = false;
  private var _lastAdjustedState = "";
  function setData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount)
  {
    //Logger.add("PlayersPanel.setData()");
    // fix WG bug - double redrawing panels on kill
    onEnterFrame = function()
    {
      delete this.onEnterFrame;
      this.setData2(data, sel, postmortemIndex, isColorBlind, knownPlayersCount);
    }
  }

  function setData2(data, sel, postmortemIndex, isColorBlind, knownPlayersCount)
  {
    //Logger.add("PlayersPanel.setData2()");
    //Logger.add(data);

    var start = new Date();

    m_names.condenseWhite = true;
    m_vehicles.condenseWhite = true;

    super.setData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount);

    players_bg._alpha = Config.s_config.playersPanel.alpha;
    m_list._alpha = Config.s_config.playersPanel.iconAlpha;

    if (data && m_knownPlayersCount != data.length)
    {
      m_knownPlayersCount = data.length;
      XVMAdjustPanelSize();
    }
    
    if (m_state != _lastAdjustedState)
    {
      XVMAdjustPanelSize();
      _lastAdjustedState = m_state;
    }

    if (DEBUG_TIMES)
      Logger.add("DEBUG TIME: PlayersPanel: setData2(): " + Utils.elapsedMSec(start, new Date()) + " ms");
  }

  // override
  function onRecreateDevice(width, height)
  {
    //Logger.add("PlayersPanel.onRecreateDevice()");
    super.onRecreateDevice(width, height);
    XVMAdjustPanelSize();
  }

  // override
  function _setVehiclesStr(data, sel, isColorBlind, knownPlayersCount)
  {
    //Logger.add("PlayersPanel._setVehiclesStr(): knownPlayersCount=" + knownPlayersCount + " sel=" + sel);
    try
    {
      m_fieldType = Defines.FIELDTYPE_VEHICLE;
      m_data = data;
      m_item = 0;
      super._setVehiclesStr(data, sel, isColorBlind, knownPlayersCount);
    }
    finally
    {
      m_fieldType = Defines.FIELDTYPE_NONE;
      m_data = null;
      m_item = 0;
    }
  }

  // override
  function _setNamesStr(data, sel, isColorBlind, knownPlayersCount)
  {
    //Logger.add("PlayersPanel._setNameStr()");
    try
    {
      m_fieldType = Defines.FIELDTYPE_NICK;
      m_data = data;
      m_item = 0;
      super._setNamesStr(data, sel, isColorBlind, knownPlayersCount);
    }
    finally
    {
      m_fieldType = Defines.FIELDTYPE_NONE;
      m_data = null;
      m_item = 0;
    }
  }

  // override
  function updateWidthOfLongestName()
  {
    //Logger.add("PlayersPanel.updateWidthOfLongestName()");
    // do nothing
  }

  // override
  function _getHTMLText(colorScheme, text)
  {
    //Logger.add("PlayersPanel._getHTMLText()");
    if (m_fieldType != Defines.FIELDTYPE_NONE)
    {
      //var name = m_data.label + ((m_data.clanAbbrev == "") ? "" : "[" + m_data.clanAbbrev + "]");
      var format: String = null;
      switch (m_state)
      {
        case "medium":
          if (m_fieldType == Defines.FIELDTYPE_VEHICLE)
            break;
            //return m_data.vehicle;
          format = (m_type == "left")
            ? Config.s_config.playersPanel.medium.formatLeft
            : Config.s_config.playersPanel.medium.formatRight;
          break;
        case "medium2":
          if (m_fieldType == Defines.FIELDTYPE_NICK)
            break;//return name;
          format = (m_type == "left")
            ? Config.s_config.playersPanel.medium2.formatLeft
            : Config.s_config.playersPanel.medium2.formatRight;
          break;
        case "large":
          if (m_fieldType == Defines.FIELDTYPE_NICK)
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
          break;//return (m_fieldType == Defines.FIELDTYPE_NICK) ? name : m_data.vehicle;
      }

      if (format)
      {
        //Logger.add("before: " + text);
        text = TextCache.GetFormattedText(
          m_data[m_item++],
          "PP_" + m_state + "_" + m_fieldType,
          Utils.endsWith("dead", colorScheme),
          format,
          (m_state == "medium" || m_state == "medium2" || m_state == "large") ? Config.s_config.playersPanel[m_state].width : -1,
          (m_state == "medium" || m_state == "medium2" || m_state == "large") ? m_names.getNewTextFormat() : null);
        //Logger.add("after: " + text);
      }
    }

    return super._getHTMLText(colorScheme, text);
  }

  /**
   * XVM
   */

  function XVMAdjustPanelSize()
  {
    //Logger.add("PlayersPanel.XVMAdjustPanelSize()");

    var namesWidthDefault = 46;
    var namesWidth = namesWidthDefault;
    var vehiclesWidthDefault = 65;
    var vehiclesWidth = vehiclesWidthDefault;
    var widthDelta = 0;
    var squadSize = 0;
    switch (m_state)
    {
      case "medium":
        namesWidth = Math.max(XVMGetMaximumFieldWidth(m_names), Config.s_config.playersPanel.medium.width);
        widthDelta = namesWidthDefault - namesWidth;
        break;
      case "medium2":
        vehiclesWidth = Config.s_config.playersPanel.medium2.width;
        widthDelta = vehiclesWidthDefault - vehiclesWidth;
        break;
      case "large":
        namesWidthDefault = 296;
        namesWidth = Math.max(XVMGetMaximumFieldWidth(m_names), Config.s_config.playersPanel.large.width);
        vehiclesWidth = XVMGetMaximumFieldWidth(m_vehicles);
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
