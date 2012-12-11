import wot.Minimap.model.MapConfig;

class wot.Minimap.model.MinimapMacro
{
    public static function process(format:String, player:Object):String
    {
        if (format.indexOf("{{") == -1)
            return format;

        // TODO: format = StatFormat.FormatText({ label: m_playerFullName }, format);
        var formatArr:Array

        /** Level */
        formatArr = format.split("{{level}}");
        if (formatArr.length > 1)
            format = formatArr.join(player.level);

        /** Vehicle type */
        formatArr = format.split("{{vehicle}}");
        if (formatArr.length > 1)
            format = formatArr.join(player.vehicle);

        /** Nickname shortened */
        formatArr = format.split("{{short-nick}}");
        if (formatArr.length > 1)
        {
            var userName:String = player.userName;
            var shortNick = userName.slice(0, MapConfig.nickShrink);
            format = formatArr.join(shortNick);
        }

        return format;
    }
}