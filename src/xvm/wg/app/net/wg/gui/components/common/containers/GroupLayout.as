package net.wg.gui.components.common.containers
{
    import net.wg.infrastructure.interfaces.IBaseLayout;
    
    public class GroupLayout extends Object implements IBaseLayout
    {
        
        public function GroupLayout() {
            super();
        }
        
        protected var _target:Group;
        
        private var _gap:int = 0;
        
        public function set target(param1:Object) : void {
            this._target = Group(param1);
        }
        
        public function invokeLayout() : Object {
            return null;
        }
        
        public function dispose() : void {
            this._target = null;
        }
        
        public function get target() : Object {
            return this._target;
        }
        
        public function get gap() : int {
            return this._gap;
        }
        
        public function set gap(param1:int) : void {
            this._gap = param1;
        }
    }
}
