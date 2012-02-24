intrinsic class net.wargaming.ingame.PlayersPanel extends MovieClip
{
  static var PLAYER_NAME_LENGTH;

  var m_list;
  var m_names;
  var m_frags;
  var m_vehicles;
  var m_state;
  var m_type;
  var players_bg;

  function setData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount);
  function update();
  function onRecreateDevice(width, height);
  function _setNamesStr(data, sel, isColorBlind, knownPlayersCount);
  function _getHTMLText(colorScheme, text);
}
