/**
 * Base Control Class (abstract) - based on the ScaleForm's gfx.core.UIComponent
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
import gfx.events.EventTypes;
import com.xvm.Defines;

class com.xvm.Controls.ControlBase extends MovieClip
{
    /////////////////////////////////////////////////////////////////
    // PUBLIC STATIC
    
    public static function createInstance(context:MovieClip, symbol:String, name:String, depth:Number, initObj:Object):MovieClip
    {
        var mc:MovieClip = context.attachMovie(symbol, name, depth, initObj);
        if (mc.invalidate)
            mc.invalidate();
        return mc;
    }

    /////////////////////////////////////////////////////////////////
    // PRIVATE VARS

    //var useHandCursor, dispatchEvent, , hitTest;
    
    private var initialized:Boolean = false;
    private var __width:Number = Number.NaN;
    private var __height:Number = Number.NaN;
    private var _disabled:Boolean = false;
    private var sizeIsInvalid:Boolean = false;
    private var _color:Number = Defines.UICOLOR_DEFAULT;
    private var __alpha:Number = 100;
    private var _dataProvider:Object = null;
    private var _focused:Boolean = false;
    private var _displayFocus:Boolean = false;
    private var invalidationIntervalID:Number = undefined;

    /////////////////////////////////////////////////////////////////
    // .ctor()
    
    private function ControlBase()
    {
        super();
        gfx.events.EventDispatcher.initialize(this);

        var me = this;
	onKeyDown = function() { me.onKeyDown(); }
	onKeyUp = function() { me.onKeyUp(); }
	onMouseDown = function() { me.onMouseDown(); }
	onMouseMove = function() { me.onMouseMove(); }
	onMouseUp = function() { me.onMouseUp(); }
	onPress = function() { me.onPress(); }
	onRelease = function() { me.onRelease(); }
	onReleaseOutside = function() { me.onReleaseOutside(); }
	onRollOver = function() { me.onRollOver(); }
        onRollOut = function()  { me.onRollOut(); }
    }

    /////////////////////////////////////////////////////////////////
    // PUBLIC METHODS
    
    public function get disabled():Boolean
    {
        return _disabled;
    }
    
    public function set disabled(value)
    {
        _disabled = value;
        super.enabled = !value;
        useHandCursor = !value;
        invalidate();
    }
    
    public function get visible()
    {
        return _visible;
    }
    
    public function set visible(value)
    {
        if (_visible == value)
            return;
        _visible = value;
        if (initialized)
            dispatchEvent({ type: value ? EventTypes.SHOW : EventTypes.HIDE });
    }

    public function get width()
    {
        return __width;
    }
    
    public function set width(value)
    {
        setSize(value, __height || _height);
    }
    
    public function get height()
    {
        return __height;
    }
    
    public function set height(value)
    {
        setSize(__width || _width, value);
    }
    
    public function setSize(width, height)
    {
        if (__width == width && __height == height)
            return;
        __width = width;
        __height = height;
        sizeIsInvalid = true;
        invalidate();
    }
    
    public function get color():Number
    {
        return _color;
    }
    
    public function set color(value:Number)
    {
        _color = color;
        invalidate();
    }
    
    public function get alpha():Number
    {
        return __alpha;
    }
    
    public function set alpha(value:Number)
    {
        __alpha = alpha;
        invalidate();
    }
    
    public function get dataProvider():Object
    {
        return _dataProvider;
    }

    public function set dataProvider(value:Object)
    {
        _dataProvider = value;
        invalidate();
    }
    
    public function get focused()
    {
        return _focused;
    }
    
    public function set focused(value)
    {
        if (value == _focused)
            return;
        _focused = value;
        
        if (!value && Selection.getFocus() == this)
            Selection.setFocus(null);
        else if (value && Selection.getFocus() != this)
            Selection.setFocus(this);
        
        changeFocus();
        
        dispatchEvent({ type: value ? EventTypes.FOCUS_IN : EventTypes.FOCUS_OUT });
    }
    
    public function get displayFocus()
    {
        return _displayFocus;
    }
    
    public function set displayFocus(value)
    {
        if (value == _displayFocus)
            return;
        _displayFocus = value;
        changeFocus();
    }

    public function invalidate()
    {
        if (!invalidationIntervalID)
            invalidationIntervalID = _global.setInterval(this, "validateNow", 1);
    }
    
    // STUBS
    
    public function configUI()
    {
    }
    
    public function draw()
    {
    }
    
    public function changeFocus()
    {
    }
    
    public function scrollWheel(delta)
    {
    }
    
    public function toString()
    {
        return ("[XVM ControlBase " + _name + "]");
    }
    
    /////////////////////////////////////////////////////////////////
    // gfx.events.EventDispatcher inherits
    
    public function addEventListener(event, scope, callBack) {};
    public function removeEventListener(event, scope, callBack) {};
    public function dispatchEvent(event) {};
    public function hasEventListener(event) {};

    /////////////////////////////////////////////////////////////////
    // PRIVATE
    
    private function onLoad()
    {
        if (__width == NaN)
            __width = _width;
        if (__height == NaN)
            __height = _height;
        
        initialized = true;
        
        configUI();
        validateNow();
        
        if (_focused && Selection.getFocus() == null)
            gfx.managers.FocusHandler.instance.onSetFocus(null, this);
    }

    private function validateNow()
    {
        clearInterval(invalidationIntervalID);
        delete this.invalidationIntervalID;
        
        if (!initialized)
        {
            this.onLoad();
            return;
        }
        
        this.draw();
        sizeIsInvalid = false;
    }
    
    private function onMouseWheel(delta, target)
    {
        if (this.visible && this.hitTest(_root._xmouse, _root._ymouse, true))
        {
            for (var i = Mouse.getTopMostEntity(); i; i = i._parent)
            {
                if (i == this)
                {
                    this.scrollWheel(delta > 0 ? 1 : -1);
                    break;
                }
            }
        }
    }
   
    // is required?
    private function handleInput(details, pathToFocus)
    {
        if (pathToFocus != null && pathToFocus.length > 0)
        {
            if (pathToFocus[0].handleInput(details, pathToFocus.slice(1)))
                return true;
        }
        return false;
    }
}
