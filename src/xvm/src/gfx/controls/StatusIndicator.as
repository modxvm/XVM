class gfx.controls.StatusIndicator extends gfx.core.UIComponent
{
    var __get__maximum, __get__minimum, __get__value, __set__value, __get__position, _name, tabEnabled, sizeIsInvalid, __width, _width, __height, _height, _disabled, _totalframes, gotoAndStop, __set__maximum, __set__minimum, __set__position;
    function StatusIndicator()
    {
        super();
    } // End of the function
    function get maximum()
    {
        return (_maximum);
    } // End of the function
    function set maximum(value)
    {
        if (_maximum == value)
        {
            return;
        } // end if
        _maximum = value;
        this.updatePosition();
        //return (this.maximum());
        null;
    } // End of the function
    function get minimum()
    {
        return (_minimum);
    } // End of the function
    function set minimum(value)
    {
        if (_minimum == value)
        {
            return;
        } // end if
        _minimum = value;
        this.updatePosition();
        //return (this.minimum());
        null;
    } // End of the function
    function get value()
    {
        return (_value);
    } // End of the function
    function set value(value)
    {
        var _loc2 = Math.max(_minimum, Math.min(_maximum, value));
        if (_value == _loc2)
        {
            return;
        } // end if
        _value = _loc2;
        this.updatePosition();
        //return (this.value());
        null;
    } // End of the function
    function get position()
    {
        return (_value);
    } // End of the function
    function set position(value)
    {
        this.__set__value(value);
        //return (this.position());
        null;
    } // End of the function
    function toString()
    {
        return ("[Scaleform StatusIndicator " + _name + "]");
    } // End of the function
    function configUI()
    {
        super.configUI();
        tabEnabled = false;
    } // End of the function
    function draw()
    {
        if (sizeIsInvalid)
        {
            _width = __width;
            _height = __height;
        } // end if
        this.updatePosition();
    } // End of the function
    function updatePosition()
    {
        if (_disabled)
        {
            return;
        } // end if
        var _loc2 = (_value - _minimum) / (_maximum - _minimum);
        this.gotoAndStop(Math.max(1, Math.round(_loc2 * _totalframes)));
    } // End of the function
    var _maximum = 10;
    var _minimum = 0;
    var _value = 0;
} // End of Class
