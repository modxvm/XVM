using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;

namespace wot.Dossier
{
  #region DossierData
  public class DossierData
  {
    public int dossierVersion;

    public string playerName;
    public string server;

    public List<DossierVehicleData> vehicles;

    public int maxLastBattleTime
    {
      get
      {
        if (vehicles == null)
          return 0;
        int res = 0;
        foreach (DossierVehicleData vd in vehicles)
          res = Math.Max(res, vd.lastBattleTime);
        return res;
      }
    }
  }

  public class DossierVehicleData
  {
    public int vid;

    public int VehicleId
    {
      get { return vid >> 8 & 0xFFFF; }
    }

    public int Nation
    {
      get { return vid >> 4 & 0xF; }
    }

    public int countryId;

    public int lastBattleTime;

    public int tankdata_battleLifeTime;
    public int tankdata_maxFrags;
    public int tankdata_xp;
    public int tankdata_maxXP;
    public int tankdata_battlesCount;
    public int tankdata_wins;
    public int tankdata_losses;
    public int tankdata_survivedBattles;
    public int tankdata_winAndSurvived;
    public int tankdata_frags;
    public int tankdata_shots;
    public int tankdata_hits;
    public int tankdata_spotted;
    public int tankdata_damageDealt;
    public int tankdata_damageReceived;
    public int tankdata_treesCut;
    public int tankdata_capturePoints;
    public int tankdata_droppedCapturePoints;

    public int company_xp;
    public int company_battlesCount;
    public int company_wins;
    public int company_losses;
    public int company_survivedBattles;
    public int company_frags;
    public int company_shots;
    public int company_hits;
    public int company_spotted;
    public int company_damageDealt;
    public int company_damageReceived;
    public int company_capturePoints;
    public int company_droppedCapturePoints;

    public int clan_xp;
    public int clan_battlesCount;
    public int clan_wins;
    public int clan_losses;
    public int clan_survivedBattles;
    public int clan_frags;
    public int clan_shots;
    public int clan_hits;
    public int clan_spotted;
    public int clan_damageDealt;
    public int clan_damageReceived;
    public int clan_capturePoints;
    public int clan_droppedCapturePoints;

    #region Append Structs
    public void AppendStruct(VehicleData_20 data)
    {
      lastBattleTime = data.lastBattleTime;

      tankdata_battleLifeTime = data.tankdata_battleLifeTime;
      tankdata_maxFrags = data.tankdata_maxFrags;
      tankdata_xp = data.tankdata_xp;
      tankdata_maxXP = data.tankdata_maxXP;
      tankdata_battlesCount = data.tankdata_battlesCount;
      tankdata_wins = data.tankdata_wins;
      tankdata_losses = data.tankdata_losses;
      tankdata_survivedBattles = data.tankdata_survivedBattles;
      tankdata_winAndSurvived = data.tankdata_winAndSurvived;
      tankdata_frags = data.tankdata_frags;
      tankdata_shots = data.tankdata_shots;
      tankdata_hits = data.tankdata_hits;
      tankdata_spotted = data.tankdata_spotted;
      tankdata_damageDealt = data.tankdata_damageDealt;
      tankdata_damageReceived = data.tankdata_damageReceived;
      tankdata_treesCut = data.tankdata_treesCut;
      tankdata_capturePoints = data.tankdata_capturePoints;
      tankdata_droppedCapturePoints = data.tankdata_droppedCapturePoints;

      company_xp = data.company_xp;
      company_battlesCount = data.company_battlesCount;
      company_wins = data.company_wins;
      company_losses = data.company_losses;
      company_survivedBattles = data.company_survivedBattles;
      company_frags = data.company_frags;
      company_shots = data.company_shots;
      company_hits = data.company_hits;
      company_spotted = data.company_spotted;
      company_damageDealt = data.company_damageDealt;
      company_damageReceived = data.company_damageReceived;
      company_capturePoints = data.company_capturePoints;
      company_droppedCapturePoints = data.company_droppedCapturePoints;

      clan_xp = data.clan_xp;
      clan_battlesCount = data.clan_battlesCount;
      clan_wins = data.clan_wins;
      clan_losses = data.clan_losses;
      clan_survivedBattles = data.clan_survivedBattles;
      clan_frags = data.clan_frags;
      clan_shots = data.clan_shots;
      clan_hits = data.clan_hits;
      clan_spotted = data.clan_spotted;
      clan_damageDealt = data.clan_damageDealt;
      clan_damageReceived = data.clan_damageReceived;
      clan_capturePoints = data.clan_capturePoints;
      clan_droppedCapturePoints = data.clan_droppedCapturePoints;
    }

    public void AppendStruct(VehicleData_22 data)
    {
      lastBattleTime = data.lastBattleTime;

      tankdata_battleLifeTime = data.tankdata_battleLifeTime;
      tankdata_maxFrags = data.tankdata_maxFrags;
      tankdata_xp = data.tankdata_xp;
      tankdata_maxXP = data.tankdata_maxXP;
      tankdata_battlesCount = data.tankdata_battlesCount;
      tankdata_wins = data.tankdata_wins;
      tankdata_losses = data.tankdata_losses;
      tankdata_survivedBattles = data.tankdata_survivedBattles;
      tankdata_winAndSurvived = data.tankdata_winAndSurvived;
      tankdata_frags = data.tankdata_frags;
      tankdata_shots = data.tankdata_shots;
      tankdata_hits = data.tankdata_hits;
      tankdata_spotted = data.tankdata_spotted;
      tankdata_damageDealt = data.tankdata_damageDealt;
      tankdata_damageReceived = data.tankdata_damageReceived;
      tankdata_treesCut = data.tankdata_treesCut;
      tankdata_capturePoints = data.tankdata_capturePoints;
      tankdata_droppedCapturePoints = data.tankdata_droppedCapturePoints;

      company_xp = data.company_xp;
      company_battlesCount = data.company_battlesCount;
      company_wins = data.company_wins;
      company_losses = data.company_losses;
      company_survivedBattles = data.company_survivedBattles;
      company_frags = data.company_frags;
      company_shots = data.company_shots;
      company_hits = data.company_hits;
      company_spotted = data.company_spotted;
      company_damageDealt = data.company_damageDealt;
      company_damageReceived = data.company_damageReceived;
      company_capturePoints = data.company_capturePoints;
      company_droppedCapturePoints = data.company_droppedCapturePoints;

      clan_xp = data.clan_xp;
      clan_battlesCount = data.clan_battlesCount;
      clan_wins = data.clan_wins;
      clan_losses = data.clan_losses;
      clan_survivedBattles = data.clan_survivedBattles;
      clan_frags = data.clan_frags;
      clan_shots = data.clan_shots;
      clan_hits = data.clan_hits;
      clan_spotted = data.clan_spotted;
      clan_damageDealt = data.clan_damageDealt;
      clan_damageReceived = data.clan_damageReceived;
      clan_capturePoints = data.clan_capturePoints;
      clan_droppedCapturePoints = data.clan_droppedCapturePoints;
    }

