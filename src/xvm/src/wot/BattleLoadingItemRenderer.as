/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.GlobalEventDispatcher;
import wot.utils.Iconset;
import wot.utils.Logger;
import wot.utils.StatData;
import wot.utils.StatLoader;
import wot.utils.StatFormat;
import wot.utils.PlayerInfo;
import wot.utils.Utils;

class wot.BattleLoadingItemRenderer extends net.wargaming.controls.LobbyPlayerListItemRenderer
{
  private static var s_logShown = false;

  private static var dummy = Logger.dummy; // avoid import warning

  private var m_iconset: Iconset = null;
  private var m_clanIconLoaded = false;
  private var m_iconLoaded: Boolean = false;
  private var m_textCache = {};

  function BattleLoadingItemRenderer()
  {
    super();

    Utils.TraceXvmModule("BattleLoadingItemRenderer");
    
    vehicleField.html = true;
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
        iconLoader._x -= 80;
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
        StatLoader.AddPlayerData(data.id, data.label, data.vehicle, data.icon, team, selected);
        GlobalEventDispatcher.addEventListener("stat_loaded", this, StatLoadedCallback);
        if (StatLoader.s_players_count === 30)
          StatLoader.StartLoadData();
      }

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

    // Remove squad icon
    if (Config.s_config.battleLoading.removeSquadIcon && squad)
      squad._visible = false;

    super.setData(data);
  }

  // override
  function setState()
  {
    super.setState();

    if (Config.s_config.battle.highlightVehicleIcon == false && (selected || data.squad > 10))
    {
      var tr = new flash.geom.Transform(iconLoader);
      tr.colorTransform = net.wargaming.managers.ColorSchemeManager.instance.getScheme(!disabled ? "normal" : "normal_dead").transform;
    }
  }

  // override
  function update()
  {
    if (!data)
    {
      super.update();
      return;
    }
    self_bg._visible = selected;

    onEnterFrame = function()
    {
      delete this.onEnterFrame;
      this.update2();
    }
  }

  function update2()
  {
    //Logger.add("update2");
    var saved_icon = data ? data.icon : null;
    if (data)
    {
      // Alternative icon set
      if (!m_iconset)
        m_iconset = new Iconset(this, completeLoad);
      m_iconset.init(iconLoader,
        [ data.icon.split(Defines.CONTOUR_ICON_PATH).join(Config.s_config.iconset.battleLoading), data.icon ]);
      data.icon = m_iconset.currentIcon;
    }

    super.update();

    if (data)
      data.icon = saved_icon;

    if (data && Config.s_config.rating.showPlayersStatistics)
    {
      vehicleField.htmlText = m_textCache.hasOwnProperty(data.label)
        ? m_textCache[data.label] : data.vehicle;
    }
  }

  // update delegate
  function StatLoadedCallback()
  {
    //Logger.add("StatLoaded(): " + data.label);

    var pdata = StatData.s_data[Utils.GetNormalizedPlayerName(data.label)];
    if (!pdata)
      return;

    if (!m_textCache.hasOwnProperty(data.label))
    {
      m_textCache[data.label] = StatFormat.DecorateField(pdata, pdata.originalText,
        team == Defines.TEAM_ALLY ? Config.s_config.battleLoading.formatLeft : Config.s_config.battleLoading.formatRight,
        team == Defines.TEAM_ALLY ? Defines.POSITION_RIGHT : Defines.POSITION_LEFT);
    }
    vehicleField.htmlText = m_textCache[pdata.fullPlayerName];
    //Logger.add(vehicleField.htmlText);
  }
}
