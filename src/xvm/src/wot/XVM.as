/**
 * ...
 * @author Nikolas Siver
 * @author bkon
 * @author sirmax2
 * @author STL1te
 */
import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.easing.Linear;
import com.greensock.easing.Cubic;
import wot.utils.Config;
import wot.utils.GraphicsUtil;
//import wot.utils.Stat;

class wot.XVM extends net.wargaming.ingame.VehicleMarker
{
  // UI Elements
  var damageHolder: MovieClip;
  var healthField: TextField;
  var healthRatio: TextField;
  var xvmHealthBar: MovieClip;
  var grid: MovieClip;

  // Private members
  var m_showExInfo: Boolean = false;
  var m_currentHealth: Number;
  var m_damageFieldNumber: Number = 0;
  var m_showMaxHealth: Boolean;

  // TextFields
  var textFields: Array;
  var textFieldConfig;

  // CST Settings
  static var HIT_KIND_ABSOLUTE = 1;
  static var HIT_KIND_RELATIVE = 2;
  var cst: Object = {};

  // Healthbar Settings
  var hbBar: MovieClip;
  var hbDamageBar: MovieClip;
  var hb: Object = {};

  static var pNameFieldWidth;
  static var vNameFieldWidth;

  function XVM()
  {
    super();

    Config.LoadConfigAndStat("OTMData.xml");

    pNameFieldWidth = vNameField._width + 20;
    vNameFieldWidth = vNameField._width + 20;

    damageHolder = createEmptyMovieClip("damageHolder", getNextHighestDepth());
    xvmHealthBar = createEmptyMovieClip("xvmHealthBar", getNextHighestDepth());
    healthField = createTextField("HealthField", getNextHighestDepth(), 0, 0, 78, 20);
    healthRatio = createTextField("HealthRatio", getNextHighestDepth(), 0, 0, 78, 20);

    grid = createEmptyMovieClip("grid", getNextHighestDepth());
  }

  // override
  function init(vClass, vIconSource, vType, vLevel, pFullName, curHealth, maxHealth, entityName, speaking, hunt)
  {
    // Use currently remembered extended / normal status for new markers
    m_showExInfo = s_showExInfo;

    super.init(vClass, vIconSource, vType, vLevel, pFullName, curHealth, maxHealth, entityName, speaking, hunt);
  }

  // override
  function showHealthBar(show)
  {
    healthBar.stop();
    healthBar._visible = false;
  }

  // override
  function updateHealth(curHealth)
  {
    m_curHealth = curHealth >= 0 ? curHealth : 0;
    setupNewHealth(curHealth, m_maxHealth);
    updateHealthUI(curHealth, m_maxHealth);
  }

  // override
  function updateState(newState, isImmediate)
  {
    super.updateState(newState, isImmediate);
    updateStyle();
  }

  // override
  function showExInfo(show)
  {
    if (m_showExInfo == show)
      return;
    m_showExInfo = show;

    // Save current extended / normal state flag to static variable, so
    // new markers can refer to it when rendered initially
    s_showExInfo = show;

    updateStyle();
  }

  // override
  function configUI()
  {
    m_currentHealth = m_curHealth;

    super.configUI();

    if (Config.value("battle/drawGrid/data") == "true")
      GraphicsUtil.drawGrid(grid, -50, -50, 100, 100, 0xFFFF00, 30);

    updateStyle();
  }

  function draw()
  {
    super.draw();
    if (iconLoader != null && iconLoader.initialized)
      iconLoader.addEventListener("complete", this, "XVMIconCompleteLoad");
  }

  // override
  function populateData()
  {
    // FIXIT: it's clear, but may be not optimal
    if (!super.populateData())
      return false;

    updateCurrentColor(m_currentHealth, m_maxHealth);
    XVMPopulateData();
    setupNewHealth(m_curHealth, m_maxHealth);

    return true;
  }

  // Comment below is not useful for now, but it's very beauty, so I can't delete it :) (sirmax2)
  //
  // The name is a LIE! We're actually selecting marker color scheme here.
  // VehicleMarkerAlly should contain 4 named frames:
  // - green - normal ally
  // - gold - squad mate
  // - blue - teamkiller
  // - yellow - squad mate in "alternate colors" mode
  // VehicleMarkerEnemy should contain 2 named frames:
  // - red - normal enemy
  // - purple - enemy in "alternate colors" mode
  //function initMarkerLabel() {
  //  this.gotoAndStop(this.colorsManager.getAliasColor(this.colorSchemeName));
  //}