    public void AppendStruct(VehicleData_24 data)
    {
      lastBattleTime = data.lastBattleTime;

      tankdata_battleLifeTime = data.tankdata_battleLifeTime;
      tankdata_maxFrags = data.tankdata_maxFrags;
      tankdata_xp = data.tankdata_xp;
      tankdata_maxXP = data.tankdata_maxXP;
      tankdata_battlesCount = data.tankdata_battlesCount;
      tankdata_wins = data.tankdata_wins;
      tankdata_losses = data.tankdata_losses;
      tankdata_survivedBattles = data.tankdata_survivedBattles;
      tankdata_winAndSurvived = data.tankdata_winAndSurvived;
      tankdata_frags = data.tankdata_frags;
      tankdata_shots = data.tankdata_shots;
      tankdata_hits = data.tankdata_hits;
      tankdata_spotted = data.tankdata_spotted;
      tankdata_damageDealt = data.tankdata_damageDealt;
      tankdata_damageReceived = data.tankdata_damageReceived;
      tankdata_treesCut = data.tankdata_treesCut;
      tankdata_capturePoints = data.tankdata_capturePoints;
      tankdata_droppedCapturePoints = data.tankdata_droppedCapturePoints;

      company_xp = data.company_xp;
      company_battlesCount = data.company_battlesCount;
      company_wins = data.company_wins;
      company_losses = data.company_losses;
      company_survivedBattles = data.company_survivedBattles;
      company_frags = data.company_frags;
      company_shots = data.company_shots;
      company_hits = data.company_hits;
      company_spotted = data.company_spotted;
      company_damageDealt = data.company_damageDealt;
      company_damageReceived = data.company_damageReceived;
      company_capturePoints = data.company_capturePoints;
      company_droppedCapturePoints = data.company_droppedCapturePoints;

      clan_xp = data.clan_xp;
      clan_battlesCount = data.clan_battlesCount;
      clan_wins = data.clan_wins;
      clan_losses = data.clan_losses;
      clan_survivedBattles = data.clan_survivedBattles;
      clan_frags = data.clan_frags;
      clan_shots = data.clan_shots;
      clan_hits = data.clan_hits;
      clan_spotted = data.clan_spotted;
      clan_damageDealt = data.clan_damageDealt;
      clan_damageReceived = data.clan_damageReceived;
      clan_capturePoints = data.clan_capturePoints;
      clan_droppedCapturePoints = data.clan_droppedCapturePoints;
    }

    public void AppendStruct(VehicleData_26 data)
    {
      lastBattleTime = data.lastBattleTime;

      tankdata_battleLifeTime = data.tankdata_battleLifeTime;
      tankdata_maxFrags = data.tankdata_maxFrags;
      tankdata_xp = data.tankdata_xp;
      tankdata_maxXP = data.tankdata_maxXP;
      tankdata_battlesCount = data.tankdata_battlesCount;
      tankdata_wins = data.tankdata_wins;
      tankdata_losses = data.tankdata_losses;
      tankdata_survivedBattles = data.tankdata_survivedBattles;
      tankdata_winAndSurvived = data.tankdata_winAndSurvived;
      tankdata_frags = data.tankdata_frags;
      tankdata_shots = data.tankdata_shots;
      tankdata_hits = data.tankdata_hits;
      tankdata_spotted = data.tankdata_spotted;
      tankdata_damageDealt = data.tankdata_damageDealt;
      tankdata_damageReceived = data.tankdata_damageReceived;
      tankdata_treesCut = data.tankdata_treesCut;
      tankdata_capturePoints = data.tankdata_capturePoints;
      tankdata_droppedCapturePoints = data.tankdata_droppedCapturePoints;

      company_xp = data.company_xp;
      company_battlesCount = data.company_battlesCount;
      company_wins = data.company_wins;
      company_losses = data.company_losses;
      company_survivedBattles = data.company_survivedBattles;
      company_frags = data.company_frags;
      company_shots = data.company_shots;
      company_hits = data.company_hits;
      company_spotted = data.company_spotted;
      company_damageDealt = data.company_damageDealt;
      company_damageReceived = data.company_damageReceived;
      company_capturePoints = data.company_capturePoints;
      company_droppedCapturePoints = data.company_droppedCapturePoints;

      clan_xp = data.clan_xp;
      clan_battlesCount = data.clan_battlesCount;
      clan_wins = data.clan_wins;
      clan_losses = data.clan_losses;
      clan_survivedBattles = data.clan_survivedBattles;
      clan_frags = data.clan_frags;
      clan_shots = data.clan_shots;
      clan_hits = data.clan_hits;
      clan_spotted = data.clan_spotted;
      clan_damageDealt = data.clan_damageDealt;
      clan_damageReceived = data.clan_damageReceived;
      clan_capturePoints = data.clan_capturePoints;
      clan_droppedCapturePoints = data.clan_droppedCapturePoints;
    }

    public void AppendStruct(VehicleData_27 data)
    {
      lastBattleTime = data.lastBattleTime;

      tankdata_battleLifeTime = data.tankdata_battleLifeTime;
      tankdata_maxFrags = data.tankdata_maxFrags;
      tankdata_xp = data.tankdata_xp;
      tankdata_maxXP = data.tankdata_maxXP;
      tankdata_battlesCount = data.tankdata_battlesCount;
      tankdata_wins = data.tankdata_wins;
      tankdata_losses = data.tankdata_losses;
      tankdata_survivedBattles = data.tankdata_survivedBattles;
      tankdata_winAndSurvived = data.tankdata_winAndSurvived;
      tankdata_frags = data.tankdata_frags;
      tankdata_shots = data.tankdata_shots;
      tankdata_hits = data.tankdata_hits;
      tankdata_spotted = data.tankdata_spotted;
      tankdata_damageDealt = data.tankdata_damageDealt;
      tankdata_damageReceived = data.tankdata_damageReceived;
      tankdata_treesCut = data.tankdata_treesCut;
      tankdata_capturePoints = data.tankdata_capturePoints;
      tankdata_droppedCapturePoints = data.tankdata_droppedCapturePoints;

      company_xp = data.company_xp;
      company_battlesCount = data.company_battlesCount;
      company_wins = data.company_wins;
      company_losses = data.company_losses;
      company_survivedBattles = data.company_survivedBattles;
      company_frags = data.company_frags;
      company_shots = data.company_shots;
      company_hits = data.company_hits;
      company_spotted = data.company_spotted;
      company_damageDealt = data.company_damageDealt;
      company_damageReceived = data.company_damageReceived;
      company_capturePoints = data.company_capturePoints;
      company_droppedCapturePoints = data.company_droppedCapturePoints;

      clan_xp = data.clan_xp;
      clan_battlesCount = data.clan_battlesCount;
      clan_wins = data.clan_wins;
      clan_losses = data.clan_losses;
      clan_survivedBattles = data.clan_survivedBattles;
      clan_frags = data.clan_frags;
      clan_shots = data.clan_shots;
      clan_hits = data.clan_hits;
      clan_spotted = data.clan_spotted;
      clan_damageDealt = data.clan_damageDealt;
      clan_damageReceived = data.clan_damageReceived;
      clan_capturePoints = data.clan_capturePoints;
      clan_droppedCapturePoints = data.clan_droppedCapturePoints;
    }

    public void AppendStruct(VehicleData_28 data)
    {
      lastBattleTime = data.lastBattleTime;

      tankdata_battleLifeTime = data.tankdata_battleLifeTime;
      tankdata_maxFrags = data.tankdata_maxFrags;
      tankdata_xp = data.tankdata_xp;
      tankdata_maxXP = data.tankdata_maxXP;
      tankdata_battlesCount = data.tankdata_battlesCount;
      tankdata_wins = data.tankdata_wins;
      tankdata_losses = data.tankdata_losses;
      tankdata_survivedBattles = data.tankdata_survivedBattles;
      tankdata_winAndSurvived = data.tankdata_winAndSurvived;
      tankdata_frags = data.tankdata_frags;
      tankdata_shots = data.tankdata_shots;
      tankdata_hits = data.tankdata_hits;
      tankdata_spotted = data.tankdata_spotted;
      tankdata_damageDealt = data.tankdata_damageDealt;
      tankdata_damageReceived = data.tankdata_damageReceived;
      tankdata_treesCut = data.tankdata_treesCut;
      tankdata_capturePoints = data.tankdata_capturePoints;
      tankdata_droppedCapturePoints = data.tankdata_droppedCapturePoints;

      company_xp = data.company_xp;
      company_battlesCount = data.company_battlesCount;
      company_wins = data.company_wins;
      company_losses = data.company_losses;
      company_survivedBattles = data.company_survivedBattles;
      company_frags = data.company_frags;
      company_shots = data.company_shots;
      company_hits = data.company_hits;
      company_spotted = data.company_spotted;
      company_damageDealt = data.company_damageDealt;
      company_damageReceived = data.company_damageReceived;
      company_capturePoints = data.company_capturePoints;
      company_droppedCapturePoints = data.company_droppedCapturePoints;

      clan_xp = data.clan_xp;
      clan_battlesCount = data.clan_battlesCount;
      clan_wins = data.clan_wins;
      clan_losses = data.clan_losses;
      clan_survivedBattles = data.clan_survivedBattles;
      clan_frags = data.clan_frags;
      clan_shots = data.clan_shots;
      clan_hits = data.clan_hits;
      clan_spotted = data.clan_spotted;
      clan_damageDealt = data.clan_damageDealt;
      clan_damageReceived = data.clan_damageReceived;
      clan_capturePoints = data.clan_capturePoints;
      clan_droppedCapturePoints = data.clan_droppedCapturePoints;
    }
    #endregion

