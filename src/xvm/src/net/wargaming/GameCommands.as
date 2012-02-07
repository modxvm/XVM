class net.wargaming.GameCommands
{
    function GameCommands()
    {
    } // End of the function
    static function quit()
    {
        fscommand("WoTQuit");
    } // End of the function
    static function logoff()
    {
        fscommand("WoTLogoff");
    } // End of the function
} // End of Class