  // override
  function updateMarkerLabel()
  {
    // FIXIT: it's clear, but may be not optimal
    super.updateMarkerLabel();

    // Update layout for the current marker state
    XVMPopulateData();
    updateStyle();
  }

  /**
   * MAIN
   */

  function XVMColorWithFallback(value)
  {
    return Number(value || this.colorsManager.getRGB(this.colorSchemeName));
  }

  function XVMFormatText(format, curHealth, maxHealth)
  {
    // AS 2 doesn't have String.replace? Shame on them. Let's use our own square wheel.
    format = format.split("{{hp}}").join(curHealth);
    format = format.split("{{hp-max}}").join(maxHealth);
    format = format.split("{{hp-ratio}}").join(Math.ceil(curHealth / maxHealth * 100));
    format = format.split("{{nick}}").join(m_playerFullName);
    format = format.split("{{vehicle}}").join(m_vname);

    return format;
  }

  function XVMCreateNewTextFormat(format_config_path: String)
  {
    if (!format_config_path)
      return null;

    if (format_config_path.charAt(format_config_path.length - 1) != "/")
      format_config_path += "/";

    format_config_path += "attributes/";

    return new TextFormat(
      Config.value(format_config_path + "font") || "$FieldFont",
      Number(Config.value(format_config_path + "size")),
      0x000000,
      Config.value(format_config_path + "bold") == "true",
      false, false, null, null,
      String(Config.value(format_config_path + "align")));
  }

  function XVMCreateTextField(data)
  {
    var textField = createTextField("vehicleText", getNextHighestDepth(), 0, 0, 140, 31);
    var textFormat: TextFormat = XVMCreateNewTextFormat(textFieldConfig + "format");
    if (data.attributes.bold)
      textFormat.bold = true;
    textField.setNewTextFormat(textFormat);
    textField.filters = [GraphicsUtil.createShadowFilter(Config.value(textFieldConfig + "filter"))];

    textField.textColor = XVMColorWithFallback(data.attributes.color);
    textField._x = Number(data.attributes.x) - textField._width / 2;
    textField._y = Number(data.attributes.y) - textField._height / 2;
    textField._alpha = Number(data.attributes.alpha);
    textField._visible = data.attributes.visible == "true";

    return { field: textField, format: String(data.attributes.format) };
  }

  function XVMRemoveTextFields()
  {
    for (var i in this.textFields)
      this.textFields[i].field.removeTextField();
    this.textFields = [];
  }

  // Damage Visualization
  function removeTextField(f: TextField)
  {
    f.removeTextField();
  }

  function showDamage(damageValue: String)
  {
    if (!cst.enabled)
      return;

    m_damageFieldNumber += 1;

    var format: TextFormat = new TextFormat();
    var damageField = damageHolder.createTextField("field" + m_damageFieldNumber, damageHolder.getNextHighestDepth(), 0, 0, 140, 20);
    var animation: TimelineLite = new TimelineLite({
      onComplete:this.removeTextField, onCompleteParams:[damageField]});

    format.font = cst.fontName;
    format.color = cst.color;
    format.bold = true;
    format.size = cst.textSize;

    // For some reason, DropShadowFilter is not rendered when textfield contains only one character,
    // so we're appending empty prefix and suffix to bypass this unexpected behavior
    damageField.text = " " + damageValue + " ";
    damageField.antiAliasType = "advanced";
    damageField.autoSize = "left";
    damageField.border = false;
    damageField.embedFonts = true;
    damageField.setTextFormat(format);
    damageField._x = -(damageField._width >> 1);
    damageField.filters = cst.filters;

    animation.insert(new TweenLite(damageField, cst.speed, {_y:-cst.range, ease:Linear.easeOut}), 0);
  }

  // Health Visualization
  function formatScrollingDamage(value, maxHealth)
  {
    return (cst.hitKind == HIT_KIND_ABSOLUTE)
      ? cst.prefix + String(value) + cst.postfix
      : cst.prefix + Math.ceil(value / maxHealth * 100) + cst.postfix;
  }

  function setupNewHealth(curHealth, maxHealth)
  {
    var delta: Number = curHealth - m_currentHealth;
    if (delta < 0)
    {
      updateCurrentColor(curHealth, maxHealth); //colorizing health bar after taking damage

      this.showDamage((curHealth < 0)
        ? cst.text || formatScrollingDamage(m_currentHealth, maxHealth)
        : formatScrollingDamage(-delta, maxHealth));

      m_currentHealth = curHealth;

      //Flow bar animation
      TweenLite.killTweensOf(this.hbDamageBar);
      this.hbDamageBar._x = hb.border + hb.width * (curHealth / maxHealth);
      this.hbDamageBar._xscale = this.hbDamageBar._xscale + 100 * (-delta / maxHealth);
      TweenLite.to(this.hbDamageBar, hb.damageTime, {_xscale:0, ease:Cubic.easeIn});
    }
  }

