package utils
{

/**
 * ...
 * @author sirmax2
 */
public final class Defines
{
    // Global versions
    public static const XVM_VERSION: String = "3.0.4";
    public static const WOT_VERSION: String = "0.8.0";
    public static const CONFIG_VERSION: String = "1.5.0";
    public static const EDITOR_VERSION: String = "0.19";

    // Dynamic color types
    public static const DYNAMIC_COLOR_EFF: Number = 1;
    public static const DYNAMIC_COLOR_RATING: Number = 2;
    public static const DYNAMIC_COLOR_KB: Number = 3;
    public static const DYNAMIC_COLOR_HP: Number = 4;
    public static const DYNAMIC_COLOR_HP_RATIO: Number = 5;
    public static const DYNAMIC_COLOR_TBATTLES: Number = 6;

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
