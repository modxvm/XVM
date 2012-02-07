class net.wargaming.controls.PlayerElement extends gfx.core.UIComponent
{
    var data, invalidate, textField, vehicleField, stateField, vehicleLevelField, iconLoader, __set__disabled, __get__disabled, gotoAndPlay;
    function PlayerElement()
    {
        super();
    } // End of the function
    function setData(_data)
    {
        data = _data;
        this.invalidate();
    } // End of the function
    function draw()
    {
        if (data)
        {
            textField.text = data.label;
            vehicleField.text = data.vehicle;
            stateField.text = "#menu:training/info/states/state" + data.state;
            vehicleLevelField.text = data.level;
            if (iconLoader instanceof gfx.controls.UILoader)
            {
                iconLoader.__set__visible(true);
                if (iconLoader.__get__source() != data.icon)
                {
                    iconLoader.__set__source(data.icon);
                } // end if
            } // end if
            _state = data.state;
            _isCurrent = data.current;
            this.__set__disabled(data.disabled);
        }
        else
        {
            textField.text = "";
            vehicleField.text = "";
            vehicleLevelField.text = "";
            iconLoader._visible = false;
            this.__set__disabled(false);
            _state = 0;
            _isCurrent = false;
        } // end else if
        var _loc2 = new flash.geom.ColorTransform();
        if (this.__get__disabled())
        {
            this.gotoAndPlay("disabled");
            _loc2.alphaMultiplier = 0.700000;
            _loc2.redMultiplier = 0.100000;
            _loc2.blueMultiplier = 0.100000;
            _loc2.greenMultiplier = 0.100000;
        }
        else if (_isCurrent)
        {
            this.gotoAndPlay("current");
            _loc2.redOffset = 21;
            _loc2.greenOffset = 9;
            _loc2.blueMultiplier = 0.510000;
            _loc2.greenMultiplier = 0.870000;
        }
        else
        {
            this.gotoAndPlay("up");
        } // end else if
        var _loc3 = new flash.geom.Transform(iconLoader);
        _loc3.colorTransform = _loc2;
        if (_state == 1)
        {
            this.gotoAndPlay("suspend");
        }
        else if (_state == 2)
        {
            this.gotoAndPlay("inbattle");
        } // end else if
    } // End of the function
    var _selected = false;
    var _state = 0;
    var _isCurrent = false;
} // End of Class
