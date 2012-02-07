import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.easing.Linear;
import com.greensock.easing.Cubic;
import wot.utils.Config;
import wot.utils.GraphicsUtil;
import wot.utils.Stat;

class wot.XVM extends net.wargaming.ingame.VehicleMarker
{
  // static members
  static var s_userNames:Array = [];

  // UI Elements
  var actionMarker:MovieClip;
  var damageHolder:MovieClip;
  var contourIcon:MovieClip;
  var levelIcon:MovieClip;
  var pNameField:TextField;
  var vNameField:TextField;
  var healthField:TextField;
  var healthRatio:TextField;
  var healthBar:MovieClip;
  var marker:MovieClip;

  // Private members
  var m_showExInfo:Boolean = false;
  var m_currentHealth:Number;
  var m_damageFieldNumber: Number = 0;
  var m_showMaxHealth:Boolean;

  //TextFields
  var textFields: Array;
  var textFieldConfig;

  // Icon Loader
  var loader : MovieClipLoader;
  var iconHolder : MovieClip;

  //CST Settings
  static var HIT_KIND_ABSOLUTE = 1;
  static var HIT_KIND_RELATIVE = 2;
  var cst:Object = {};

  //Healthbar Settings
  var hbBar : MovieClip;
  var hbDamageBar : MovieClip;
  var hbBorder : Number;
  var hbWidth : Number;
  var hbDamageTime : Number;
  var hbCurrColor : Number;
  var hbColor : Number;
  var hbLColor : Number;

  /**
   * OVERRIDES
   */

  // ctor
  function XVM()
  {
    super();
    Config.LoadConfig();
    this.actionMarker = this.attachMovie("ActionMarkers", "actionMarkers", 1, {_x: 0, _y: 0});
  }

  // override initialization
  function init(vClass, vIconSource, vType, vLevel, pFullName, curHealth, maxHealth, entityName, speaking, hunt)
  {
	var pname = pFullName.toUpperCase().split("[")[0];
    var found:Boolean = false;
	for (var i = 0; i < s_userNames.length; i++)
	{
		if (s_userNames[i] == pname)
		{
			found == true;
			break;
		}
	}
	if (!found)
		s_userNames.push(pname);

    // Use currently remembered extended / normal status for new markers
    m_showExInfo = s_showExInfo;
	//gfx.io.GameDelegate.addCallBack("XVM.configChanged", this, "updateMarkerLabel");
	//gfx.io.GameDelegate.addCallBack("XVM.configChanged", this, "test");
    //Config.listeners.push([this, "test"]);

    super.init(vClass, vIconSource, vType, vLevel, pFullName, curHealth, maxHealth, entityName, speaking, hunt);
  }

  function test()
  {
	  showDamage("TEST");
  }

  // system colors support (fix decompiler error)
  function get colorsManager()
  {
    return (net.wargaming.managers.ColorSchemeManager.instance);
  }

  // system colors support (fix decompiler error)
  function get colorSchemeName()
  {
    return ((this.vehicleDestroyed() ? ("vm_dead_") : ("vm_")) + m_entityName);
  }

  // override health changing
  function updateHealth(curHealth)
  {
    m_curHealth = curHealth >= 0 ? (curHealth) : (0);
    setupNewHealth(curHealth, m_maxHealth);
    updateHealthUI(curHealth, m_maxHealth);
  }

  // override
  function updateState(newState, isImmediate)
  {
    super.updateState(newState, isImmediate);

    this.updateStyle();
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

    this.updateStyle();
  }

  // override
  function configUI()
  {
    m_currentHealth = m_curHealth;

    super.configUI();

    this.updateStyle();
  }

