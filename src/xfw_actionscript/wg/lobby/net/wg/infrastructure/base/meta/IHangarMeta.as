package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IHangarMeta extends IEventDispatcher
    {

        function onEscapeS() : void;

        function onCloseBtnClickS() : void;

        function showHelpLayoutS() : void;

        function closeHelpLayoutS() : void;

        function hideTeaserS() : void;

        function onTeaserClickS() : void;

        function as_setCrewEnabled(param1:Boolean) : void;

        function as_setCarouselEnabled(param1:Boolean) : void;

        function as_setCarouselVisible(param1:Boolean) : void;

        function as_setupAmmunitionPanel(param1:Object) : void;

        function as_setControlsVisible(param1:Boolean) : void;

        function as_setVisible(param1:Boolean) : void;

        function as_showHelpLayout() : void;

        function as_closeHelpLayout() : void;

        function as_showMiniClientInfo(param1:String, param2:String) : void;

        function as_show3DSceneTooltip(param1:String, param2:Array) : void;

        function as_hide3DSceneTooltip() : void;

        function as_setCarousel(param1:String, param2:String) : void;

        function as_setDefaultHeader() : void;

        function as_setAlertMessageBlockVisible(param1:Boolean) : void;

        function as_setHeaderType(param1:String) : void;

        function as_showTeaser(param1:Object) : void;

        function as_setTeaserTimer(param1:String) : void;

        function as_hideTeaserTimer() : void;

        function as_setNotificationEnabled(param1:Boolean) : void;

        function as_createDQWidget() : void;

        function as_destroyDQWidget() : void;

        function as_updateSeniorityAwardsEntryPoint(param1:Boolean) : void;

        function as_updateEventEntryPoint(param1:String, param2:Boolean) : void;

        function as_showSwitchToAmmunition() : void;

        function as_setLootboxesVisible(param1:Boolean) : void;

        function as_createEventCarouselWidget() : void;

        function as_destroyEventCarouselWidget() : void;

        function as_createEventCrewWidget(param1:Boolean) : void;

        function as_destroyEventCrewWidget() : void;

        function as_createEventParamsWidget() : void;

        function as_destroyEventParamsWidget() : void;

        function as_setHangarMode(param1:String) : void;

        function as_setCloseBtnVisible(param1:Boolean) : void;
    }
}
