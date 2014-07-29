package net.wg.infrastructure.managers.utils.impl
{
    import net.wg.utils.IFocusHandler;
    import scaleform.clik.managers.FocusHandler;
    import flash.display.InteractiveObject;
    import net.wg.infrastructure.interfaces.IManagedContent;
    import scaleform.gfx.FocusManager;
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.IView;
    import net.wg.infrastructure.exceptions.InfrastructureException;
    import scaleform.clik.ui.InputDetails;
    import flash.display.Stage;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.interfaces.IAbstractWrapperView;
    import net.wg.infrastructure.interfaces.IWindow;
    
    public class FocusHandlerEx extends Object implements IFocusHandler
    {
        
        public function FocusHandlerEx()
        {
            super();
            this._focusHandler = FocusHandler.getInstance();
        }
        
        private var _focusHandler:FocusHandler = null;
        
        public function getFocus(param1:uint) : InteractiveObject
        {
            return this._focusHandler.getFocus(param1);
        }
        
        public function setFocus(param1:InteractiveObject, param2:uint = 0, param3:Boolean = false) : void
        {
            this.assertIfParentHasNoModalFocus(param1);
            this._focusHandler.setFocus(param1,param2,param3);
        }
        
        public function setModalFocus(param1:IManagedContent) : void
        {
            if(param1 != null)
            {
                FocusManager.setModalClip(Sprite(param1.containerContent));
            }
            else
            {
                FocusManager.setModalClip(null);
                this.setFocus(null);
            }
        }
        
        public function getModalFocus() : IView
        {
            var _loc1_:Sprite = FocusManager.getModalClip();
            if(_loc1_ != null)
            {
                App.utils.asserter.assert(_loc1_ is IManagedContent,"modal focus must be on ManagedContent only!",InfrastructureException);
                return IManagedContent(_loc1_).sourceView;
            }
            return null;
        }
        
        public function hasModalFocus(param1:IView) : Boolean
        {
            return this.getModalFocus() == param1;
        }
        
        public function input(param1:InputDetails) : void
        {
            this._focusHandler.input(param1);
        }
        
        public function dispose() : void
        {
            this._focusHandler.setFocus(null);
            this._focusHandler = null;
        }
        
        public function set stage(param1:Stage) : void
        {
            this._focusHandler.stage = param1;
        }
        
        private function assertIfParentHasNoModalFocus(param1:InteractiveObject) : void
        {
            var _loc3_:* = false;
            var _loc4_:IManagedContent = null;
            var _loc5_:String = null;
            var _loc2_:InteractiveObject = param1;
            if(!(_loc2_ == null) && !(this.getModalFocus() == _loc2_))
            {
                App.utils.asserter.assertNotNull(this.getModalFocus(),"current modal focus " + Errors.CANT_NULL);
                _loc3_ = false;
                _loc4_ = null;
                while(_loc2_ != null)
                {
                    if(_loc2_ is IAbstractWrapperView)
                    {
                        _loc4_ = IAbstractWrapperView(_loc2_).wrapper;
                    }
                    if(_loc2_ is IWindow)
                    {
                        _loc4_ = IWindow(_loc2_);
                    }
                    if(this.getModalFocus() == _loc2_)
                    {
                        _loc3_ = true;
                        break;
                    }
                    _loc2_ = _loc2_.parent;
                }
                if(!_loc3_ && !(_loc4_ == null))
                {
                    _loc3_ = FocusManager.getModalClip() == _loc4_;
                }
                _loc5_ = "one of parents of \"" + param1 + "\" must have a modal focus!";
                App.utils.asserter.assert(_loc3_,_loc5_);
            }
        }
    }
}
