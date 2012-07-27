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
      str = str.slice(str.lastIndexOf("/") + 1, str.lastIndexOf("."));
    str = str.split("-").join("_");
    str = Utils.trim(str);
    return str;
  }

  public static function getVehicleId(str: String): String
  {
    if (Utils.endsWith(".png", str))
    {
      str = str.slice(str.lastIndexOf("/") + 1, str.lastIndexOf("."));
      str = str.slice(str.indexOf("-") + 1);
      str = Utils.trim(str);
      return str.toUpperCase();
    }
    return null;
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

    // level 1
    germany_Ltraktor:			{ level: 1,  type: LT, tiers: [ 1, 2 ] },
    ussr_MS_1:				{ level: 1,  type: LT, tiers: [ 1, 2 ] },
    france_RenaultFT:			{ level: 1,  type: LT, tiers: [ 1, 2 ] },
    usa_T1_Cunningham:			{ level: 1,  type: LT, tiers: [ 1, 2 ] },

    // level 2
    ussr_BT_2:				{ level: 2,  type: LT, tiers: [ 2, 3 ] },
    france_D1:				{ level: 2,  type: LT, tiers: [ 2, 3 ] },
    germany_H39_captured:		{ level: 2,  type: LT, tiers: [ 2, 3 ] },
    france_Hotchkiss_H35:		{ level: 2,  type: LT, tiers: [ 2, 3 ] },
    usa_M2_lt:				{ level: 2,  type: LT, tiers: [ 2, 3 ] },
    germany_Pz35t:			{ level: 2,  type: LT, tiers: [ 2, 3 ] },
    germany_PzII:			{ level: 2,  type: LT, tiers: [ 2, 3 ] },
    ussr_T_26:				{ level: 2,  type: LT, tiers: [ 2, 3 ] },
    ussr_Tetrarch_LL:			{ level: 2,  type: LT, tiers: [ 2, 3 ] },
    usa_T2_med:				{ level: 2,  type: MT, tiers: [ 2, 3 ] },
    france_RenaultBS:			{ level: 2,  type: SP, tiers: [ 3, 4 ] },
    ussr_SU_18:				{ level: 2,  type: SP, tiers: [ 3, 4 ] },
    usa_T57:				{ level: 2,  type: SP, tiers: [ 3, 4 ] },
    ussr_AT_1:				{ level: 2,  type: TD, tiers: [ 2, 3 ] },
    germany_PanzerJager_I:		{ level: 2,  type: TD, tiers: [ 2, 3 ] },
    usa_T18:				{ level: 2,  type: TD, tiers: [ 2, 3 ] },
    france_RenaultFT_AC:		{ level: 2,  type: TD, tiers: [ 2, 3 ] },

    // level 3
    france_AMX38:			{ level: 3,  type: LT, tiers: [ 3, 5 ] },
    ussr_BT_7:				{ level: 3,  type: LT, tiers: [ 3, 5 ] },
    usa_M22_Locust:			{ level: 3,  type: LT, tiers: [ 3, 5 ] },
    usa_M3_Stuart:			{ level: 3,  type: LT, tiers: [ 3, 5 ] },
    usa_MTLS_1G14:			{ level: 3,  type: LT, tiers: [ 3, 5 ] },
    germany_Pz38t:			{ level: 3,  type: LT, tiers: [ 3, 5 ] },
    germany_PzIII_A:			{ level: 3,  type: LT, tiers: [ 3, 5 ] },
    germany_PzII_Luchs:			{ level: 3,  type: LT, tiers: [ 3, 5 ] },
    ussr_T_127:				{ level: 3,  type: LT, tiers: [ 3, 5 ] },
    germany_T_15:			{ level: 3,  type: LT, tiers: [ 3, 5 ] },
    ussr_T_46:				{ level: 3,  type: LT, tiers: [ 3, 5 ] },
    france_D2:				{ level: 3,  type: MT, tiers: [ 3, 5 ] },
    usa_M2_med:				{ level: 3,  type: MT, tiers: [ 3, 5 ] },
    germany_S35_captured:		{ level: 3,  type: MT, tiers: [ 3, 5 ] },
    usa_M37:				{ level: 3,  type: SP, tiers: [ 4, 6 ] },
    ussr_SU_26:				{ level: 3,  type: SP, tiers: [ 4, 6 ] },
    germany_Sturmpanzer_II:		{ level: 3,  type: SP, tiers: [ 4, 6 ] },
    germany_Wespe:			{ level: 3,  type: SP, tiers: [ 4, 6 ] },
    france_Lorraine39_L_AM:     	{ level: 3,  type: SP, tiers: [ 4, 6 ] },
    france_FCM_36Pak40:			{ level: 3,  type: TD, tiers: [ 3, 5 ] },
    germany_G20_Marder_II:		{ level: 3,  type: TD, tiers: [ 3, 5 ] },
    ussr_SU_76:				{ level: 3,  type: TD, tiers: [ 3, 5 ] },
    usa_T82:				{ level: 3,  type: TD, tiers: [ 3, 5 ] },
    france_RenaultUE57:         	{ level: 3,  type: TD, tiers: [ 3, 5 ] },

    // level 4
    ussr_A_20:				{ level: 4,  type: LT, tiers: [ 4, 8 ] },
    usa_M5_Stuart:			{ level: 4,  type: LT, tiers: [ 4, 8 ] },
    germany_Pz38_NA:			{ level: 4,  type: LT, tiers: [ 4, 8 ] },
    usa_M3_Grant:			{ level: 4,  type: MT, tiers: [ 4, 6 ] },
    germany_PzIII:			{ level: 4,  type: MT, tiers: [ 4, 6 ] },
    ussr_T_28:				{ level: 4,  type: MT, tiers: [ 4, 6 ] },
    france_B1:				{ level: 4,  type: HT, tiers: [ 4, 5 ] },
    germany_Grille:			{ level: 4,  type: SP, tiers: [ 5, 8 ] },
    usa_M7_Priest:			{ level: 4,  type: SP, tiers: [ 5, 8 ] },
    ussr_SU_5:				{ level: 4,  type: SP, tiers: [ 5, 8 ] },
    france__105_leFH18B2:		{ level: 4,  type: SP, tiers: [ 5, 8 ] },
    france_AMX_105AM:           	{ level: 4,  type: SP, tiers: [ 5, 8 ] },
    ussr_GAZ_74b:			{ level: 4,  type: TD, tiers: [ 4, 6 ] },
    germany_Hetzer:			{ level: 4,  type: TD, tiers: [ 4, 6 ] },
    usa_M8A1:				{ level: 4,  type: TD, tiers: [ 4, 6 ] },
    usa_T40:				{ level: 4,  type: TD, tiers: [ 4, 6 ] },
    france_Somua_Sau_40:        	{ level: 4,  type: TD, tiers: [ 4, 6 ] },

    // level 5
    usa_M24_Chaffee:			{ level: 5,  type: LT, tiers: [ 7, 12 ] },
    ussr_T_50_2:			{ level: 5,  type: LT, tiers: [ 7, 12 ] },
    germany_VK2801:			{ level: 5,  type: LT, tiers: [ 7, 12 ] },
    usa_M4_Sherman:			{ level: 5,  type: MT, tiers: [ 5, 7 ] },
    usa_M7_med:				{ level: 5,  type: MT, tiers: [ 5, 7 ] },
    germany_PzIII_IV:			{ level: 5,  type: MT, tiers: [ 5, 7 ] },
    germany_PzIV:			{ level: 5,  type: MT, tiers: [ 5, 7 ] },
    usa_Ram_II:				{ level: 5,  type: MT, tiers: [ 5, 7 ] },
    germany_T_25:			{ level: 5,  type: MT, tiers: [ 5, 7 ] },
    ussr_T_34:				{ level: 5,  type: MT, tiers: [ 5, 7 ] },
    uk_GB68_Matilda_Black_Prince:	{ level: 5,  type: MT, tiers: [ 5, 7 ] },
    france_BDR_G1B:			{ level: 5,  type: HT, tiers: [ 5, 7 ] },
    usa_T1_hvy:				{ level: 5,  type: HT, tiers: [ 5, 7 ] },
    ussr_KV1:				{ level: 5,  type: HT, tiers: [ 5, 7 ] },
    ussr_KV_220_action:			{ level: 5,  type: HT, tiers: [ 5, 7 ] },
    germany_Hummel:			{ level: 5,  type: SP, tiers: [ 7, 9 ] },
    usa_M41:				{ level: 5,  type: SP, tiers: [ 7, 9 ] },
    ussr_SU_8:				{ level: 5,  type: SP, tiers: [ 7, 9 ] },
    france_AMX_13F3AM:          	{ level: 5,  type: SP, tiers: [ 7, 9 ] },
    usa_M10_Wolverine:			{ level: 5,  type: TD, tiers: [ 5, 7 ] },
    ussr_SU_85:				{ level: 5,  type: TD, tiers: [ 5, 7 ] },
    ussr_SU_85I:			{ level: 5,  type: TD, tiers: [ 5, 7 ] },
    germany_StuGIII:			{ level: 5,  type: TD, tiers: [ 5, 7 ] },
    usa_T49:				{ level: 5,  type: TD, tiers: [ 5, 7 ] },
    france_S_35CA:              	{ level: 5,  type: TD, tiers: [ 5, 7 ] },

    // level 6
    france_AMX_12t:			{ level: 6,  type: LT, tiers: [ 7, 11 ] },
    usa_M4A3E8_Sherman:			{ level: 6,  type: MT, tiers: [ 6, 8 ] },
    usa_Sherman_Jumbo:			{ level: 6,  type: MT, tiers: [ 6, 8 ] },
    ussr_T_34_85:			{ level: 6,  type: MT, tiers: [ 6, 8 ] },
    germany_VK3001H:			{ level: 6,  type: MT, tiers: [ 6, 8 ] },
    germany_VK3001P:			{ level: 6,  type: MT, tiers: [ 6, 8 ] },
    germany_VK3601H:			{ level: 6,  type: MT, tiers: [ 6, 8 ] },
    france_ARL_44:			{ level: 6,  type: HT, tiers: [ 6, 8 ] },
    ussr_KV2:				{ level: 6,  type: HT, tiers: [ 6, 8 ] },
    ussr_KV_1s:				{ level: 6,  type: HT, tiers: [ 6, 8 ] },
    usa_M6:				{ level: 6,  type: HT, tiers: [ 6, 8 ] },
    ussr_T150:				{ level: 6,  type: HT, tiers: [ 6, 8 ] },
    germany_G_Panther:			{ level: 6,  type: SP, tiers: [ 9, 10 ] },
    usa_M12:				{ level: 6,  type: SP, tiers: [ 9, 10 ] },
    ussr_SU_14:				{ level: 6,  type: SP, tiers: [ 9, 10 ] },
    ussr_S_51:				{ level: 6,  type: SP, tiers: [ 9, 10 ] },
    france_Lorraine155_50:      	{ level: 6,  type: SP, tiers: [ 9, 10 ] },
    germany_JagdPzIV:			{ level: 6,  type: TD, tiers: [ 6, 8 ] },
    usa_M18_Hellcat:			{ level: 6,  type: TD, tiers: [ 6, 8 ] },
    usa_M36_Slagger:			{ level: 6,  type: TD, tiers: [ 6, 8 ] },
    ussr_SU_100:			{ level: 6,  type: TD, tiers: [ 6, 8 ] },
    france_ARL_V39:             	{ level: 6,  type: TD, tiers: [ 6, 8 ] },
    germany_DickerMax:                  { level: 6,  type: TD, tiers: [ 6, 8 ] },

    // level 7
    france_AMX_13_75:			{ level: 7,  type: LT, tiers: [ 8, 11 ] },
    ussr_KV_13:				{ level: 7,  type: MT, tiers: [ 7, 9 ] },
    germany_PzV:			{ level: 7,  type: MT, tiers: [ 7, 9 ] },
    usa_T20:				{ level: 7,  type: MT, tiers: [ 7, 9 ] },
    ussr_T_43:				{ level: 7,  type: MT, tiers: [ 7, 9 ] },
    germany_VK3002DB:			{ level: 7,  type: MT, tiers: [ 7, 9 ] },
    france_AMX_M4_1945:			{ level: 7,  type: HT, tiers: [ 7, 9 ] },
    ussr_IS:				{ level: 7,  type: HT, tiers: [ 7, 9 ] },
    ussr_KV_3:				{ level: 7,  type: HT, tiers: [ 7, 9 ] },
    germany_PzVI:			{ level: 7,  type: HT, tiers: [ 7, 9 ] },
    germany_PzVI_Tiger_P:		{ level: 7,  type: HT, tiers: [ 7, 9 ] },
    usa_T29:				{ level: 7,  type: HT, tiers: [ 7, 9 ] },
    germany_G_Tiger:			{ level: 7,  type: SP, tiers: [ 10, 12 ] },
    usa_M40M43:				{ level: 7,  type: SP, tiers: [ 10, 12 ] },
    ussr_Object_212:			{ level: 7,  type: SP, tiers: [ 10, 12 ] },
    france_Lorraine155_51:      	{ level: 7,  type: SP, tiers: [ 10, 12 ] },
    germany_JagdPanther:		{ level: 7,  type: TD, tiers: [ 7, 9 ] },
    ussr_SU_152:			{ level: 7,  type: TD, tiers: [ 7, 9 ] },
    usa_T25_2:				{ level: 7,  type: TD, tiers: [ 7, 9 ] },
    usa_T25_AT:				{ level: 7,  type: TD, tiers: [ 7, 9 ] },
    france_AMX_AC_Mle1946:      	{ level: 7,  type: TD, tiers: [ 7, 9 ] },

    // level 8
    france_AMX_13_90:			{ level: 8,  type: LT, tiers: [ 9, 12 ] },
    germany_Panther_II:			{ level: 8,  type: MT, tiers: [ 8, 10 ] },
    usa_Pershing:			{ level: 8,  type: MT, tiers: [ 8, 10 ] },
    ussr_T_44:				{ level: 8,  type: MT, tiers: [ 8, 10 ] },
    france_AMX_50_100:			{ level: 8,  type: HT, tiers: [ 8, 10 ] },
    china_Ch03_WZ_111:			{ level: 8,  type: HT, tiers: [ 8, 10 ] },
    ussr_IS_3:				{ level: 8,  type: HT, tiers: [ 8, 10 ] },
    ussr_KV4:				{ level: 8,  type: HT, tiers: [ 8, 10 ] },
    germany_PzVIB_Tiger_II:		{ level: 8,  type: HT, tiers: [ 8, 10 ] },
    germany_Lowe:			{ level: 8,  type: HT, tiers: [ 8, 10 ] },
    usa_M6A2E1:				{ level: 8,  type: HT, tiers: [ 8, 10 ] },
    usa_T32:				{ level: 8,  type: HT, tiers: [ 8, 10 ] },
    usa_T34_hvy:			{ level: 8,  type: HT, tiers: [ 8, 10 ] },
    germany_VK4502A:			{ level: 8,  type: HT, tiers: [ 8, 10 ] },
    germany_G_E:			{ level: 8,  type: SP, tiers: [ 11, 12 ] },
    ussr_Object_261:			{ level: 8,  type: SP, tiers: [ 11, 12 ] },
    usa_T92:				{ level: 8,  type: SP, tiers: [ 11, 12 ] },
    france_Bat_Chatillon155:    	{ level: 8,  type: SP, tiers: [ 11, 12 ] },
    germany_Ferdinand:			{ level: 8,  type: TD, tiers: [ 8, 10 ] },
    germany_JagdPantherII:		{ level: 8,  type: TD, tiers: [ 8, 10 ] },
    ussr_ISU_152:			{ level: 8,  type: TD, tiers: [ 8, 10 ] },
    usa_T28:				{ level: 8,  type: TD, tiers: [ 8, 10 ] },
    usa_T28_Prototype:			{ level: 8,  type: TD, tiers: [ 8, 10 ] },
    france_AMX_AC_Mle1948:      	{ level: 8,  type: TD, tiers: [ 8, 10 ] },

    // level 9
    france_Lorraine40t:			{ level: 9,  type: MT, tiers: [ 9, 11 ] },
    germany_E_50:			{ level: 9,  type: MT, tiers: [ 9, 11 ] },
    usa_M46_Patton:			{ level: 9,  type: MT, tiers: [ 9, 11 ] },
    ussr_T_54:				{ level: 9,  type: MT, tiers: [ 9, 11 ] },
    france_AMX_50_120:			{ level: 9,  type: HT, tiers: [ 9, 11 ] },
    germany_E_75:			{ level: 9,  type: HT, tiers: [ 9, 11 ] },
    ussr_IS8:				{ level: 9,  type: HT, tiers: [ 9, 11 ] },
    usa_M103:				{ level: 9,  type: HT, tiers: [ 9, 11 ] },
    ussr_ST_I:				{ level: 9,  type: HT, tiers: [ 9, 11 ] },
    germany_VK4502P:			{ level: 9,  type: HT, tiers: [ 9, 11 ] },
    germany_JagdTiger:			{ level: 9,  type: TD, tiers: [ 9, 11 ] },
    ussr_Object_704:			{ level: 9,  type: TD, tiers: [ 9, 11 ] },
    usa_T30:				{ level: 9,  type: TD, tiers: [ 9, 11 ] },
    usa_T95:				{ level: 9,  type: TD, tiers: [ 9, 11 ] },
    france_AMX50_Foch:          	{ level: 9,  type: TD, tiers: [ 9, 11 ] },

    // level 10
    france_Bat_Chatillon25t:		{ level: 10, type: MT, tiers: [ 10, 12 ] },
    germany_E50_Ausf_M:			{ level: 10, type: MT, tiers: [ 10, 12 ] },
    usa_M48A1:				{ level: 10, type: MT, tiers: [ 10, 12 ] },
    ussr_T62A:				{ level: 10, type: MT, tiers: [ 10, 12 ] },
    germany_E_100:			{ level: 10, type: HT, tiers: [ 10, 12 ] },
    france_F10_AMX_50B:			{ level: 10, type: HT, tiers: [ 10, 12 ] },
    ussr_IS_4:				{ level: 10, type: HT, tiers: [ 10, 12 ] },
    ussr_IS_7:				{ level: 10, type: HT, tiers: [ 10, 12 ] },
    germany_Maus:			{ level: 10, type: HT, tiers: [ 10, 12 ] },
    usa_T110:				{ level: 10, type: HT, tiers: [ 10, 12 ] },
    france_AMX_50Fosh_155:		{ level: 10, type: TD, tiers: [ 10, 12 ] },
    germany_JagdPz_E100:		{ level: 10, type: TD, tiers: [ 10, 12 ] },
    usa_T110E3:				{ level: 10, type: TD, tiers: [ 10, 12 ] },
    usa_T110E4:				{ level: 10, type: TD, tiers: [ 10, 12 ] },
    ussr_Object268:			{ level: 10, type: TD, tiers: [ 10, 12 ] },

    // non-standard
    germany_Bison_I:			{ level: 2,  type: SP, tiers: [ 3, 5 ] },
    usa_T2_lt:				{ level: 2,  type: LT, tiers: [ 2, 4 ] },
    ussr_M3_Stuart_LL:			{ level: 3,  type: LT, tiers: [ 3, 4 ] },
    ussr_BT_SV:				{ level: 3,  type: LT, tiers: [ 3, 4 ] },
    germany_PzII_J:			{ level: 3,  type: LT, tiers: [ 3, 4 ] },
    ussr_T_50:				{ level: 4,  type: LT, tiers: [ 5, 9 ] },
    germany_VK1602:			{ level: 4,  type: LT, tiers: [ 5, 9 ] },
    ussr_Valentine_LL:			{ level: 4,  type: LT, tiers: [ 4, 4 ] },
    germany_B_1bis_captured:		{ level: 4,  type: HT, tiers: [ 4, 4 ] },
    ussr_A_32:				{ level: 4,  type: MT, tiers: [ 4, 5 ] },
    france_AMX40:			{ level: 4,  type: LT, tiers: [ 4, 6 ] },
    france_ELC_AMX:			{ level: 5,  type: LT, tiers: [ 6, 9 ] },
    germany_PzIV_Hydro:			{ level: 5,  type: MT, tiers: [ 5, 6 ] },
    ussr_Churchill_LL:			{ level: 5,  type: HT, tiers: [ 5, 6 ] },
    ussr_Matilda_II_LL:			{ level: 5,  type: MT, tiers: [ 5, 6 ] },
    usa_T14:				{ level: 5,  type: HT, tiers: [ 5, 6 ] },
    ussr_KV_220:			{ level: 5,  type: HT, tiers: [ 5, 6 ] },
    usa_M4A2E4:				{ level: 5,  type: MT, tiers: [ 5, 6 ] },
    germany_PzV_PzIV_ausf_Alfa:		{ level: 6,  type: MT, tiers: [ 6, 7 ] },
    germany_PzV_PzIV:			{ level: 6,  type: MT, tiers: [ 6, 7 ] },
    china_Ch02_Type62:			{ level: 6,  type: LT, tiers: [ 7, 10 ] },
    ussr_KV_5:				{ level: 8,  type: HT, tiers: [ 8, 9 ] },
    ussr_Object252:			{ level: 8,  type: HT, tiers: [ 8, 9 ] },
    usa_T26_E4_SuperPershing:           { level: 8,  type: MT, tiers: [ 8, 9 ] },
    china_Ch01_Type59:			{ level: 8,  type: MT, tiers: [ 8, 9 ] },
    germany_JagdTiger_SdKfz_185:	{ level: 8,  type: TD, tiers: [ 8, 9 ] }
  }
}