    #region ToJSON

    public string TankDataToJson()
    {
      return "{" +
        "\"battleLifeTime\":" + tankdata_battleLifeTime +
        ",\"maxFrags\":" + tankdata_maxFrags +
        ",\"xp\":" + tankdata_xp +
        ",\"maxXP\":" + tankdata_maxXP +
        ",\"battlesCount\":" + tankdata_battlesCount +
        ",\"wins\":" + tankdata_wins +
        ",\"losses\":" + tankdata_losses +
        ",\"survivedBattles\":" + tankdata_survivedBattles +
        ",\"winAndSurvived\":" + tankdata_winAndSurvived +
        ",\"frags\":" + tankdata_frags +
        ",\"shots\":" + tankdata_shots +
        ",\"hits\":" + tankdata_hits +
        ",\"spotted\":" + tankdata_spotted +
        ",\"damageDealt\":" + tankdata_damageDealt +
        ",\"damageReceived\":" + tankdata_damageReceived +
        ",\"treesCut\":" + tankdata_treesCut +
        ",\"capturePoints\":" + tankdata_capturePoints +
        ",\"droppedCapturePoints\":" + tankdata_droppedCapturePoints +
        "}";
    }

    public string CompanyDataToJson()
    {
      return "{" +
        "\"xp\":" + company_xp +
        ",\"battlesCount\":" + company_battlesCount +
        ",\"wins\":" + company_wins +
        ",\"losses\":" + company_losses +
        ",\"survivedBattles\":" + company_survivedBattles +
        ",\"frags\":" + company_frags +
        ",\"shots\":" + company_shots +
        ",\"hits\":" + company_hits +
        ",\"spotted\":" + company_spotted +
        ",\"damageDealt\":" + company_damageDealt +
        ",\"damageReceived\":" + company_damageReceived +
        ",\"capturePoints\":" + company_capturePoints +
        ",\"droppedCapturePoints\":" + company_droppedCapturePoints +
        "}";
    }

    public string ClanDataToJson()
    {
      return "{" +
        "\"xp\":" + clan_xp +
        ",\"battlesCount\":" + clan_battlesCount +
        ",\"wins\":" + clan_wins +
        ",\"losses\":" + clan_losses +
        ",\"survivedBattles\":" + clan_survivedBattles +
        ",\"frags\":" + clan_frags +
        ",\"shots\":" + clan_shots +
        ",\"hits\":" + clan_hits +
        ",\"spotted\":" + clan_spotted +
        ",\"damageDealt\":" + clan_damageDealt +
        ",\"damageReceived\":" + clan_damageReceived +
        ",\"capturePoints\":" + clan_capturePoints +
        ",\"droppedCapturePoints\":" + clan_droppedCapturePoints +
        "}";
    }

    #endregion
  }
  #endregion

  #region tankdata_version = 20
  [StructLayout(LayoutKind.Explicit)]
  public struct VehicleData_20
  {
    [FieldOffset(2)] public Int32 lastBattleTime;
    [FieldOffset(6)] public Int32 tankdata_battleLifeTime;
    [FieldOffset(10)] public byte tankdata_maxFrags;
    [FieldOffset(11)] public Int32 tankdata_xp;
    [FieldOffset(15)] public Int16 tankdata_maxXP;
    [FieldOffset(17)] public Int32 tankdata_battlesCount;
    [FieldOffset(21)] public Int32 tankdata_wins;
    [FieldOffset(25)] public Int32 tankdata_losses;
    [FieldOffset(29)] public Int32 tankdata_survivedBattles;
    [FieldOffset(33)] public Int32 tankdata_winAndSurvived;
    [FieldOffset(37)] public Int32 tankdata_frags;
    [FieldOffset(41)] public Int32 tankdata_frags8p;
    [FieldOffset(45)] public Int32 tankdata_fragsBeast;
    [FieldOffset(49)] public Int32 tankdata_shots;
    [FieldOffset(53)] public Int32 tankdata_hits;
    [FieldOffset(57)] public Int32 tankdata_spotted;
    [FieldOffset(61)] public Int32 tankdata_damageDealt;
    [FieldOffset(65)] public Int32 tankdata_damageReceived;
    [FieldOffset(69)] public Int16 tankdata_treesCut;
    [FieldOffset(71)] public Int32 tankdata_capturePoints;
    [FieldOffset(75)] public Int32 tankdata_droppedCapturePoints;
    
    [FieldOffset(79)] public Int16 series_sniperSeries;
    [FieldOffset(81)] public Int16 series_maxSniperSeries;
    [FieldOffset(83)] public byte series_invincibleSeries;
    [FieldOffset(84)] public byte series_maxInvincibleSeries;
    [FieldOffset(85)] public byte series_diehardSeries;
    [FieldOffset(86)] public byte series_maxDiehardSeries;
    [FieldOffset(87)] public byte series_killingSeries;
    [FieldOffset(88)] public byte series_maxKillingSeries;
    [FieldOffset(89)] public byte series_piercingSeries;
    [FieldOffset(90)] public byte series_maxPiercingSeries;

    [FieldOffset(91)] public Int16 battle_battleHeroes;
    [FieldOffset(93)] public Int16 battle_warrior;
    [FieldOffset(95)] public Int16 battle_invader;
    [FieldOffset(97)] public Int16 battle_sniper;
    [FieldOffset(99)] public Int16 battle_defender;
    [FieldOffset(101)] public Int16 battle_steelwall;
    [FieldOffset(103)] public Int16 battle_confederate;
    [FieldOffset(105)] public Int16 battle_scout;
    [FieldOffset(107)] public Int16 battle_evileye;
    
    [FieldOffset(109)] public byte major_medalKay;
    [FieldOffset(110)] public byte major_medalCarius;
    [FieldOffset(111)] public byte major_medalKnispel;
    [FieldOffset(112)] public byte major_medalPoppel;
    [FieldOffset(113)] public byte major_medalAbrams;
    [FieldOffset(114)] public byte major_medalLeClerc;
    [FieldOffset(115)] public byte major_medalLavrinenko;
    [FieldOffset(116)] public byte major_medalEkins;
    
    [FieldOffset(117)] public Int16 epic_medalWittmann;
    [FieldOffset(119)] public Int16 epic_medalOrlik;
    [FieldOffset(121)] public Int16 epic_medalOskin;
    [FieldOffset(123)] public Int16 epic_medalHalonen;
    [FieldOffset(125)] public Int16 epic_medalBurda;
    [FieldOffset(127)] public Int16 epic_medalBillotte;
    [FieldOffset(129)] public Int16 epic_medalKolobanov;
    [FieldOffset(131)] public Int16 epic_medalFadin;
    [FieldOffset(135)] public Int16 epic_medalDeLanglade;
    [FieldOffset(137)] public Int16 epic_medalTamadaYoshio;
    [FieldOffset(139)] public Int16 epic_medalErohin;
    [FieldOffset(141)] public Int16 epic_medalHoroshilov;
    [FieldOffset(143)] public Int16 epic_medalLister;
    
    [FieldOffset(133)] public Int16 special_heroesOfRassenay;
    [FieldOffset(145)] public Int16 special_beasthunter;
    [FieldOffset(147)] public Int16 special_mousebane;
    [FieldOffset(149)] public byte special_tankExpert;
    [FieldOffset(150)] public byte special_sniperspecial;
    [FieldOffset(151)] public byte special_invincible;
    [FieldOffset(152)] public byte special_diehard;
    [FieldOffset(153)] public Int16 special_raider;
    [FieldOffset(155)] public byte special_handOfDeath;
    [FieldOffset(156)] public byte special_armorPiercer;
    [FieldOffset(157)] public Int16 special_kamikaze;
    [FieldOffset(159)] public byte special_lumberjack;
    [FieldOffset(160)] public byte special_markOfMastery;
    
