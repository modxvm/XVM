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

        private static const MACROS: Object = {
            syscolors: [
                { value: "(system)", label: "UseSystemColor", icon: Embed.syscolors }
            ],
            // In players panel, battle loading screen and statistic form:
            panels: [
                { value: "{{nick}}", label: "nick", icon: Embed.nick },
                { value: "{{vehicle}}", label: "vehicle", icon: Embed.vehicle },
            ],
            colors_panels: [
                { value: "{{c:vtype}}", label: "c_vtype", icon: Embed.c_vtype }
            ],
            // In hit log:
            hitlog: [
                { value: "{{nick}}", label: "nick", icon: Embed.nick },
                { value: "{{vehicle}}", label: "vehicle", icon: Embed.vehicle },
                { value: "{{level}}", label: "level", icon: Embed.level },
                { value: "{{rlevel}}", label: "rlevel", icon: Embed.rlevel },
                { value: "{{n}}", label: "n", icon: Embed.n },
                { value: "{{dmg}}", label: "dmg", icon: Embed.dmg },
                { value: "{{dmg-total}}", label: "dmg_total", icon: Embed.dmg_total },
                { value: "{{dmg-kind}}", label: "dmg_kind", icon: Embed.dmg_kind }
            ],
            colors_hitlog: [
                { value: "{{c:dmg-kind}}", label: "c_dmg_kind", icon: Embed.c_dmg_kind },
                { value: "{{c:vtype}}", label: "c_vtype", icon: Embed.c_vtype }
            ],
            // In tank markers:
            markers: [
                { value: "{{nick}}", label: "nick", icon: Embed.nick },
                { value: "{{vehicle}}", label: "vehicle", icon: Embed.vehicle },
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
                { value: "{{c:vtype}}", label: "c_vtype", icon: Embed.c_vtype }
            ],
            // In floating damage text:
            markers_damage: [
                { value: "{{nick}}", label: "nick", icon: Embed.nick },
                { value: "{{vehicle}}", label: "vehicle", icon: Embed.vehicle },
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
                { value: "{{c:vtype}}", label: "c_vtype", icon: Embed.c_vtype }
            ],
            // Statistics
            stats: [
                { value: "{{rating}}", label: "rating", icon: Embed.rating },
                { value: "{{eff}}", label: "eff", icon: Embed.eff },
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