  function updateHealthUI(curHealth, maxHealth)
  {
    var ratio: Number = curHealth / maxHealth * 100;
    healthField.text = m_showMaxHealth ? curHealth + " / " + maxHealth : curHealth;
    healthRatio.text = Math.ceil(ratio) + "%";
    this.hbBar._xscale = ratio;

    for (var i in this.textFields)
      this.textFields[i].field.text = this.XVMFormatText(this.textFields[i].format, curHealth, maxHealth);
  }

  function updateCurrentColor(curHealth, maxHealth)
  {
    var fullColor: Number = XVMColorWithFallback(hb.color);
    var lowColor: Number = XVMColorWithFallback(hb.lcolor || hb.color);
    var percent: Number = curHealth / maxHealth;

    //determ current (real-time) color
    hb.currColor = GraphicsUtil.colorByRatio(percent, lowColor, fullColor);
    GraphicsUtil.setColor(this.hbBar, hb.currColor); //colorizing health bar
  }

  function XVMIconCompleteLoad(event)
  {
    // Vehicle Icon
    var playerStatus = (m_entityName == "enemy") ? "enemy" : "friend";
    var p_contourIcon = "components/" + playerStatus + "/contourIcon/";
    var iconColor: Color = new Color(iconLoader);
    var tintColor: Number = Number(Config.value(p_contourIcon + "tint/attributes/color"));
    var tintAmount: Number = Number(Config.value(p_contourIcon + "tint/attributes/amount")) * 0.01;
    var tintRatio: Number;

    var iconTransform: Object = iconColor.getTransform();
    iconTransform.rb = (Number(tintColor) >> 16);
    iconTransform.gb = (Number(tintColor) >> 8) & 0xff;
    iconTransform.bb = (Number(tintColor) & 0xff);
    iconTransform.ra = 0;
    iconTransform.ga = 0;
    iconTransform.ba = 0;
    tintRatio = tintAmount / (1 - ((iconTransform.ra + iconTransform.ga + iconTransform.ba) / 300));
    iconTransform.rb *= tintRatio;
    iconTransform.gb *= tintRatio;
    iconTransform.bb *= tintRatio;
    iconTransform.ra = iconTransform.ga = iconTransform.ba = (1 - tintAmount) * 100;
    iconColor.setTransform(iconTransform);
  }