    [FieldOffset(161)] public Int32 company_xp;
    [FieldOffset(165)] public Int32 company_battlesCount;
    [FieldOffset(169)] public Int32 company_wins;
    [FieldOffset(173)] public Int32 company_losses;
    [FieldOffset(177)] public Int32 company_survivedBattles;
    [FieldOffset(181)] public Int32 company_frags;
    [FieldOffset(185)] public Int32 company_shots;
    [FieldOffset(189)] public Int32 company_hits;
    [FieldOffset(193)] public Int32 company_spotted;
    [FieldOffset(197)] public Int32 company_damageDealt;
    [FieldOffset(201)] public Int32 company_damageReceived;
    [FieldOffset(205)] public Int32 company_capturePoints;
    [FieldOffset(209)] public Int32 company_droppedCapturePoints;
    
    [FieldOffset(213)] public Int32 clan_xp;
    [FieldOffset(217)] public Int32 clan_battlesCount;
    [FieldOffset(221)] public Int32 clan_wins;
    [FieldOffset(225)] public Int32 clan_losses;
    [FieldOffset(229)] public Int32 clan_survivedBattles;
    [FieldOffset(233)] public Int32 clan_frags;
    [FieldOffset(237)] public Int32 clan_shots;
    [FieldOffset(241)] public Int32 clan_hits;
    [FieldOffset(245)] public Int32 clan_spotted;
    [FieldOffset(249)] public Int32 clan_damageDealt;
    [FieldOffset(253)] public Int32 clan_damageReceived;
    [FieldOffset(257)] public Int32 clan_capturePoints;
    [FieldOffset(261)] public Int32 clan_droppedCapturePoints;
    
    [FieldOffset(265)] public Int16 structure_fragspos;
  }
  #endregion

  #region tankdata_version = 22
  [StructLayout(LayoutKind.Explicit)]
  public struct VehicleData_22
  {
    [FieldOffset(2)] public Int32 lastBattleTime;
    [FieldOffset(6)] public Int32 tankdata_battleLifeTime;
    [FieldOffset(10)] public byte tankdata_maxFrags;
    [FieldOffset(11)] public Int32 tankdata_xp;
    [FieldOffset(15)] public Int16 tankdata_maxXP;
    [FieldOffset(17)] public Int32 tankdata_battlesCount;
    [FieldOffset(21)] public Int32 tankdata_wins;
    [FieldOffset(25)] public Int32 tankdata_losses;
    [FieldOffset(29)] public Int32 tankdata_survivedBattles;
    [FieldOffset(33)] public Int32 tankdata_winAndSurvived;
    [FieldOffset(37)] public Int32 tankdata_frags;
    [FieldOffset(41)] public Int32 tankdata_frags8p;
    [FieldOffset(45)] public Int32 tankdata_fragsBeast;
    [FieldOffset(49)] public Int32 tankdata_shots;
    [FieldOffset(53)] public Int32 tankdata_hits;
    [FieldOffset(57)] public Int32 tankdata_spotted;
    [FieldOffset(61)] public Int32 tankdata_damageDealt;
    [FieldOffset(65)] public Int32 tankdata_damageReceived;
    [FieldOffset(69)] public Int16 tankdata_treesCut;
    [FieldOffset(71)] public Int32 tankdata_capturePoints;
    [FieldOffset(75)] public Int32 tankdata_droppedCapturePoints;

    [FieldOffset(79)] public Int16 series_sniperSeries;
    [FieldOffset(81)] public Int16 series_maxSniperSeries;
    [FieldOffset(83)] public byte series_invincibleSeries;
    [FieldOffset(84)] public byte series_maxInvincibleSeries;
    [FieldOffset(85)] public byte series_diehardSeries;
    [FieldOffset(86)] public byte series_maxDiehardSeries;
    [FieldOffset(87)] public byte series_killingSeries;
    [FieldOffset(88)] public byte series_maxKillingSeries;
    [FieldOffset(89)] public byte series_piercingSeries;
    [FieldOffset(90)] public byte series_maxPiercingSeries;

    [FieldOffset(91)] public Int16 battle_battleHeroes;
    [FieldOffset(93)] public Int32 battle_fragsSinai;
    [FieldOffset(97)] public Int16 battle_warrior;
    [FieldOffset(99)] public Int16 battle_invader;
    [FieldOffset(101)] public Int16 battle_sniper;
    [FieldOffset(103)] public Int16 battle_defender;
    [FieldOffset(105)] public Int16 battle_steelwall;
    [FieldOffset(107)] public Int16 battle_supporter;
    [FieldOffset(109)] public Int16 battle_scout;
    [FieldOffset(111)] public Int16 battle_evileye;

    [FieldOffset(113)] public byte major_medalKay;
    [FieldOffset(114)] public byte major_medalCarius;
    [FieldOffset(115)] public byte major_medalKnispel;
    [FieldOffset(116)] public byte major_medalPoppel;
    [FieldOffset(117)] public byte major_medalAbrams;
    [FieldOffset(118)] public byte major_medalLeClerc;
    [FieldOffset(119)] public byte major_medalLavrinenko;
    [FieldOffset(120)] public byte major_medalEkins;

    [FieldOffset(121)] public Int16 epic_medalWittmann;
    [FieldOffset(123)] public Int16 epic_medalOrlik;
    [FieldOffset(125)] public Int16 epic_medalOskin;
    [FieldOffset(127)] public Int16 epic_medalHalonen;
    [FieldOffset(129)] public Int16 epic_medalBurda;
    [FieldOffset(131)] public Int16 epic_medalBillotte;
    [FieldOffset(133)] public Int16 epic_medalKolobanov;
    [FieldOffset(135)] public Int16 epic_medalFadin;
    [FieldOffset(137)] public Int16 epic_medalRadleyWalters;
    [FieldOffset(139)] public Int16 epic_medalBrunoPietro;
    [FieldOffset(141)] public Int16 epic_medalTarczay;
    [FieldOffset(143)] public Int16 epic_medalPascucci;
    [FieldOffset(145)] public Int16 epic_medalDumitru;
    [FieldOffset(147)] public Int16 epic_medalLehvaslaiho;
    [FieldOffset(149)] public Int16 epic_medalNikolas;
    [FieldOffset(151)] public Int16 epic_medalLafayettePool;

    [FieldOffset(153)] public Int16 special_sinai;
    [FieldOffset(155)] public Int16 special_heroesOfRassenay;
    [FieldOffset(157)] public Int16 special_beasthunter;
    [FieldOffset(159)] public Int16 special_mousebane;
    [FieldOffset(161)] public Int16 special_tankExpertStrg;

    [FieldOffset(163)] public byte special_titleSniper;
    [FieldOffset(164)] public byte special_invincible;
    [FieldOffset(165)] public byte special_diehard;
    [FieldOffset(166)] public Int16 special_raider;
    [FieldOffset(168)] public byte special_handOfDeath;
    [FieldOffset(169)] public byte special_armorPiercer;
    [FieldOffset(170)] public Int16 special_kamikaze;
    [FieldOffset(172)] public byte special_lumberjack;
    [FieldOffset(173)] public byte special_markOfMastery;

    [FieldOffset(174)] public Int32 company_xp;
    [FieldOffset(178)] public Int32 company_battlesCount;
    [FieldOffset(182)] public Int32 company_wins;
    [FieldOffset(186)] public Int32 company_losses;
    [FieldOffset(190)] public Int32 company_survivedBattles;
    [FieldOffset(194)] public Int32 company_frags;
    [FieldOffset(198)] public Int32 company_shots;
    [FieldOffset(202)] public Int32 company_hits;
    [FieldOffset(206)] public Int32 company_spotted;
    [FieldOffset(210)] public Int32 company_damageDealt;
    [FieldOffset(214)] public Int32 company_damageReceived;
    [FieldOffset(218)] public Int32 company_capturePoints;
    [FieldOffset(222)] public Int32 company_droppedCapturePoints;

