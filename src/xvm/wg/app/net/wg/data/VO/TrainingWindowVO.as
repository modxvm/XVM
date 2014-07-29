package net.wg.data.VO
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class TrainingWindowVO extends DAAPIDataClass
    {
        
        public function TrainingWindowVO(param1:Object)
        {
            super(param1);
        }
        
        private var _description:String = "";
        
        private var _timeout:Number;
        
        private var _arena:Number;
        
        private var _privacy:Boolean;
        
        private var _create:Boolean;
        
        private var _canMakeOpenedClosed:Boolean;
        
        private var _canChangeComment:Boolean;
        
        private var _canChangeArena:Boolean;
        
        public function get canMakeOpenedClosed() : Boolean
        {
            return this._canMakeOpenedClosed;
        }
        
        public function set canMakeOpenedClosed(param1:Boolean) : void
        {
            this._canMakeOpenedClosed = param1;
        }
        
        public function get canChangeComment() : Boolean
        {
            return this._canChangeComment;
        }
        
        public function set canChangeComment(param1:Boolean) : void
        {
            this._canChangeComment = param1;
        }
        
        public function get canChangeArena() : Boolean
        {
            return this._canChangeArena;
        }
        
        public function set canChangeArena(param1:Boolean) : void
        {
            this._canChangeArena = param1;
        }
        
        public function get create() : Boolean
        {
            return this._create;
        }
        
        public function set create(param1:Boolean) : void
        {
            this._create = param1;
        }
        
        public function get privacy() : Boolean
        {
            return this._privacy;
        }
        
        public function set privacy(param1:Boolean) : void
        {
            this._privacy = param1;
        }
        
        public function get arena() : Number
        {
            return this._arena;
        }
        
        public function set arena(param1:Number) : void
        {
            this._arena = param1;
        }
        
        public function get timeout() : Number
        {
            return this._timeout;
        }
        
        public function set timeout(param1:Number) : void
        {
            this._timeout = param1;
        }
        
        public function get description() : String
        {
            return this._description;
        }
        
        public function set description(param1:String) : void
        {
            this._description = param1;
        }
    }
}
