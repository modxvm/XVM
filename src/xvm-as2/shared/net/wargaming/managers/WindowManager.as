intrinsic class net.wargaming.managers.WindowManager
{
    static function get instance():WindowManager;
    function open(symbol, uniqueName, initObj, managed, group, relativeTo, positionPolicy);
    function close(uniqueName, force);
    function isOpen(uniqueName);
    function getWindow(uniqueName);
    function setWindow(window, uniqueName, managed, group, positionPolicy);
    function moveTo(window, x, y, group, relativeTo);
    function swapToNextHighestDepth(window);
    function closeAllManagedWindow(forse);
    function update(width, height);
    function focusToTopWindow();
    function hasOpened();
    function deleteWindow(uniqueName);
}