    [FieldOffset(226)] public Int32 clan_xp;
    [FieldOffset(230)] public Int32 clan_battlesCount;
    [FieldOffset(234)] public Int32 clan_wins;
    [FieldOffset(238)] public Int32 clan_losses;
    [FieldOffset(242)] public Int32 clan_survivedBattles;
    [FieldOffset(246)] public Int32 clan_frags;
    [FieldOffset(250)] public Int32 clan_shots;
    [FieldOffset(254)] public Int32 clan_hits;
    [FieldOffset(258)] public Int32 clan_spotted;
    [FieldOffset(262)] public Int32 clan_damageDealt;
    [FieldOffset(266)] public Int32 clan_damageReceived;
    [FieldOffset(270)] public Int32 clan_capturePoints;
    [FieldOffset(274)] public Int32 clan_droppedCapturePoints;

    [FieldOffset(278)] public Int16 structure_fragspos;
  }
  #endregion

  #region tankdata_version = 24
  [StructLayout(LayoutKind.Explicit)]
  public struct VehicleData_24
  {
    [FieldOffset(2)] public Int32 lastBattleTime;
    [FieldOffset(6)] public Int32 tankdata_battleLifeTime;
    [FieldOffset(10)] public byte tankdata_maxFrags;
    [FieldOffset(11)] public Int32 tankdata_xp;
    [FieldOffset(15)] public Int16 tankdata_maxXP;
    [FieldOffset(17)] public Int32 tankdata_battlesCount;
    [FieldOffset(21)] public Int32 tankdata_wins;
    [FieldOffset(25)] public Int32 tankdata_losses;
    [FieldOffset(29)] public Int32 tankdata_survivedBattles;
    [FieldOffset(33)] public Int32 tankdata_winAndSurvived;
    [FieldOffset(37)] public Int32 tankdata_frags;
    [FieldOffset(41)] public Int32 tankdata_frags8p;
    [FieldOffset(45)] public Int32 tankdata_fragsBeast;
    [FieldOffset(49)] public Int32 tankdata_shots;
    [FieldOffset(53)] public Int32 tankdata_hits;
    [FieldOffset(57)] public Int32 tankdata_spotted;
    [FieldOffset(61)] public Int32 tankdata_damageDealt;
    [FieldOffset(65)] public Int32 tankdata_damageReceived;
    [FieldOffset(69)] public Int16 tankdata_treesCut;
    [FieldOffset(71)] public Int32 tankdata_capturePoints;
    [FieldOffset(75)] public Int32 tankdata_droppedCapturePoints;

    [FieldOffset(79)] public Int16 series_sniperSeries;
    [FieldOffset(81)] public Int16 series_maxSniperSeries;
    [FieldOffset(83)] public byte series_invincibleSeries;
    [FieldOffset(84)] public byte series_maxInvincibleSeries;
    [FieldOffset(85)] public byte series_diehardSeries;
    [FieldOffset(86)] public byte series_maxDiehardSeries;
    [FieldOffset(87)] public byte series_killingSeries;
    [FieldOffset(88)] public byte series_maxKillingSeries;
    [FieldOffset(89)] public byte series_piercingSeries;
    [FieldOffset(90)] public byte series_maxPiercingSeries;

    [FieldOffset(91)] public Int16 battle_battleHeroes;
    [FieldOffset(93)] public Int32 battle_fragsSinai;
    [FieldOffset(97)] public Int16 battle_warrior;
    [FieldOffset(99)] public Int16 battle_invader;
    [FieldOffset(101)] public Int16 battle_sniper;
    [FieldOffset(103)] public Int16 battle_defender;
    [FieldOffset(105)] public Int16 battle_steelwall;
    [FieldOffset(107)] public Int16 battle_supporter;
    [FieldOffset(109)] public Int16 battle_scout;
    [FieldOffset(111)] public Int16 battle_evileye;

    [FieldOffset(113)] public byte major_medalKay;
    [FieldOffset(114)] public byte major_medalCarius;
    [FieldOffset(115)] public byte major_medalKnispel;
    [FieldOffset(116)] public byte major_medalPoppel;
    [FieldOffset(117)] public byte major_medalAbrams;
    [FieldOffset(118)] public byte major_medalLeClerc;
    [FieldOffset(119)] public byte major_medalLavrinenko;
    [FieldOffset(120)] public byte major_medalEkins;

    [FieldOffset(121)] public Int16 epic_medalWittmann;
    [FieldOffset(123)] public Int16 epic_medalOrlik;
    [FieldOffset(125)] public Int16 epic_medalOskin;
    [FieldOffset(127)] public Int16 epic_medalHalonen;
    [FieldOffset(129)] public Int16 epic_medalBurda;
    [FieldOffset(131)] public Int16 epic_medalBillotte;
    [FieldOffset(133)] public Int16 epic_medalKolobanov;
    [FieldOffset(135)] public Int16 epic_medalFadin;
    [FieldOffset(137)] public Int16 epic_medalRadleyWalters;
    [FieldOffset(139)] public Int16 epic_medalBrunoPietro;
    [FieldOffset(141)] public Int16 epic_medalTarczay;
    [FieldOffset(143)] public Int16 epic_medalPascucci;
    [FieldOffset(145)] public Int16 epic_medalDumitru;
    [FieldOffset(147)] public Int16 epic_medalLehvaslaiho;
    [FieldOffset(149)] public Int16 epic_medalNikolas;
    [FieldOffset(151)] public Int16 epic_medalLafayettePool;
    [FieldOffset(278)] public Int16 epic_medalBrothersInArms;
    [FieldOffset(280)] public Int16 epic_medalCrucialContribution;

    [FieldOffset(153)] public Int16 special_sinai;
    [FieldOffset(155)] public Int16 special_heroesOfRassenay;
    [FieldOffset(157)] public Int16 special_beasthunter;
    [FieldOffset(159)] public Int16 special_mousebane;
    [FieldOffset(161)] public Int16 special_tankExpertStrg;
    [FieldOffset(163)] public byte special_titleSniper;
    [FieldOffset(164)] public byte special_invincible;
    [FieldOffset(165)] public byte special_diehard;
    [FieldOffset(166)] public Int16 special_raider;
    [FieldOffset(168)] public byte special_handOfDeath;
    [FieldOffset(169)] public byte special_armorPiercer;
    [FieldOffset(170)] public Int16 special_kamikaze;
    [FieldOffset(172)] public byte special_lumberjack;
    [FieldOffset(173)] public byte special_markOfMastery;

    [FieldOffset(174)] public Int32 company_xp;
    [FieldOffset(178)] public Int32 company_battlesCount;
    [FieldOffset(182)] public Int32 company_wins;
    [FieldOffset(186)] public Int32 company_losses;
    [FieldOffset(190)] public Int32 company_survivedBattles;
    [FieldOffset(194)] public Int32 company_frags;
    [FieldOffset(198)] public Int32 company_shots;
    [FieldOffset(202)] public Int32 company_hits;
    [FieldOffset(206)] public Int32 company_spotted;
    [FieldOffset(210)] public Int32 company_damageDealt;
    [FieldOffset(214)] public Int32 company_damageReceived;
    [FieldOffset(218)] public Int32 company_capturePoints;
    [FieldOffset(222)] public Int32 company_droppedCapturePoints;

    [FieldOffset(226)] public Int32 clan_xp;
    [FieldOffset(230)] public Int32 clan_battlesCount;
    [FieldOffset(234)] public Int32 clan_wins;
    [FieldOffset(238)] public Int32 clan_losses;
    [FieldOffset(242)] public Int32 clan_survivedBattles;
    [FieldOffset(246)] public Int32 clan_frags;
    [FieldOffset(250)] public Int32 clan_shots;
    [FieldOffset(254)] public Int32 clan_hits;
    [FieldOffset(258)] public Int32 clan_spotted;
    [FieldOffset(262)] public Int32 clan_damageDealt;
    [FieldOffset(266)] public Int32 clan_damageReceived;
    [FieldOffset(270)] public Int32 clan_capturePoints;
    [FieldOffset(274)] public Int32 clan_droppedCapturePoints;