  // override
  function populateData()
  {
	//Stat.ReloadStat("stat/@log populateData " + m_playerFullName.toUpperCase() + ".xml");
    // FIXIT: it's clear, but may be not optimal
    if (!super.populateData())
      return false;

    updateCurrentColor(m_currentHealth, m_maxHealth);
    OTMPopulateData();
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

  function updateMarkerLabel()
  {
	// FIXIT: it's clear, but may be not optimal
    super.updateMarkerLabel();

    // Update OTM layout for the current marker state
    this.OTMPopulateData();
    this.updateStyle();
  }

  /**
   * MAIN
   */

  function OTMColorWithFallback(value)
  {
    return Number(value || this.colorsManager.getRGB(this.colorSchemeName));
  }

  function OTMFormatText(format, curHealth, maxHealth)
  {
    // AS 2 doesn't have String.replace? Shame on them. Let's use our own square wheel.
    format = format.split("{{hp}}").join(curHealth);
    format = format.split("{{hp-max}}").join(maxHealth);
    format = format.split("{{hp-ratio}}").join(Math.ceil(curHealth / maxHealth * 100));
    format = format.split("{{nick}}").join(m_playerFullName);
    format = format.split("{{vehicle}}").join(m_vname);

    return format;
  }

  // Damage Visualization
  function removeTextField(f:TextField)
  {
    f.removeTextField();
  }

  function showDamage(damageValue:String)
  {
    if (!cst.enabled)
      return;

    m_damageFieldNumber += 1;

    var format: TextFormat = new TextFormat();
    var damageField = damageHolder.createTextField("field" + m_damageFieldNumber,
      damageHolder.getNextHighestDepth(), 0, 0, 140, 20);
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
      this.hbDamageBar._x = hbBorder + hbWidth * (curHealth / maxHealth);
      this.hbDamageBar._xscale = this.hbDamageBar._xscale + 100 * (-delta / maxHealth);
      TweenLite.to(this.hbDamageBar, hbDamageTime, {_xscale:0, ease:Cubic.easeIn});
    }
  }

  function updateHealthUI(curHealth, maxHealth)
  {
    var ratio: Number = curHealth / maxHealth * 100;
    healthField.text = m_showMaxHealth ? curHealth + " / " + maxHealth : curHealth;
    healthRatio.text = Math.ceil(ratio) + "%";
    this.hbBar._xscale = ratio;

    for (var i in this.textFields)
      this.textFields[i].field.text = this.OTMFormatText(this.textFields[i].format, curHealth, maxHealth);
  }

  function updateCurrentColor(curHealth, maxHealth)
  {
    var fullColor:Number = OTMColorWithFallback(hbColor);
    var lowColor:Number = OTMColorWithFallback(hbLColor || hbColor);
    var percent:Number = curHealth / maxHealth;

    //determ current (real-time) color
    hbCurrColor = GraphicsUtil.colorByRatio(percent, lowColor, fullColor);
    GraphicsUtil.setColor(this.hbBar, hbCurrColor); //colorizing health bar
  }

