class net.wargaming.ingame.BattleFadingMessageList extends net.wargaming.notification.FadingMessageList
{
    var _renderersCollection, initialized, __get__renderersCollection, __get__externalPrefix, __set__stackLength, __set__direction, __set__messageLifeTime, __set__messageAlphaSpeed, _renderers, pushMessage, __set__externalPrefix, __set__renderersCollection;
    function BattleFadingMessageList()
    {
        super();
    } // End of the function
    function get renderersCollection()
    {
        return (_renderersCollection);
    } // End of the function
    function set renderersCollection(collection)
    {
        _renderersCollection = collection;
        if (initialized)
        {
            this.buildRendererMap();
        } // end if
        //return (this.renderersCollection());
        null;
    } // End of the function
    function get externalPrefix()
    {
        return (_externalPrefix);
    } // End of the function
    function set externalPrefix(value)
    {
        if (_externalPrefix == value)
        {
            return;
        } // end if
        gfx.io.GameDelegate.removeCallBack("battle." + _externalPrefix + ".RefreshUI", this, "onRefreshUI");
        gfx.io.GameDelegate.removeCallBack("battle." + _externalPrefix + ".ShowMessage", this, "onShowMessage");
        _externalPrefix = value;
        gfx.io.GameDelegate.addCallBack("battle." + _externalPrefix + ".RefreshUI", this, "onRefreshUI");
        gfx.io.GameDelegate.addCallBack("battle." + _externalPrefix + ".ShowMessage", this, "onShowMessage");
        //return (this.externalPrefix());
        null;
    } // End of the function
    function configUI()
    {
        this.buildRendererMap();
        super.configUI();
    } // End of the function

    function buildRendererMap()
    {
        var debugData = "";

        var iterator = _renderersCollection.getIterator();
        _renderersColorMap = {};
        while (iterator.hasNext())
        {
            var element = iterator.next();
            _renderersColorMap[element.colorAlias] = element.renderer;
        } // end while
    } // End of the function

    function getItemRenderer(messageData)
    {
        var _loc2 = _renderersColorMap[messageData.color];
        return (_loc2 != undefined && _loc2 != "" ? (_loc2) : (_defaultRenderer));
    } // End of the function
    function onRefreshUI()
    {
        function onEnterFrame()
        {
            gfx.io.GameDelegate.call("battle." + _externalPrefix + ".PopulateUI", [], this, "onPopulateUI");
            delete this.onEnterFrame;
        } // End of the function
    } // End of the function
    function onPopulateUI(maxLinesCount, direction, lifeTime, alphaSpeed, showUniqueOnly)
    {
        this.__set__stackLength(maxLinesCount);
        this.__set__direction(direction);
        this.__set__messageLifeTime(lifeTime);
        this.__set__messageAlphaSpeed(alphaSpeed);
        _showUniqueOnly = showUniqueOnly;
    } // End of the function
    function onShowMessage(key, message, color)
    {
        var _loc3 = false;
        if (_showUniqueOnly)
        {
            var _loc4 = _renderers.length;
            for (var _loc2 = 0; _loc4 > _loc2; ++_loc2)
            {
                if (_renderers[_loc2].data.key == key && _renderers[_loc2]._alpha > 0)
                {
                    _loc3 = true;
                    break;
                } // end if
            } // end of for
        } // end if
        if (!_loc3)
        {
            var _loc5 = {key: key, text: message, color: color};
            this.pushMessage(_loc5);
        } // end if
    } // End of the function
    var _renderersColorMap = {};
    var _defaultRenderer = "";
    var _externalPrefix = "";
    var _showUniqueOnly = false;
} // End of Class
