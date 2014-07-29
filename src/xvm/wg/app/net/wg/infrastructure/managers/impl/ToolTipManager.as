package net.wg.infrastructure.managers.impl
{
    import net.wg.infrastructure.base.meta.impl.ToolTipMgrMeta;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.infrastructure.base.meta.IToolTipMgrMeta;
    import flash.display.DisplayObjectContainer;
    import flash.display.DisplayObject;
    import net.wg.data.managers.ITooltipProps;
    import net.wg.utils.IUtils;
    import net.wg.utils.IAssertable;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.interfaces.IToolTip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.data.managers.IToolTipParams;
    import net.wg.gui.utils.ComplexTooltipHelper;
    import net.wg.data.constants.Linkages;
    import net.wg.data.managers.impl.TooltipProps;
    import net.wg.utils.IScheduler;
    
    public class ToolTipManager extends ToolTipMgrMeta implements ITooltipMgr, IToolTipMgrMeta
    {
        
        public function ToolTipManager(param1:DisplayObjectContainer)
        {
            super();
            this._container = param1;
        }
        
        private static var SCHEDULE_TIME:uint = 100;
        
        private var _container:DisplayObjectContainer = null;
        
        private var _currentTooltip:DisplayObject = null;
        
        private var _props:ITooltipProps = null;
        
        public function as_show(param1:Object, param2:String) : void
        {
            var _loc3_:IUtils = null;
            var _loc4_:IAssertable = null;
            this.hide();
            if(App.instance)
            {
                _loc4_ = App.utils.asserter;
                _loc4_.assertNotNull(this._props,"_props" + Errors.CANT_NULL);
                _loc3_ = App.utils;
                if(this._props.showDelay != 0)
                {
                    _loc3_.scheduler.scheduleTask(this.hide,this._props.showDelay);
                }
                this._currentTooltip = DisplayObject(_loc3_.classFactory.getObject(param2,this._props));
                if(this._currentTooltip != null)
                {
                    IToolTip(this._currentTooltip).build(param1,this._props);
                    this._container.addChild(this._currentTooltip);
                }
            }
            this._props = null;
        }
        
        public function hide() : void
        {
            if(this._currentTooltip != null)
            {
                IDisposable(this._currentTooltip).dispose();
                this._container.removeChild(this._currentTooltip);
                this._currentTooltip = null;
            }
            this.cancelTasks();
        }
        
        public function showSpecial(param1:String, param2:ITooltipProps, ... rest) : void
        {
            this.cancelTasks();
            this._props = this.prepareProperties(param2);
            App.utils.scheduler.scheduleTask(onCreateTypedTooltipS,SCHEDULE_TIME,param1,rest,this._props.type);
        }
        
        public function showComplex(param1:String, param2:ITooltipProps = null) : void
        {
            this.cancelTasks();
            this._props = this.prepareProperties(param2);
            this.rescheduleTask(onCreateComplexTooltipS,param1,this._props.type);
        }
        
        public function showComplexWithParams(param1:String, param2:IToolTipParams, param3:ITooltipProps = null) : void
        {
            if(!param2)
            {
                return;
            }
            var _loc4_:ComplexTooltipHelper = new ComplexTooltipHelper();
            if(param2.header)
            {
                _loc4_.addHeader(App.utils.locale.makeString(param1 + "/header",param2.header));
            }
            if(param2.body)
            {
                _loc4_.addBody(App.utils.locale.makeString(param1 + "/body",param2.body));
            }
            if(param2.note)
            {
                _loc4_.addNote(App.utils.locale.makeString(param1 + "/note",param2.note));
            }
            var _loc5_:String = _loc4_.make();
            if(_loc5_.length > 0)
            {
                App.toolTipMgr.showComplex(_loc5_);
            }
        }
        
        public function show(param1:String, param2:ITooltipProps = null) : void
        {
            this.cancelTasks();
            this._props = this.prepareProperties(param2);
            this.rescheduleTask(this.as_show,param1,Linkages.TOOL_TIP_COMPLEX);
        }
        
        public function showLocal(param1:String, param2:Object, param3:ITooltipProps = null) : void
        {
            this.cancelTasks();
            this._props = this.prepareProperties(param3);
            App.utils.scheduler.scheduleTask(this.as_show,SCHEDULE_TIME,param2,param1);
        }
        
        private function prepareProperties(param1:ITooltipProps) : ITooltipProps
        {
            if(param1 == null)
            {
                return TooltipProps.DEFAULT;
            }
            return param1;
        }
        
        private function cancelTasks() : void
        {
            var _loc1_:IScheduler = App.utils.scheduler;
            _loc1_.cancelTask(onCreateTypedTooltipS);
            _loc1_.cancelTask(onCreateComplexTooltipS);
            _loc1_.cancelTask(this.as_show);
        }
        
        private function rescheduleTask(param1:Function, param2:String, param3:String) : void
        {
            App.utils.scheduler.scheduleTask(param1,SCHEDULE_TIME,param2,param3);
        }
    }
}
