package net.wg.infrastructure.managers.impl
{
    import net.wg.infrastructure.base.meta.impl.EventLogManagerMeta;
    import net.wg.infrastructure.managers.IEventLogManager;
    import net.wg.utils.IAssertable;
    import net.wg.data.constants.generated.EVENT_LOG_CONSTANTS;
    import net.wg.data.constants.Values;
    import net.wg.infrastructure.interfaces.entity.IIdentifiable;
    import flash.events.Event;
    
    public class EventLogManager extends EventLogManagerMeta implements IEventLogManager
    {
        
        public function EventLogManager()
        {
            super();
        }
        
        public function logSubSystem(param1:uint, param2:String, param3:uint, param4:uint) : void
        {
            var _loc5_:String = "Unknown logged event: " + param2;
            var _loc6_:IAssertable = App.utils.asserter;
            _loc6_.assert(!(EVENT_LOG_CONSTANTS.EVENT_TYPES.indexOf(param2) == -1),_loc5_);
            _loc6_.assert(!(EVENT_LOG_CONSTANTS.SUB_SYSTEMS.indexOf(param1) == -1),"Unknown logging subsytem:" + param1);
            _loc6_.assert(!(param3 == Values.EMPTY_UIID),"uiid must be initialized before logging!");
            logEventS(param1,param2,param3,param4);
        }
        
        public function logUIElement(param1:IIdentifiable, param2:String, param3:uint) : void
        {
            App.utils.asserter.assert(!(param1.UIID == Values.EMPTY_UIID),"uiid for \"" + param1 + " must be initialized before logging!");
            this.logSubSystem(EVENT_LOG_CONSTANTS.SST_UI_COMMON,param2,param1.UIID,param3);
        }
        
        public function logUIEvent(param1:Event, param2:uint) : void
        {
            App.utils.asserter.assert(param1.target is IIdentifiable,"event.target for \"" + param1.target + " must be implements IIdentifiable for UIID taking correctly!");
            this.logUIElement(IIdentifiable(param1.target),param1.type,param2);
        }
    }
}
