class net.wargaming.managers.Localization
{
    function Localization()
    {
    } // End of the function
    static function gold(value)
    {
        return (String(flash.external.ExternalInterface.call("WG.getGoldFormat", net.wargaming.managers.Localization.getNumber(value))));
    } // End of the function
    static function integer(value)
    {
        return (String(flash.external.ExternalInterface.call("WG.getIntegralFormat", net.wargaming.managers.Localization.getNumber(value))));
    } // End of the function
    static function float(value)
    {
        return (String(flash.external.ExternalInterface.call("WG.getFractionalFormat", net.wargaming.managers.Localization.getNumber(value))));
    } // End of the function
    static function niceNumber(value)
    {
        return (String(flash.external.ExternalInterface.call("WG.getNiceNumberFormat", net.wargaming.managers.Localization.getNumber(value))));
    } // End of the function
    static function shortTime(value)
    {
        return (String(flash.external.ExternalInterface.call("WG.getShortTimeFormat", net.wargaming.managers.Localization.getDate(value))));
    } // End of the function
    static function longTime(value)
    {
        return (String(flash.external.ExternalInterface.call("WG.getLongTimeFormat", net.wargaming.managers.Localization.getDate(value))));
    } // End of the function
    static function shortDate(value)
    {
        return (String(flash.external.ExternalInterface.call("WG.getShortDateFormat", net.wargaming.managers.Localization.getDate(value))));
    } // End of the function
    static function longDate(value)
    {
        return (String(flash.external.ExternalInterface.call("WG.getLongDateFormat", net.wargaming.managers.Localization.getDate(value))));
    } // End of the function
    static function getDate(value)
    {
        if (value instanceof Date)
        {
            value = value.getTime();
        } // end if
        return (net.wargaming.managers.Localization.getNumber(value));
    } // End of the function
    static function getNumber(value)
    {
        return (Number(value));
    } // End of the function
} // End of Class
