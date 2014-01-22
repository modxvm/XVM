package utils
{
    public final class Macros
    {
		import com.xvm.*;
		
        import utils.Embed;

        public static function get(m:String):Array
        {
            var ma:Array = m.split(",");
            var res:Array = [];
            for each (var a:String in ma)
            {
                if (res.length > 0)
                    res.push({ type: "separator" });
                res = res.concat(MACROS[a]);
            }
            return res;
        }

        public static function format(format:String):String
        {
            if (!format)
                return "";

            var hp:Number = 500;
            var hpMax:Number = 2000;
            var hpRatio:Number = 25;
            var alphaHp:String = "#" +
                Utils.padLeft((Utils.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP, hp) / 100 * 255).toString(16), 2, '0');
            var alphaHpRatio:String = "#" +
                Utils.padLeft((Utils.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP_RATIO, hp) / 100 * 255).toString(16), 2, '0');

            // Fix font (ugly hack)
            format = format.split("$TextFont").join("Tahoma")

            // Text
            format = format.split("{{dead}}").join(Config.config.hitLog.deadMarker);

            format = format.split("{{extra}}").join(Config.config.captureBar.ally.extra);
            format = format.split("{{points}}").join("5");
            format = format.split("{{tanks}}").join("3" + (Config.config.captureBar.appendPlus ? "+" : ""));
            format = format.split("{{time}}").join("1:15");
            format = format.split("{{time-sec}}").join("75");
            format = format.split("{{speed}}").join("3");

            var name:String = "Player";
            var vname:String = "T-34";
            var vnames:String = "t34";
            format = format.split("{{nick}}").join(name + "[CLAN]");
            format = format.split("{{name}}").join(name);
            format = format.split("{{short-nick}}").join(name.slice(0, Config.config.minimap.nickShrink));
            format = format.split("{{clan}}").join("[CLAN]");
            format = format.split("{{clannb}}").join("CLAN");
            format = format.split("{{vehicle}}").join(vname);
            format = format.split("{{vehiclename}}").join("ussr-T-34");
            format = format.split("{{short-vehicle}}").join(vnames);
            format = format.split("{{vtype}}").join(Config.config.texts.vtype.MT);
            format = format.split("{{level}}").join("5");
            format = format.split("{{rlevel}}").join("V");
            format = format.split("{{turret}}").join(Config.config.turretMarkers.highVulnerability);
            format = format.split("{{hp}}").join(hp.toString());
            format = format.split("{{hp-ratio}}").join(hpRatio.toString());
            format = format.split("{{hp-max}}").join(hpMax.toString());
            format = format.split("{{dmg}}").join("250");
            format = format.split("{{dmg-ratio}}").join("27");
            format = format.split("{{dmg-kind}}").join("attack");

            format = format.split("{{n}}").join("10");
            format = format.split("{{n-player}}").join("3");
            format = format.split("{{dmg-total}}").join("2500");
            format = format.split("{{dmg-avg}}").join("250");
            format = format.split("{{dmg-player}}").join("1500");

            // Colors
            format = format.split("{{c:hp}}").join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP, hp));
            format = format.split("{{c:hp-ratio}}").join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP_RATIO, hpRatio));
            format = format.split("{{c:dmg-kind}}").join(Utils.GetDmgKindValue("attack"));
            format = format.split("{{c:vtype}}").join(Utils.GetVTypeColorValue("MT"));
            format = format.split("{{c:system}}").join("#FBFBFB");

            // Transparency
            format = format.split("{{a:hp}}").join(alphaHp);
            format = format.split("{{a:hp-ratio}}").join(alphaHpRatio);

            // Statistics
            format = format.split("{{avglvl}}").join("5");
            format = format.split("{{xeff}}").join("XX");
            format = format.split("{{xwn}}").join("77");
            format = format.split("{{eff}}").join("1800");
            format = format.split("{{wn6}}").join("1600");
            format = format.split("{{wn8}}").join("1600");
            format = format.split("{{wn}}").join("1600");
            format = format.split("{{e}}").join("5");
            format = format.split("{{rating}}").join("66%");
            format = format.split("{{teff}}").join("1024");
            format = format.split("{{tdb}}").join("1010");
            format = format.split("{{tdb:4}}").join("1010");
            format = format.split("{{tdv}}").join("0.9");
            format = format.split("{{tfb}}").join("1.0");
            format = format.split("{{tsb}}").join("1.1");
            format = format.split("{{kb}}").join("11k");
            format = format.split("{{battles}}").join("11000");
            format = format.split("{{wins}}").join("7260");
            format = format.split("{{rating:3}}").join("66%");
            format = format.split("{{eff:4}}").join("1800");
            format = format.split("{{kb:3}}").join("11k");
            format = format.split("{{t-rating}}").join("55%");
            format = format.split("{{t-kb}}").join(".5k");
            format = format.split("{{t-kb-0}}").join("0.5k");
            format = format.split("{{t-hb}}").join("5h");
            format = format.split("{{t-battles}}").join("5500");
            format = format.split("{{t-wins}}").join("3025");
            format = format.split("{{t-rating:3}}").join("55%");
            format = format.split("{{t-kb:4}}").join(" .5k");
            format = format.split("{{t-hb:3}}").join(" 5h");
            format = format.split("{{t-battles:4}}").join("5500");
            format = format.split("{{c:xeff}}").join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, 100));
            format = format.split("{{c:xwn}}").join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, 77));
            format = format.split("{{c:eff}}").join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, 1800));
            format = format.split("{{c:wn6}}").join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN6, 1600));
            format = format.split("{{c:wn8}}").join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN8, 1600));
            format = format.split("{{c:wn}}").join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN8, 1600));
            format = format.split("{{c:rating}}").join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, 66));
            format = format.split("{{c:kb}}").join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_KB, 11));
            format = format.split("{{c:e}}").join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_E, 5));
            format = format.split("{{c:tdb}}").join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDB, 1010));
            format = format.split("{{c:tdv}}").join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDV, 0.9));
            format = format.split("{{c:tfb}}").join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TFB, 1.0));
            format = format.split("{{c:tsb}}").join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TSB, 1.1));
            format = format.split("{{c:t-rating}}").join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, 55));
            format = format.split("{{c:t-battles}}").join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TBATTLES, 5500));

            return Utils.trim(format);
        }

        private static const MACROS: Object = {
            syscolors: [
                { value: "(system)", label: "UseSystemColor", icon: Embed.syscolors }
            ],
            // In players panel, battle loading screen and statistic form:
            panels: [
                { value: "{{nick}}", label: "nick", icon: Embed.nick },
                { value: "{{name}}", label: "name", icon: Embed.name },
                { value: "{{clan}}", label: "clan", icon: Embed.clan },
                { value: "{{clannb}}", label: "clannb", icon: Embed.clannb },
                { value: "{{vehicle}}", label: "vehicle", icon: Embed.vehicle },
                { value: "{{vtype}}", label: "vtype", icon: Embed.vtype },
            ],
            colors_panels: [
                { value: "{{c:vtype}}", label: "c_vtype", icon: Embed.c_vtype }
            ],
            // In hit log:
            hitlog: [
                { value: "{{nick}}", label: "nick", icon: Embed.nick },
                { value: "{{name}}", label: "name", icon: Embed.name },
                { value: "{{clan}}", label: "clan", icon: Embed.clan },
                { value: "{{clannb}}", label: "clannb", icon: Embed.clannb },
                { value: "{{vehicle}}", label: "vehicle", icon: Embed.vehicle },
                { value: "{{vtype}}", label: "vtype", icon: Embed.vtype },
                { value: "{{level}}", label: "level", icon: Embed.level },
                { value: "{{rlevel}}", label: "rlevel", icon: Embed.rlevel },
                { value: "{{n}}", label: "n", icon: Embed.n },
                { value: "{{n-player}}", label: "n_player", icon: Embed.n_player },
                { value: "{{dmg}}", label: "dmg", icon: Embed.dmg },
                { value: "{{dmg-total}}", label: "dmg_total", icon: Embed.dmg_total },
                { value: "{{dmg-avg}}", label: "dmg_avg", icon: Embed.dmg_avg },
                { value: "{{dmg-player}}", label: "dmg_player", icon: Embed.dmg_player },
                { value: "{{dmg-kind}}", label: "dmg_kind", icon: Embed.dmg_kind }
            ],
            captureBar: [
                { value: "{{points}}", label: "cb_points", icon: Embed.points },
                { value: "{{extra}}", label: "cb_extra", icon: Embed.extra }
            ],
            captureBarExtra: [
                { value: "{{points}}", label: "cb_points", icon: Embed.points },
                { value: "{{tanks}}", label: "cb_tanks", icon: Embed.tanks },
                { value: "{{time}}", label: "cb_time", icon: Embed.time },
                { value: "{{time-sec}}", label: "cb_time_sec", icon: Embed.time_sec },
                { value: "{{speed}}", label: "cb_speed", icon: Embed.speed }
            ],
            minimap: [
                { value: "{{short-nick}}", label: "short_nick", icon: Embed.short_nick },
                { value: "{{short-vehicle}}", label: "short_vehicle", icon: Embed.short_vehicle },
                { value: "{{vehicle}}", label: "vehicle", icon: Embed.vehicle },
                { value: "{{level}}", label: "level", icon: Embed.level }
            ],
            dead: [
                { value: "{{dead}}", label: "dead", icon: Embed.dead }
            ],
            colors_hitlog: [
                { value: "{{c:dmg-kind}}", label: "c_dmg_kind", icon: Embed.c_dmg_kind },
                { value: "{{c:vtype}}", label: "c_vtype", icon: Embed.c_vtype }
            ],
            // In tank markers:
            markers: [
                { value: "{{nick}}", label: "nick", icon: Embed.nick },
                { value: "{{name}}", label: "name", icon: Embed.name },
                { value: "{{clan}}", label: "clan", icon: Embed.clan },
                { value: "{{clannb}}", label: "clannb", icon: Embed.clannb },
                { value: "{{squad}}", label: "squad", icon: Embed.squad },
                { value: "{{vehicle}}", label: "vehicle", icon: Embed.vehicle },
                { value: "{{vtype}}", label: "vtype", icon: Embed.vtype },
                { value: "{{level}}", label: "level", icon: Embed.level },
                { value: "{{rlevel}}", label: "rlevel", icon: Embed.rlevel },
                { value: "{{turret}}", label: "turret", icon: Embed.turret },
                { value: "{{hp}}", label: "hp", icon: Embed.hp },
                { value: "{{hp-ratio}}", label: "hp_ratio", icon: Embed.hp_ratio },
                { value: "{{hp-max}}", label: "hp_max", icon: Embed.hp_max }
            ],
            colors_markers: [
                { value: "{{c:hp}}", label: "c_hp", icon: Embed.c_hp },
                { value: "{{c:hp-ratio}}", label: "c_hp_ratio", icon: Embed.c_hp_ratio },
                { value: "{{c:vtype}}", label: "c_vtype", icon: Embed.c_vtype },
                { value: "{{c:system}}", label: "c_system", icon: Embed.c_system }
            ],
            // In floating damage text:
            markers_damage: [
                { value: "{{nick}}", label: "nick", icon: Embed.nick },
                { value: "{{name}}", label: "name", icon: Embed.name },
                { value: "{{clan}}", label: "clan", icon: Embed.clan },
                { value: "{{clannb}}", label: "clannb", icon: Embed.clannb },
                { value: "{{squad}}", label: "squad", icon: Embed.squad },
                { value: "{{vehicle}}", label: "vehicle", icon: Embed.vehicle },
                { value: "{{vtype}}", label: "vtype", icon: Embed.vtype },
                { value: "{{level}}", label: "level", icon: Embed.level },
                { value: "{{rlevel}}", label: "rlevel", icon: Embed.rlevel },
                { value: "{{turret}}", label: "turret", icon: Embed.turret },
                { value: "{{hp}}", label: "hp", icon: Embed.hp },
                { value: "{{hp-ratio}}", label: "hp_ratio", icon: Embed.hp_ratio },
                { value: "{{hp-max}}", label: "hp_max", icon: Embed.hp_max },
                { value: "{{dmg}}", label: "dmg", icon: Embed.dmg },
                { value: "{{dmg-ratio}}", label: "dmg_ratio", icon: Embed.dmg_ratio },
                { value: "{{dmg-kind}}", label: "dmg_kind", icon: Embed.dmg_kind }
            ],
            colors_markers_damage: [
                { value: "{{c:hp}}", label: "c_hp", icon: Embed.c_hp },
                { value: "{{c:hp-ratio}}", label: "c_hp_ratio", icon: Embed.c_hp_ratio },
                { value: "{{c:dmg}}", label: "c_dmg", icon: Embed.c_dmg },
                { value: "{{c:dmg-kind}}", label: "c_dmg_kind", icon: Embed.c_dmg_kind },
                { value: "{{c:vtype}}", label: "c_vtype", icon: Embed.c_vtype },
                { value: "{{c:system}}", label: "c_system", icon: Embed.c_system }
            ],
            // Statistics
            stats: [
                { value: "{{avglvl}}", label: "avglvl", icon: Embed.avglvl },
                { value: "{{rating}}", label: "rating", icon: Embed.rating },
                { value: "{{xeff}}", label: "xeff", icon: Embed.xeff },
                { value: "{{xwn}}", label: "xwn", icon: Embed.xwn },
                { value: "{{eff}}", label: "eff", icon: Embed.eff },
                { value: "{{wn6}}", label: "wn6", icon: Embed.wn6 },
                { value: "{{wn8}}", label: "wn8", icon: Embed.wn8 },
                { value: "{{wn}}", label: "wn", icon: Embed.wn },
                { value: "{{e}}", label: "e", icon: Embed.e },
                { value: "{{teff}}", label: "teff", icon: Embed.teff },
                { value: "{{tdb}}", label: "tdb", icon: Embed.tdb },
                { value: "{{tdv}}", label: "tdv", icon: Embed.tdv },
                { value: "{{tfb}}", label: "tfb", icon: Embed.tfb },
                { value: "{{tsb}}", label: "tsb", icon: Embed.tsb },
                { value: "{{kb}}", label: "kb", icon: Embed.kb },
                { value: "{{battles}}", label: "battles", icon: Embed.battles },
                { value: "{{wins}}", label: "wins", icon: Embed.wins },
                { value: "{{rating:3}}", label: "rating_3", icon: Embed.rating_3 },
                { value: "{{eff:4}}", label: "eff_4", icon: Embed.eff_4 },
                { value: "{{kb:3}}", label: "kb_3", icon: Embed.kb_3 },
                { value: "{{t-rating}}", label: "t_rating", icon: Embed.t_rating },
                { value: "{{t-kb}}", label: "t_kb", icon: Embed.t_kb },
                { value: "{{t-kb-0}}", label: "t_kb_0", icon: Embed.t_kb_0 },
                { value: "{{t-hb}}", label: "t_hb", icon: Embed.t_hb },
                { value: "{{t-battles}}", label: "t_battles", icon: Embed.t_battles },
                { value: "{{t-wins}}", label: "t_wins", icon: Embed.t_wins },
                { value: "{{t-rating:3}}", label: "t_rating_3", icon: Embed.t_rating_3 },
                { value: "{{t-kb:4}}", label: "t_kb_4", icon: Embed.t_kb_4 },
                { value: "{{t-hb:3}}", label: "t_hb_3", icon: Embed.t_hb_3 },
                { value: "{{t-battles:4}}", label: "t_battles_4", icon: Embed.t_battles_4 }
            ],
            colors_stat: [
                { value: "{{c:xeff}}", label: "c_xeff", icon: Embed.c_xeff },
                { value: "{{c:xwn}}", label: "c_xwn", icon: Embed.c_xwn },
                { value: "{{c:eff}}", label: "c_eff", icon: Embed.c_eff },
                { value: "{{c:wn6}}", label: "c_wn6", icon: Embed.c_wn6 },
                { value: "{{c:wn8}}", label: "c_wn8", icon: Embed.c_wn8 },
                { value: "{{c:wn}}", label: "c_wn", icon: Embed.c_wn },
                { value: "{{c:e}}", label: "c_e", icon: Embed.c_e },
                { value: "{{c:rating}}", label: "c_rating", icon: Embed.c_rating },
                { value: "{{c:t-rating}}", label: "c_t_rating", icon: Embed.c_t_rating },
                { value: "{{c:t-battles}}", label: "c_t_battles", icon: Embed.c_t_battles },
                { value: "{{c:tdb}}", label: "c_tdb", icon: Embed.c_tdb },
                { value: "{{c:tdv}}", label: "c_tdv", icon: Embed.c_tdv },
                { value: "{{c:tfb}}", label: "c_tfb", icon: Embed.c_tfb },
                { value: "{{c:tsb}}", label: "c_tsb", icon: Embed.c_tsb },
                { value: "{{c:kb}}", label: "c_kb", icon: Embed.c_kb }
            ],
            // Dynamic transparency macros:
            transparency: [
                { value: "{{a:hp}}", label: "a_hp", icon: Embed.a_hp },
                { value: "{{a:hp-ratio}}", label: "a_hp_ratio", icon: Embed.a_hp_ratio }
            ]
        };
    }

}
