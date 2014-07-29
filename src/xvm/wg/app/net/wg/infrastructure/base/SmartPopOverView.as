package net.wg.infrastructure.base
{
    import net.wg.infrastructure.base.meta.impl.SmartPopOverViewMeta;
    import net.wg.infrastructure.base.meta.ISmartPopOverViewMeta;
    import net.wg.gui.components.popOvers.SmartPopOverExternalLayout;
    import flash.events.Event;
    import net.wg.infrastructure.interfaces.IWrapper;
    import net.wg.data.utilData.TwoDimensionalPadding;
    import flash.display.DisplayObject;
    import flash.geom.Point;
    
    public class SmartPopOverView extends SmartPopOverViewMeta implements ISmartPopOverViewMeta
    {
        
        public function SmartPopOverView()
        {
            this.popoverLayout = new SmartPopOverExternalLayout();
            super();
        }
        
        protected var popoverLayout:SmartPopOverExternalLayout;
        
        override protected function configUI() : void
        {
            super.configUI();
            stage.addEventListener(Event.RESIZE,this.stageResizeHandler,false,0,true);
            this.stageResizeHandler(null);
        }
        
        override public function set wrapper(param1:IWrapper) : void
        {
            super.wrapper = param1;
            this.initLayout();
        }
        
        protected function initLayout() : void
        {
            this.popoverLayout.positionKeyPointPadding = this.getKeyPointPadding();
            this.updateCallerGlobalPosition();
            BaseViewWrapper(wrapper).layout = this.popoverLayout;
        }
        
        protected function getKeyPointPadding() : TwoDimensionalPadding
        {
            var _loc1_:DisplayObject = DisplayObject(App.popoverMgr.popoverCaller.getTargetButton());
            var _loc2_:Number = _loc1_.width / 2;
            var _loc3_:Number = _loc1_.height / 2;
            return new TwoDimensionalPadding(new Point(0,-_loc3_),new Point(_loc2_,0),new Point(0,_loc3_),new Point(-_loc2_,0));
        }
        
        protected function updateCallerGlobalPosition() : void
        {
            var _loc1_:DisplayObject = DisplayObject(App.popoverMgr.popoverCaller.getTargetButton());
            var _loc2_:Number = _loc1_.width / 2;
            var _loc3_:Number = _loc1_.height / 2;
            var _loc4_:Point = _loc1_.parent.localToGlobal(new Point(_loc1_.x,_loc1_.y));
            this.as_setPositionKeyPoint(_loc4_.x + _loc2_,_loc4_.y + _loc3_);
        }
        
        protected function stageResizeHandler(param1:Event) : void
        {
            this.popoverLayout.stageDimensions = new Point(stage.stageWidth,stage.stageHeight);
            this.updateCallerGlobalPosition();
            BaseViewWrapper(wrapper).invalidateLayout();
        }
        
        public function as_setPositionKeyPoint(param1:Number, param2:Number) : void
        {
            this.popoverLayout.positionKeyPoint = new Point(param1,param2);
            BaseViewWrapper(wrapper).invalidateLayout();
        }
        
        override protected function onDispose() : void
        {
            this.popoverLayout = null;
            if(stage)
            {
                stage.removeEventListener(Event.RESIZE,this.stageResizeHandler);
            }
            super.onDispose();
        }
    }
}
