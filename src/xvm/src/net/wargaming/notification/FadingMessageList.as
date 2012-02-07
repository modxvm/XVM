class net.wargaming.notification.FadingMessageList extends gfx.core.UIComponent
{
    var __get__stackLength, __get__direction, __get__messageLifeTime, __get__messageAlphaSpeed, _renderers, getNextHighestDepth, attachMovie, invalidate, __set__direction, __set__messageAlphaSpeed, __set__messageLifeTime, __set__stackLength;
    function FadingMessageList()
    {
        super();
    } // End of the function
    function get stackLength()
    {
        return (_stackLength);
    } // End of the function
    function set stackLength(value)
    {
        if (_stackLength == value)
        {
            return;
        } // end if
        _stackLength = value;
        //return (this.stackLength());
        null;
    } // End of the function
    function get direction()
    {
        return (_direction);
    } // End of the function
    function set direction(value)
    {
        if (_direction == value)
        {
            return;
        } // end if
        _direction = value;
        //return (this.direction());
        null;
    } // End of the function
    function get messageLifeTime()
    {
        return (_lifeTime);
    } // End of the function
    function set messageLifeTime(value)
    {
        if (_lifeTime == value)
        {
            return;
        } // end if
        _lifeTime = value;
        //return (this.messageLifeTime());
        null;
    } // End of the function
    function get messageAlphaSpeed()
    {
        return (_alphaSpeed);
    } // End of the function
    function set messageAlphaSpeed(value)
    {
        if (_alphaSpeed == value)
        {
            return;
        } // end if
        _alphaSpeed = value;
        //return (this.messageAlphaSpeed());
        null;
    } // End of the function
    function pushMessage(messageData)
    {
        _renderers.unshift(this.createItemRenderer(messageData, _renderers.length));
    } // End of the function
    function clear()
    {
        while (_renderers.length)
        {
            _renderers.pop().close();
        } // end while
    } // End of the function
    function configUI()
    {
        _renderers = [];
        super.configUI();
    } // End of the function
    function draw()
    {
        var _loc6 = _renderers.length;
        var _loc4 = 0;
        for (var _loc3 = 0; _loc6 > _loc3; ++_loc3)
        {
            var _loc2 = (MovieClip)(_renderers[_loc3]);
            if (_stackLength == _loc3 || _loc2._alpha == 0)
            {
                break;
            } // end if
            if (_direction == "up")
            {
                _loc4 = _loc4 - _loc2._height;
            } // end if
            _loc2._y = _loc4;
            if (_direction == "down")
            {
                _loc4 = _loc4 + _loc2._height;
            } // end if
            _loc2.startShow();
        } // end of for
        var _loc5 = _renderers.splice(_loc3);
        while (_loc5.length)
        {
            _loc5.pop().close();
        } // end while
    } // End of the function
    function getItemRenderer(messageData)
    {
        return (_itemRenderer);
    } // End of the function
    function createItemRenderer(messageData, index)
    {
        index = this.getNextHighestDepth();
        var _loc2 = this.attachMovie(this.getItemRenderer(messageData), "renderer" + index, index, {_x: 0, _y: 0, _lifeTime: _lifeTime, _alphaSpeed: _alphaSpeed, _alpha: 0.010000});
        if (_loc2 == null)
        {
            return (null);
        } // end if
        _loc2.addEventListener("drawRenderer", this, "onDrawRenderer");
        _loc2.setData(messageData);
        return (_loc2);
    } // End of the function
    function onDrawRenderer(event)
    {
        this.invalidate();
    } // End of the function
    var _itemRenderer = "";
    var _stackLength = -1;
    var _direction = "up";
    var _lifeTime = 0;
    var _alphaSpeed = 0;
} // End of Class
