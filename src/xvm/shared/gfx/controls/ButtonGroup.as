intrinsic class gfx.controls.ButtonGroup // extends gfx.events.EventDispatcher
{
    var selectedButton;
    function get length();
    function addButton(button);
    function removeButton(button);
    function indexOf(button);
    function getButtonAt(index);
    function get data();
    function setSelectedButton(button);
}
