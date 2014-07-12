package net.wg.infrastructure.base
{
    import net.wg.infrastructure.base.meta.impl.AbstractTweenMeta;
    import net.wg.infrastructure.interfaces.ITween;
    import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
    import net.wg.infrastructure.interfaces.ITweenHandler;
    import flash.display.DisplayObject;
    import net.wg.utils.IAssertable;
    import net.wg.data.constants.Errors;
    import flash.events.Event;
    import org.idmedia.as3commons.lang.IllegalStateException;
    import net.wg.data.constants.TweenActionsOnRemove;
    
    public class AbstractTween extends AbstractTweenMeta implements ITween
    {
        
        public function AbstractTween() {
            super();
        }
        
        private var _props:ITweenPropertiesVO = null;
        
        private var _handler:ITweenHandler = null;
        
        private var _memberData:Object;
        
        public function getTargetDisplayObject() : DisplayObject {
            return this._props.getTarget();
        }
        
        public function setHandler(param1:ITweenHandler) : void {
            this._handler = param1;
        }
        
        public function onAnimComplete() : void {
            if(this._handler != null)
            {
                this._handler.onComplete(this);
            }
        }
        
        public function onAnimStart() : void {
            if(this._handler != null)
            {
                this._handler.onStart(this);
            }
        }
        
        public function get memberData() : Object {
            return this._memberData;
        }
        
        public function set memberData(param1:Object) : void {
            this._memberData = param1;
        }
        
        public function get props() : ITweenPropertiesVO {
            return this._props;
        }
        
        public function set props(param1:ITweenPropertiesVO) : void {
            var _loc2_:IAssertable = App.utils.asserter;
            _loc2_.assertNotNull(param1,"props in Tween " + Errors.CANT_NULL);
            var _loc3_:DisplayObject = param1.getTarget();
            _loc2_.assertNotNull(_loc3_,"_props.target in Tween " + Errors.CANT_NULL);
            _loc2_.assertNotNull(_loc3_.stage,"target.stage in Tween " + Errors.CANT_NULL);
            var _loc4_:int = param1.getDuration();
            _loc2_.assertNotNull(_loc4_,"_props.duration " + Errors.CANT_NULL);
            _loc2_.assert(_loc4_ > 0,"_props.duration has not maintained value");
            var _loc5_:ITweenHandler = param1.getHandler();
            if(_loc5_ != null)
            {
                this.setHandler(_loc5_);
            }
            this._props = param1;
        }
        
        override protected function onPopulate() : void {
            super.onPopulate();
            initialiazeS(this._props);
            this._props.getTarget().addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
        }
        
        override protected function onDispose() : void {
            var _loc1_:IAssertable = App.utils.asserter;
            _loc1_.assertNotNull(this._props,"props in Tween " + Errors.CANT_NULL);
            var _loc2_:DisplayObject = this._props.getTarget();
            _loc1_.assertNotNull(_loc2_,"_props.target in Tween " + Errors.CANT_NULL);
            _loc2_.removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
            this._props.dispose();
            this._props = null;
            this._handler = null;
            this._memberData = null;
            super.onDispose();
        }
        
        private function onRemovedFromStage(param1:Event) : void {
            var _loc2_:String = null;
            switch(this._props.getActionAfterRemoveFromStage())
            {
                case TweenActionsOnRemove.STOP:
                    setPausedS(true);
                    break;
                case TweenActionsOnRemove.NOT_TO_PROCESS:
                    break;
                default:
                    _loc2_ = "unknown actionAfterRemoveFromStage value: " + this._props.getActionAfterRemoveFromStage();
                    throw new IllegalStateException(_loc2_);
            }
        }
        
        public function get isOnCodeBased() : Boolean {
            return this.props.getIsOnCodeBased();
        }
    }
}
