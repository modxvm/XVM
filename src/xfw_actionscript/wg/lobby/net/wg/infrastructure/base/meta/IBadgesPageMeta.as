package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IBadgesPageMeta extends IEventDispatcher
    {

        function onBackClickS() : void;

        function onSelectBadgeS(param1:int) : void;

        function onDeselectBadgeS() : void;

        function onSelectSuffixBadgeS() : void;

        function onDeselectSuffixBadgeS() : void;

        function onDummyButtonPressS() : void;

        function as_setStaticData(param1:Object) : void;

        function as_setReceivedBadges(param1:Object) : void;

        function as_setNotReceivedBadges(param1:Object) : void;

        function as_setSelectedBadge(param1:Object, param2:Boolean) : void;

        function as_setSuffixBadgeImg(param1:String, param2:String, param3:Boolean) : void;
    }
}
