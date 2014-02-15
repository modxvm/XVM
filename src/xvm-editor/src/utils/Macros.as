package utils
{
    import mx.controls.Image;

    public final class Macros
    {
        import com.xvm.*;
        import flash.display.*;
        import flash.text.*;
        import utils.Embed;
        import mx.core.*;

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

            for (var i:int = 0; i < res.length; ++i)
            {
                var v:* = res[i];
                if (v is String)
                {
                    res[i] = {
                        value: v,
                        label: v.replace("{{", "").replace("}}", "").replace(/:/g, "_").replace(/-/g, "_"),
                        bitmap: getMacroIcon(v)
                    }
                }
            }

            return res;
        }

        public static function getMacroIcon(m:String):BitmapData
        {
            var sprite:SpriteAsset = new SpriteAsset();

            var field:TextField = new TextField();
            field.y = -1;
            field.embedFonts = true;
            field.antiAliasType = AntiAliasType.NORMAL;
            field.htmlText = "<font face='Cuprum' size='12'>" + m + "</font>";
            sprite.addChild(field);

            var bitmapData:BitmapData = new BitmapData(64, 16, true, 0x000000);
            bitmapData.draw(sprite);

            return bitmapData;
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
            format = format.split("{{xwn6}}").join("76");
            format = format.split("{{xwn8}}").join("78");
            format = format.split("{{xwn}}").join("78");
            format = format.split("{{eff}}").join("1800");
            format = format.split("{{wn6}}").join("1606");
            format = format.split("{{wn8}}").join("1608");
            format = format.split("{{wn}}").join("1608");
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
            format = format.split("{{c:xwn6}}").join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, 76));
            format = format.split("{{c:xwn8}}").join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, 78));
            format = format.split("{{c:xwn}}").join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, 78));
            format = format.split("{{c:eff}}").join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, 1800));
            format = format.split("{{c:wn6}}").join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN6, 1606));
            format = format.split("{{c:wn8}}").join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN8, 1608));
            format = format.split("{{c:wn}}").join(Utils.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN8, 1608));
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
                "{{nick}}",
                "{{name}}",
                "{{clan}}",
                "{{clannb}}",
                "{{vehicle}}",
                "{{vtype}}",
            ],
            colors_panels: [
                "{{c:vtype}}"
            ],
            // In hit log:
            hitlog: [
                "{{nick}}",
                "{{name}}",
                "{{clan}}",
                "{{clannb}}",
                "{{vehicle}}",
                "{{vtype}}",
                "{{level}}",
                "{{rlevel}}",
                "{{n}}",
                "{{n-player}}",
                "{{dmg}}",
                "{{dmg-total}}",
                "{{dmg-avg}}",
                "{{dmg-player}}",
                "{{dmg-kind}}"
            ],
            captureBar: [
                "{{points}}",
                "{{extra}}"
            ],
            captureBarExtra: [
                "{{points}}",
                "{{tanks}}",
                "{{time}}",
                "{{time-sec}}",
                "{{speed}}"
            ],
            minimap: [
                "{{short-nick}}",
                "{{short-vehicle}}",
                "{{vehicle}}",
                "{{level}}"
            ],
            dead: [
                "{{dead}}"
            ],
            colors_hitlog: [
                "{{c:dmg-kind}}",
                "{{c:vtype}}"
            ],
            // In tank markers:
            markers: [
                "{{nick}}",
                "{{name}}",
                "{{clan}}",
                "{{clannb}}",
                "{{squad}}",
                "{{vehicle}}",
                "{{vtype}}",
                "{{level}}",
                "{{rlevel}}",
                "{{turret}}",
                "{{hp}}",
                "{{hp-ratio}}",
                "{{hp-max}}"
            ],
            colors_markers: [
                "{{c:hp}}",
                "{{c:hp-ratio}}",
                "{{c:vtype}}",
                "{{c:system}}"
            ],
            // In floating damage text:
            markers_damage: [
                "{{nick}}",
                "{{name}}",
                "{{clan}}",
                "{{clannb}}",
                "{{squad}}",
                "{{vehicle}}",
                "{{vtype}}",
                "{{level}}",
                "{{rlevel}}",
                "{{turret}}",
                "{{hp}}",
                "{{hp-ratio}}",
                "{{hp-max}}",
                "{{dmg}}",
                "{{dmg-ratio}}",
                "{{dmg-kind}}"
            ],
            colors_markers_damage: [
                "{{c:hp}}",
                "{{c:hp-ratio}}",
                "{{c:dmg}}",
                "{{c:dmg-kind}}",
                "{{c:vtype}}",
                "{{c:system}}"
            ],
            // Statistics
            stats: [
                "{{avglvl}}",
                "{{rating}}",
                "{{xeff}}",
                "{{xwn6}}",
                "{{xwn8}}",
                "{{eff}}",
                "{{wn6}}",
                "{{wn8}}",
                //"{{e}}",
                //"{{teff}}",
                //"{{tdb}}",
                //"{{tdv}}",
                //"{{tfb}}",
                //"{{tsb}}",
                "{{kb}}",
                "{{battles}}",
                "{{wins}}",
                "{{rating:3}}",
                "{{eff:4}}",
                "{{kb:3}}",
                "{{t-rating}}",
                "{{t-kb}}",
                "{{t-kb-0}}",
                "{{t-hb}}",
                "{{t-battles}}",
                "{{t-wins}}",
                "{{t-rating:3}}",
                "{{t-kb:4}}",
                "{{t-hb:3}}",
                "{{t-battles:4}}"
            ],
            colors_stat: [
                "{{c:xeff}}",
                "{{c:xwn6}}",
                "{{c:xwn8}}",
                "{{c:eff}}",
                "{{c:wn6}}",
                "{{c:wn8}}",
                "{{c:rating}}",
                "{{c:t-rating}}",
                "{{c:t-battles}}",
                "{{c:kb}}"
            ],
            // Dynamic transparency macros:
            transparency: [
                "{{a:hp}}",
                "{{a:hp-ratio}}"
            ]
        };
    }

}
