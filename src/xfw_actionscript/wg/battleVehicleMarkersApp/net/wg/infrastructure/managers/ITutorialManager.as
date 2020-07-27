package net.wg.infrastructure.managers
{
    import net.wg.infrastructure.base.meta.ITutorialManagerMeta;
    import net.wg.infrastructure.events.TutorialEvent;
    import flash.display.DisplayObject;
    import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
    import net.wg.infrastructure.interfaces.IView;
    import net.wg.data.TutorialBuilderVO;
    import flash.display.DisplayObjectContainer;

    public interface ITutorialManager extends ITutorialManagerMeta
    {

        function onComponentCheckComplete(param1:String, param2:TutorialEvent, param3:String) : void;

        function onComponentCreatedByLinkage(param1:DisplayObject, param2:String) : void;

        function addListenersToCustomTutorialComponent(param1:ITutorialCustomComponent) : void;

        function removeListenersFromCustomTutorialComponent(param1:ITutorialCustomComponent) : void;

        function dispatchEventForCustomComponent(param1:ITutorialCustomComponent) : void;

        function setupEffectBuilder(param1:IView, param2:TutorialBuilderVO, param3:DisplayObject) : void;

        function get isSystemEnabled() : Object;

        function setViewForTutorialId(param1:IView, param2:String) : void;

        function onEffectComplete(param1:DisplayObject, param2:String) : void;

        function addHintZoneForGFComponent(param1:DisplayObjectContainer, param2:String, param3:int, param4:int, param5:int, param6:int) : void;

        function removeHintZoneForGFComponent(param1:DisplayObjectContainer, param2:String) : void;
    }
}
