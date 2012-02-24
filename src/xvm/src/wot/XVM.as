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
import wot.utils.ConfigOld;
import wot.utils.GraphicsUtil;
import wot.utils.Stat;

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

    Config.LoadConfigAndStat("XVM.xvmconf");
    ConfigOld.LoadConfigAndStat("OTMData.xml");

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
    if (entityName != null)
      m_entityName = entityName;

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

    if (ConfigOld.bool("battle/drawGrid/data"))
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
    var color = value ? Number(Stat.FormatText(m_playerFullName, value).split("#").join("0x")) : null;
    return (color && !isNaN(color)) ? color : this.colorsManager.getRGB(this.colorSchemeName);
  }

  function XVMFormatText(format, curHealth, maxHealth)
  {
    // AS 2 doesn't have String.replace? Shame on them. Let's use our own square wheel.
    format = format.split("{{hp}}").join(curHealth);
    format = format.split("{{hp-max}}").join(maxHealth);
    format = format.split("{{hp-ratio}}").join(Math.ceil(curHealth / maxHealth * 100));
    format = format.split("{{nick}}").join(m_playerFullName);
    format = format.split("{{vehicle}}").join(m_vname);

    format = Stat.FormatText(m_playerFullName, format);
    format = wot.utils.Utils.trim(format);

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
      ConfigOld.string(format_config_path + "font", "$FieldFont"),
      ConfigOld.int(format_config_path + "size", 12),
      0x000000,
      ConfigOld.bool(format_config_path + "bold"),
      false, false, null, null,
      ConfigOld.string(format_config_path + "align"));
  }

  function XVMCreateTextField(data)
  {
    var textField = createTextField("infoText", getNextHighestDepth(), 0, 0, 140, 31);
    // textField.html = true; // FIXIT: in html mode Font and Position are wrong.
    var textFormat: TextFormat = XVMCreateNewTextFormat(textFieldConfig + "format");
    if (data.attributes.bold)
      textFormat.bold = true;
    textField.setNewTextFormat(textFormat);
    textField.filters = [GraphicsUtil.createShadowFilter(ConfigOld.value(textFieldConfig + "filter"))];

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
    var playerStatus = (m_entityName == "enemy") ? "enemy" : "friend";
    var p_hb = "components/" + playerStatus + "/healthBar/";
    var color = ConfigOld.string(p_hb + "fill/attributes/color");
    var lcolor = ConfigOld.string(p_hb + "fill/attributes/lcolor");

    var fullColor: Number = XVMColorWithFallback(color);
    var lowColor: Number = XVMColorWithFallback(lcolor || color);

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
    var tintColor: Number = XVMColorWithFallback(ConfigOld.string(p_contourIcon + "tint/attributes/color"));
    var tintAmount: Number = ConfigOld.int(p_contourIcon + "tint/attributes/amount") * 0.01;
    var tintRatio: Number;

    var iconTransform: Object = iconColor.getTransform();
    iconTransform.rb = (tintColor >> 16);
    iconTransform.gb = (tintColor >> 8) & 0xff;
    iconTransform.bb = (tintColor & 0xff);
    iconTransform.ra = 0;
    iconTransform.ga = 0;
    iconTransform.ba = 0;
    tintRatio = tintAmount / (1 - ((iconTransform.ra + iconTransform.ga + iconTransform.ba) / 300));
    iconTransform.rb *= tintRatio;
    iconTransform.gb *= tintRatio;
    iconTransform.bb *= tintRatio;
    iconTransform.ra = iconTransform.ga = iconTransform.ba = (1 - tintAmount) * 100;
    iconColor.setTransform(iconTransform);

    updateStyle();
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
    pNameField.filters = [GraphicsUtil.createShadowFilter(ConfigOld.value(p_playerName + "filter"))];
    pNameField.text = m_playerFullName;

    // Vehicle Name
    vNameField.setNewTextFormat(XVMCreateNewTextFormat(p_vehicleName + "format"));
    vNameField.filters = [GraphicsUtil.createShadowFilter(ConfigOld.value(p_vehicleName + "filter"))];
    vNameField.text = m_vname;

    // Vehicle Type Marker
    var scale = {
      x: ConfigOld.int(p_vehicleIcon + "scale/attributes/x"),
      y: ConfigOld.int(p_vehicleIcon + "scale/attributes/y"),
      maxScale: ConfigOld.int(p_vehicleIcon + "scale/attributes/maxScale", 100)
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
      enabled: ConfigOld.bool(p_cstCurrent + "enabled/attributes/value"),
      speed: ConfigOld.int(p_cstCurrent + "speed/attributes/value", 2),
      range: ConfigOld.int(p_cstCurrent + "maxRange/attributes/value", 40),
      color: XVMColorWithFallback(ConfigOld.string(p_cstCurrent + "color/attributes/value")),
      fontName: ConfigOld.string(p_cstCurrent + "font/data", "$TextFont"),
      textSize: ConfigOld.int(p_cstCurrent + "textSize/attributes/value", 12),
      text: ConfigOld.string(p_cstCurrent + "message/data"),
      prefix: ConfigOld.string(p_cstCurrent + "prefix/data", ""),
      postfix: ConfigOld.string(p_cstCurrent + "postfix/data", ""),
      hitKind: ConfigOld.string(p_cstCurrent + "hitKind/data").toLowerCase() == "relative" ? HIT_KIND_RELATIVE : HIT_KIND_ABSOLUTE,
      filters: [GraphicsUtil.createShadowFilter(ConfigOld.value(p_cstCurrent + "filter"))]
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

    hb.border = ConfigOld.int(p_hb + "border/attributes/size", 1);
    hb.width = ConfigOld.int(p_hb + "fill/attributes/width", 80);
    hb.damageTime = ConfigOld.int(p_hb + "damage/attributes/fade", 1);

    var hbFillHeight: Number = ConfigOld.int(p_hb + "fill/attributes/height", 12);

    GraphicsUtil.fillRect(xvmHealthBar, 0, 0, hb.width + 2 * hb.border, hbFillHeight + 2 * hb.border,
      ConfigOld.int(p_hb + "border/attributes/color", 0x000000), ConfigOld.int(p_hb + "border/attributes/alpha", 30));
    GraphicsUtil.fillRect(this.hbBar, 0, 0, hb.width, hbFillHeight,
      hb.currColor, ConfigOld.int(p_hb + "fill/attributes/alpha", 30));
    GraphicsUtil.fillRect(this.hbDamageBar, 0, 0, hb.width, hbFillHeight,
      XVMColorWithFallback(ConfigOld.string(p_hb + "damage/attributes/color")), ConfigOld.int(p_hb + "damage/attributes/alpha", 80));

    this.hbBar._x = this.hbBar._y = hb.border;
    this.hbDamageBar._x = hb.border + hb.width;
    this.hbDamageBar._y = hb.border;
    this.hbDamageBar._xscale = 0;

    // Health Field
    m_showMaxHealth = ConfigOld.bool(p_currentHealth + "maxValue/attributes/enabled");
    healthField.setNewTextFormat(XVMCreateNewTextFormat(p_currentHealth + "format"));
    healthField.filters = [GraphicsUtil.createShadowFilter(ConfigOld.value(p_currentHealth + "filter"))];

    // Health Ratio
    healthRatio.setNewTextFormat(XVMCreateNewTextFormat(p_healthRatio + "format"));
    healthRatio.filters = [GraphicsUtil.createShadowFilter(ConfigOld.value(p_healthRatio + "filter"))];

    // Info Text
    XVMRemoveTextFields();
    this.textFieldConfig = comp_path + "infoText/";
  }

  function updateStyle()
  {
    try
    {
      var playerStatus = m_entityName == "enemy" ? "enemy" : "friend";
      var vehicleStatus = this.vehicleDestroyed ? "dead" : "alive";
      var uiStatus = m_showExInfo ? "extended" : "normal";
      var b_path = "behavior/" + playerStatus + "/" + vehicleStatus + "/" + uiStatus + "/";

      // Player Name
      pNameField.textColor = XVMColorWithFallback(ConfigOld.string(b_path + "playerName/attributes/color"));
      pNameField._x = ConfigOld.int(b_path + "playerName/attributes/x");
      pNameField._y = ConfigOld.int(b_path + "playerName/attributes/y");
      pNameField._alpha = ConfigOld.int(b_path + "playerName/attributes/alpha", 100);
      pNameField._visible = ConfigOld.bool(b_path + "playerName/attributes/visible");
      pNameField._width = pNameFieldWidth;

      // Vehicle Name
      vNameField.textColor = XVMColorWithFallback(ConfigOld.string(b_path + "vehicleName/attributes/color"));
      vNameField._x = ConfigOld.int(b_path + "vehicleName/attributes/x");
      vNameField._y = ConfigOld.int(b_path + "vehicleName/attributes/y");
      vNameField._alpha = ConfigOld.int(b_path + "vehicleName/attributes/alpha", 100);
      vNameField._visible = ConfigOld.bool(b_path + "vehicleName/attributes/visible");
      vNameField._width = vNameFieldWidth;

      // Vehicle Type Marker
      marker._x = ConfigOld.int(b_path + "vehicleIcon/attributes/x");
      marker._y = ConfigOld.int(b_path + "vehicleIcon/attributes/y");
      marker._alpha = ConfigOld.int(b_path + "vehicleIcon/attributes/alpha", 100);
      marker._visible = ConfigOld.bool(b_path + "vehicleIcon/attributes/visible");

      // Level Icon
      levelIcon._x = ConfigOld.int(b_path + "levelIcon/attributes/x");
      levelIcon._y = ConfigOld.int(b_path + "levelIcon/attributes/y");
      levelIcon._alpha = ConfigOld.int(b_path + "levelIcon/attributes/alpha", 100);
      levelIcon._visible = ConfigOld.bool(b_path + "levelIcon/attributes/visible");

      // Action Marker
      actionMarker._x = ConfigOld.int(b_path + "actionMarker/attributes/x");
      actionMarker._y = ConfigOld.int(b_path + "actionMarker/attributes/y");

      // Vehicle Icon
      iconLoader._x = ConfigOld.int(b_path + "contourIcon/attributes/x") - iconLoader.__width / 2;
      iconLoader._y = ConfigOld.int(b_path + "contourIcon/attributes/y") - iconLoader.__height / 2;
      iconLoader._alpha = ConfigOld.int(b_path + "contourIcon/attributes/alpha", 100);
      iconLoader._visible = ConfigOld.bool(b_path + "contourIcon/attributes/visible");

      // Combat Scroll Text
      damageHolder._x = ConfigOld.int(b_path + "combatScrollText/attributes/x");
      damageHolder._y = ConfigOld.int(b_path + "combatScrollText/attributes/y");

      // Health Bar
      xvmHealthBar._x = ConfigOld.int(b_path + "healthBar/attributes/x");
      xvmHealthBar._y = ConfigOld.int(b_path + "healthBar/attributes/y");
      xvmHealthBar._alpha = ConfigOld.int(b_path + "healthBar/attributes/alpha", 100);
      xvmHealthBar._visible = ConfigOld.bool(b_path + "healthBar/attributes/visible");

      // Health Field
      healthField.textColor = XVMColorWithFallback(ConfigOld.string(b_path + "currentHealth/attributes/color"));
      healthField._x = ConfigOld.int(b_path + "currentHealth/attributes/x");
      healthField._y = ConfigOld.int(b_path + "currentHealth/attributes/y") + 2; // sirmax: why this value?
      healthField._alpha = ConfigOld.int(b_path + "currentHealth/attributes/alpha", 100);
      healthField._visible = ConfigOld.bool(b_path + "currentHealth/attributes/visible");

      // Health Ratio
      healthRatio.textColor = XVMColorWithFallback(ConfigOld.string(b_path + "healthRatio/attributes/color"));
      healthRatio._x = ConfigOld.int(b_path + "healthRatio/attributes/x");
      healthRatio._y = ConfigOld.int(b_path + "healthRatio/attributes/y") + 2; // sirmax: why this value?
      healthRatio._alpha = ConfigOld.int(b_path + "healthRatio/attributes/alpha", 100);
      healthRatio._visible = ConfigOld.bool(b_path + "healthRatio/attributes/visible");

      // Info Text
      this.XVMRemoveTextFields();
      var infoText = ConfigOld.value(b_path + "infoText");
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
    catch (e)
    {
      XVMSetErrorText("ERR:us:" + String(e));
    }
  }

  function XVMSetErrorText(str)
  {
      pNameField.setNewTextFormat(new TextFormat("$FieldFont", 13, 0xFF0000, true, false, true, null, null, "center"));
      pNameField.text = str;
      pNameField._width = 150;
      pNameField._height = 20;
      pNameField._x = -75;
      pNameField._y = 5;
      pNameField._alpha = 100;
      pNameField._visible = true;
  }
}
