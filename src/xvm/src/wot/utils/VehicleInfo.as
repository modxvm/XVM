/**
 * ...
 * @author sirmax2
 */
import wot.utils.Utils;

class wot.utils.VehicleInfo
{
  // icon = ../maps/icons/vehicle/contour/usa-M24_Chaffee.tga
  public static function getName(str: String): String
  {
    // str is icon path?
    if (Utils.endsWith(".png", str))
    {
      var a = str.split("\\");
      str = a[a.length - 1];
      str = str.slice(str.indexOf("-") + 1, str.lastIndexOf("."));
      str = str.split("-").join("_");
      str = Utils.trim(str);
    }

    return str;
  }

  public static function getInfo(str: String): Object
  {
    return _data[getName(str)] || null;
  }

  // PRIVATE

  private static var LT = 1;
  private static var MT = 2;
  private static var HT = 3;
  private static var TD = 4;
  private static var SP = 5;

  private static var _data = {
    // unknown
    A44:			{ level: 0,  type: HT, tiers: [ 0, 0 ] },

    // level 1
    Ltraktor:			{ level: 1,  type: LT, tiers: [ 1, 2 ] },
    MS_1:			{ level: 1,  type: LT, tiers: [ 1, 2 ] },
    RenaultFT:			{ level: 1,  type: LT, tiers: [ 1, 2 ] },
    T1_Cunningham:		{ level: 1,  type: LT, tiers: [ 1, 2 ] },

    // level 2
    BT_2:			{ level: 2,  type: LT, tiers: [ 2, 3 ] },
    D1:				{ level: 2,  type: LT, tiers: [ 2, 3 ] },
    H39_captured:		{ level: 2,  type: LT, tiers: [ 2, 3 ] },
    Hotchkiss_H35:		{ level: 2,  type: LT, tiers: [ 2, 3 ] },
    M2_lt:			{ level: 2,  type: LT, tiers: [ 2, 3 ] },
    Pz35t:			{ level: 2,  type: LT, tiers: [ 2, 3 ] },
    PzII:			{ level: 2,  type: LT, tiers: [ 2, 3 ] },
    T_26:			{ level: 2,  type: LT, tiers: [ 2, 3 ] },
    Tetrarch_LL:		{ level: 2,  type: LT, tiers: [ 2, 3 ] },
    T2_med:			{ level: 2,  type: MT, tiers: [ 2, 3 ] },
    SU_18:			{ level: 2,  type: SP, tiers: [ 3, 5 ] },
    T57:			{ level: 2,  type: SP, tiers: [ 3, 5 ] },
    AT_1:			{ level: 2,  type: TD, tiers: [ 3, 5 ] },
    PanzerJager_I:		{ level: 2,  type: TD, tiers: [ 3, 5 ] },
    T18:			{ level: 2,  type: TD, tiers: [ 3, 5 ] },

    // level 3
    AMX38:			{ level: 3,  type: LT, tiers: [ 3, 6 ] },
    BT_7:			{ level: 3,  type: LT, tiers: [ 3, 6 ] },
    M22_Locust:			{ level: 3,  type: LT, tiers: [ 3, 6 ] },
    M3_Stuart:			{ level: 3,  type: LT, tiers: [ 3, 6 ] },
    MTLS_1G14:			{ level: 3,  type: LT, tiers: [ 3, 6 ] },
    Pz38t:			{ level: 3,  type: LT, tiers: [ 3, 6 ] },
    PzIII_A:			{ level: 3,  type: LT, tiers: [ 3, 6 ] },
    PzII_Luchs:			{ level: 3,  type: LT, tiers: [ 3, 6 ] },
    T_127:			{ level: 3,  type: LT, tiers: [ 3, 6 ] },
    T_15:			{ level: 3,  type: LT, tiers: [ 3, 6 ] },
    T_46:			{ level: 3,  type: LT, tiers: [ 3, 6 ] },
    D2:				{ level: 3,  type: MT, tiers: [ 3, 6 ] },
    M2_med:			{ level: 3,  type: MT, tiers: [ 3, 6 ] },
    S35_captured:		{ level: 3,  type: MT, tiers: [ 3, 6 ] },
    M37:			{ level: 3,  type: SP, tiers: [ 4, 8 ] },
    SU_26:			{ level: 3,  type: SP, tiers: [ 4, 8 ] },
    Sturmpanzer_II:		{ level: 3,  type: SP, tiers: [ 4, 8 ] },
    Wespe:			{ level: 3,  type: SP, tiers: [ 4, 8 ] },
    FCM_36Pak40:		{ level: 3,  type: TD, tiers: [ 4, 6 ] },
    G20_Marder_II:		{ level: 3,  type: TD, tiers: [ 4, 6 ] },
    SU_76:			{ level: 3,  type: TD, tiers: [ 4, 6 ] },
    T82:			{ level: 3,  type: TD, tiers: [ 4, 6 ] },

    // level 4
    A_20:			{ level: 4,  type: LT, tiers: [ 4, 10 ] },
    M5_Stuart:			{ level: 4,  type: LT, tiers: [ 4, 10 ] },
    Pz38_NA:			{ level: 4,  type: LT, tiers: [ 4, 10 ] },
    A_32:			{ level: 4,  type: MT, tiers: [ 4, 8 ] },
    M3_Grant:			{ level: 4,  type: MT, tiers: [ 4, 8 ] },
    PzIII:			{ level: 4,  type: MT, tiers: [ 4, 8 ] },
    T_28:			{ level: 4,  type: MT, tiers: [ 4, 8 ] },
    B1:				{ level: 4,  type: HT, tiers: [ 4, 6 ] },
    B_1bis_captured:		{ level: 4,  type: HT, tiers: [ 4, 6 ] },
    Grille:			{ level: 4,  type: SP, tiers: [ 6, 9 ] },
    M7_Priest:			{ level: 4,  type: SP, tiers: [ 6, 9 ] },
    SU_5:			{ level: 4,  type: SP, tiers: [ 6, 9 ] },
    _105_leFH18B2:		{ level: 4,  type: SP, tiers: [ 6, 9 ] },
    GAZ_74b:			{ level: 4,  type: TD, tiers: [ 5, 8 ] },
    Hetzer:			{ level: 4,  type: TD, tiers: [ 5, 8 ] },
    M8A1:			{ level: 4,  type: TD, tiers: [ 5, 8 ] },
    T40:			{ level: 4,  type: TD, tiers: [ 5, 8 ] },

    // level 5
    M24_Chaffee:		{ level: 5,  type: LT, tiers: [ 8, 13 ] },
    T_50_2:			{ level: 5,  type: LT, tiers: [ 8, 13 ] },
    VK2801:			{ level: 5,  type: LT, tiers: [ 8, 13 ] },
    M4_Sherman:			{ level: 5,  type: MT, tiers: [ 6, 9 ] },
    M7_med:			{ level: 5,  type: MT, tiers: [ 6, 9 ] },
    PzIII_IV:			{ level: 5,  type: MT, tiers: [ 6, 9 ] },
    PzIV:			{ level: 5,  type: MT, tiers: [ 6, 9 ] },
    Ram_II:			{ level: 5,  type: MT, tiers: [ 6, 9 ] },
    T_25:			{ level: 5,  type: MT, tiers: [ 6, 9 ] },
    T_34:			{ level: 5,  type: MT, tiers: [ 6, 9 ] },
    BDR_G1B:			{ level: 5,  type: HT, tiers: [ 6, 9 ] },
    KV1:			{ level: 5,  type: HT, tiers: [ 6, 9 ] },
    T1_hvy:			{ level: 5,  type: HT, tiers: [ 6, 9 ] },
    Hummel:			{ level: 5,  type: SP, tiers: [ 8, 10 ] },
    M41:			{ level: 5,  type: SP, tiers: [ 8, 10 ] },
    SU_8:			{ level: 5,  type: SP, tiers: [ 8, 10 ] },
    M10_Wolverine:		{ level: 5,  type: TD, tiers: [ 6, 9 ] },
    SU_85:			{ level: 5,  type: TD, tiers: [ 6, 9 ] },
    StuGIII:			{ level: 5,  type: TD, tiers: [ 6, 9 ] },
    T49:			{ level: 5,  type: TD, tiers: [ 6, 9 ] },

    // level 6
    AMX_13_75:			{ level: 6,  type: LT, tiers: [ 8, 12 ] },
    M4A3E8_Sherman:		{ level: 6,  type: MT, tiers: [ 7, 10 ] },
    PzV_PzIV_ausf_Alfa:		{ level: 6,  type: MT, tiers: [ 7, 10 ] },
    PzV_PzIV:			{ level: 6,  type: MT, tiers: [ 7, 10 ] },
    Sherman_Jumbo:		{ level: 6,  type: MT, tiers: [ 7, 10 ] },
    T_34_85:			{ level: 6,  type: MT, tiers: [ 7, 10 ] },
    VK3001H:			{ level: 6,  type: MT, tiers: [ 7, 10 ] },
    VK3001P:			{ level: 6,  type: MT, tiers: [ 7, 10 ] },
    VK3601H:			{ level: 6,  type: MT, tiers: [ 7, 10 ] },
    ARL_44:			{ level: 6,  type: HT, tiers: [ 7, 11 ] },
    KV2:			{ level: 6,  type: HT, tiers: [ 7, 11 ] },
    KV_1s:			{ level: 6,  type: HT, tiers: [ 7, 11 ] },
    M6:				{ level: 6,  type: HT, tiers: [ 7, 11 ] },
    T150:			{ level: 6,  type: HT, tiers: [ 7, 11 ] },
    G_Panther:			{ level: 6,  type: SP, tiers: [ 10, 11 ] },
    M12:			{ level: 6,  type: SP, tiers: [ 10, 11 ] },
    SU_14:			{ level: 6,  type: SP, tiers: [ 10, 11 ] },
    S_51:			{ level: 6,  type: SP, tiers: [ 10, 11 ] },
    JagdPzIV:			{ level: 6,  type: TD, tiers: [ 7, 10 ] },
    M18_Hellcat:		{ level: 6,  type: TD, tiers: [ 7, 10 ] },
    M36_Slagger:		{ level: 6,  type: TD, tiers: [ 7, 10 ] },
    SU_100:			{ level: 6,  type: TD, tiers: [ 7, 10 ] },

    // level 7
    AMX_13_90:			{ level: 7,  type: LT, tiers: [ 10, 13 ] },
    KV_13:			{ level: 7,  type: MT, tiers: [ 8, 11 ] },
    PzV:			{ level: 7,  type: MT, tiers: [ 8, 11 ] },
    T20:			{ level: 7,  type: MT, tiers: [ 8, 11 ] },
    T_43:			{ level: 7,  type: MT, tiers: [ 8, 11 ] },
    VK3002DB:			{ level: 7,  type: MT, tiers: [ 8, 11 ] },
    AMX_M4_1945:		{ level: 7,  type: HT, tiers: [ 8, 12 ] },
    IS:				{ level: 7,  type: HT, tiers: [ 8, 12 ] },
    KV_3:			{ level: 7,  type: HT, tiers: [ 8, 12 ] },
    PzVI:			{ level: 7,  type: HT, tiers: [ 8, 12 ] },
    PzVI_Tiger_P:		{ level: 7,  type: HT, tiers: [ 8, 12 ] },
    T29:			{ level: 7,  type: HT, tiers: [ 8, 12 ] },
    G_Tiger:			{ level: 7,  type: SP, tiers: [ 11, 12 ] },
    M40M43:			{ level: 7,  type: SP, tiers: [ 11, 12 ] },
    Object_212:			{ level: 7,  type: SP, tiers: [ 11, 12 ] },
    JagdPanther:		{ level: 7,  type: TD, tiers: [ 8, 11 ] },
    SU_152:			{ level: 7,  type: TD, tiers: [ 8, 11 ] },
    T25_2:			{ level: 7,  type: TD, tiers: [ 8, 11 ] },
    T25_AT:			{ level: 7,  type: TD, tiers: [ 8, 11 ] },

    // level 8
    Ch01_Type59:		{ level: 8,  type: MT, tiers: [ 9, 11 ] },
    Lorraine40t:		{ level: 8,  type: MT, tiers: [ 9, 11 ] },
    Panther_II:			{ level: 8,  type: MT, tiers: [ 9, 11 ] },
    Pershing:			{ level: 8,  type: MT, tiers: [ 9, 11 ] },
    T23:			{ level: 8,  type: MT, tiers: [ 9, 11 ] },
    T_44:			{ level: 8,  type: MT, tiers: [ 9, 11 ] },
    AMX_50_100:			{ level: 8,  type: HT, tiers: [ 9, 12 ] },
    Ch03_WZ_111:		{ level: 8,  type: HT, tiers: [ 9, 12 ] },
    IS_3:			{ level: 8,  type: HT, tiers: [ 9, 12 ] },
    KV4:			{ level: 8,  type: HT, tiers: [ 9, 12 ] },
    PzVIB_Tiger_II:		{ level: 8,  type: HT, tiers: [ 9, 12 ] },
    T32:			{ level: 8,  type: HT, tiers: [ 9, 12 ] },
    T34_hvy:			{ level: 8,  type: HT, tiers: [ 9, 12 ] },
    VK4502A:			{ level: 8,  type: HT, tiers: [ 9, 12 ] },
    G_E:			{ level: 8,  type: SP, tiers: [ 12, 13 ] },
    Object_261:			{ level: 8,  type: SP, tiers: [ 12, 13 ] },
    T92:			{ level: 8,  type: SP, tiers: [ 12, 13 ] },
    Ferdinand:			{ level: 8,  type: TD, tiers: [ 9, 12 ] },
    ISU_152:			{ level: 8,  type: TD, tiers: [ 9, 12 ] },
    T28:			{ level: 8,  type: TD, tiers: [ 9, 12 ] },
    T28_Prototype:		{ level: 8,  type: TD, tiers: [ 9, 12 ] },

    // level 9
    Bat_Chatillon25t:		{ level: 9,  type: MT, tiers: [ 11, 13 ] },
    E_50:			{ level: 9,  type: MT, tiers: [ 11, 13 ] },
    M46_Patton:			{ level: 9,  type: MT, tiers: [ 11, 13 ] },
    T_54:			{ level: 9,  type: MT, tiers: [ 11, 13 ] },
    AMX_50_120:			{ level: 9,  type: HT, tiers: [ 10, 13 ] },
    E_75:			{ level: 9,  type: HT, tiers: [ 10, 13 ] },
    IS8:			{ level: 9,  type: HT, tiers: [ 10, 13 ] },
    M103:			{ level: 9,  type: HT, tiers: [ 10, 13 ] },
    ST_I:			{ level: 9,  type: HT, tiers: [ 10, 13 ] },
    VK4502P:			{ level: 9,  type: HT, tiers: [ 10, 13 ] },
    JagdTiger:			{ level: 9,  type: TD, tiers: [ 10, 13 ] },
    Object_704:			{ level: 9,  type: TD, tiers: [ 10, 13 ] },
    T30:			{ level: 9,  type: TD, tiers: [ 10, 13 ] },
    T95:			{ level: 9,  type: TD, tiers: [ 10, 13 ] },

    // level 10
    E_100:			{ level: 10, type: HT, tiers: [ 11, 13 ] },
    F10_AMX_50B:		{ level: 10, type: HT, tiers: [ 11, 13 ] },
    IS_4:			{ level: 10, type: HT, tiers: [ 11, 13 ] },
    IS_7:			{ level: 10, type: HT, tiers: [ 11, 13 ] },
    Maus:			{ level: 10, type: HT, tiers: [ 11, 13 ] },
    T110:			{ level: 10, type: HT, tiers: [ 11, 13 ] },

    // non-standard
    Bison_I:			{ level: 2,  type: SP, tiers: [ 3, 7 ] },
    T2_lt:			{ level: 2,  type: LT, tiers: [ 2, 5 ] },
    M3_Stuart_LL:		{ level: 3,  type: LT, tiers: [ 3, 5 ] },
    BT_SV:			{ level: 3,  type: LT, tiers: [ 3, 5 ] },
    PzII_J:			{ level: 3,  type: LT, tiers: [ 3, 5 ] },
    T_50:			{ level: 4,  type: LT, tiers: [ 6, 10 ] },
    VK1602:			{ level: 4,  type: LT, tiers: [ 6, 10 ] },
    Valentine_LL:		{ level: 4,  type: LT, tiers: [ 4, 6 ] },
    AMX40:			{ level: 4,  type: LT, tiers: [ 4, 8 ] },
    AMX_12t:			{ level: 5,  type: LT, tiers: [ 7, 10 ] },
    SU_85I:			{ level: 5,  type: TD, tiers: [ 6, 8 ] },
    PzIV_Hydro:			{ level: 5,  type: MT, tiers: [ 6, 8 ] },
    Churchill_LL:		{ level: 5,  type: HT, tiers: [ 6, 7 ] },
    Matilda_II_LL:		{ level: 5,  type: MT, tiers: [ 6, 8 ] },
    T14:			{ level: 5,  type: HT, tiers: [ 6, 7 ] },
    KV_220:			{ level: 5,  type: HT, tiers: [ 6, 7 ] },
    KV_220_action:		{ level: 5,  type: HT, tiers: [ 6, 7 ] },
    M4A2E4:			{ level: 5,  type: MT, tiers: [ 6, 8 ] },
    Ch02_Type62:		{ level: 6,  type: LT, tiers: [ 8, 11 ] },
    M6A2E1:			{ level: 8,  type: HT, tiers: [ 9, 11 ] },
    KV_5:			{ level: 8,  type: HT, tiers: [ 9, 10 ] },
    Lowe:			{ level: 8,  type: HT, tiers: [ 9, 11 ] },
    Object252:			{ level: 8,  type: HT, tiers: [ 9, 11 ] },
    JagdTiger_SdKfz_185:        { level: 8,  type: TD, tiers: [ 9, 11 ] }
  }
}
