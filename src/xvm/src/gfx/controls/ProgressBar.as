class gfx.controls.ProgressBar extends gfx.controls.StatusIndicator
{
    var targetClip, _parent, __get__target, __get__mode, _value, _minimum, _maximum, _name, inspectableTarget, __set__target, __get__value, __set__value, dispatchEvent, _disabled, onEnterFrame, __set__mode, __get__percentLoaded;
    function ProgressBar()
    {
        super();
    } // End of the function
    function get target()
    {
        return (targetClip);
    } // End of the function
    function set target(value)
    {
        var _loc3 = value;
        if (typeof(value) == "string")
        {
            _loc3 = _parent[value];
        } // end if
        if (_loc3 == targetClip)
        {
            return;
        } // end if
        if (targetClip.removeEventListener != null)
        {
            targetClip.removeEventListener("progress", this, "handleProgress");
            targetClip.removeEventListener("complete", this, "handleComplete");
        } // end if
        targetClip = value;
        if (targetClip == null)
        {
            return;
        } // end if
        this.setUpTarget();
        //return (this.target());
        null;
    } // End of the function
    function get mode()
    {
        return (_mode);
    } // End of the function
    function set mode(value)
    {
        if (value == _mode)
        {
            return;
        } // end if
        _mode = value.toLowerCase();
        this.setUpTarget();
        //return (this.mode());
        null;
    } // End of the function
    function get percentLoaded()
    {
        var _loc2 = (_value - _minimum) / (_maximum - _minimum) * 100;
        return (_loc2);
    } // End of the function
    function setProgress(loaded, total)
    {
        if (_mode != "manual")
        {
            return;
        } // end if
        var _loc2 = loaded / total;
        this.setPercent(_loc2);
    } // End of the function
    function toString()
    {
        return ("[Scaleform ProgressBar " + _name + "]");
    } // End of the function
    function configUI()
    {
        super.configUI();
        if (inspectableTarget != "")
        {
            this.__set__target(inspectableTarget);
            inspectableTarget = null;
        } // end if
    } // End of the function
    function setPercent(percent)
    {
        var _loc2 = percent * (_maximum - _minimum) + _minimum;
        if (this.__get__value() == _loc2)
        {
            return;
        } // end if
        this.__set__value(_loc2);
        this.dispatchEvent({type: "progress"});
        if (this.__get__value() == _maximum)
        {
            this.dispatchEvent({type: "complete"});
        } // end if
    } // End of the function
    function setUpTarget()
    {
        if (_disabled)
        {
            return;
        } // end if
        delete this.onEnterFrame;
        if (targetClip == null)
        {
            return;
        } // end if
        if (targetClip && targetClip.removeEventListener)
        {
            targetClip.removeEventListener("progress", this, "handleProgress");
            targetClip.removeEventListener("complete", this, "handleComplete");
        } // end if
        switch (_mode)
        {
            case "manual":
            {
                break;
            } 
            case "polled":
            {
                onEnterFrame = pollTarget;
                break;
            } 
            case "event":
            {
                if (targetClip.addEventListener != null)
                {
                    targetClip.addEventListener("progress", this, "handleProgress");
                    targetClip.addEventListener("complete", this, "handleComplete");
                } // end if
                break;
            } 
        } // End of switch
    } // End of the function
    function pollTarget()
    {
        if (this.__get__target() == null || _mode != "polled")
        {
            return;
        } // end if
        this.setPercent(this.__get__target().bytesTotal > 0 ? (targetClip.bytesLoaded / targetClip.bytesTotal) : (0));
    } // End of the function
    function handleProgress(event)
    {
        if (_mode != "event")
        {
            return;
        } // end if
        this.setPercent(event.bytesTotal > 0 ? (event.bytesLoaded / event.bytesTotal) : (0));
    } // End of the function
    function handleComplete()
    {
        this.setPercent(100);
    } // End of the function
    var _mode = "manual";
} // End of Class
