class gfx.managers.InputDelegate extends gfx.events.EventDispatcher
{
    var dispatchEvent;
    static var _instance;
    function InputDelegate()
    {
        super();
        Key.addListener(this);
    } // End of the function
    static function get instance()
    {
        if (gfx.managers.InputDelegate._instance == null)
        {
            _instance = new gfx.managers.InputDelegate();
        } // end if
        return (gfx.managers.InputDelegate._instance);
    } // End of the function
    function readInput(type, code, scope, callBack)
    {
        return (null);
    } // End of the function
    function inputToNav(type, code, value)
    {
        if (type == "key")
        {
            switch (code)
            {
                case 38:
                {
                    return (gfx.ui.NavigationCode.UP);
                } 
                case 40:
                {
                    return (gfx.ui.NavigationCode.DOWN);
                } 
                case 37:
                {
                    return (gfx.ui.NavigationCode.LEFT);
                } 
                case 39:
                {
                    return (gfx.ui.NavigationCode.RIGHT);
                } 
                case 13:
                case 32:
                {
                    return (gfx.ui.NavigationCode.ENTER);
                } 
                case 8:
                {
                    return (gfx.ui.NavigationCode.BACK);
                } 
                case 9:
                {
                    return (Key.isDown(16) ? (gfx.ui.NavigationCode.SHIFT_TAB) : (gfx.ui.NavigationCode.TAB));
                } 
                case 36:
                {
                    return (gfx.ui.NavigationCode.HOME);
                } 
                case 35:
                {
                    return (gfx.ui.NavigationCode.END);
                } 
                case 34:
                {
                    return (gfx.ui.NavigationCode.PAGE_DOWN);
                } 
                case 33:
                {
                    return (gfx.ui.NavigationCode.PAGE_UP);
                } 
                case 27:
                {
                    return (gfx.ui.NavigationCode.ESCAPE);
                } 
            } // End of switch
        } // end if
    } // End of the function
    function onKeyDown()
    {
        this.handleKeyPress("keyDown");
    } // End of the function
    function onKeyUp()
    {
        this.handleKeyPress("keyUp");
    } // End of the function
    function handleKeyPress(type)
    {
        var _loc2 = Key.getCode();
        var _loc3 = new gfx.ui.InputDetails("key", _loc2, type, this.inputToNav("key", _loc2));
        this.dispatchEvent({type: "input", details: _loc3});
    } // End of the function
} // End of Class
