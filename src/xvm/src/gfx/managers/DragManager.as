class gfx.managers.DragManager extends gfx.events.EventDispatcher
{
    var eventProvider, _data, _target, pressOrigin, pressOriginTrackAsMenu, relatedObject, dispatchEvent, __get__inDrag, __get__data, __get__target;
    static var _instance, __get__instance;
    function DragManager()
    {
        super();
        gfx.managers.InputDelegate.__get__instance().addEventListener("input", this, "handleInput");
        eventProvider = _root;
    } // End of the function
    static function get instance()
    {
        if (gfx.managers.DragManager._instance == null)
        {
            _instance = new gfx.managers.DragManager();
        } // end if
        return (gfx.managers.DragManager._instance);
    } // End of the function
    function get inDrag()
    {
        return (_inDrag);
    } // End of the function
    function get data()
    {
        return (_data);
    } // End of the function
    function get target()
    {
        return (_target);
    } // End of the function
    function startDrag(pressOrigin, avatar, data, relatedObject, alignmentTarget, lockCenter, left, top, right, bottom)
    {
        if (pressOrigin == null)
        {
            return;
        } // end if
        removeTarget = false;
        var _loc2;
        if (avatar instanceof MovieClip)
        {
            _loc2 = (MovieClip)(avatar);
        }
        else if (avatar == null)
        {
            _loc2 = null;
        }
        else
        {
            _loc2 = gfx.managers.PopUpManager.createPopUp(pressOrigin, String(avatar), {_x: pressOrigin._xmouse, _y: pressOrigin._ymouse}, pressOrigin);
            if (_loc2 != null)
            {
                removeTarget = true;
            } // end else if
        } // end else if
        _target = _loc2;
        if (alignmentTarget != null && alignmentTarget != _loc2 && _loc2 != null)
        {
            var _loc4 = {x: 0, y: 0};
            alignmentTarget.localToGlobal(_loc4);
            _loc2._parent.globalToLocal(_loc4);
            _loc2._x = _loc4.x;
            _loc2._y = _loc4.y;
        } // end if
        this.initiateDrag(data, relatedObject);
        if (pressOrigin != null)
        {
            this.pressOrigin = pressOrigin;
            pressOriginTrackAsMenu = pressOrigin.trackAsMenu;
            pressOrigin.trackAsMenu = true;
        } // end if
        if (_loc2 != null)
        {
            dragOffsetX = lockCenter ? (0) : (-_loc2._xmouse);
            dragOffsetY = lockCenter ? (0) : (-_loc2._ymouse);
        } // end if
        var _loc10 = this;
        eventProvider.onMouseMove = gfx.utils.Delegate.create(this, doDrag);
        eventProvider.onMouseUp = gfx.utils.Delegate.create(this, stopDrag);
        return (_target);
    } // End of the function
    function stopDrag()
    {
        this.finishDrag(false);
    } // End of the function
    function initiateDrag(data, relatedObject)
    {
        _inDrag = true;
        _data = data;
        this.relatedObject = relatedObject;
        dropTarget = null;
        this.dispatchEvent({type: "dragBegin", data: data});
    } // End of the function
    function cancelDrag()
    {
        this.finishDrag(true);
    } // End of the function
    function update()
    {
        if (this.__get__inDrag())
        {
            this.doDrag();
        } // end if
    } // End of the function
    function doDrag()
    {
        if (_target != null)
        {
            _target._x = _target._parent._xmouse + dragOffsetX;
            _target._y = _target._parent._ymouse + dragOffsetY;
        } // end if
    } // End of the function
    function finishDrag(cancelled)
    {
        if (!_inDrag)
        {
            return;
        } // end if
        if (pressOrigin != null)
        {
            pressOrigin.trackAsMenu = pressOriginTrackAsMenu;
        } // end if
        this.dispatchEvent({type: "dragEnd", cancelled: cancelled, data: _data, dropTarget: dropTarget});
        this.cleanUp();
    } // End of the function
    function cleanUp()
    {
        dropTarget = null;
        if (removeTarget && _target != null)
        {
            _target.removeMovieClip();
        } // end if
        _target = null;
        _data = null;
        delete eventProvider.onMouseMove;
        delete eventProvider.onMouseUp;
        dragOffsetX = dragOffsetY = 0;
        _inDrag = false;
    } // End of the function
    function handleInput(event)
    {
        if (event.details.code == cancelKeyCode)
        {
            this.cancelDrag();
        } // end if
    } // End of the function
    var removeTarget = false;
    var dragOffsetX = 0;
    var dragOffsetY = 0;
    var cancelKeyCode = 27;
    var dropTarget = null;
    var _inDrag = false;
} // End of Class
