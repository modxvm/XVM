class net.wargaming.notification.FadingMessageRenderer extends gfx.core.UIComponent
{
    var _data, initialized, __get__data, __set__data, _alpha, tabChildren, tabEnabled, textField, _yscale, _xscale, _height, dispatchEvent, _intervalID, tweenEnd, removeMovieClip, tweenTo;
    function FadingMessageRenderer()
    {
        super();
    } // End of the function
    function get data()
    {
        return (_data);
    } // End of the function
    function set data(value)
    {
        if (_data == value)
        {
            return;
        } // end if
        _data = value;
        if (initialized)
        {
            this.populateData(_data);
        } // end if
        //return (this.data());
        null;
    } // End of the function
    function setData(data)
    {
        this.__set__data(data);
    } // End of the function
    function startShow()
    {
        if (!_shown)
        {
            _shown = true;
            _alpha = 100;
            this.startVisibleLife();
        } // end if
        return (_shown);
    } // End of the function
    function configUI()
    {
        tabEnabled = tabChildren = false;
        textField.wordWrap = true;
        textField.autoSize = true;
        gfx.motion.Tween.init();
        if (_data)
        {
            this.populateData(_data);
        } // end if
        super.configUI();
    } // End of the function
    function draw()
    {
        _xscale = _yscale = 100;
        _height = textField._height;
        this.dispatchEvent({type: "drawRenderer"});
    } // End of the function
    function close()
    {
        clearInterval(_intervalID);
        delete this._intervalID;
        this.tweenEnd();
        this.removeMovieClip();
    } // End of the function
    function populateData(initData)
    {
        textField.text = String(initData);
    } // End of the function
    function startVisibleLife()
    {
        clearInterval(_intervalID);
        delete this._intervalID;
        if (_lifeTime > 0)
        {
            _intervalID = setInterval(this, "stopVisibleLife", _lifeTime * 1000);
        } // end if
    } // End of the function
    function stopVisibleLife()
    {
        clearInterval(_intervalID);
        delete this._intervalID;
        if (_alphaSpeed > 0)
        {
            this.tweenTo(_alphaSpeed, {_alpha: 0}, mx.transitions.easing.None.easeNone);
        }
        else
        {
            _alpha = 0;
        } // end else if
    } // End of the function
    var _lifeTime = 0;
    var _alphaSpeed = 0;
    var _shown = false;
} // End of Class
