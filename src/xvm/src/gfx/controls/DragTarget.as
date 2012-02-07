class gfx.controls.DragTarget extends gfx.core.UIComponent
{
    var _visible, _dragAcceptTypes, __set__dragAcceptTypes, dragAcceptTypeHash, __get__dragAcceptTypes, dispatchEvent, onDragOver, onRollOver, onDragOut, onRollOut, trackAsMenu, gotoAndStop, gotoAndPlay;
    function DragTarget()
    {
        super();
        _visible = false;
        if (_dragAcceptTypes != null)
        {
            this.__set__dragAcceptTypes(_dragAcceptTypes);
            delete this._dragAcceptTypes;
        } // end if
    } // End of the function
    function get dragAcceptTypes()
    {
        var _loc2 = [];
        for (var _loc3 in dragAcceptTypeHash)
        {
            _loc2.push(_loc3);
        } // end of for...in
        return (_loc2);
    } // End of the function
    function set dragAcceptTypes(types)
    {
        if (types == null || types.length < 1)
        {
            dragAcceptTypeHash = null;
            return;
        } // end if
        dragAcceptTypeHash = {};
        for (var _loc2 = 0; _loc2 < types.length; ++_loc2)
        {
            dragAcceptTypeHash[String(types[_loc2])] = true;
        } // end of for
        //return (this.dragAcceptTypes());
        null;
    } // End of the function
    function allowDrop(data)
    {
        return (data == null || dragAcceptTypeHash == null || dragAcceptTypeHash[data.type] || dragAcceptTypeHash["*"]);
    } // End of the function
    function acceptDrop(data)
    {
        this.dispatchEvent({type: "drop", data: data});
    } // End of the function
    function configUI()
    {
        super.configUI();
        gfx.managers.DragManager.__get__instance().addEventListener("dragBegin", this, "dragBegin");
        gfx.managers.DragManager.__get__instance().addEventListener("dragEnd", this, "dragEnd");
        onRollOver = onDragOver = handleRollOver;
        onRollOut = onDragOut = handleRollOut;
    } // End of the function
    function dragBegin(event)
    {
        if (!this.allowDrop(event.data))
        {
            return;
        } // end if
        trackAsMenu = _visible = true;
        this.gotoAndStop("up");
        this.gotoAndStop("dragUp");
    } // End of the function
    function dragEnd(event)
    {
        trackAsMenu = _visible = false;
        this.gotoAndStop("dragUp");
        this.gotoAndStop("up");
        if (event.dropTarget == this && !event.cancelled)
        {
            this.acceptDrop(event.data);
        } // end if
    } // End of the function
    function handleRollOver(mouseIndex)
    {
        this.gotoAndPlay("over");
        if (trackAsMenu)
        {
            this.gotoAndPlay("dragOver");
        } // end if
        gfx.managers.DragManager.__get__instance().dropTarget = this;
    } // End of the function
    function handleRollOut(mouseIndex)
    {
        this.gotoAndPlay("up");
        this.gotoAndPlay("out");
        if (trackAsMenu)
        {
            this.gotoAndStop("dragUp");
            this.gotoAndPlay("dragOut");
            gfx.managers.DragManager.__get__instance().dropTarget = null;
        } // end if
    } // End of the function
} // End of Class
