class gfx.controls.UILoader extends gfx.core.UIComponent
{
    var invalidate, _source, contentHolder, bytesTotal, bytesLoaded, onEnterFrame, loader, _name, initSize, bg, initialized, visible, createEmptyMovieClip, __width, __height, dispatchEvent, _visible;
    function UILoader()
    {
        super();
    } // End of the function
    function get autoSize()
    {
        return (_autoSize);
    } // End of the function
    function set autoSize(value)
    {
        _autoSize = value;
        this.invalidate();
        //return (this.autoSize());
        //null;
    } // End of the function
    function get source()
    {
        return (_source);
    } // End of the function
    function set source(value)
    {
        if (value == "")
        {
            return;
        } // end if
        this.load(value);
        //return (this.source());
        //null;
    } // End of the function
    function get maintainAspectRatio()
    {
        return (_maintainAspectRatio);
    } // End of the function
    function set maintainAspectRatio(value)
    {
        _maintainAspectRatio = value;
        this.invalidate();
        //return (this.maintainAspectRatio());
        //null;
    } // End of the function
    function get content()
    {
        return (contentHolder);
    } // End of the function
    function get percentLoaded()
    {
        if (bytesTotal == 0 || _source == null)
        {
            return (0);
        } // end if
        return (bytesLoaded / bytesTotal * 100);
    } // End of the function
    function unload()
    {
        onEnterFrame = null;
        if (contentHolder != null)
        {
            loader.removeListener(this);
            contentHolder.removeMovieClip();
            contentHolder = null;
        } // end if
    } // End of the function
    function toString()
    {
        return ("[Scaleform UILoader " + _name + "]");
    } // End of the function
    function configUI()
    {
        super.configUI();
        this.initSize();
        bg.swapDepths(100);
        bg.removeMovieClip();
        if (!contentHolder && _source)
        {
            this.load(_source);
        } // end if
    } // End of the function
    function load(url)
    {
        if (url == "" && url != _source)
        {
            return;
        } // end if
        this.unload();
        _source = url;
        if (!initialized)
        {
            return;
        } // end if
        _visiblilityBeforeLoad = visible;
        this.__set__visible(false);
        contentHolder = this.createEmptyMovieClip("contentHolder", 1);
        loader = new MovieClipLoader();
        loader.addListener(this);
        loader.loadClip(_source, contentHolder);
        onEnterFrame = checkProgress;
    } // End of the function
    function draw()
    {
        contentHolder._xscale = contentHolder._yscale = 100;
        if (!_autoSize || contentHolder._width <= 0)
        {
            return;
        } // end if
        if (_maintainAspectRatio)
        {
            contentHolder._xscale = contentHolder._yscale = Math.min(this.__get__height() / contentHolder._height, this.__get__width() / contentHolder._width) * 100;
            contentHolder._x = __width - contentHolder._width >> 1;
            contentHolder._y = __height - contentHolder._height >> 1;
        }
        else
        {
            contentHolder._width = __width;
            contentHolder._height = __height;
        } // end else if
    } // End of the function
    function onLoadError()
    {
        this.dispatchEvent({type: "ioError"});
    } // End of the function
    function onLoadComplete()
    {
        onEnterFrame = null;
        this.draw();
        _visible = _visiblilityBeforeLoad;
        this.dispatchEvent({type: "complete"});
    } // End of the function
    function checkProgress()
    {
        var _loc2 = loader.getProgress(contentHolder);
        bytesLoaded = _loc2.bytesLoaded;
        bytesTotal = _loc2.bytesTotal;
        if (bytesTotal < 5)
        {
            return;
        } // end if
        this.dispatchEvent({type: "progress", loaded: this.__get__percentLoaded()});
    } // End of the function
    var _maintainAspectRatio = true;
    var _autoSize = true;
    var _visiblilityBeforeLoad = true;
} // End of Class
