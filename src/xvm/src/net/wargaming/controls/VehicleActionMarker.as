class net.wargaming.controls.VehicleActionMarker extends gfx.core.UIComponent
{
    var invalidate, gotoAndStop;
    function VehicleActionMarker()
    {
        super();
    } // End of the function
    function get action()
    {
        return (__actionBitMask);
    } // End of the function
    function set action(bitMask)
    {
        if (__actionBitMask == bitMask)
        {
            return;
        } // end if
        __actionBitMask = bitMask;
        this.invalidate();
        //return (this.action());
        //null;
    } // End of the function
    function get team()
    {
        return (__team);
    } // End of the function
    function set team(value)
    {
        if (__team == value)
        {
            return;
        } // end if
        __team = value;
        this.invalidate();
        //return (this.team());
        //null;
    } // End of the function
    function draw()
    {
        super.draw();
        var _loc3 = net.wargaming.managers.VehicleActionManager.getActions(__team, __actionBitMask);
        if (_loc3.length)
        {
			var all = net.wargaming.managers.VehicleActionManager.allActions;
            for (var a in all)
            {
				this.action = a;
                if (this[this.action] != null)
                {
                    this[this.action]._visible = false;
                } // end if
            } // end of for...in
            for (var a in _loc3)
            {
				this.action = a;
                if (this[this.action] != null)
                {
                    this[this.action]._visible = true;
                } // end if
            } // end of for...in
            this.gotoAndStop("actions");
        }
        else
        {
            this.gotoAndStop(1);
        } // end else if
    } // End of the function
    var __actionBitMask = 0;
    var __team = "common";
} // End of Class
