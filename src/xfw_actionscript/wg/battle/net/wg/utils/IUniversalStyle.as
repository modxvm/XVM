package net.wg.utils
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.utils.Dictionary;
    import flash.filters.DropShadowFilter;

    public interface IUniversalStyle extends IDisposable
    {

        function getStyledDisplayObjects() : IUniversalBtnStyledDisplayObjects;

        function addStyledDisplayObjects(param1:IUniversalBtnStyledDisplayObjects) : void;

        function get statesTextFieldColor() : Dictionary;

        function get statesLinkage() : String;

        function get disableBitmapSrc() : String;

        function get toggleIndicatorLinkage() : String;

        function get toggleGlowLinkage() : String;

        function get tfSize() : uint;

        function get tfColor() : uint;

        function get tfShadowFilter() : DropShadowFilter;
    }
}