  function XVMPopulateData()
  {
    var playerStatus = (m_entityName == "enemy") ? "enemy" : "friend";
    var comp_path = "components/" + playerStatus + "/";
    var p_cstCurrent = comp_path + "combatScrollText/";
    var p_hb = comp_path + "healthBar/";
    var p_vehicleIcon = comp_path + "vehicleIcon/";
    var p_contourIcon = comp_path + "contourIcon/";
    var p_currentHealth = comp_path + "currentHealth/";
    var p_healthRatio = comp_path + "healthRatio/";
    var p_playerName = comp_path + "playerName/";
    var p_vehicleName = comp_path + "vehicleName/";

    // Player Name
    pNameField.setNewTextFormat(XVMCreateNewTextFormat(p_playerName + "format"));
    pNameField.filters = [GraphicsUtil.createShadowFilter(Config.value(p_playerName + "filter"))];
    pNameField.text = m_playerFullName;

    // Vehicle Name
    vNameField.setNewTextFormat(XVMCreateNewTextFormat(p_vehicleName + "format"));
    vNameField.filters = [GraphicsUtil.createShadowFilter(Config.value(p_vehicleName + "filter"))];
    vNameField.text = m_vname;

    // Vehicle Type Marker
    var scale = {
      x: Config.value(p_vehicleIcon + "scale/attributes/x"),
      y: Config.value(p_vehicleIcon + "scale/attributes/y"),
      maxScale: Config.value(p_vehicleIcon + "scale/attributes/maxScale")
    }
    for (var childName in marker.marker)
    {
      var child = marker.marker[childName];
      child._x += scale.x * scale.maxScale / 100;
      child._y += scale.y * scale.maxScale / 100;
      child._xscale = child._yscale = scale.maxScale;
    };

    // Level Icon
    levelIcon.gotoAndStop(m_level);

    // Vehicle Type Icon
    if (iconLoader != null && iconLoader.initialized)
    {
      iconLoader.addEventListener("complete", this, "XVMIconCompleteLoad");
      XVMIconCompleteLoad(null);
    }

    // Combat Scroll Text
    cst = {
      enabled: Config.value(p_cstCurrent + "enabled/attributes/value") == "true",
      speed: Number(Config.value(p_cstCurrent + "speed/attributes/value")),
      range: Number(Config.value(p_cstCurrent + "maxRange/attributes/value")),
      color: XVMColorWithFallback(Config.value(p_cstCurrent + "color/attributes/value")),
      fontName: Config.value(p_cstCurrent + "font/data") || "$TextFont",
      textSize: Number(Config.value(p_cstCurrent + "textSize/attributes/value")),
      text: Config.value(p_cstCurrent + "message/data"),
      prefix: Config.value(p_cstCurrent + "prefix/data") || "",
      postfix: Config.value(p_cstCurrent + "postfix/data") || "",
      hitKind: Config.value(p_cstCurrent + "hitKind/data") == "Relative" ? HIT_KIND_RELATIVE : HIT_KIND_ABSOLUTE,
      filters: [GraphicsUtil.createShadowFilter(Config.value(p_cstCurrent + "filter"))]
    }

    // Health Bar
    xvmHealthBar.clear();

    if (this.hbBar)
      this.hbBar.clear();
    else
      this.hbBar = xvmHealthBar.createEmptyMovieClip("barMC", xvmHealthBar.getNextHighestDepth());

    if (this.hbDamageBar)
      this.hbDamageBar.clear();
    else
      this.hbDamageBar = xvmHealthBar.createEmptyMovieClip("damageMC", xvmHealthBar.getNextHighestDepth());

    hb.border = Number(Config.value(p_hb + "border/attributes/size"));
    hb.width = Number(Config.value(p_hb + "fill/attributes/width"));
    hb.damageTime = Number(Config.value(p_hb + "damage/attributes/fade"));
    hb.color = Number(Config.value(p_hb + "fill/attributes/color"));
    hb.lcolor = Number(Config.value(p_hb + "fill/attributes/lcolor"));

    var hbFillHeight: Number = Number(Config.value(p_hb + "fill/attributes/height"));

    GraphicsUtil.fillRect(xvmHealthBar, 0, 0, hb.width + 2 * hb.border, hbFillHeight + 2 * hb.border,
      Number(Config.value(p_hb + "border/attributes/color")), Number(Config.value(p_hb + "border/attributes/alpha")));
    GraphicsUtil.fillRect(this.hbBar, 0, 0, hb.width, hbFillHeight,
      hb.currColor, Number(Config.value(p_hb + "fill/attributes/alpha")));
    GraphicsUtil.fillRect(this.hb.damageBar, 0, 0, hb.width, hbFillHeight,
      XVMColorWithFallback(Config.value(p_hb + "damage/attributes/color")), Number(Config.value(p_hb + "damage/attributes/alpha")));

    this.hbBar._x = this.hbBar._y = hb.border;
    this.hbDamageBar._x = hb.border + hb.width;
    this.hbDamageBar._y = hb.border;
    this.hbDamageBar._xscale = 0;

    // Health Field
    m_showMaxHealth = Config.value(p_currentHealth + "maxValue/attributes/enabled") == "true";
    healthField.setNewTextFormat(XVMCreateNewTextFormat(p_currentHealth + "format"));
    healthField.filters = [GraphicsUtil.createShadowFilter(Config.value(p_currentHealth + "filter"))];

    // Health Ratio
    healthRatio.setNewTextFormat(XVMCreateNewTextFormat(p_healthRatio + "format"));
    healthRatio.filters = [GraphicsUtil.createShadowFilter(Config.value(p_healthRatio + "filter"))];

    // Info Text
    XVMRemoveTextFields();
    this.textFieldConfig = comp_path + "infoText/";
  }

