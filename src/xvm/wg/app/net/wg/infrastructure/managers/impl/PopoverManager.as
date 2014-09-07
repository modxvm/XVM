package net.wg.infrastructure.managers.impl
{
    import net.wg.infrastructure.base.meta.impl.PopoverManagerMeta;
    import net.wg.infrastructure.base.meta.IPopoverManagerMeta;
    import net.wg.infrastructure.managers.IPopoverManager;
    import flash.display.Stage;
    import net.wg.infrastructure.interfaces.IPopOverCaller;
    import net.wg.infrastructure.interfaces.IClosePopoverCallback;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.NullPointerException;
    import flash.events.MouseEvent;
    import flash.display.DisplayObject;
    import net.wg.infrastructure.interfaces.IPopoverWrapper;
    import net.wg.infrastructure.base.interfaces.IAbstractPopOverView;
    
    public class PopoverManager extends PopoverManagerMeta implements IPopoverManagerMeta, IPopoverManager
    {
        
        public function PopoverManager(param1:Stage)
        {
            super();
            this._stage = param1;
        }
        
        private var _stage:Stage;
        
        private var _popoverCaller:IPopOverCaller;
        
        private var client:IClosePopoverCallback = null;
        
        public function show(param1:IPopOverCaller, param2:String, param3:Object = null, param4:IClosePopoverCallback = null) : void
        {
            App.utils.asserter.assertNotNull(param1,"popoverCaller" + Errors.CANT_NULL,NullPointerException);
            App.utils.asserter.assertNotNull(param2,"alias" + Errors.CANT_NULL,NullPointerException);
            if(this._popoverCaller == param1)
            {
                this.hide();
                return;
            }
            this._stage.addEventListener(MouseEvent.MOUSE_DOWN,this.stageMouseDownHandler,false,0,true);
            this._popoverCaller = param1;
            this.client = param4;
            requestShowPopoverS(param2,param3);
            if(this.client)
            {
                this.client.onPopoverOpen();
            }
        }
        
        public function hide() : void
        {
            requestHidePopoverS();
        }
        
        public function as_onPopoverDestroy() : void
        {
            if(this._popoverCaller)
            {
                this._stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.stageMouseDownHandler);
                if(this.client != null)
                {
                    this.client.onPopoverClose();
                }
                this._popoverCaller = null;
            }
        }
        
        public function dispose() : void
        {
            this._popoverCaller = null;
            this.client = null;
            this._stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.stageMouseDownHandler);
            this._stage = null;
        }
        
        public function get popoverCaller() : IPopOverCaller
        {
            return this._popoverCaller;
        }
        
        private function stageMouseDownHandler(param1:MouseEvent) : void
        {
            App.utils.asserter.assertNotNull(this._popoverCaller,this + " _lastPopoverCaller have not to be NULL!",NullPointerException);
            var _loc2_:DisplayObject = param1.target as DisplayObject;
            if(!_loc2_)
            {
                return;
            }
            var _loc3_:DisplayObject = this._popoverCaller.getHitArea();
            while(_loc2_)
            {
                if(_loc2_ == this._popoverCaller.getTargetButton() || _loc2_ == _loc3_ || _loc2_ is IPopoverWrapper || _loc2_ is IAbstractPopOverView)
                {
                    return;
                }
                _loc2_ = _loc2_.parent;
            }
            this.hide();
        }
    }
}
