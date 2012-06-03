/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.Iconset;
import wot.utils.Logger;
import wot.utils.Stat;
import wot.utils.PlayerInfo;
import wot.utils.Utils;

class wot.BattleLoadingItemRenderer extends net.wargaming.controls.LobbyPlayerListItemRenderer
{
  private static var s_logShown = false;

  private var m_iconset: Iconset = null;
  private var m_clanIconLoaded = false;
  private var m_iconLoaded: Boolean = false;
  private var m_textCache = {};
  
  function BattleLoadingItemRenderer()
  {
    super();
    vehicleField.html = true;
    Config.LoadConfig("XVM.xvmconf");
  }

  private function get team(): Number
  {
    return (this.owner._name == "team1List") ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY;
  }

  function completeLoad()
  {
    //Logger.add("completeLoad");
    if (m_iconLoaded)
      return;
    m_iconLoaded = true;

    vehicleField._width += 80;
    if (team == Defines.TEAM_ALLY)
      vehicleField._x -= 113; // sirmax: why this value?
    else
      vehicleField._x += 5;
    if (!Config.s_config.battle.mirroredVehicleIcons)
    {
      if (team == Defines.TEAM_ENEMY)
      {
        iconLoader._xscale = -iconLoader._xscale;
        iconLoader._x -= iconLoader.__width;
        //Logger.add(iconLoader.width + "x" + iconLoader.height);
      }
    }
  }
  
  // override
  function setData(data)
  {
    //Logger.add("setData");
    if (data)
    {
      // Add players for statistics loading
      if (Config.s_config.rating.showPlayersStatistics)
      {
        if (!s_logShown)
        {
          s_logShown = true;
          // Just to check config is loaded correctly
          Logger.add("[BattleLoading]\n" +
            "  GameRegion=" + Config.s_game_region + "\n" +
            "  MAX_PATH=" + Defines.MAX_PATH + "\n" +
            "  configVersion=" + Config.s_config.configVersion + "\n" +
            "  showPlayersStatistics=true\n" +
            "  loadEnemyStatsInFogOfWar=" + Config.s_config.rating.loadEnemyStatsInFogOfWar + "\n" +
            "  loadEnemyStatsInFogOfWar=" + Config.s_config.rating.loadEnemyStatsInFogOfWar + "\n" +
            "  useStandardMarkers=" + Config.s_config.battle.useStandardMarkers);
        }
        Stat.AddPlayerData(this, XVMStatUpdateCallback, data.id, data.label, data.vehicle, data.icon, team);
        if (Stat.s_player_ids.length === 30)
          Stat.StartLoadData();
      }

      // Alternative icon set
/*      if (!m_iconset)
        m_iconset = new Iconset(this, completeLoad, data.icon);
      else
        data.icon = m_iconset.originalIcon;
      m_iconset.init(iconLoader,
        [ data.icon.split(Defines.CONTOUR_ICON_PATH).join(Config.s_config.iconset.battleLoading), data.icon ]);
      data.icon = m_iconset.currentIcon;*/
      if (!m_iconset)
        m_iconset = new Iconset(this, completeLoad, data.icon);
      m_iconset.init(iconLoader, [ data.icon ]);

      // Player/clan icons
      var cfg = Config.s_config.battleLoading.clanIcon;
      if (cfg.show && !m_clanIconLoaded)
      {
        m_clanIconLoaded = true;
        var pinfo = PlayerInfo.getPlayerInfo(Utils.GetPlayerName(data.label), Utils.GetClanName(data.label));
        if (pinfo)
          PlayerInfo.createClanIcon(this, "m_clanIcon", pinfo.icon, cfg, iconLoader._x, iconLoader._y, team);
      }
    }

    if (Config.s_config.battleLoading.removeSquadIcon && squad)
      squad._visible = false;

    super.setData(data);
  }

  // override
  function update()
  {
    //Logger.add("update");
    super.update();
    if (Config.s_config.rating.showPlayersStatistics)
    {
      if (data)
        vehicleField.htmlText = (m_textCache.hasOwnProperty(data.label)) ? m_textCache[data.label] : data.vehicle;
    }
  }

  // update delegate (function name is fixed and cannot be changed)
  function XVMStatUpdateCallback(pdata)
  {
    //Logger.add("XVMStatUpdateCallback(): " + pdata.originalText);
    if (!m_textCache.hasOwnProperty(pdata.fullPlayerName))
    {
      m_textCache[data.label] = Stat.DecorateField(pdata, pdata.originalText,
        team == Defines.TEAM_ALLY ? Config.s_config.battleLoading.formatLeft : Config.s_config.battleLoading.formatRight,
        team == Defines.TEAM_ALLY ? Defines.POSITION_RIGHT : Defines.POSITION_LEFT);
    }
    vehicleField.htmlText = m_textCache[pdata.fullPlayerName];
    //Logger.add(vehicleField.htmlText);
  }
}
