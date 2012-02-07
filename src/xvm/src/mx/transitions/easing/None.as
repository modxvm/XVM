class mx.transitions.easing.None
{
    function None()
    {
    } // End of the function
    static function easeNone(t, b, c, d)
    {
        return (c * t / d + b);
    } // End of the function
    static function easeIn(t, b, c, d)
    {
        return (c * t / d + b);
    } // End of the function
    static function easeOut(t, b, c, d)
    {
        return (c * t / d + b);
    } // End of the function
    static function easeInOut(t, b, c, d)
    {
        return (c * t / d + b);
    } // End of the function
    static var version = "1.1.0.52";
} // End of Class
