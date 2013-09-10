intrinsic class gfx.controls.Button extends gfx.core.UIComponent
{
    var state;
    var textField;
    var tooltipText;
    function get label();
    function set label(value);
    function get selected();
    function set selected(value);
    function get groupName();
    function set groupName(value);
    function get group():gfx.controls.ButtonGroup;
    function set group(value);
    function get disableFocus();
    function set disableFocus(value);
    function get autoSize();
    function set autoSize(value);
    function setState(state);
}
