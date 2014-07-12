package net.wg.gui.lobby.fortifications.data
{
    import net.wg.gui.lobby.fortifications.data.base.BaseFortificationVO;
    
    public class FortWelcomeViewVO extends BaseFortificationVO
    {
        
        public function FortWelcomeViewVO(param1:Object) {
            super(param1);
        }
        
        private var _isOnClan:Boolean = false;
        
        private var _canRoleCreateFortRest:Boolean = false;
        
        private var _canCreateFortLim:Boolean = false;
        
        public function canCreateFort() : Boolean {
            return (this.canRoleCreateFort()) && (this.canCreateFortLim);
        }
        
        public function canRoleCreateFort() : Boolean {
            return this.canRoleCreateFortRest;
        }
        
        public function get canRoleCreateFortRest() : Boolean {
            return this._canRoleCreateFortRest;
        }
        
        public function set canRoleCreateFortRest(param1:Boolean) : void {
            this._canRoleCreateFortRest = param1;
        }
        
        public function get isOnClan() : Boolean {
            return this._isOnClan;
        }
        
        public function set isOnClan(param1:Boolean) : void {
            this._isOnClan = param1;
        }
        
        public function get canCreateFortLim() : Boolean {
            return this._canCreateFortLim;
        }
        
        public function set canCreateFortLim(param1:Boolean) : void {
            this._canCreateFortLim = param1;
        }
    }
}