  function OTMPopulateData()
  {
    var playerStatus = (m_entityName == "enemy") ? "enemy" : "friend";
    var data = Config.config.overTargetMarkers.components[playerStatus];
    var cstCurrentSettings = data.combatScrollText;
    var hbSettings = data.healthBar;
    var vehicleIconSettings = data.vehicleIcon;
    var contourIconSettings = data.contourIcon;
    var currentHealthSettings = data.currentHealth;
    var healthRatioSettings = data.healthRatio;
    var playerNameSettings = data.playerName;
    var vehicleNameSettings = data.vehicleName;

	var scaleattr = vehicleIconSettings.scale.attributes;
    for (var childName in marker.marker)
	{
      var child = marker.marker[childName];
      child._x += scaleattr.x * scaleattr.maxScale / 100;
      child._y += scaleattr.y * scaleattr.maxScale / 100;
      child._xscale = child._yscale = scaleattr.maxScale;
    };

    //Contour Icons
    var contourColor:Color = new Color(contourIcon);
    var tintColor:Number = Number(contourIconSettings.tint.attributes.color);
    var tintAmount:Number = Number(contourIconSettings.tint.attributes.amount) * 0.01;
    var tintRatio:Number;

    var contourTransform:Object = contourColor.getTransform();
    contourTransform.rb = (Number(tintColor) >> 16);
    contourTransform.gb = (Number(tintColor) >> 8) & 0xff;
    contourTransform.bb = (Number(tintColor) & 0xff);
    contourTransform.ra = 0;
    contourTransform.ga = 0;
    contourTransform.ba = 0;
    tintRatio = tintAmount/ (1 - ((contourTransform.ra + contourTransform.ga + contourTransform.ba) / 300));
    contourTransform.rb *= tintRatio;
    contourTransform.gb *= tintRatio;
    contourTransform.bb *= tintRatio;
    contourTransform.ra = contourTransform.ga = contourTransform.ba = (1 - tintAmount) * 100;
    contourColor.setTransform(contourTransform);

    var me = this;
    iconHolder = contourIcon.createEmptyMovieClip("holder", 0);
    loader = new MovieClipLoader();
    loader.addListener({
      onLoadInit: function(content) {
        content._x = - content._width / 2;
        content._y = - content._height / 2;
        me.updateStyle();
      }
    });
    loader.loadClip(m_source, iconHolder);

    //Extract CST Settings
	cst = {
      enabled: cstCurrentSettings.enabled.attributes.value == "true",
      speed: Number(cstCurrentSettings.speed.attributes.value),
      range: Number(cstCurrentSettings.maxRange.attributes.value),
      color: OTMColorWithFallback(cstCurrentSettings.color.attributes.value),
      fontName: cstCurrentSettings.font.data || "$TextFont",
      textSize: Number(cstCurrentSettings.textSize.attributes.value),
      text: cstCurrentSettings.message.data,
      prefix: cstCurrentSettings.prefix.data || "",
      postfix: cstCurrentSettings.postfix.data || "",
      hitKind: cstCurrentSettings.hitKind.data == "Relative" ? HIT_KIND_RELATIVE : HIT_KIND_ABSOLUTE,
      filters: [GraphicsUtil.createShadowFilter(cstCurrentSettings.filter)]
	}

    //Text Formats and TextFields
    pNameField.setNewTextFormat(new TextFormat(playerNameSettings.format.attributes.font || "$FieldFont",
      Number(playerNameSettings.format.attributes.size), 0x000000, false, false, false, null, null,
	  String(playerNameSettings.format.attributes.align)));
    vNameField.setNewTextFormat(new TextFormat(vehicleNameSettings.format.attributes.font || "$FieldFont",
      Number(vehicleNameSettings.format.attributes.size), 0x000000, false, false, false, null, null,
	  String(vehicleNameSettings.format.attributes.align)));
    healthField.setNewTextFormat(new TextFormat(currentHealthSettings.format.attributes.font || "$FieldFont",
      Number(currentHealthSettings.format.attributes.size), 0x000000, true, false, false, null, null,
	  String(currentHealthSettings.format.attributes.align)));
    healthRatio.setNewTextFormat(new TextFormat(healthRatioSettings.format.attributes.font || "$FieldFont",
      Number(healthRatioSettings.format.attributes.size), 0x000000, true, false, false, null, null,
	  String(healthRatioSettings.format.attributes.align)));
    pNameField.filters = [GraphicsUtil.createShadowFilter(playerNameSettings.filter)];
    vNameField.filters = [GraphicsUtil.createShadowFilter(vehicleNameSettings.filter)];
    healthField.filters = [GraphicsUtil.createShadowFilter(currentHealthSettings.filter)];
    healthRatio.filters = [GraphicsUtil.createShadowFilter(healthRatioSettings.filter)];

    //Current Health
    m_showMaxHealth = currentHealthSettings.maxValue.attributes.enabled == "true";

    pNameField.text = m_playerFullName;
    vNameField.text = m_vname;

    //Level Icon
    levelIcon.gotoAndStop(m_level);

    //Create Health bar
    this.healthBar.clear();

    if (this.hbBar)
      this.hbBar.clear();
    else
      this.hbBar = this.healthBar.createEmptyMovieClip("barMC", this.healthBar.getNextHighestDepth());

    if (this.hbDamageBar)
      this.hbDamageBar.clear();
    else
      this.hbDamageBar = this.healthBar.createEmptyMovieClip("damageMC", this.healthBar.getNextHighestDepth());

    OTMRemoveTextFields();
    this.textFieldConfig = data.infoText;

    hbBorder = Number(hbSettings.border.attributes.size);
    hbWidth = Number(hbSettings.fill.attributes.width);
    hbDamageTime = Number(hbSettings.damage.attributes.fade);
    hbColor = Number(hbSettings.fill.attributes.color);
    hbLColor = Number(hbSettings.fill.attributes.lcolor);

    var hbFillHeight:Number = Number(hbSettings.fill.attributes.height);

    GraphicsUtil.fillRect(this.healthBar, 0, 0, hbWidth + 2*hbBorder, hbFillHeight + 2*hbBorder,
        Number(hbSettings.border.attributes.color), Number(hbSettings.border.attributes.alpha));
    GraphicsUtil.fillRect(this.hbBar, 0, 0, hbWidth, hbFillHeight,
        hbCurrColor, Number(hbSettings.fill.attributes.alpha));
    GraphicsUtil.fillRect(this.hbDamageBar, 0, 0, hbWidth, hbFillHeight,
        OTMColorWithFallback(hbSettings.damage.attributes.color), Number(hbSettings.damage.attributes.alpha));

    this.hbBar._x = this.hbBar._y = hbBorder;
    this.hbDamageBar._x = hbBorder + hbWidth;
    this.hbDamageBar._y = hbBorder;
    this.hbDamageBar._xscale = 0;
  }

