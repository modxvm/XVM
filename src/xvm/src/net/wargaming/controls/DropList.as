class net.wargaming.controls.DropList extends net.wargaming.ScrollingList
{
    var dragTarget, _dragAcceptTypes, __set__dragAcceptTypes, _dragItem, originalAllowDropFunction, constraints, onMouseMove, dispatchItemEvent, handleItemClick, dispatchEvent, initialized, __get__dragAcceptTypes, _xmouse, _ymouse, _parent, __height, __width, __get__data;
    function DropList()
    {
        super();
        dragTarget.swapDepths(2);
        if (_dragAcceptTypes != null)
        {
            this.__set__dragAcceptTypes(_dragAcceptTypes);
            delete this._dragAcceptTypes;
        } // end if
    } // End of the function
    function get data()
    {
        return (_dragItem.data);
    } // End of the function
    function configUI()
    {
        super.configUI();
        dragTarget.addEventListener("drop", this, "propagateEvent");
        dragTarget.acceptDrop = gfx.utils.Delegate.create(this, acceptDrop);
        originalAllowDropFunction = dragTarget.allowDrop;
        dragTarget.allowDrop = gfx.utils.Delegate.create(this, allowDrop);
        dragTarget.__set__dragAcceptTypes(_dragAcceptTypes);
        constraints = new gfx.utils.Constraints(this, true);
        constraints.addElement(dragTarget, gfx.utils.Constraints.ALL);
    } // End of the function
    function setUpRenderer(clip)
    {
        clip.owner = this;
        clip.tabEnabled = false;
        clip.doubleClickEnabled = true;
        clip.addEventListener("press", this, "handlePress");
        clip.addEventListener("click", this, "handleRelease");
        clip.addEventListener("doubleClick", this, "dispatchItemEvent");
        clip.addEventListener("rollOver", this, "dispatchItemEvent");
        clip.addEventListener("rollOut", this, "dispatchItemEvent");
    } // End of the function
    function handlePress(event)
    {
        if (event.mouseIndex != null)
        {
            _dragItem = event.target;
            onMouseMove = beginDrag;
        } // end if
        this.dispatchItemEvent(event);
    } // End of the function
    function handleRelease(event)
    {
        delete this.onMouseMove;
        this.handleItemClick(event);
    } // End of the function
    function propagateEvent(event)
    {
        if (event.target != dragTarget)
        {
            return;
        } // end if
        event.target = this;
        this.dispatchEvent(event);
    } // End of the function
    function get dragAcceptTypes()
    {
        return (_dragAcceptTypes);
    } // End of the function
    function set dragAcceptTypes(value)
    {
        _dragAcceptTypes = value;
        if (initialized)
        {
            dragTarget.__set__dragAcceptTypes(value);
        } // end if
        //return (this.dragAcceptTypes());
        null;
    } // End of the function
    function acceptDrop(data)
    {
        this.dispatchEvent({type: "drop", data: data});
    } // End of the function
    function allowDrop(data)
    {
        return (originalAllowDropFunction.call(dragTarget, data));
    } // End of the function
    function beginDrag()
    {
        if (_dragItem != null && _dragItem.data != null)
        {
            gfx.managers.DragManager.__get__instance().addEventListener("dragEnd", this, "dragEnd");
            _dragItem._alpha = 30;
            delete this.onMouseMove;
            gfx.managers.DragManager.__get__instance().stopDrag();
            var _loc3 = gfx.managers.PopUpManager.createPopUp(_parent, "PlayerElement", {_x: _xmouse, _y: _ymouse}, this);
            var _loc2 = gfx.managers.DragManager.__get__instance().startDrag(_dragItem, _loc3, _dragItem.data, this, _dragItem);
            gfx.managers.DragManager.__get__instance().removeTarget = true;
            _loc2.setData(_dragItem.data);
        } // end if
    } // End of the function
    function dragEnd(event)
    {
        _dragItem._alpha = 100;
        if (event.dropTarget == this && !event.cancelled)
        {
            this.acceptDrop(event.data);
        } // end if
        delete this._dragItem;
    } // End of the function
    function draw()
    {
        super.draw();
        constraints.update(__width, __height);
    } // End of the function
} // End of Class
