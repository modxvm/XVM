package net.wg.data.VO 
{
    import net.wg.data.daapi.base.*;
    
    public class TrainingWindowVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function TrainingWindowVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get create():Boolean
        {
            return this._create;
        }

        public function set create(arg1:Boolean):void
        {
            this._create = arg1;
            return;
        }

        public function get privacy():Boolean
        {
            return this._privacy;
        }

        public function set privacy(arg1:Boolean):void
        {
            this._privacy = arg1;
            return;
        }

        public function get arena():Number
        {
            return this._arena;
        }

        public function set arena(arg1:Number):void
        {
            this._arena = arg1;
            return;
        }

        public function get timeout():Number
        {
            return this._timeout;
        }

        public function set timeout(arg1:Number):void
        {
            this._timeout = arg1;
            return;
        }

        public function get description():String
        {
            return this._description;
        }

        public function set description(arg1:String):void
        {
            this._description = arg1;
            return;
        }

        internal var _description:String="";

        internal var _timeout:Number;

        internal var _arena:Number;

        internal var _privacy:Boolean;

        internal var _create:Boolean;
    }
}
