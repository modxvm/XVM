intrinsic class gfx.core.UIComponent extends MovieClip
{
    public var initialized:Boolean;
    
    static function createInstance(context, symbol, name, depth, initObj);
    
    function get disabled();
    function set disabled(value);
    function get visible();
    function set visible(value);
    function get width();
    function set width(value);
    function get height();
    function set height(value);
    function setSize(width, height);
    function get focused();
    function set focused(value);
    function get displayFocus();
    function set displayFocus(value);
    function handleInput(details, pathToFocus);
    function invalidate();
    function validateNow();
    function toString();
    function configUI();
    function initSize();
    function draw();
    function changeFocus();
    function onMouseWheel(delta, target);
    function scrollWheel(delta);

    // gfx.events.EventDispatcher inherits
    function addEventListener(event, scope, callBack);
    function removeEventListener(event, scope, callBack);
    function dispatchEvent(event);
    function hasEventListener(event);
}