    [FieldOffset(298)] public Int16 structure_fragspos;
  }
  #endregion

  #region tankdata_version = 26
  [StructLayout(LayoutKind.Explicit)]
  public struct VehicleData_26
  {
    [FieldOffset(2)] public Int32 lastBattleTime;
    [FieldOffset(6)] public Int32 tankdata_battleLifeTime;
    [FieldOffset(10)] public byte tankdata_maxFrags;
    [FieldOffset(11)] public Int32 tankdata_xp;
    [FieldOffset(15)] public Int16 tankdata_maxXP;
    [FieldOffset(17)] public Int32 tankdata_battlesCount;
    [FieldOffset(21)] public Int32 tankdata_wins;
    [FieldOffset(25)] public Int32 tankdata_losses;
    [FieldOffset(29)] public Int32 tankdata_survivedBattles;
    [FieldOffset(33)] public Int32 tankdata_winAndSurvived;
    [FieldOffset(37)] public Int32 tankdata_frags;
    [FieldOffset(41)] public Int32 tankdata_frags8p;
    [FieldOffset(45)] public Int32 tankdata_fragsBeast;
    [FieldOffset(49)] public Int32 tankdata_shots;
    [FieldOffset(53)] public Int32 tankdata_hits;
    [FieldOffset(57)] public Int32 tankdata_spotted;
    [FieldOffset(61)] public Int32 tankdata_damageDealt;
    [FieldOffset(65)] public Int32 tankdata_damageReceived;
    [FieldOffset(69)] public Int16 tankdata_treesCut;
    [FieldOffset(71)] public Int32 tankdata_capturePoints;
    [FieldOffset(75)] public Int32 tankdata_droppedCapturePoints;

    [FieldOffset(79)] public Int16 series_sniperSeries;
    [FieldOffset(81)] public Int16 series_maxSniperSeries;
    [FieldOffset(83)] public byte series_invincibleSeries;
    [FieldOffset(84)] public byte series_maxInvincibleSeries;
    [FieldOffset(85)] public byte series_diehardSeries;
    [FieldOffset(86)] public byte series_maxDiehardSeries;
    [FieldOffset(87)] public byte series_killingSeries;
    [FieldOffset(88)] public byte series_maxKillingSeries;
    [FieldOffset(89)] public byte series_piercingSeries;
    [FieldOffset(90)] public byte series_maxPiercingSeries;

    [FieldOffset(91)] public Int16 battle_battleHeroes;
    [FieldOffset(93)] public Int32 battle_fragsSinai;
    [FieldOffset(97)] public Int16 battle_warrior;
    [FieldOffset(99)] public Int16 battle_invader;
    [FieldOffset(101)] public Int16 battle_sniper;
    [FieldOffset(103)] public Int16 battle_defender;
    [FieldOffset(105)] public Int16 battle_steelwall;
    [FieldOffset(107)] public Int16 battle_supporter;
    [FieldOffset(109)] public Int16 battle_scout;
    [FieldOffset(111)] public Int16 battle_evileye;

    [FieldOffset(113)] public byte major_medalKay;
    [FieldOffset(114)] public byte major_medalCarius;
    [FieldOffset(115)] public byte major_medalKnispel;
    [FieldOffset(116)] public byte major_medalPoppel;
    [FieldOffset(117)] public byte major_medalAbrams;
    [FieldOffset(118)] public byte major_medalLeClerc;
    [FieldOffset(119)] public byte major_medalLavrinenko;
    [FieldOffset(120)] public byte major_medalEkins;

    [FieldOffset(121)] public Int16 epic_medalWittmann;
    [FieldOffset(123)] public Int16 epic_medalOrlik;
    [FieldOffset(125)] public Int16 epic_medalOskin;
    [FieldOffset(127)] public Int16 epic_medalHalonen;
    [FieldOffset(129)] public Int16 epic_medalBurda;
    [FieldOffset(131)] public Int16 epic_medalBillotte;
    [FieldOffset(133)] public Int16 epic_medalKolobanov;
    [FieldOffset(135)] public Int16 epic_medalFadin;
    [FieldOffset(137)] public Int16 epic_medalRadleyWalters;
    [FieldOffset(139)] public Int16 epic_medalBrunoPietro;
    [FieldOffset(141)] public Int16 epic_medalTarczay;
    [FieldOffset(143)] public Int16 epic_medalPascucci;
    [FieldOffset(145)] public Int16 epic_medalDumitru;
    [FieldOffset(147)] public Int16 epic_medalLehvaslaiho;
    [FieldOffset(149)] public Int16 epic_medalNikolas;
    [FieldOffset(151)] public Int16 epic_medalLafayettePool;
    [FieldOffset(278)] public Int16 epic_medalBrothersInArms;
    [FieldOffset(280)] public Int16 epic_medalCrucialContribution;
    [FieldOffset(282)] public Int16 epic_medalDeLanglade;
    [FieldOffset(284)] public Int16 epic_medalTamadaYoshio;

    [FieldOffset(286)] public Int16 special_bombardier;
    [FieldOffset(288)] public Int16 special_huntsman;
    [FieldOffset(290)] public Int16 special_alaric;
    [FieldOffset(292)] public Int16 special_sturdy;
    [FieldOffset(294)] public Int16 special_ironMan;
    [FieldOffset(296)] public Int16 special_luckyDevil;
    [FieldOffset(298)] public Int16 special_pattonValley;
    [FieldOffset(300)] public Int32 special_fragsPatton;
    [FieldOffset(153)] public Int16 special_sinai;
    [FieldOffset(155)] public Int16 special_heroesOfRassenay;
    [FieldOffset(157)] public Int16 special_beasthunter;
    [FieldOffset(159)] public Int16 special_mousebane;
    [FieldOffset(161)] public Int16 special_tankExpertStrg;
    [FieldOffset(163)] public byte special_titleSniper;
    [FieldOffset(164)] public byte special_invincible;
    [FieldOffset(165)] public byte special_diehard;
    [FieldOffset(166)] public Int16 special_raider;
    [FieldOffset(168)] public byte special_handOfDeath;
    [FieldOffset(169)] public byte special_armorPiercer;
    [FieldOffset(170)] public Int16 special_kamikaze;
    [FieldOffset(172)] public byte special_lumberjack;
    [FieldOffset(173)] public byte special_markOfMastery;

    [FieldOffset(174)] public Int32 company_xp;
    [FieldOffset(178)] public Int32 company_battlesCount;
    [FieldOffset(182)] public Int32 company_wins;
    [FieldOffset(186)] public Int32 company_losses;
    [FieldOffset(190)] public Int32 company_survivedBattles;
    [FieldOffset(194)] public Int32 company_frags;
    [FieldOffset(198)] public Int32 company_shots;
    [FieldOffset(202)] public Int32 company_hits;
    [FieldOffset(206)] public Int32 company_spotted;
    [FieldOffset(210)] public Int32 company_damageDealt;
    [FieldOffset(214)] public Int32 company_damageReceived;
    [FieldOffset(218)] public Int32 company_capturePoints;
    [FieldOffset(222)] public Int32 company_droppedCapturePoints;

    [FieldOffset(226)] public Int32 clan_xp;
    [FieldOffset(230)] public Int32 clan_battlesCount;
    [FieldOffset(234)] public Int32 clan_wins;
    [FieldOffset(238)] public Int32 clan_losses;
    [FieldOffset(242)] public Int32 clan_survivedBattles;
    [FieldOffset(246)] public Int32 clan_frags;
    [FieldOffset(250)] public Int32 clan_shots;
    [FieldOffset(254)] public Int32 clan_hits;
    [FieldOffset(258)] public Int32 clan_spotted;
    [FieldOffset(262)] public Int32 clan_damageDealt;
    [FieldOffset(266)] public Int32 clan_damageReceived;
    [FieldOffset(270)] public Int32 clan_capturePoints;
    [FieldOffset(274)] public Int32 clan_droppedCapturePoints;

    [FieldOffset(304)] public Int16 structure_fragspos;
  }
  #endregion