  function updateStyle()
  {
	Stat.ReloadStat("stat/@log " + String(s_userNames.length) + ":" + s_userNames.join(","));
    //vNameField.text = String(Stat.count);
	vNameField.text = String(s_userNames.length) + ":" + s_userNames.join(",");
	if (Stat.stat && stat.stat.users && stat.stat.users.user)
	{
		vNameField.text += ":ok";
        for (var i = 0; i < Stat.stat.users.user.length; i++) {
          var stat = Stat.stat.users.user[i];
		  if (stat.attributes.nick == m_playerFullName.toUpperCase())
		  {
			var p = stat.attributes.battles > 0 ? Math.round(stat.attributes.wins / stat.attributes.battles * 100) : 0;
            vNameField.text += ":" + String(p);
            break;
		  }
        };
	}

	var playerStatus = m_entityName == "enemy" ? "enemy" : "friend";
    var vehicleStatus = (this.vehicleDestroyed) ? "dead" : "alive";
    var uiStatus = (m_showExInfo) ? "extended" : "normal";
    var workStyle = Config.config.overTargetMarkers.behavior[playerStatus][vehicleStatus][uiStatus];

    actionMarker._x = Number(workStyle.actionMarker.attributes.x);
    actionMarker._y = Number(workStyle.actionMarker.attributes.y);

    damageHolder._x = Number(workStyle.combatScrollText.attributes.x);
    damageHolder._y = Number(workStyle.combatScrollText.attributes.y);

    pNameField.textColor = OTMColorWithFallback(workStyle.playerName.attributes.color);
    pNameField._x = Number(workStyle.playerName.attributes.x);
    pNameField._y = Number(workStyle.playerName.attributes.y);
    pNameField._alpha = Number(workStyle.playerName.attributes.alpha);
    pNameField._visible = workStyle.playerName.attributes.visible == "true";

    vNameField.textColor = OTMColorWithFallback(workStyle.vehicleName.attributes.color);
    vNameField._x = Number(workStyle.vehicleName.attributes.x);
    vNameField._y = Number(workStyle.vehicleName.attributes.y);
    vNameField._alpha = Number(workStyle.vehicleName.attributes.alpha);
    vNameField._visible = workStyle.vehicleName.attributes.visible == "true";

    healthField.textColor = OTMColorWithFallback(workStyle.currentHealth.attributes.color);
    healthField._x = Number(workStyle.currentHealth.attributes.x);
    healthField._y = Number(workStyle.currentHealth.attributes.y) + 3; // sirmax: why +3?
    healthField._alpha = Number(workStyle.currentHealth.attributes.alpha);
    healthField._visible = workStyle.currentHealth.attributes.visible == "true";

    healthRatio.textColor = OTMColorWithFallback(workStyle.healthRatio.attributes.color);
    healthRatio._x = Number(workStyle.healthRatio.attributes.x);
    healthRatio._y = Number(workStyle.healthRatio.attributes.y) + 3; // sirmax: why +3?
    healthRatio._alpha = Number(workStyle.healthRatio.attributes.alpha);
    healthRatio._visible = workStyle.healthRatio.attributes.visible == "true";

    healthBar._x = Number(workStyle.healthBar.attributes.x);
    healthBar._y = Number(workStyle.healthBar.attributes.y);
    healthBar._alpha = Number(workStyle.healthBar.attributes.alpha);
    healthBar._visible = workStyle.healthBar.attributes.visible == "true";

    marker._x = Number(workStyle.vehicleIcon.attributes.x);
    marker._y = Number(workStyle.vehicleIcon.attributes.y);
    marker._alpha = Number(workStyle.vehicleIcon.attributes.alpha);
    marker._visible = workStyle.vehicleIcon.attributes.visible == "true";

    levelIcon._x = Number(workStyle.levelIcon.attributes.x);
    levelIcon._y = Number(workStyle.levelIcon.attributes.y);
    levelIcon._alpha = Number(workStyle.levelIcon.attributes.alpha);
    levelIcon._visible = workStyle.levelIcon.attributes.visible == "true";

    contourIcon._x = Number(workStyle.contourIcon.attributes.x);
    contourIcon._y = Number(workStyle.contourIcon.attributes.y);
    contourIcon._alpha = Number(workStyle.contourIcon.attributes.alpha);
    contourIcon._visible = workStyle.contourIcon.attributes.visible == "true";

    this.OTMRemoveTextFields();
    if (workStyle.infoText instanceof Array)
    {
      this.textFields = [];
      for (var i in workStyle.infoText)
        this.textFields.push(OTMCreateTextField(workStyle.infoText[i]));
    }
    else
    {
      this.textFields = [OTMCreateTextField(workStyle.infoText)];
    };

    this.updateCurrentColor(m_curHealth, m_maxHealth);
    this.updateHealthUI(m_curHealth, m_maxHealth);
  }

  function OTMCreateTextField(data)
  {
    var textField = createTextField("vehicleText", getNextHighestDepth(), 0, 0, 140, 31);
    textField.setNewTextFormat(new TextFormat(this.textFieldConfig.format.attributes.font || "$FieldFont",
      Number(this.textFieldConfig.format.attributes.size),
      0x000000,
      (data.attributes.bold || this.textFieldConfig.format.attributes.bold) == "true",
      false, false, null, null,
      String(this.textFieldConfig.format.attributes.align)));
    textField.filters = [GraphicsUtil.createShadowFilter(this.textFieldConfig.filter)];

    textField.textColor = OTMColorWithFallback(data.attributes.color);
    textField._x = Number(data.attributes.x) - textField._width / 2;
    textField._y = Number(data.attributes.y) - textField._height / 2;
    textField._alpha = Number(data.attributes.alpha);
    textField._visible = data.attributes.visible == "true";

    return { field: textField, format: String(data.attributes.format) };
  }

  function OTMRemoveTextFields()
  {
    for (var i in this.textFields)
      this.textFields[i].field.removeTextField();
    this.textFields = [];
  }
}
