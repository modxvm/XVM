package utils
{

/**
 * ...
 * @author sirmax2
 */
public final class Defines
{
    // Global versions
    public static const XVM_VERSION: String = "3.5.0";
    public static const WOT_VERSION: String = "0.8.4";
    public static const CONFIG_VERSION: String = "1.5.0";
    public static const EDITOR_VERSION: String = "0.43";

    // Dynamic color types
    public static const DYNAMIC_COLOR_EFF: Number = 1;
    public static const DYNAMIC_COLOR_RATING: Number = 2;
    public static const DYNAMIC_COLOR_KB: Number = 3;
    public static const DYNAMIC_COLOR_HP: Number = 4;
    public static const DYNAMIC_COLOR_HP_RATIO: Number = 5;
    public static const DYNAMIC_COLOR_TBATTLES: Number = 6;
    public static const DYNAMIC_COLOR_TDB: Number = 7;
    public static const DYNAMIC_COLOR_TDV: Number = 8;
    public static const DYNAMIC_COLOR_TFB: Number = 9;
    public static const DYNAMIC_COLOR_TSB: Number = 10;
    public static const DYNAMIC_COLOR_E: Number = 11;
    public static const DYNAMIC_COLOR_TWR: Number = 12;
    public static const DYNAMIC_COLOR_WN: Number = 13;
    public static const DYNAMIC_COLOR_X: Number = 14;

    // Dynamic alpha types
    //public static const DYNAMIC_ALPHA_EFF: Number = 1;
    //public static const DYNAMIC_ALPHA_RATING: Number = 2;
    //public static const DYNAMIC_ALPHA_KB: Number = 3;
    public static const DYNAMIC_ALPHA_HP: Number = 4;
    public static const DYNAMIC_ALPHA_HP_RATIO: Number = 5;
    //public static const DYNAMIC_ALPHA_TBATTLES: Number = 6;

    // Damage flag at Xvm.as: updateHealth
    public static var FROM_UNKNOWN: Number = 0;
    public static var FROM_ALLY: Number = 1;
    public static var FROM_ENEMY: Number = 2;
    public static var FROM_SQUAD: Number = 3;
    public static var FROM_PLAYER: Number = 4;
}

}