  #region tankdata_version = 27
  [StructLayout(LayoutKind.Explicit)]
  public struct VehicleData_27
  {
    [FieldOffset(0)]   public Int16 tankdata_version;
    [FieldOffset(2)]   public Int32 tankdata_creationTime;
    [FieldOffset(6)]   public Int32 lastBattleTime;
    [FieldOffset(10)]  public Int32 tankdata_battleLifeTime;
    [FieldOffset(14)]  public byte tankdata_maxFrags;
    [FieldOffset(15)]  public Int32 tankdata_xp;
    [FieldOffset(19)]  public Int16 tankdata_maxXP;
    [FieldOffset(21)]  public Int32 tankdata_battlesCount;
    [FieldOffset(25)]  public Int32 tankdata_wins;
    [FieldOffset(29)]  public Int32 tankdata_losses;
    [FieldOffset(33)]  public Int32 tankdata_survivedBattles;
    [FieldOffset(37)]  public Int32 tankdata_winAndSurvived;
    [FieldOffset(41)]  public Int32 tankdata_frags;
    [FieldOffset(45)]  public Int32 tankdata_frags8p;
    [FieldOffset(49)]  public Int32 tankdata_fragsBeast;
    [FieldOffset(53)]  public Int32 tankdata_shots;
    [FieldOffset(57)]  public Int32 tankdata_hits;
    [FieldOffset(61)]  public Int32 tankdata_spotted;
    [FieldOffset(65)]  public Int32 tankdata_damageDealt;
    [FieldOffset(69)]  public Int32 tankdata_damageReceived;
    [FieldOffset(73)]  public Int16 tankdata_treesCut;
    [FieldOffset(75)]  public Int32 tankdata_capturePoints;
    [FieldOffset(79)]  public Int32 tankdata_droppedCapturePoints;

    [FieldOffset(83)]  public Int16 series_sniperSeries;
    [FieldOffset(85)]  public Int16 series_maxSniperSeries;
    [FieldOffset(87)]  public byte series_invincibleSeries;
    [FieldOffset(88)]  public byte series_maxInvincibleSeries;
    [FieldOffset(89)]  public byte series_diehardSeries;
    [FieldOffset(90)]  public byte series_maxDiehardSeries;
    [FieldOffset(91)]  public byte series_killingSeries;
    [FieldOffset(92)]  public byte series_maxKillingSeries;
    [FieldOffset(93)]  public byte series_piercingSeries;
    [FieldOffset(94)]  public byte series_maxPiercingSeries;

    [FieldOffset(95)]  public Int16 battle_battleHeroes;
    [FieldOffset(97)]  public Int32 battle_fragsSinai;
    [FieldOffset(101)] public Int16 battle_warrior;
    [FieldOffset(103)] public Int16 battle_invader;
    [FieldOffset(105)] public Int16 battle_sniper;
    [FieldOffset(107)] public Int16 battle_defender;
    [FieldOffset(109)] public Int16 battle_steelwall;
    [FieldOffset(111)] public Int16 battle_supporter;
    [FieldOffset(113)] public Int16 battle_scout;
    [FieldOffset(115)] public Int16 battle_evileye;

    [FieldOffset(117)] public byte major_medalKay;
    [FieldOffset(118)] public byte major_medalCarius;
    [FieldOffset(119)] public byte major_medalKnispel;
    [FieldOffset(120)] public byte major_medalPoppel;
    [FieldOffset(121)] public byte major_medalAbrams;
    [FieldOffset(122)] public byte major_medalLeClerc;
    [FieldOffset(123)] public byte major_medalLavrinenko;
    [FieldOffset(124)] public byte major_medalEkins;

    [FieldOffset(125)] public Int16 epic_medalWittmann;
    [FieldOffset(127)] public Int16 epic_medalOrlik;
    [FieldOffset(129)] public Int16 epic_medalOskin;
    [FieldOffset(131)] public Int16 epic_medalHalonen;
    [FieldOffset(133)] public Int16 epic_medalBurda;
    [FieldOffset(135)] public Int16 epic_medalBillotte;
    [FieldOffset(137)] public Int16 epic_medalKolobanov;
    [FieldOffset(139)] public Int16 epic_medalFadin;
    [FieldOffset(141)] public Int16 epic_medalRadleyWalters;
    [FieldOffset(143)] public Int16 epic_medalBrunoPietro;
    [FieldOffset(145)] public Int16 epic_medalTarczay;
    [FieldOffset(147)] public Int16 epic_medalPascucci;
    [FieldOffset(149)] public Int16 epic_medalDumitru;
    [FieldOffset(151)] public Int16 epic_medalLehvaslaiho;
    [FieldOffset(153)] public Int16 epic_medalNikolas;
    [FieldOffset(155)] public Int16 epic_medalLafayettePool;

    [FieldOffset(157)] public Int16 special_sinai;
    [FieldOffset(159)] public Int16 special_heroesOfRassenay;
    [FieldOffset(161)] public Int16 special_beasthunter;
    [FieldOffset(163)] public Int16 special_mousebane;
    [FieldOffset(165)] public Int16 special_tankExpertStrg;
    [FieldOffset(167)] public byte special_titleSniper;
    [FieldOffset(168)] public byte special_invincible;
    [FieldOffset(169)] public byte special_diehard;
    [FieldOffset(170)] public Int16 special_raider;
    [FieldOffset(172)] public byte special_handOfDeath;
    [FieldOffset(173)] public byte special_armorPiercer;
    [FieldOffset(174)] public Int16 special_kamikaze;
    [FieldOffset(176)] public byte special_lumberjack;
    [FieldOffset(177)] public byte special_markOfMastery;
    
    [FieldOffset(178)] public Int32 company_xp;
    [FieldOffset(182)] public Int32 company_battlesCount;
    [FieldOffset(186)] public Int32 company_wins;
    [FieldOffset(190)] public Int32 company_losses;
    [FieldOffset(194)] public Int32 company_survivedBattles;
    [FieldOffset(198)] public Int32 company_frags;
    [FieldOffset(202)] public Int32 company_shots;
    [FieldOffset(206)] public Int32 company_hits;
    [FieldOffset(210)] public Int32 company_spotted;
    [FieldOffset(214)] public Int32 company_damageDealt;
    [FieldOffset(218)] public Int32 company_damageReceived;
    [FieldOffset(222)] public Int32 company_capturePoints;
    [FieldOffset(226)] public Int32 company_droppedCapturePoints;

    [FieldOffset(230)] public Int32 clan_xp;
    [FieldOffset(234)] public Int32 clan_battlesCount;
    [FieldOffset(238)] public Int32 clan_wins;
    [FieldOffset(242)] public Int32 clan_losses;
    [FieldOffset(246)] public Int32 clan_survivedBattles;
    [FieldOffset(250)] public Int32 clan_frags;
    [FieldOffset(254)] public Int32 clan_shots;
    [FieldOffset(258)] public Int32 clan_hits;
    [FieldOffset(262)] public Int32 clan_spotted;
    [FieldOffset(266)] public Int32 clan_damageDealt;
    [FieldOffset(270)] public Int32 clan_damageReceived;
    [FieldOffset(274)] public Int32 clan_capturePoints;
    [FieldOffset(278)] public Int32 clan_droppedCapturePoints;
    
    [FieldOffset(282)] public Int16 epic_medalBrothersInArms;
    [FieldOffset(284)] public Int16 epic_medalCrucialContribution;
    [FieldOffset(286)] public Int16 epic_medalDeLanglade;
    [FieldOffset(288)] public Int16 epic_medalTamadaYoshio;

    [FieldOffset(290)] public Int16 special_bombardier;
    [FieldOffset(292)] public Int16 special_huntsman;
    [FieldOffset(294)] public Int16 special_alaric;
    [FieldOffset(296)] public Int16 special_sturdy;
    [FieldOffset(298)] public Int16 special_ironMan;
    [FieldOffset(300)] public Int16 special_luckyDevil;
    [FieldOffset(302)] public Int16 special_pattonValley;
    [FieldOffset(304)] public Int32 special_fragsPatton;

    [FieldOffset(308)] public Int16 structure_fragspos;
  }
  #endregion

