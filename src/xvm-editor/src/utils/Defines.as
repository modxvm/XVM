package utils
{

public final class Defines
{
    // Global versions
    public static const XVM_VERSION: String = "2.5.2";
    public static const WOT_VERSION: String = "0.7.5";
    public static const CONFIG_VERSION: String = "1.5.0";
    public static const EDITOR_VERSION: String = "0.5";

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

    // icons
    // color
    [Embed("images/c_hp.png")]
    public static const c_hp:Class;
    [Embed("images/c_hp_ratio.png")]
    public static const c_hp_ratio:Class;
    [Embed("images/c_eff.png")]
    public static const c_eff:Class;
    [Embed("images/c_rating.png")]
    public static const c_rating:Class;
    [Embed("images/c_kb.png")]
    public static const c_kb:Class;
    [Embed("images/c_t_rating.png")]
    public static const c_t_rating:Class;
    [Embed("images/c_t_battles.png")]
    public static const c_t_battles:Class;
    // alpha
    [Embed("images/a_hp.png")]
    public static const a_hp:Class;
    [Embed("images/a_hp_ratio.png")]
    public static const a_hp_ratio:Class;

    // Macros groups
    public static const MACROS: Object = {
        // In players panel, battle loading screen and statistic form:
        panels: [
            { value: "{{nick}}", label: "", icon: "" },
            { value: "{{vehicle}}", label: "", icon: "" }
        ],
        // In tank markers:
        markers: [
            { value: "{{hp}}", label: "", icon: "" },
            { value: "{{hp-ratio}}", label: "", icon: "" },
            { value: "{{hp-max}}", label: "", icon: "" },
            { value: "{{nick}}", label: "", icon: "" },
            { value: "{{vehicle}}", label: "", icon: "" },
            { value: "{{level}}", label: "", icon: "" },
            { value: "{{dmg}}", label: "", icon: "" },
            { value: "{{dmg-ratio}}", label: "", icon: "" }
        ],
        // Statistics
        stats: [
            { value: "{{rating}}", label: "", icon: "" },
            { value: "{{eff}}", label: "", icon: "" },
            { value: "{{kb}}", label: "", icon: "" },
            { value: "{{battles}}", label: "", icon: "" },
            { value: "{{wins}}", label: "", icon: "" },
            { value: "{{rating:3}}", label: "", icon: "" },
            { value: "{{eff:4}}", label: "", icon: "" },
            { value: "{{kb:3}}", label: "", icon: "" },
            { value: "{{t-kb}}", label: "", icon: "" },
            { value: "{{t-battles}}", label: "", icon: "" },
            { value: "{{t-wins}}", label: "", icon: "" },
            { value: "{{t-rating:3}}", label: "", icon: "" },
            { value: "{{t-kb:4}}", label: "", icon: "" },
            { value: "{{t-battles:4}}", label: "", icon: "" },
            { value: "{{t-kb-0}}", label: "", icon: "" },
            { value: "{{t-hb}}", label: "", icon: "" },
            { value: "{{t-hb:3}}", label: "", icon: "" }
        ],
        // Dynamic colors macros:
        colors: [
            { value: "{{c:hp}}", label: "", icon: c_hp },
            { value: "{{c:hp-ratio}}", label: "", icon: c_hp_ratio },
            { value: "{{c:eff}}", label: "", icon: c_eff },
            { value: "{{c:rating}}", label: "", icon: c_rating },
            { value: "{{c:kb}}", label: "", icon: c_kb },
            { value: "{{c:t-rating}}", label: "", icon: c_t_rating },
            { value: "{{c:t-battles}}", label: "", icon: c_t_battles }
        ],
        // Dynamic transparency macros:
        transparency: [
            { value: "{{a:hp}}", label: "", icon: a_hp },
            { value: "{{a:hp-ratio}}", label: "", icon: a_hp_ratio }
        ]
    };
}

}
