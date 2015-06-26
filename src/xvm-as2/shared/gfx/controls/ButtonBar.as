intrinsic class gfx.controls.ButtonBar extends gfx.core.UIComponent
{
    /////////////////////////////////////////////////////////////////
    // XVM
    var xvm_initialized:Boolean;
    /////////////////////////////////////////////////////////////////

    var renderers;
    
    function get dataProvider();
    function set dataProvider(value);
    function get itemRenderer();
    function set itemRenderer(value);
    function get spacing();
    function set spacing(value);
    function get direction();
    function set direction(value);
    function get autoSize();
    function set autoSize(value);
    function get buttonWidth();
    function set buttonWidth(value);
    function get selectedIndex();
    function set selectedIndex(value);
    function get selectedItem();
    function get labelField();
    function set labelField(value);
    function get labelFunction();
    function set labelFunction(value);
}