  function updateStyle()
  {
    var playerStatus = m_entityName == "enemy" ? "enemy" : "friend";
    var vehicleStatus = this.vehicleDestroyed ? "dead" : "alive";
    var uiStatus = m_showExInfo ? "extended" : "normal";
    var b_path = "behavior/" + playerStatus + "/" + vehicleStatus + "/" + uiStatus + "/";

    // Player Name
    pNameField.textColor = XVMColorWithFallback(Config.value(b_path + "playerName/attributes/color"));
    pNameField._x = Number(Config.value(b_path + "playerName/attributes/x"));
    pNameField._y = Number(Config.value(b_path + "playerName/attributes/y"));
    pNameField._alpha = Number(Config.value(b_path + "playerName/attributes/alpha"));
    pNameField._visible = Config.value(b_path + "playerName/attributes/visible") == "true";
    pNameField._width = pNameFieldWidth;

    // Vehicle Name
    vNameField.textColor = XVMColorWithFallback(Config.value(b_path + "vehicleName/attributes/color"));
    vNameField._x = Number(Config.value(b_path + "vehicleName/attributes/x"));
    vNameField._y = Number(Config.value(b_path + "vehicleName/attributes/y"));
    vNameField._alpha = Number(Config.value(b_path + "vehicleName/attributes/alpha"));
    vNameField._visible = Config.value(b_path + "vehicleName/attributes/visible") == "true";
    vNameField._width = vNameFieldWidth;

    // Vehicle Type Marker
    marker._x = Number(Config.value(b_path + "vehicleIcon/attributes/x"));
    marker._y = Number(Config.value(b_path + "vehicleIcon/attributes/y"));
    marker._alpha = Number(Config.value(b_path + "vehicleIcon/attributes/alpha"));
    marker._visible = Config.value(b_path + "vehicleIcon/attributes/visible") == "true";

    // Level Icon
    levelIcon._x = Config.value(b_path + "levelIcon/attributes/x");
    levelIcon._y = Number(Config.value(b_path + "levelIcon/attributes/y"));
    levelIcon._alpha = Number(Config.value(b_path + "levelIcon/attributes/alpha"));
    levelIcon._visible = Config.value(b_path + "levelIcon/attributes/visible") == "true";

    // Action Marker
    actionMarker._x = Number(Config.value(b_path + "actionMarker/attributes/x"));
    actionMarker._y = Number(Config.value(b_path + "actionMarker/attributes/y"));

    // Vehicle Icon
    iconLoader._x = Number(Config.value(b_path + "contourIcon/attributes/x")) - iconLoader._width / 2;
    iconLoader._y = Number(Config.value(b_path + "contourIcon/attributes/y")) - iconLoader._height / 2;
    iconLoader._alpha = Number(Config.value(b_path + "contourIcon/attributes/alpha"));
    iconLoader._visible = Config.value(b_path + "contourIcon/attributes/visible") == "true";

    // Combat Scroll Text
    damageHolder._x = Number(Config.value(b_path + "combatScrollText/attributes/x"));
    damageHolder._y = Number(Config.value(b_path + "combatScrollText/attributes/y"));

    // Health Bar
    xvmHealthBar._x = Number(Config.value(b_path + "healthBar/attributes/x"));
    xvmHealthBar._y = Number(Config.value(b_path + "healthBar/attributes/y"));
    xvmHealthBar._alpha = Number(Config.value(b_path + "healthBar/attributes/alpha"));
    xvmHealthBar._visible = Config.value(b_path + "healthBar/attributes/visible") == "true";

    // Health Field
    healthField.textColor = XVMColorWithFallback(Config.value(b_path + "currentHealth/attributes/color"));
    healthField._x = Number(Config.value(b_path + "currentHealth/attributes/x"));
    healthField._y = Number(Config.value(b_path + "currentHealth/attributes/y")) + 2; // sirmax: why this value?
    healthField._alpha = Number(Config.value(b_path + "currentHealth/attributes/alpha"));
    healthField._visible = Config.value(b_path + "currentHealth/attributes/visible") == "true";

    // Health Ratio
    healthRatio.textColor = XVMColorWithFallback(Config.value(b_path + "healthRatio/attributes/color"));
    healthRatio._x = Number(Config.value(b_path + "healthRatio/attributes/x"));
    healthRatio._y = Number(Config.value(b_path + "healthRatio/attributes/y")) + 2; // sirmax: why this value?
    healthRatio._alpha = Number(Config.value(b_path + "healthRatio/attributes/alpha"));
    healthRatio._visible = Config.value(b_path + "healthRatio/attributes/visible") == "true";

    // Info Text
    this.XVMRemoveTextFields();
    var infoText = Config.value(b_path + "infoText");
    if (infoText instanceof Array)
    {
      this.textFields = [];
      for (var i in infoText)
        this.textFields.push(XVMCreateTextField(infoText[i]));
    }
    else
    {
      this.textFields = [XVMCreateTextField(infoText)];
    };

    // Update Colors
    this.updateCurrentColor(m_curHealth, m_maxHealth);
    this.updateHealthUI(m_curHealth, m_maxHealth);
  }
}
