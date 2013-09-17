/**
 * XVM
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm.vehinfo
{
    import flash.utils.Dictionary;

    public class VehicleInfoData
    {
        private static var _data:Dictionary = null;

        public static function get data():Dictionary
        {
            if (_data == null)
                _data = _initData();
            return _data;
        }

        private static function _initData():Dictionary
        {
            var d:Dictionary = new Dictionary();

            // level 1
            d["ussr_MS_1"] =                         { tiers: [ 1, 2 ], name: null, short: "MS" };
            d["germany_Ltraktor"] =                  { tiers: [ 1, 2 ], name: null, short: "Ltrak" };
            d["usa_T1_Cunningham"] =                 { tiers: [ 1, 2 ], name: null, short: "Cunn" };
            d["china_Ch06_Renault_NC31"] =           { tiers: [ 1, 2 ], name: null, short: "31" };
            d["france_RenaultFT"] =                  { tiers: [ 1, 2 ], name: null, short: "FT" };
            d["uk_GB01_Medium_Mark_I"] =             { tiers: [ 1, 2 ], name: null, short: "Mk1" };

            // level 2
            d["ussr_BT_2"] =                         { tiers: [ 2, 3 ], name: null, short: "BT2" };
            d["ussr_T_26"] =                         { tiers: [ 2, 3 ], name: null, short: "T26" };
            d["ussr_T_60"] =                         { tiers: [ 2, 3 ], name: null, short: "T60" };
            d["ussr_Tetrarch_LL"] =                  { tiers: [ 2, 3 ], name: null, short: "Tetr" };
            d["germany_H39_captured"] =              { tiers: [ 2, 3 ], name: null, short: "H39" };
            d["germany_Pz35t"] =                     { tiers: [ 2, 3 ], name: null, short: "Pz35" };
            d["germany_PzII"] =                      { tiers: [ 2, 3 ], name: null, short: "Pz2" };
            d["usa_M2_lt"] =                         { tiers: [ 2, 3 ], name: null, short: "M2LT" };
            d["usa_T1_E6"] =                         { tiers: [ 2, 3 ], name: null, short: "T1E6" };
            d["china_Ch07_Vickers_MkE_Type_BT26"] =  { tiers: [ 2, 3 ], name: null, short: "BT26" };
            d["france_D1"] =                         { tiers: [ 2, 3 ], name: null, short: "D1" };
            d["france_Hotchkiss_H35"] =              { tiers: [ 2, 3 ], name: null, short: "H35" };
            d["uk_GB03_Cruiser_Mk_I"] =              { tiers: [ 2, 3 ], name: null, short: "Cru1" };
            d["uk_GB58_Cruiser_Mk_III"] =            { tiers: [ 2, 3 ], name: null, short: "Crui3" };
            d["usa_T2_med"] =                        { tiers: [ 2, 3 ], name: null, short: "T2MT" };
            d["uk_GB05_Vickers_Medium_Mk_II"] =      { tiers: [ 2, 3 ], name: null, short: "Mk2" };
            d["ussr_AT_1"] =                         { tiers: [ 2, 3 ], name: null, short: "AT-1" };
            d["germany_PanzerJager_I"] =             { tiers: [ 2, 3 ], name: null, short: "PzJg" };
            d["usa_T18"] =                           { tiers: [ 2, 3 ], name: null, short: "T18" };
            d["france_RenaultFT_AC"] =               { tiers: [ 2, 3 ], name: null, short: "FTAC" };
            d["uk_GB39_Universal_CarrierQF2"] =      { tiers: [ 2, 3 ], name: null, short: "QF2" };
            d["ussr_SU_18"] =                        { tiers: [ 2, 3 ], name: null, short: "Su18" };
            d["germany_GW_Mk_VIe"] =                 { tiers: [ 2, 3 ], name: null, short: "Gw6e" };
            d["usa_T57"] =                           { tiers: [ 2, 3 ], name: null, short: "T57" };
            d["france_RenaultBS"] =                  { tiers: [ 2, 3 ], name: null, short: "BS" };
            d["uk_GB25_Loyd_Carrier"] =              { tiers: [ 2, 3 ], name: null, short: "2pdr" };

            // level 3
            d["ussr_BT_7"] =                         { tiers: [ 3, 5 ], name: null, short: "BT7" };
            d["ussr_LTP"] =                          { tiers: [ 3, 5 ], name: null, short: "LTP" };
            d["ussr_T_46"] =                         { tiers: [ 3, 5 ], name: null, short: "T46" };
            d["ussr_T_70"] =                         { tiers: [ 3, 5 ], name: null, short: "T70" };
            d["germany_Pz_II_AusfG"] =               { tiers: [ 3, 5 ], name: null, short: "Pz2G" };
            d["germany_Pz38t"] =                     { tiers: [ 3, 5 ], name: null, short: "Pz38t" };
            d["germany_PzI_ausf_C"] =                { tiers: [ 3, 5 ], name: null, short: "Pz2C" };
            d["germany_PzIII_A"] =                   { tiers: [ 3, 5 ], name: null, short: "Pz3A" };
            d["germany_T_15"] =                      { tiers: [ 3, 5 ], name: null, short: "T-15" };
            d["usa_M22_Locust"] =                    { tiers: [ 3, 5 ], name: null, short: "Locus" };
            d["usa_M3_Stuart"] =                     { tiers: [ 3, 5 ], name: null, short: "M3Stu" };
            d["usa_MTLS_1G14"] =                     { tiers: [ 3, 5 ], name: null, short: "MTLS" };
            d["china_Ch08_Type97_Chi_Ha"] =          { tiers: [ 3, 5 ], name: null, short: "97" };
            d["france_AMX38"] =                      { tiers: [ 3, 5 ], name: null, short: "AMX38" };
            d["uk_GB59_Cruiser_Mk_IV"] =             { tiers: [ 3, 5 ], name: null, short: "Crui4" };
            d["uk_GB69_Cruiser_Mk_II"] =             { tiers: [ 3, 5 ], name: null, short: "Crui2" };
            d["germany_S35_captured"] =              { tiers: [ 3, 5 ], name: null, short: "S35" };
            d["usa_M2_med"] =                        { tiers: [ 3, 5 ], name: null, short: "M2MT" };
            d["france_D2"] =                         { tiers: [ 3, 5 ], name: null, short: "D2" };
            d["uk_GB06_Vickers_Medium_Mk_III"] =     { tiers: [ 3, 5 ], name: null, short: "Mk3" };
            d["ussr_SU_76"] =                        { tiers: [ 3, 5 ], name: null, short: "Su76" };
            d["germany_G20_Marder_II"] =             { tiers: [ 3, 5 ], name: null, short: "Mard" };
            d["usa_T82"] =                           { tiers: [ 3, 5 ], name: null, short: "T82" };
            d["france_FCM_36Pak40"] =                { tiers: [ 3, 5 ], name: null, short: "Fcm36" };
            d["france_RenaultUE57"] =                { tiers: [ 3, 5 ], name: null, short: "UE57" };
            d["uk_GB42_Valentine_AT"] =              { tiers: [ 3, 5 ], name: null, short: "ValAT" };
            d["ussr_SU_26"] =                        { tiers: [ 3, 5 ], name: null, short: "Su26" };
            d["germany_Bison_I"] =                   { tiers: [ 3, 5 ], name: null, short: "Bison" };
            d["germany_Wespe"] =                     { tiers: [ 3, 5 ], name: null, short: "Wespe" };
            d["usa_M7_Priest"] =                     { tiers: [ 3, 5 ], name: null, short: "Pries" };
            d["usa_Sexton_I"] =                      { tiers: [ 3, 5 ], name: null, short: "Sext1usa" };
            d["france_Lorraine39_L_AM"] =            { tiers: [ 3, 5 ], name: null, short: "Lor39" };
            d["uk_GB27_Sexton"] =                    { tiers: [ 3, 5 ], name: null, short: "Sext" };
            d["uk_GB78_Sexton_I"] =                  { tiers: [ 3, 5 ], name: null, short: "Sext1" };

            // level 4
            d["ussr_A_20"] =                         { tiers: [ 4, 8 ], name: null, short: "A20" };
            d["ussr_T_50"] =                         { tiers: [ 4, 8 ], name: null, short: "T50" };
            d["germany_Pz38_NA"] =                   { tiers: [ 4, 8 ], name: null, short: "Pz38" };
            d["germany_PzII_Luchs"] =                { tiers: [ 4, 8 ], name: null, short: "Luchs" };
            d["usa_M5_Stuart"] =                     { tiers: [ 4, 8 ], name: null, short: "M5Stu" };
            d["china_Ch09_M5"] =                     { tiers: [ 4, 8 ], name: null, short: "M5" };
            d["ussr_T_28"] =                         { tiers: [ 4, 6 ], name: null, short: "T-28" };
            d["germany_PzIII"] =                     { tiers: [ 4, 6 ], name: null, short: "Pz3" };
            d["germany_PzIII_training"] =            { tiers: [ 4, 6 ], name: null, short: "Pz3" };
            d["germany_VK2001DB"] =                  { tiers: [ 4, 6 ], name: null, short: "2001" };
            d["usa_M3_Grant"] =                      { tiers: [ 4, 6 ], name: null, short: "M3Lee" };
            d["uk_GB07_Matilda"] =                   { tiers: [ 4, 6 ], name: null, short: "Matil" };
            d["germany_DW_II"] =                     { tiers: [ 4, 5 ], name: null, short: "DWII" };
            d["france_B1"] =                         { tiers: [ 4, 5 ], name: null, short: "B1" };
            d["ussr_GAZ_74b"] =                      { tiers: [ 4, 6 ], name: null, short: "Su85b" };
            d["germany_Hetzer"] =                    { tiers: [ 4, 6 ], name: null, short: "Hetz" };
            d["usa_M8A1"] =                          { tiers: [ 4, 6 ], name: null, short: "M8A1" };
            d["usa_T40"] =                           { tiers: [ 4, 6 ], name: null, short: "T40" };
            d["france_Somua_Sau_40"] =               { tiers: [ 4, 6 ], name: null, short: "Somua" };
            d["uk_GB57_Alecto"] =                    { tiers: [ 4, 6 ], name: null, short: "Alect" };
            d["ussr_SU_5"] =                         { tiers: [ 4, 6 ], name: null, short: "Su5" };
            d["germany_Pz_Sfl_IVb"] =                { tiers: [ 4, 6 ], name: null, short: "PzS4b" };
            d["germany_Sturmpanzer_II"] =            { tiers: [ 4, 6 ], name: null, short: "StPz2" };
            d["usa_M37"] =                           { tiers: [ 4, 6 ], name: null, short: "M37" };
            d["france_AMX_Ob_Am105"] =               { tiers: [ 4, 6 ], name: null, short: "Am105" };
            d["uk_GB26_Birch_Gun"] =                 { tiers: [ 4, 6 ], name: null, short: "Birch" };

            // level 5
            d["ussr_T_50_2"] =                       { tiers: [ 6, 9 ], name: null, short: "502" };
            d["germany_VK1602"] =                    { tiers: [ 6, 9 ], name: null, short: "1602" };
            d["france_ELC_AMX"] =                    { tiers: [ 6, 9 ], name: null, short: "ELC" };
            d["ussr_T_34"] =                         { tiers: [ 5, 7 ], name: null, short: "34" };
            d["germany_PzIII_IV"] =                  { tiers: [ 5, 7 ], name: null, short: "Pz3/4" };
            d["germany_PzIV"] =                      { tiers: [ 5, 7 ], name: null, short: "Pz4" };
            d["germany_T_25"] =                      { tiers: [ 5, 7 ], name: null, short: "T-25" };
            d["usa_M4_Sherman"] =                    { tiers: [ 5, 7 ], name: null, short: "Sherm" };
            d["usa_M7_med"] =                        { tiers: [ 5, 7 ], name: null, short: "M7" };
            d["usa_Ram_II"] =                        { tiers: [ 5, 7 ], name: null, short: "Ram2" };
            d["china_Ch21_T34"] =                    { tiers: [ 5, 7 ], name: null, short: "t-34" };
            d["ussr_KV"] =                           { tiers: [ 5, 7 ], name: null, short: "KV" };
            d["ussr_KV1"] =                          { tiers: [ 5, 7 ], name: null, short: "KV1" };
            d["germany_VK3001H"] =                   { tiers: [ 5, 7 ], name: null, short: "3001H" };
            d["usa_T1_hvy"] =                        { tiers: [ 5, 7 ], name: null, short: "T1Hv" };
            d["france_BDR_G1B"] =                    { tiers: [ 5, 7 ], name: null, short: "BDR" };
            d["uk_GB08_Churchill_I"] =               { tiers: [ 5, 7 ], name: null, short: "Chur1" };
            d["ussr_SU_85"] =                        { tiers: [ 5, 7 ], name: null, short: "Su85" };
            d["germany_StuGIII"] =                   { tiers: [ 5, 7 ], name: null, short: "StuG" };
            d["usa_M10_Wolverine"] =                 { tiers: [ 5, 7 ], name: null, short: "Wolv" };
            d["usa_T49"] =                           { tiers: [ 5, 7 ], name: null, short: "T49" };
            d["france_S_35CA"] =                     { tiers: [ 5, 7 ], name: null, short: "S35" };
            d["uk_GB73_AT2"] =                       { tiers: [ 5, 7 ], name: null, short: "AT2" };
            d["ussr_SU122A"] =                       { tiers: [ 5, 7 ], name: null, short: "122A" };
            d["germany_Grille"] =                    { tiers: [ 5, 7 ], name: null, short: "Grill" };
            d["usa_M41"] =                           { tiers: [ 5, 7 ], name: null, short: "M41" };
            d["france__105_leFH18B2"] =              { tiers: [ 5, 7 ], name: null, short: "leFH" };
            d["france_AMX_105AM"] =                  { tiers: [ 5, 7 ], name: null, short: "105AM" };
            d["uk_GB28_Bishop"] =                    { tiers: [ 5, 7 ], name: null, short: "Bishp" };

            // level 6
            d["ussr_MT25"] =                         { tiers: [ 7, 10 ], name: null, short: "MT25" };
            d["germany_VK2801"] =                    { tiers: [ 7, 10 ], name: null, short: "2801" };
            d["usa_T21"] =                           { tiers: [ 7, 10 ], name: null, short: "T21" };
            d["china_Ch15_59_16"] =                  { tiers: [ 7, 10 ], name: null, short: "59-16" };
            d["china_Ch24_Type64"] =                 { tiers: [ 7, 10 ], name: null, short: "t-64" };
            d["france_AMX_12t"] =                    { tiers: [ 7, 10 ], name: null, short: "12t" };
            d["ussr_T_34_85"] =                      { tiers: [ 6, 8 ], name: null, short: "3485" };
            d["ussr_A43"] =                          { tiers: [ 6, 8 ], name: null, short: "A43" };
            d["ussr_T_34_85_training"] =             { tiers: [ 6, 8 ], name: null, short: "3485" };
            d["germany_PzIV_schmalturm"] =           { tiers: [ 6, 8 ], name: null, short: "Pz4S" };
            d["germany_VK3001P"] =                   { tiers: [ 6, 8 ], name: null, short: "3001P" };
            d["germany_VK3002DB_V1"] =               { tiers: [ 6, 8 ], name: null, short: "3002DB" };
            d["germany_VK3002M"] =                   { tiers: [ 6, 8 ], name: null, short: "3002M" };
            d["usa_M4A3E8_Sherman"] =                { tiers: [ 6, 8 ], name: null, short: "SheE8" };
            d["usa_M4A3E8_Sherman_training"] =       { tiers: [ 6, 8 ], name: null, short: "SheE8" };
            d["usa_Sherman_Jumbo"] =                 { tiers: [ 6, 8 ], name: null, short: "SheJm" };
            d["china_Ch20_Type58"] =                 { tiers: [ 6, 8 ], name: null, short: "58" };
            d["uk_GB21_Cromwell"] =                  { tiers: [ 6, 8 ], name: null, short: "Cromw" };
            d["ussr_KV_1s"] =                        { tiers: [ 6, 8 ], name: null, short: "KV1S" };
            d["ussr_KV2"] =                          { tiers: [ 6, 8 ], name: null, short: "KV2" };
            d["ussr_T150"] =                         { tiers: [ 6, 8 ], name: null, short: "T150" };
            d["germany_VK3601H"] =                   { tiers: [ 6, 8 ], name: null, short: "3601" };
            d["usa_M6"] =                            { tiers: [ 6, 8 ], name: null, short: "M6" };
            d["france_ARL_44"] =                     { tiers: [ 6, 8 ], name: null, short: "ARL" };
            d["uk_GB09_Churchill_VII"] =             { tiers: [ 6, 8 ], name: null, short: "Chur7" };
            d["ussr_SU_100"] =                       { tiers: [ 6, 8 ], name: null, short: "Su100" };
            d["ussr_SU100Y"] =                       { tiers: [ 6, 8 ], name: null, short: "100Y" };
            d["germany_DickerMax"] =                 { tiers: [ 6, 8 ], name: null, short: "DMax" };
            d["germany_JagdPzIV"] =                  { tiers: [ 6, 8 ], name: null, short: "JPz" };
            d["usa_M18_Hellcat"] =                   { tiers: [ 6, 8 ], name: null, short: "Hellc" };
            d["usa_M36_Slagger"] =                   { tiers: [ 6, 8 ], name: null, short: "Jacks" };
            d["france_ARL_V39"] =                    { tiers: [ 6, 8 ], name: null, short: "V39" };
            d["uk_GB40_Gun_Carrier_Churchill"] =     { tiers: [ 6, 8 ], name: null, short: "GChur" };
            d["uk_GB74_AT8"] =                       { tiers: [ 6, 8 ], name: null, short: "AT8" };
            d["ussr_SU_8"] =                         { tiers: [ 6, 8 ], name: null, short: "Su8" };
            d["germany_Hummel"] =                    { tiers: [ 6, 8 ], name: null, short: "Humm" };
            d["usa_M44"] =                           { tiers: [ 6, 8 ], name: null, short: "M44" };
            d["france_AMX_13F3AM"] =                 { tiers: [ 6, 8 ], name: null, short: "13F3" };
            d["uk_GB77_FV304"] =                     { tiers: [ 6, 8 ], name: null, short: "FV304" };

            // level 7
            d["germany_Auf_Panther"] =               { tiers: [ 8, 11 ], name: null, short: "APant" };
            d["usa_T71"] =                           { tiers: [ 8, 11 ], name: null, short: "71" };
            d["china_Ch02_Type62"] =                 { tiers: [ 8, 11 ], name: null, short: "62" };
            d["china_Ch16_WZ_131"] =                 { tiers: [ 8, 11 ], name: null, short: "131" };
            d["france_AMX_13_75"] =                  { tiers: [ 8, 11 ], name: null, short: "1375" };
            d["ussr_A44"] =                          { tiers: [ 7, 9 ], name: null, short: "A44" };
            d["ussr_KV_13"] =                        { tiers: [ 7, 9 ], name: null, short: "KV13" };
            d["ussr_T_43"] =                         { tiers: [ 7, 9 ], name: null, short: "43" };
            d["germany_PzV"] =                       { tiers: [ 7, 9 ], name: null, short: "Pant" };
            d["germany_PzV_training"] =              { tiers: [ 7, 9 ], name: null, short: "Pant" };
            d["germany_VK3002DB"] =                  { tiers: [ 7, 9 ], name: null, short: "3002D" };
            d["usa_T20"] =                           { tiers: [ 7, 9 ], name: null, short: "T20" };
            d["china_Ch04_T34_1"] =                  { tiers: [ 7, 9 ], name: null, short: "34/1" };
            d["china_Ch04_T34_1_training"] =         { tiers: [ 7, 9 ], name: null, short: "34/1" };
            d["uk_GB22_Comet"] =                     { tiers: [ 7, 9 ], name: null, short: "Comet" };
            d["ussr_IS"] =                           { tiers: [ 7, 9 ], name: null, short: "IS" };
            d["ussr_KV_3"] =                         { tiers: [ 7, 9 ], name: null, short: "KV3" };
            d["germany_PzVI"] =                      { tiers: [ 7, 9 ], name: null, short: "Tger" };
            d["germany_PzVI_Tiger_P"] =              { tiers: [ 7, 9 ], name: null, short: "TgerP" };
            d["usa_T29"] =                           { tiers: [ 7, 9 ], name: null, short: "T29" };
            d["china_Ch10_IS2"] =                    { tiers: [ 7, 9 ], name: null, short: "IS2" };
            d["france_AMX_M4_1945"] =                { tiers: [ 7, 9 ], name: null, short: "AMX1945" };
            d["uk_GB10_Black_Prince"] =              { tiers: [ 7, 9 ], name: null, short: "Princ" };
            d["ussr_SU100M1"] =                      { tiers: [ 7, 9 ], name: null, short: "100M1" };
            d["ussr_SU122_44"] =                     { tiers: [ 7, 9 ], name: null, short: "12244" };
            d["ussr_SU_152"] =                       { tiers: [ 7, 9 ], name: null, short: "152" };
            d["germany_JagdPanther"] =               { tiers: [ 7, 9 ], name: null, short: "JagP" };
            d["usa_T25_2"] =                         { tiers: [ 7, 9 ], name: null, short: "25/2" };
            d["usa_T25_AT"] =                        { tiers: [ 7, 9 ], name: null, short: "25AT" };
            d["france_AMX_AC_Mle1946"] =             { tiers: [ 7, 9 ], name: null, short: "Mle46" };
            d["uk_GB71_AT_15A"] =                    { tiers: [ 7, 9 ], name: null, short: "AT15A" };
            d["uk_GB75_AT7"] =                       { tiers: [ 7, 9 ], name: null, short: "AT7" };
            d["ussr_S_51"] =                         { tiers: [ 7, 9 ], name: null, short: "S51" };
            d["ussr_SU14_1"] =                       { tiers: [ 7, 9 ], name: null, short: "Su141" };
            d["germany_G_Panther"] =                 { tiers: [ 7, 9 ], name: null, short: "GwP" };
            d["usa_M12"] =                           { tiers: [ 7, 9 ], name: null, short: "M12" };
            d["france_Lorraine155_50"] =             { tiers: [ 7, 9 ], name: null, short: "15550" };
            d["uk_GB29_Crusader_5inch"] =            { tiers: [ 7, 9 ], name: null, short: "Crus5" };

            // level 8
            d["china_Ch17_WZ131_1_WZ132"] =          { tiers: [ 9, 12 ], name: null, short: "132" };
            d["france_AMX_13_90"] =                  { tiers: [ 9, 12 ], name: null, short: "1390" };
            d["ussr_Object416"] =                    { tiers: [ 8, 10 ], name: null, short: "o416" };
            d["ussr_T_44"] =                         { tiers: [ 8, 10 ], name: null, short: "44" };
            d["germany_Indien_Panzer"] =             { tiers: [ 8, 10 ], name: null, short: "IndPz" };
            d["germany_Panther_II"] =                { tiers: [ 8, 10 ], name: null, short: "Pant2" };
            d["usa_Pershing"] =                      { tiers: [ 8, 10 ], name: null, short: "Persh" };
            d["usa_T23"] =                           { tiers: [ 8, 10 ], name: null, short: "T23" };
            d["usa_T69"] =                           { tiers: [ 8, 10 ], name: null, short: "69" };
            d["china_Ch05_T34_2"] =                  { tiers: [ 8, 10 ], name: null, short: "34/2" };
            d["uk_GB23_Centurion"] =                 { tiers: [ 8, 10 ], name: null, short: "Cent" };
            d["ussr_IS_3"] =                         { tiers: [ 8, 10 ], name: null, short: "3" };
            d["ussr_KV4"] =                          { tiers: [ 8, 10 ], name: null, short: "KV4" };
            d["germany_Lowe"] =                      { tiers: [ 8, 10 ], name: null, short: "Lowe" };
            d["germany_PzVIB_Tiger_II"] =            { tiers: [ 8, 10 ], name: null, short: "Tger2" };
            d["germany_PzVIB_Tiger_II_training"] =   { tiers: [ 8, 10 ], name: null, short: "Tger2" };
            d["germany_VK4502A"] =                   { tiers: [ 8, 10 ], name: null, short: "4502A" };
            d["usa_M6A2E1"] =                        { tiers: [ 8, 10 ], name: null, short: "M6A2E" };
            d["usa_T32"] =                           { tiers: [ 8, 10 ], name: null, short: "T32" };
            d["usa_T34_hvy"] =                       { tiers: [ 8, 10 ], name: null, short: "T34Hv" };
            d["china_Ch03_WZ_111"] =                 { tiers: [ 8, 10 ], name: null, short: "111" };
            d["china_Ch11_110"] =                    { tiers: [ 8, 10 ], name: null, short: "110" };
            d["france_AMX_50_100"] =                 { tiers: [ 8, 10 ], name: null, short: "50100" };
            d["uk_GB11_Caernarvon"] =                { tiers: [ 8, 10 ], name: null, short: "Caern" };
            d["ussr_ISU_152"] =                      { tiers: [ 8, 10 ], name: null, short: "152" };
            d["ussr_SU_101"] =                       { tiers: [ 8, 10 ], name: null, short: "Su101" };
            d["germany_Ferdinand"] =                 { tiers: [ 8, 10 ], name: null, short: "Ferd" };
            d["germany_JagdPantherII"] =             { tiers: [ 8, 10 ], name: null, short: "JagP2" };
            d["usa_T28"] =                           { tiers: [ 8, 10 ], name: null, short: "T28" };
            d["usa_T28_Prototype"] =                 { tiers: [ 8, 10 ], name: null, short: "T28Pr" };
            d["france_AMX_AC_Mle1948"] =             { tiers: [ 8, 10 ], name: null, short: "Mle48" };
            d["uk_GB72_AT15"] =                      { tiers: [ 8, 10 ], name: null, short: "AT15" };
            d["ussr_SU_14"] =                        { tiers: [ 8, 10 ], name: null, short: "Su142" };
            d["germany_GW_Tiger_P"] =                { tiers: [ 8, 10 ], name: null, short: "GwTP" };
            d["usa_M40M43"] =                        { tiers: [ 8, 10 ], name: null, short: "4043" };
            d["france_Lorraine155_51"] =             { tiers: [ 8, 10 ], name: null, short: "15551" };
            d["uk_GB79_FV206"] =                     { tiers: [ 8, 10 ], name: null, short: "FV206" };

            // level 9
            d["ussr_T_54"] =                         { tiers: [ 9, 11 ], name: null, short: "54"  };
            d["germany_E_50"] =                      { tiers: [ 9, 11 ], name: null, short: "50"  };
            d["germany_Pro_Ag_A"] =                  { tiers: [ 9, 11 ], name: null, short: "LeoPr" };
            d["usa_M46_Patton"] =                    { tiers: [ 9, 11 ], name: null, short: "Patt"  };
            d["usa_T54E1"] =                         { tiers: [ 9, 11 ], name: null, short: "54E1"  };
            d["china_Ch18_WZ_120"] =                 { tiers: [ 9, 11 ], name: null, short: "120" };
            d["france_Lorraine40t"] =                { tiers: [ 9, 11 ], name: null, short: "Lor40" };
            d["uk_GB24_Centurion_Mk3"] =             { tiers: [ 9, 11 ], name: null, short: "Cent3" };
            d["ussr_IS8"] =                          { tiers: [ 9, 11 ], name: null, short: "8"  };
            d["ussr_ST_I"] =                         { tiers: [ 9, 11 ], name: null, short: "ST1"  };
            d["germany_E_75"] =                      { tiers: [ 9, 11 ], name: null, short: "75"  };
            d["germany_VK4502P"] =                   { tiers: [ 9, 11 ], name: null, short: "4502P" };
            d["usa_M103"] =                          { tiers: [ 9, 11 ], name: null, short: "103"  };
            d["china_Ch12_111_1_2_3"] =              { tiers: [ 9, 11 ], name: null, short: "111/1" };
            d["france_AMX_50_120"] =                 { tiers: [ 9, 11 ], name: null, short: "50120"  };
            d["uk_GB12_Conqueror"] =                 { tiers: [ 9, 11 ], name: null, short: "Conq" };
            d["ussr_Object_704"] =                   { tiers: [ 9, 11 ], name: null, short: "704"  };
            d["ussr_SU122_54"] =                     { tiers: [ 9, 11 ], name: null, short: "12254"  };
            d["germany_JagdTiger"] =                 { tiers: [ 9, 11 ], name: null, short: "JagT"  };
            d["usa_T30"] =                           { tiers: [ 9, 11 ], name: null, short: "T30" };
            d["usa_T95"] =                           { tiers: [ 9, 11 ], name: null, short: "95"  };
            d["france_AMX50_Foch"] =                 { tiers: [ 9, 11 ], name: null, short: "Foch"  };
            d["uk_GB32_Tortoise"] =                  { tiers: [ 9, 11 ], name: null, short: "Tort" };
            d["ussr_Object_212"] =                   { tiers: [ 9, 11 ], name: null, short: "212"  };
            d["germany_G_Tiger"] =                   { tiers: [ 9, 11 ], name: null, short: "GwT" };
            d["usa_M53_55"] =                        { tiers: [ 9, 11 ], name: null, short: "5355" };
            d["france_Bat_Chatillon155_55"] =        { tiers: [ 9, 11 ], name: null, short: "Bat155" };
            d["uk_GB30_FV3805"] =                    { tiers: [ 9, 11 ], name: null, short: "3805" };

            // level 10
            d["ussr_Object_140"] =                   { tiers: [ 10, 12 ], name: null, short: "o140" };
            d["ussr_Object_907"] =                   { tiers: [ 10, 12 ], name: null, short: "907" };
            d["ussr_T62A"] =                         { tiers: [ 10, 12 ], name: null, short: "62A"  };
            d["germany_E50_Ausf_M"] =                { tiers: [ 10, 12 ], name: null, short: "50M" };
            d["germany_Leopard1"] =                  { tiers: [ 10, 12 ], name: null, short: "Leo" };
            d["usa_M48A1"] =                         { tiers: [ 10, 12 ], name: null, short: "M48" };
            d["usa_M60"] =                           { tiers: [ 10, 12 ], name: null, short: "M60" };
            d["china_Ch19_121"] =                    { tiers: [ 10, 12 ], name: null, short: "121" };
            d["france_Bat_Chatillon25t"] =           { tiers: [ 10, 12 ], name: null, short: "Bat" };
            d["uk_GB70_FV4202_105"] =                { tiers: [ 10, 12 ], name: null, short: "4202" };
            d["ussr_IS_4"] =                         { tiers: [ 10, 12 ], name: null, short: "4"  };
            d["ussr_IS_7"] =                         { tiers: [ 10, 12 ], name: null, short: "7"  };
            d["germany_E_100"] =                     { tiers: [ 10, 12 ], name: null, short: "100"  };
            d["germany_Maus"] =                      { tiers: [ 10, 12 ], name: null, short: "Maus"  };
            d["germany_VK7201"] =                    { tiers: [ 10, 12 ], name: null, short: "7201" };
            d["usa_T110"] =                          { tiers: [ 10, 12 ], name: null, short: "110E5"  };
            d["usa_T57_58"] =                        { tiers: [ 10, 12 ], name: null, short: "T57H" };
            d["china_Ch22_113"] =                    { tiers: [ 10, 12 ], name: null, short: "113" };
            d["france_F10_AMX_50B"] =                { tiers: [ 10, 12 ], name: null, short: "50B"  };
            d["uk_GB13_FV215b"] =                    { tiers: [ 10, 12 ], name: null, short: "215b"  };
            d["ussr_Object263"] =                    { tiers: [ 10, 12 ], name: null, short: "263"  };
            d["ussr_Object268"] =                    { tiers: [ 10, 12 ], name: null, short: "268"  };
            d["germany_JagdPz_E100"] =               { tiers: [ 10, 12 ], name: null, short: "JPz100"  };
            d["usa_T110E3"] =                        { tiers: [ 10, 12 ], name: null, short: "E3"  };
            d["usa_T110E4"] =                        { tiers: [ 10, 12 ], name: null, short: "E4"  };
            d["france_AMX_50Fosh_155"] =             { tiers: [ 10, 12 ], name: null, short: "Foch155"  };
            d["uk_GB48_FV215b_183"] =                { tiers: [ 10, 12 ], name: null, short: "183" };
            d["ussr_Object_261"] =                   { tiers: [ 10, 12 ], name: null, short: "261"  };
            d["germany_G_E"] =                       { tiers: [ 10, 12 ], name: null, short: "GwE" };
            d["usa_T92"] =                           { tiers: [ 10, 12 ], name: null, short: "T92" };
            d["france_Bat_Chatillon155_58"] =        { tiers: [ 10, 12 ], name: null, short: "15558" };
            d["uk_GB31_Conqueror_Gun"] =             { tiers: [ 10, 12 ], name: null, short: "ConqG" };

            // non-standard
            d["germany_PzI"] =                       { tiers: [ 2, 2 ], name: null, short: "Pz1" };
            d["usa_T2_lt"] =                         { tiers: [ 2, 4 ], name: null, short: "T2LT" };
            d["ussr_BT_SV"] =                        { tiers: [ 3, 4 ], name: null, short: "BTSV" };
            d["ussr_M3_Stuart_LL"] =                 { tiers: [ 3, 4 ], name: null, short: "StuLL" };
            d["ussr_T_127"] =                        { tiers: [ 3, 4 ], name: null, short: "T127" };
            d["germany_PzII_J"] =                    { tiers: [ 3, 4 ], name: null, short: "Pz2J" };
            d["ussr_T80"] =                          { tiers: [ 4, 6 ], name: null, short: "T80" };
            d["ussr_Valentine_LL"] =                 { tiers: [ 4, 4 ], name: null, short: "ValLL" };
            d["france_AMX40"] =                      { tiers: [ 4, 6 ], name: null, short: "AMX40" };
            d["uk_GB04_Valentine"] =                 { tiers: [ 4, 6 ], name: null, short: "Val1" };
            d["uk_GB60_Covenanter"] =                { tiers: [ 4, 6 ], name: null, short: "Coven" };
            d["ussr_A_32"] =                         { tiers: [ 4, 5 ], name: null, short: "A32" };
            d["germany_B_1bis_captured"] =           { tiers: [ 4, 4 ], name: null, short: "B1bis" };
            d["usa_M24_Chaffee"] =                   { tiers: [ 7, 12 ], name: null, short: "Chaff" };
            d["uk_GB20_Crusader"] =                  { tiers: [ 5, 7 ], name: null, short: "Crus" };
            d["ussr_Matilda_II_LL"] =                { tiers: [ 5, 6 ], name: null, short: "MatLL" };
            d["germany_PzIV_Hydro"] =                { tiers: [ 5, 6 ], name: null, short: "Pz4H" };
            d["usa_M4A2E4"] =                        { tiers: [ 5, 6 ], name: null, short: "SheE4" };
            d["uk_GB68_Matilda_Black_Prince"] =      { tiers: [ 5, 6 ], name: null, short: "MatilBP" };
            d["japan_Chi_Nu_Kai"] =                  { tiers: [ 5, 6 ], name: null, short: "ChiNuKai" };
            d["ussr_Churchill_LL"] =                 { tiers: [ 5, 6 ], name: null, short: "Chur" };
            d["ussr_KV_220"] =                       { tiers: [ 5, 6 ], name: null, short: "KV220" };
            d["ussr_KV_220_action"] =                { tiers: [ 5, 6 ], name: null, short: "KV220A" };
            d["usa_T14"] =                           { tiers: [ 5, 6 ], name: null, short: "T14" };
            d["uk_GB51_Excelsior"] =                 { tiers: [ 5, 6 ], name: null, short: "Excel" };
            d["ussr_SU_85I"] =                       { tiers: [ 5, 6 ], name: null, short: "Su85i" };
            d["germany_PzV_PzIV"] =                  { tiers: [ 6, 7 ], name: null, short: "Pz5/4" };
            d["germany_PzV_PzIV_ausf_Alfa"] =        { tiers: [ 6, 7 ], name: null, short: "Pz5/4A" };
            d["uk_GB63_TOG_II"] =                    { tiers: [ 6, 7 ], name: null, short: "TOG" };
            d["ussr_T44_122"] =                      { tiers: [ 7, 8 ], name: null, short: "T44-122" };
            d["ussr_T44_85"] =                       { tiers: [ 7, 8 ], name: null, short: "T44-85" };
            d["germany_Panther_M10"] =               { tiers: [ 7, 8 ], name: null, short: "PaM10" };
            d["germany_E_25"] =                      { tiers: [ 7, 8 ], name: null, short: "E25" };
            d["usa_T26_E4_SuperPershing"] =          { tiers: [ 8, 9 ], name: null, short: "Super" };
            d["china_Ch01_Type59"] =                 { tiers: [ 8, 9 ], name: null, short: "59" };
            d["china_Ch01_Type59_Gold"] =            { tiers: [ 8, 9 ], name: null, short: "59G" };
            d["china_Ch14_T34_3"] =                  { tiers: [ 8, 9 ], name: null, short: "34/3" };
            d["ussr_KV_5"] =                         { tiers: [ 8, 9 ], name: null, short: "KV5" };
            d["ussr_Object252"] =                    { tiers: [ 8, 9 ], name: null, short: "IS6" };
            d["china_Ch23_112"] =                    { tiers: [ 8, 9 ], name: null, short: "112" };
            d["france_FCM_50t"] =                    { tiers: [ 8, 9 ], name: null, short: "Fcm50" };
            d["germany_JagdTiger_SdKfz_185"] =       { tiers: [ 8, 9 ], name: null, short: "JgT88" };

            // DO NOT REMOVE
            d["unknown"] =                           { tiers: [ 0, 0 ],   name: null, short: "?" };
            return d;
        }
    }
}
