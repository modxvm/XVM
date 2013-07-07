intrinsic class net.wargaming.controls.Window extends gfx.core.UIComponent
{
    function minimize();
    function get formSource();
    function set formSource(value);
    function get title();
    function set title(value);
    function get icon();
    function set icon(value);
    function get allowResize();
    function set allowResize(value);
    function get allowDrag();
    function set allowDrag(value);
    function get showClose();
    function set showClose(value);
    function configUI();
    function showWaiting(msg, props);
    function get isWaiting();
    function timeoutEnded();
    function hideWaiting();
    function draw();
    function configForm();
}
