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

  var _init:Boolean = false;

  // Centered _y value of text field 
  var centeredTextY:Number;
  var leadingNames:Number;
  var leadingVehicles:Number;
  
  function setData2(data, sel, postmortemIndex, isColorBlind, knownPlayersCount)
  {
    //Logger.add("PlayersPanel.setData2()");
    //Logger.add(data);

    var start = new Date();

    m_names.condenseWhite = true;
    m_vehicles.condenseWhite = true;

    if (!_init)
    {
        _init = true;
        centeredTextY = m_names._y - 5;
        m_names.verticalAlign = "top"; // for incomplete team - cannot set to "center"
        m_vehicles.verticalAlign = "top"; // for incomplete team - cannot set to "center"
    }

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

    // FIXIT: this code is not optimal. Find how to set default leading for text fields and remove this code.
    m_names.htmlText = m_names.htmlText.split('LEADING="9"').join('LEADING="' + leadingNames + '"');
    m_names._y = centeredTextY + leadingNames / 2.0; // centering on cell, because of align=top
    
    m_vehicles.htmlText = m_vehicles.htmlText.split('LEADING="9"').join('LEADING="' + leadingVehicles + '"');
    m_vehicles._y = centeredTextY + leadingVehicles / 2.0; // centering on cell, because of align=top

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
    if (m_fieldType == Defines.FIELDTYPE_NONE)
      return super._getHTMLText(colorScheme, text);
    
    var format: String = null;
    switch (m_state)
    {
      case "medium":
        if (m_fieldType == Defines.FIELDTYPE_VEHICLE)
          break;
        format = (m_type == "left")
          ? Config.s_config.playersPanel.medium.formatLeft
          : Config.s_config.playersPanel.medium.formatRight;
        break;
      case "medium2":
        if (m_fieldType == Defines.FIELDTYPE_NICK)
          break;
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
        else if (m_fieldType == Defines.FIELDTYPE_VEHICLE)
        {
          format = (m_type == "left")
            ? Config.s_config.playersPanel.large.vehicleFormatLeft
            : Config.s_config.playersPanel.large.vehicleFormatRight;
        }
        break;
      default:
        break;
    }

    if (format != null)
    {
      //Logger.add("before: " + text);
      var data = m_data[m_item++];
      var deadState = Utils.endsWith("dead", colorScheme) ? Defines.DEADSTATE_DEAD : Defines.DEADSTATE_ALIVE;
      var key = "PP/" + deadState + "/" + data.label + "/" + data.vehicle + "/" +
        m_state + "/" + m_fieldType;
      text = TextCache.Get(key) || TextCache.Format(key, data, format,
        (m_state == "medium" || m_state == "medium2" || m_state == "large") ? Config.s_config.playersPanel[m_state].width : -1,
        (m_state == "medium" || m_state == "medium2" || m_state == "large") ? m_names.getNewTextFormat() : null,
        deadState);
      //Logger.add("after: " + text);
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

    if (m_names && m_names._visible)
        leadingNames = 29 - XVMGetMaximumFieldHeight(m_names);

    if (m_vehicles && m_vehicles._visible)
        leadingVehicles = 29 - XVMGetMaximumFieldHeight(m_vehicles);

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

  function XVMGetMaximumFieldHeight(field: TextField)
  {
    var max_height = 0;
    for (var i = 0; i < field.numLines; ++i)
    {
      var w = Math.round(field.getLineMetrics(i).height) + 4; // 4 is a size of gutters
      if (w > max_height)
        max_height = w;
    }
    return max_height;
  }
}
