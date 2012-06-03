intrinsic class net.wargaming.ingame.VehicleMarker extends gfx.core.UIComponent
{
  static var s_showExInfo;

  var m_curHealth;
  var m_maxHealth;
  var m_playerFullName;
  var m_vname;
  var m_entityName;
  var m_level;
  var m_source;
  var m_isPopulated;
  var m_vehicleClass;
  var m_markerState;
  var m_markerLabel;

  var marker: MovieClip;
  var pNameField: TextField;
  var vNameField: TextField;
  var iconLoader;
  var levelIcon;
  var actionMarker;
  var healthBar: MovieClip;
  var bgShadow: MovieClip;

  function get colorsManager();
  function get colorSchemeName();
  function get vehicleDestroyed();

  function init(vClass, vIconSource, vType, vLevel, pFullName, curHealth, maxHealth, entityName, speaking, hunt);
  function updateMarkerSettings();
  function updateHealth(curHealth);
  function updateState(newState, isImmediate);
  function showExInfo(show);
  function configUI();
  function populateData();
  function initMarkerLabel();
  function updateMarkerLabel();
  function setupIconLoader();
  function _centeringIcon();

  function invalidate();
  function setVehicleClass();
}