  #region tankdata_version = 28
  [StructLayout(LayoutKind.Explicit)]
  public struct VehicleData_28
  {
    [FieldOffset(0)]   public Int16 tankdata_version;
    [FieldOffset(2)]   public Int32 tankdata_creationTime;
    [FieldOffset(6)]   public Int32 lastBattleTime;
    [FieldOffset(10)]  public Int32 tankdata_battleLifeTime;
    [FieldOffset(14)]  public byte tankdata_maxFrags;
    [FieldOffset(15)]  public Int32 tankdata_xp;
    [FieldOffset(19)]  public Int16 tankdata_maxXP;
    [FieldOffset(21)]  public Int32 tankdata_battlesCount;
    [FieldOffset(25)]  public Int32 tankdata_wins;
    [FieldOffset(29)]  public Int32 tankdata_losses;
    [FieldOffset(33)]  public Int32 tankdata_survivedBattles;
    [FieldOffset(37)]  public Int32 tankdata_winAndSurvived;
    [FieldOffset(41)]  public Int32 tankdata_frags;
    [FieldOffset(45)]  public Int32 tankdata_frags8p;
    [FieldOffset(49)]  public Int32 tankdata_fragsBeast;
    [FieldOffset(53)]  public Int32 tankdata_shots;
    [FieldOffset(57)]  public Int32 tankdata_hits;
    [FieldOffset(61)]  public Int32 tankdata_spotted;
    [FieldOffset(65)]  public Int32 tankdata_damageDealt;
    [FieldOffset(69)]  public Int32 tankdata_damageReceived;
    [FieldOffset(73)]  public Int16 tankdata_treesCut;
    [FieldOffset(75)]  public Int32 tankdata_capturePoints;
    [FieldOffset(79)]  public Int32 tankdata_droppedCapturePoints;

    [FieldOffset(83)]  public Int16 series_sniperSeries;
    [FieldOffset(85)]  public Int16 series_maxSniperSeries;
    [FieldOffset(87)]  public byte series_invincibleSeries;
    [FieldOffset(88)]  public byte series_maxInvincibleSeries;
    [FieldOffset(89)]  public byte series_diehardSeries;
    [FieldOffset(90)]  public byte series_maxDiehardSeries;
    [FieldOffset(91)]  public byte series_killingSeries;
    [FieldOffset(92)]  public byte series_maxKillingSeries;
    [FieldOffset(93)]  public byte series_piercingSeries;
    [FieldOffset(94)]  public byte series_maxPiercingSeries;

    [FieldOffset(95)]  public Int16 battle_battleHeroes;
    [FieldOffset(97)]  public Int32 battle_fragsSinai;
    [FieldOffset(101)] public Int16 battle_warrior;
    [FieldOffset(103)] public Int16 battle_invader;
    [FieldOffset(105)] public Int16 battle_sniper;
    [FieldOffset(107)] public Int16 battle_defender;
    [FieldOffset(109)] public Int16 battle_steelwall;
    [FieldOffset(111)] public Int16 battle_supporter;
    [FieldOffset(113)] public Int16 battle_scout;
    [FieldOffset(115)] public Int16 battle_evileye;

    [FieldOffset(117)] public byte major_medalKay;
    [FieldOffset(118)] public byte major_medalCarius;
    [FieldOffset(119)] public byte major_medalKnispel;
    [FieldOffset(120)] public byte major_medalPoppel;
    [FieldOffset(121)] public byte major_medalAbrams;
    [FieldOffset(122)] public byte major_medalLeClerc;
    [FieldOffset(123)] public byte major_medalLavrinenko;
    [FieldOffset(124)] public byte major_medalEkins;

    [FieldOffset(125)] public Int16 epic_medalWittmann;
    [FieldOffset(127)] public Int16 epic_medalOrlik;
    [FieldOffset(129)] public Int16 epic_medalOskin;
    [FieldOffset(131)] public Int16 epic_medalHalonen;
    [FieldOffset(133)] public Int16 epic_medalBurda;
    [FieldOffset(135)] public Int16 epic_medalBillotte;
    [FieldOffset(137)] public Int16 epic_medalKolobanov;
    [FieldOffset(139)] public Int16 epic_medalFadin;
    [FieldOffset(141)] public Int16 epic_medalRadleyWalters;
    [FieldOffset(143)] public Int16 epic_medalBrunoPietro;
    [FieldOffset(145)] public Int16 epic_medalTarczay;
    [FieldOffset(147)] public Int16 epic_medalPascucci;
    [FieldOffset(149)] public Int16 epic_medalDumitru;
    [FieldOffset(151)] public Int16 epic_medalLehvaslaiho;
    [FieldOffset(153)] public Int16 epic_medalNikolas;
    [FieldOffset(155)] public Int16 epic_medalLafayettePool;

    [FieldOffset(157)] public Int16 special_sinai;
    [FieldOffset(159)] public Int16 special_heroesOfRassenay;
    [FieldOffset(161)] public Int16 special_beasthunter;
    [FieldOffset(163)] public Int16 special_mousebane;
    [FieldOffset(165)] public Int16 special_tankExpertStrg;
    [FieldOffset(167)] public byte special_titleSniper;
    [FieldOffset(168)] public byte special_invincible;
    [FieldOffset(169)] public byte special_diehard;
    [FieldOffset(170)] public Int16 special_raider;
    [FieldOffset(172)] public byte special_handOfDeath;
    [FieldOffset(173)] public byte special_armorPiercer;
    [FieldOffset(174)] public Int16 special_kamikaze;
    [FieldOffset(176)] public Int16 special_lumberjack;
    [FieldOffset(178)] public byte special_markOfMastery;
    
    [FieldOffset(179)] public Int32 company_xp;
    [FieldOffset(183)] public Int32 company_battlesCount;
    [FieldOffset(187)] public Int32 company_wins;
    [FieldOffset(191)] public Int32 company_losses;
    [FieldOffset(195)] public Int32 company_survivedBattles;
    [FieldOffset(199)] public Int32 company_frags;
    [FieldOffset(203)] public Int32 company_shots;
    [FieldOffset(207)] public Int32 company_hits;
    [FieldOffset(211)] public Int32 company_spotted;
    [FieldOffset(215)] public Int32 company_damageDealt;
    [FieldOffset(219)] public Int32 company_damageReceived;
    [FieldOffset(223)] public Int32 company_capturePoints;
    [FieldOffset(227)] public Int32 company_droppedCapturePoints;

    [FieldOffset(231)] public Int32 clan_xp;
    [FieldOffset(235)] public Int32 clan_battlesCount;
    [FieldOffset(239)] public Int32 clan_wins;
    [FieldOffset(243)] public Int32 clan_losses;
    [FieldOffset(247)] public Int32 clan_survivedBattles;
    [FieldOffset(251)] public Int32 clan_frags;
    [FieldOffset(255)] public Int32 clan_shots;
    [FieldOffset(259)] public Int32 clan_hits;
    [FieldOffset(263)] public Int32 clan_spotted;
    [FieldOffset(267)] public Int32 clan_damageDealt;
    [FieldOffset(271)] public Int32 clan_damageReceived;
    [FieldOffset(275)] public Int32 clan_capturePoints;
    [FieldOffset(279)] public Int32 clan_droppedCapturePoints;
    
    [FieldOffset(283)] public Int16 epic_medalBrothersInArms;
    [FieldOffset(285)] public Int16 epic_medalCrucialContribution;
    [FieldOffset(287)] public Int16 epic_medalDeLanglade;
    [FieldOffset(289)] public Int16 epic_medalTamadaYoshio;

    [FieldOffset(291)] public Int16 special_bombardier;
    [FieldOffset(293)] public Int16 special_huntsman;
    [FieldOffset(295)] public Int16 special_alaric;
    [FieldOffset(297)] public Int16 special_sturdy;
    [FieldOffset(299)] public Int16 special_ironMan;
    [FieldOffset(301)] public Int16 special_luckyDevil;
    [FieldOffset(303)] public Int16 special_pattonValley;
    [FieldOffset(305)] public Int32 special_fragsPatton;

    [FieldOffset(309)] public Int16 structure_fragspos;
  }
  #endregion
}
