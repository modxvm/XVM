intrinsic class net.wargaming.ingame.VehicleMarker extends MovieClip // extends gfx.core.UIComponent
{
  static var s_showExInfo;

  var m_curHealth;
  var m_maxHealth;
  var m_playerFullName;
  var m_vname;
  var m_entityName;
  var m_level;
  var m_source;

  var marker;
  var pNameField;
  var vNameField;
  var iconLoader;
  var levelIcon;
  var actionMarker;
  var healthBar;

  function get colorsManager();
  function get colorSchemeName();
  function get vehicleDestroyed();

  function init(vClass, vIconSource, vType, vLevel, pFullName, curHealth, maxHealth, entityName, speaking, hunt);
  function updateState(newState, isImmediate);
  function configUI();
  function draw();
  function populateData();
  function updateMarkerLabel();
}
