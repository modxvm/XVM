class net.wargaming.controls.Window extends gfx.core.UIComponent
{
    var resizeBtn, titleBtn, invalidate, __get__formSource, __get__title, __get__icon, __get__allowResize, __get__allowDrag, __get__showClose, _name, background, hit, constraints, iconMovie, closeBtn, getNextHighestDepth, modalBackground, createEmptyMovieClip, waiting, target, owner, message, _width, _height, waiting_fade_in_id, __get__isWaiting, __set__focused, __width, __height, form, __set__visible, loader, attachMovie, dispatchEvent, _maxWidth, _minWidth, _maxHeight, _minHeight, setSize, startDrag, stopDrag, _parent, dragProps, onMouseMove, updateIntervalID, unloadMovie, _focused, focus_element, __set__allowDrag, __set__allowResize, __set__formSource, __set__icon, __set__showClose, __set__title;
    function Window()
    {
        super();
        if (Mouse.useResizeCursor)
        {
            Mouse.useResizeCursor(resizeBtn);
        } // end if
        if (Mouse.useDragCursor)
        {
            Mouse.useDragCursor(titleBtn);
        } // end if
        _global.gfxExtensions = true;
        Mouse.addListener(this);
        if (titleBtn)
        {
            titleBtn.handleKeyboard = false;
        } // end if
    } // End of the function
    function get formSource()
    {
        return (_formSource);
    } // End of the function
    function set formSource(value)
    {
        _formSource = value;
        formCreated = false;
        this.invalidate();
        //return (this.formSource());
        null;
    } // End of the function
    function get title()
    {
        return (_title);
    } // End of the function
    function set title(value)
    {
        var _loc3 = _root.createTextField("convertingTextField", _root.getNextHighestDepth(), -1000, -1000, 1, 1);
        _loc3.text = value;
        value = _root.convertingTextField.text;
        _loc3.removeTextField();
        _title = value;
        this.invalidate();
        //return (this.title());
        null;
    } // End of the function
    function get icon()
    {
        return (_icon);
    } // End of the function
    function set icon(value)
    {
        _icon = value;
        this.invalidate();
        //return (this.icon());
        null;
    } // End of the function
    function get allowResize()
    {
        return (_allowResize);
    } // End of the function
    function set allowResize(value)
    {
        _allowResize = value;
        this.invalidate();
        //return (this.allowResize());
        null;
    } // End of the function
    function get allowDrag()
    {
        return (_allowDrag);
    } // End of the function
    function set allowDrag(value)
    {
        _allowDrag = value;
        this.invalidate();
        //return (this.allowDrag());
        null;
    } // End of the function
    function get showClose()
    {
        return (_showClose);
    } // End of the function
    function set showClose(value)
    {
        _showClose = value;
        this.invalidate();
        //return (this.showClose());
        null;
    } // End of the function
    function toString()
    {
        return ("[Wargaming Window " + _name + "]");
    } // End of the function
    function configUI()
    {
        background.hitTestDisable = true;
        hit.tabEnabled = hit.focusEnabled = false;
        hit.useHandCursor = false;
        hit.onPress = function ()
        {
            return (true);
        };
        hit.onRelease = function ()
        {
            return (true);
        };
        super.configUI();
        constraints = new gfx.utils.Constraints(this);
        constraints.addElement(titleBtn, gfx.utils.Constraints.LEFT | gfx.utils.Constraints.RIGHT);
        constraints.addElement(iconMovie, gfx.utils.Constraints.LEFT);
        constraints.addElement(closeBtn, gfx.utils.Constraints.RIGHT);
        constraints.addElement(background, gfx.utils.Constraints.ALL);
        constraints.addElement(hit, gfx.utils.Constraints.ALL);
        if (titleBtn)
        {
            titleBtn.addEventListener("press", this, "handleTitleDragStart");
            titleBtn.addEventListener("click", this, "handleTitleDragStop");
            titleBtn.addEventListener("click", this, "onTitleBtnClick");
            titleBtn.addEventListener("releaseOutside", this, "handleTitleDragStop");
        } // end if
        if (resizeBtn)
        {
            resizeBtn.addEventListener("press", this, "handleResizeDragStart");
            resizeBtn.addEventListener("click", this, "handleResizeDragStop");
            resizeBtn.addEventListener("releaseOutside", this, "handleResizeDragStop");
        } // end if
        if (closeBtn)
        {
            closeBtn.addEventListener("click", this, "handleClose");
        } // end if
    } // End of the function
    function __waiting_fade_in(target)
    {
        if (target.waiting._alpha >= 100)
        {
            target.waiting._alpha = 100;
            clearInterval(target.waiting_fade_in_id);
        } // end if
        target.waiting._alpha = target.waiting._alpha + 4;
    } // End of the function
    function showWaiting(msg, props)
    {
        this.hideWaiting();
        var _loc4 = props.type || "waiting";
        var _loc2 = props.timeout;
        var _loc5 = props.color || 16777215;
        index = ++net.wargaming.controls.Window.index;
        modalBackground = gfx.core.UIComponent.createInstance(this, "PopUpModal", "modalBackground" + net.wargaming.controls.Window.index, this.getNextHighestDepth());
        if (modalBackground != null)
        {
            modalBackground._x = _offsetLeft;
            modalBackground._y = _offsetTop;
            modalBackground._width = background._width - _offsetLeft - _offsetRight;
            modalBackground._height = background._height - _offsetTop - _offsetBottom;
            modalBackground.tabEnabled = false;
            modalBackground.useHandCursor = false;
            modalBackground.onRelease = function ()
            {
            };
        } // end if
        index = ++net.wargaming.controls.Window.index;
        waiting = this.createEmptyMovieClip("waiting" + net.wargaming.controls.Window.index, this.getNextHighestDepth());
        switch (_loc4)
        {
            case "waiting":
            {
                var _loc3 = new MovieClipLoader();
                _loc3.loadClip("waiting.swf", waiting);
                _loc3.addListener({target: waiting, owner: this, message: msg, onLoadInit: function ()
                {
                    target._xscale = target._yscale = 100;
                    target._x = owner.modalBackground._width - target._width >> 1;
                    target._y = owner.modalBackground._height - target._height >> 1;
                    target.setMessage(message);
                    target._alpha = 40;
                    owner.waiting_fade_in_id = setInterval(owner.__waiting_fade_in, 10, owner);
                }});
                break;
            } 
            case "message":
            {
                index = ++net.wargaming.controls.Window.index;
                waiting.messageLabel = gfx.core.UIComponent.createInstance(waiting, "WaitingLabel", "messageLabel" + net.wargaming.controls.Window.index, waiting.getNextHighestDepth());
                waiting.messageLabel._x = _width - waiting.messageLabel._width >> 1;
                waiting.messageLabel._y = _height - waiting.messageLabel._height >> 1;
                waiting.messageLabel.textField.textColor = _loc5;
                waiting.messageLabel.textField.text = msg;
                waiting._alpha = 40;
                waiting_fade_in_id = setInterval(__waiting_fade_in, 50, this);
                break;
            } 
        } // End of switch
        if (_loc2 != undefined)
        {
            waiting.timeoutID = setTimeout(function (target)
            {
                target.hideWaiting();
            }, _loc2, this);
        } // end if
    } // End of the function
    function get isWaiting()
    {
        return (waiting != null);
    } // End of the function
    function hideWaiting()
    {
        if (!this.__get__isWaiting())
        {
            return;
        } // end if
        if (waiting_fade_in_id)
        {
            clearInterval(waiting_fade_in_id);
        } // end if
        if (waiting.timeoutID != undefined)
        {
            clearTimeout(waiting.timeoutID);
        } // end if
        if (waiting.messageLabel)
        {
            waiting.messageLabel.removeMovieClip();
        } // end if
        waiting.unloadMovie();
        waiting.removeMovieClip();
        modalBackground.removeMovieClip();
        modalBackground = null;
    } // End of the function
    function onMouseDown(button, target)
    {
        for (var _loc3 = Mouse.getTopMostEntity(false); _loc3 != null && _loc3 != _root; _loc3 = _loc3._parent)
        {
            if (_loc3 == this)
            {
                net.wargaming.managers.WindowManager.__get__instance().swapToNextHighestDepth(this);
                return;
            } // end if
        } // end of for
        this.__set__focused(false);
    } // End of the function
    function handleInput(details, path)
    {
        if (_showClose && details.navEquivalent == gfx.ui.NavigationCode.ESCAPE && details.value != "keyUp")
        {
            if (path.length == 0 || path[0].handleInput == null || path[0].handleInput(details, path.slice(1)) != true)
            {
                switch (details.navEquivalent)
                {
                    case gfx.ui.NavigationCode.ESCAPE:
                    {
                        function onEnterFrame()
                        {
                            this.handleClose();
                            delete this.onEnterFrame;
                        } // End of the function
                        return (true);
                    } 
                } // End of switch
            } // end if
        } // end if
        if (path != null && path.length > 0)
        {
            var _loc4 = path[0].handleInput(details, path.slice(1));
            if (_loc4)
            {
                return (_loc4);
            } // end if
        } // end if
        return (false);
    } // End of the function
    function draw()
    {
        if (_formSource == undefined || _formSource.length == 0)
        {
            return;
        } // end if
        if (!formCreated)
        {
            resizeBtn._ox = __width - resizeBtn._x;
            resizeBtn._oy = __height - resizeBtn._y;
            if (_formType == "swf" && !form)
            {
                this.__set__visible(false);
                if (loader)
                {
                    delete this.loader;
                } // end if
                loader = new MovieClipLoader();
                this.createEmptyMovieClip("form", this.getNextHighestDepth());
                loader.addListener(this);
                loader.loadClip(_formSource, form);
            }
            else
            {
                this.attachMovie(_formSource, "form", this.getNextHighestDepth());
                formCreated = true;
                this.configForm();
            } // end else if
            return;
        } // end if
        if (resizeBtn != null)
        {
            resizeBtn._visible = _allowResize;
            resizeBtn._x = __width - resizeBtn._ox;
            resizeBtn._y = __height - resizeBtn._oy;
        } // end if
        if (closeBtn != null)
        {
            closeBtn._visible = _showClose;
        } // end if
        if (iconMovie != null)
        {
            iconMovie.gotoAndStop(_icon);
        } // end if
        if (titleBtn != null)
        {
            if (iconMovie != null && _icon != "")
            {
                titleBtn._x = iconMovie._x + iconMovie._width - 2;
            } // end if
            titleBtn.__set__text(_title);
            titleBtn.__set__disabled(!_allowDrag);
        } // end if
        constraints.update(__width, __height);
        if (form.setSize != null)
        {
            form.setSize(__width - _offsetRight - _offsetLeft, __height - _offsetBottom - _offsetTop);
        }
        else
        {
            form._width = __width - _offsetRight - _offsetLeft;
            form._height = __height - _offsetBottom - _offsetTop;
        } // end else if
        if (form && form.validateNow)
        {
            form.validateNow();
        } // end if
        if (!__firstDrawComplete)
        {
            __firstDrawComplete = true;
            this.dispatchEvent({type: "firstDrawComplete"});
        } // end if
    } // End of the function
    function onLoadComplete()
    {
    } // End of the function
    function onLoadInit()
    {
        formCreated = true;
        this.configForm();
        this.__set__visible(true);
    } // End of the function
    function configForm()
    {
        if (!form)
        {
            return;
        } // end if
        form._x = _offsetLeft;
        form._y = _offsetTop;
        var _loc3 = form._x + form._width + _offsetRight;
        var _loc2 = form._y + form._height + _offsetBottom;
        resizeBtn._x = resizeBtn._y = 0;
        _loc3 = Math.max(_minWidth, Math.min(_maxWidth, _loc3));
        _loc2 = Math.max(_minHeight, Math.min(_maxHeight, _loc2));
        this.setSize(_loc3, _loc2);
        constraints.update(__width, __height);
        this.dispatchEvent({type: "confirmFormComplete", window: this, width: _loc3, height: _loc2});
    } // End of the function
    function handleTitleDragStart()
    {
        this.startDrag(false);
    } // End of the function
    function handleTitleDragStop()
    {
        this.stopDrag();
    } // End of the function
    function onTitleBtnClick(args)
    {
        net.wargaming.managers.WindowManager.__get__instance().swapToNextHighestDepth(this);
    } // End of the function
    function handleResizeDragStart()
    {
        dragProps = [_parent._xmouse, _parent._ymouse, __width, __height];
        onMouseMove = handleResize;
    } // End of the function
    function handleResizeDragStop()
    {
        onMouseMove = null;
        delete this.onMouseMove;
    } // End of the function
    function handleResize()
    {
        if (updateIntervalID)
        {
            return;
        } // end if
        updateIntervalID = setInterval(this, "updateSize", 30);
    } // End of the function
    function updateSize()
    {
        clearInterval(updateIntervalID);
        delete this.updateIntervalID;
        this.setSize(Math.max(_minWidth, Math.min(_maxWidth, dragProps[2] + _parent._xmouse - dragProps[0])), Math.max(_minHeight, Math.min(_maxHeight, dragProps[3] + _parent._ymouse - dragProps[1])));
    } // End of the function
    function handleClose()
    {
        if (_showClose)
        {
            this.hideWaiting();
            this.dispatchEvent({type: "close"});
            this.unloadMovie();
        } // end if
    } // End of the function
    function changeFocus()
    {
        if (_focused)
        {
            background.gotoAndPlay("enable");
            Selection.setFocus(focus_element || titleBtn);
        }
        else
        {
            background.gotoAndPlay("disable");
        } // end else if
    } // End of the function
    var childName = "";
    var _formType = "symbol";
    var _formSource = "";
    var _title = "";
    var _icon = "";
    var _allowResize = true;
    var _allowDrag = true;
    var _showClose = true;
    var formCreated = false;
    var _offsetTop = 31;
    var _offsetBottom = 14;
    var _offsetLeft = 8;
    var _offsetRight = 9;
    static var index = 0;
    var __firstDrawComplete = false;
} // End of Class
