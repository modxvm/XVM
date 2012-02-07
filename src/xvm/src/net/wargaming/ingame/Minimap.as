class net.wargaming.ingame.Minimap extends gfx.core.UIComponent
{
    var constraints, foregroundHR, sizeIsInvalid, __width, _width, __height, _height, foreground, _xscale, _yscale, _parent, __get__visible, setSize, _alpha, __set__visible, visible, _x, _y, mapHit;
    function Minimap()
    {
        super();
        Mouse.addListener(this);
        constraints = new gfx.utils.Constraints();
    } // End of the function
    function configUI()
    {
        foregroundHR._visible = false;
        gfx.io.GameDelegate.addCallBack("minimap.sizeUp", this, "sizeUp");
        gfx.io.GameDelegate.addCallBack("minimap.sizeDown", this, "sizeDown");
        gfx.io.GameDelegate.addCallBack("minimap.visible", this, "setVisible");
        gfx.io.GameDelegate.addCallBack("minimap.setupSize", this, "setupSize");
        gfx.io.GameDelegate.addCallBack("minimap.setupAlpha", this, "setupAlpha");
    } // End of the function
    function draw()
    {
        if (sizeIsInvalid)
        {
            _width = __width;
            _height = __height;
            foregroundHR._visible = __width > net.wargaming.ingame.Minimap.MINIMAP_SIZE;
            foreground._visible = !foregroundHR._visible;
            this.updatePlayerMessangersPanel();
            if (_xscale != _yscale)
            {
                _xscale = _yscale;
            } // end if
        } // end if
    } // End of the function
    function updatePlayerMessangersPanel(stageHeight)
    {
        if (stageHeight == null)
        {
            stageHeight = Stage.height;
        } // end if
        if (foreground._visible)
        {
            _parent.playerMessangersPanel._y = stageHeight - __height + 5;
        }
        else
        {
            _parent.playerMessangersPanel._y = stageHeight - __height + int(8 * _yscale / 100);
        } // end else if
    } // End of the function
    function setupSize(size, stageHeight)
    {
        if (this.__get__visible())
        {
            sizeIndex = this.correctSizeIndex(size, stageHeight);
            var _loc2 = net.wargaming.ingame.Minimap.MINIMAP_SIZE + sizeIndex * net.wargaming.ingame.Minimap.MINIMAP_STEP;
            this.setSize(_loc2, _loc2);
        } // end if
    } // End of the function
    function setupAlpha(mAlpha)
    {
        _alpha = 100 - mAlpha;
    } // End of the function
    function correctSizeIndex(sizeIndex, stageHeight)
    {
        var _loc3 = int(net.wargaming.ingame.Minimap.MINIMAP_SIZE + sizeIndex * net.wargaming.ingame.Minimap.MINIMAP_STEP);
        if (stageHeight == null)
        {
            stageHeight = Stage.height;
        } // end if
        if (_loc3 < net.wargaming.ingame.Minimap.MINIMAP_SIZE)
        {
            return (0);
        } // end if
        var _loc2 = stageHeight - _parent.rightPanel.getHeight() - _parent.rightPanel._y;
        if (_loc3 > _loc2)
        {
            return (int((_loc2 - net.wargaming.ingame.Minimap.MINIMAP_SIZE) / net.wargaming.ingame.Minimap.MINIMAP_STEP));
        } // end if
        return (sizeIndex);
    } // End of the function
    function sizeUp()
    {
        if (this.__get__visible())
        {
            var _loc2 = this.correctSizeIndex(sizeIndex + 1);
            gfx.io.GameDelegate.call("minimap.setSize", [_loc2]);
        } // end if
    } // End of the function
    function sizeDown()
    {
        if (this.__get__visible())
        {
            var _loc2 = this.correctSizeIndex(sizeIndex - 1);
            gfx.io.GameDelegate.call("minimap.setSize", [_loc2]);
        } // end if
    } // End of the function
    function setVisible()
    {
        this.__set__visible(!this.__get__visible());
        _root.g_components.minimap = visible;
    } // End of the function
    function onRecreateDevice(w, h)
    {
        this.setupSize(sizeIndex, h);
        this.updatePlayerMessangersPanel(h);
        _x = w;
        _y = h;
    } // End of the function
    function onMouseDown(button, target)
    {
		/* fix decompiler errors (sirmax2)
        if (target == mapHit && (button == 1 || button == 2))
        {
            gfx.io.GameDelegate.call("minimap.onClick", [mapHit._xmouse, mapHit._ymouse, button == Mouse.LEFT]);
        } // end if
		*/
    } // End of the function
    static var MINIMAP_SIZE = 231;
    static var MINIMAP_STEP = 50;
    var sizeIndex = 0;
} // End of Class
