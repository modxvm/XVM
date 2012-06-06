intrinsic class net.wargaming.ingame.VehicleMarker extends gfx.core.UIComponent
{
  static var s_showExInfo: Boolean;

  var m_curHealth: Number;
  var m_maxHealth: Number;
  var m_playerFullName: String;
  var m_vname: String;
  var m_entityName: String;
  var m_level: Number;
  var m_source: String;
  var m_isPopulated: Boolean;
  var m_vehicleClass: String;
  var m_markerState: String;
  var m_markerLabel: String;

  var marker: MovieClip;
  var pNameField: TextField;
  var vNameField: TextField;
  var iconLoader: net.wargaming.controls.UILoaderAlt;
  var levelIcon: MovieClip;
  var actionMarker: MovieClip;
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
