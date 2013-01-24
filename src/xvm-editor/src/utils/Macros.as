package utils
{
    public final class Macros
    {
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
                Utils.padLeft((GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP, hp) / 100 * 255).toString(16), 2, '0');
            var alphaHpRatio:String = "#" +
                Utils.padLeft((GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP_RATIO, hp) / 100 * 255).toString(16), 2, '0');

            // Fix font (ugly hack)
            format = format.replace("$TextFont", "Tahoma")

            // Text
            format = format.replace("{{dead}}", Config.s_config.hitLog.deadMarker);

            format = format.replace("{{extra}}", Config.s_config.captureBar.ally.extra);
            format = format.replace("{{points}}", "5");
            format = format.replace("{{tanks}}", "3" + (Config.s_config.captureBar.appendPlus ? "+" : ""));
            format = format.replace("{{time}}", "1:15");
            format = format.replace("{{time-sec}}", "75");
            format = format.replace("{{speed}}", "3");

            var name:String = "Player";
            var vname:String = "T-34";
            var vnames:String = "t34";
            format = format.replace("{{nick}}", name + "[CLAN]");
            format = format.replace("{{name}}", name);
            format = format.replace("{{short-nick}}", name.slice(0, Config.s_config.minimap.nickShrink));
            format = format.replace("{{clan}}", "[CLAN]");
            format = format.replace("{{vehicle}}", vname);
            format = format.replace("{{short-vehicle}}", vnames);
            format = format.replace("{{vtype}}", Config.s_config.texts.vtype.MT);
            format = format.replace("{{level}}", "5");
            format = format.replace("{{rlevel}}", "V");
            format = format.replace("{{turret}}", Config.s_config.turretMarkers.highVulnerability);
            format = format.replace("{{hp}}", hp.toString());
            format = format.replace("{{hp-ratio}}", hpRatio.toString());
            format = format.replace("{{hp-max}}", hpMax.toString());
            format = format.replace("{{dmg}}", "250");
            format = format.replace("{{dmg-ratio}}", "27");
            format = format.replace("{{dmg-kind}}", "attack");

            format = format.replace("{{n}}", "10");
            format = format.replace("{{n-player}}", "3");
            format = format.replace("{{dmg-total}}", "2500");
            format = format.replace("{{dmg-avg}}", "250");
            format = format.replace("{{dmg-player}}", "1500");

            // Colors
            format = format.replace("{{c:hp}}", GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP, hp));
            format = format.replace("{{c:hp-ratio}}", GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP_RATIO, hpRatio));
            format = format.replace("{{c:dmg-kind}}", GraphicsUtil.GetDmgKindValue("attack"));
            format = format.replace("{{c:vtype}}", GraphicsUtil.GetVTypeColorValue("MT"));
            format = format.replace("{{c:system}}", "#FBFBFB");

            // Transparency
            format = format.replace("{{a:hp}}", alphaHpRatio);
            format = format.replace("{{a:hp-ratio}}", alphaHpRatio);

            // Statistics
            format = format.replace("{{rating}}", "66%");
            format = format.replace("{{eff}}", "1800");
            format = format.replace("{{e}}", "5");
            format = format.replace("{{wn}}", "1001");
            format = format.replace("{{twr}}", "61%");
            format = format.replace("{{teff}}", "1024");
            format = format.replace("{{tdb}}", "1010");
            format = format.replace("{{tdb:4}}", "1010");
            format = format.replace("{{tdv}}", "0.9");
            format = format.replace("{{tfb}}", "1.0");
            format = format.replace("{{tsb}}", "1.1");
            format = format.replace("{{kb}}", "11k");
            format = format.replace("{{battles}}", "11000");
            format = format.replace("{{wins}}", "7260");
            format = format.replace("{{rating:3}}", "66%");
            format = format.replace("{{eff:4}}", "1800");
            format = format.replace("{{kb:3}}", " 11k");
            format = format.replace("{{t-rating}}", "55%");
            format = format.replace("{{t-kb}}", ".5k");
            format = format.replace("{{t-kb-0}}", "0.5k");
            format = format.replace("{{t-hb}}", "5h");
            format = format.replace("{{t-battles}}", "5500");
            format = format.replace("{{t-wins}}", "3025");
            format = format.replace("{{t-rating:3}}", "55%");
            format = format.replace("{{t-kb:4}}", " .5k");
            format = format.replace("{{t-hb:3}}", " 5h");
            format = format.replace("{{t-battles:4}}", "5500");
            format = format.replace("{{c:eff}}", GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, 1800));
            format = format.replace("{{c:wn}}", GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN, 1600));
            format = format.replace("{{c:twr}}", GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TWR, 61));
            format = format.replace("{{c:rating}}", GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, 66));
            format = format.replace("{{c:kb}}", GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_KB, 11));
            format = format.replace("{{c:e}}", GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_E, 5));
            format = format.replace("{{c:tdb}}", GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDB, 1010));
            format = format.replace("{{c:tdv}}", GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDV, 0.9));
            format = format.replace("{{c:tfb}}", GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TFB, 1.0));
            format = format.replace("{{c:tsb}}", GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TSB, 1.1));
            format = format.replace("{{c:t-rating}}", GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, 55));
            format = format.replace("{{c:t-battles}}", GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TBATTLES, 5500));

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
                { value: "{{c:dmg-kind}}", label: "c_dmg_kind", icon: Embed.c_dmg_kind },
                { value: "{{c:vtype}}", label: "c_vtype", icon: Embed.c_vtype },
                { value: "{{c:system}}", label: "c_system", icon: Embed.c_system }
            ],
            // Statistics
            stats: [
                { value: "{{rating}}", label: "rating", icon: Embed.rating },
                { value: "{{eff}}", label: "eff", icon: Embed.eff },
                { value: "{{e}}", label: "e", icon: Embed.e },
                { value: "{{teff}}", label: "teff", icon: Embed.teff },
                { value: "{{twr}}", label: "twr", icon: Embed.twr },
                { value: "{{wn}}", label: "wn", icon: Embed.wn },
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
                { value: "{{c:eff}}", label: "c_eff", icon: Embed.c_eff },
                { value: "{{c:e}}", label: "c_e", icon: Embed.c_e },
                { value: "{{c:twr}}", label: "c_twr", icon: Embed.c_twr },
                { value: "{{c:wn}}", label: "c_wn", icon: Embed.c_wn },
                { value: "{{c:tdb}}", label: "c_tdb", icon: Embed.c_tdb },
                { value: "{{c:tdv}}", label: "c_tdv", icon: Embed.c_tdv },
                { value: "{{c:tfb}}", label: "c_tfb", icon: Embed.c_tfb },
                { value: "{{c:tsb}}", label: "c_tsb", icon: Embed.c_tsb },
                { value: "{{c:rating}}", label: "c_rating", icon: Embed.c_rating },
                { value: "{{c:kb}}", label: "c_kb", icon: Embed.c_kb },
                { value: "{{c:t-rating}}", label: "c_t_rating", icon: Embed.c_t_rating },
                { value: "{{c:t-battles}}", label: "c_t_battles", icon: Embed.c_t_battles }
            ],
            // Dynamic transparency macros:
            transparency: [
                { value: "{{a:hp}}", label: "a_hp", icon: Embed.a_hp },
                { value: "{{a:hp-ratio}}", label: "a_hp_ratio", icon: Embed.a_hp_ratio }
            ]
        };
    }

}
