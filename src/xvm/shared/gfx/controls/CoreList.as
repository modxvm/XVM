intrinsic class gfx.controls.CoreList extends gfx.core.UIComponent
{
    function get itemRenderer();
    function set itemRenderer(value);
    function get dataProvider():Array;
    function set dataProvider(value:Array);
    function get selectedIndex():Number;
    function set selectedIndex(value:Number);
    function scrollToIndex(index:Number);
    function get labelField();
    function set labelField(value);
    function get labelFunction();
    function set labelFunction(value);
    function itemToLabel(item);
}
