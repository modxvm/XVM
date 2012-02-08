intrinsic class net.wargaming.ingame.PlayersPanel
{
  static var PLAYER_NAME_LENGTH;

  var m_list;
  var m_names;
  var m_state;
  var m_type;

  function setData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount);
  function _setNamesStr(data, sel, isColorBlind, knownPlayersCount);
  function _getHTMLText(colorScheme, text);
}
