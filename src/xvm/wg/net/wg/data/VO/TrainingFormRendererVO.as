package net.wg.data.VO 
{
    import net.wg.data.daapi.base.*;
    
    public class TrainingFormRendererVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function TrainingFormRendererVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get id():Number
        {
            return this._id;
        }

        public function set id(arg1:Number):void
        {
            this._id = arg1;
            return;
        }

        public function get disabled():Boolean
        {
            return this._disabled;
        }

        public function set disabled(arg1:Boolean):void
        {
            this._disabled = arg1;
            return;
        }

        public function get icon():String
        {
            return this._icon;
        }

        public function set icon(arg1:String):void
        {
            this._icon = arg1;
            return;
        }

        public function get owner():String
        {
            return this._owner;
        }

        public function set owner(arg1:String):void
        {
            this._owner = arg1;
            return;
        }

        public function get total():Number
        {
            return this._total;
        }

        public function set total(arg1:Number):void
        {
            this._total = arg1;
            return;
        }

        public function get count():Number
        {
            return this._count;
        }

        public function set count(arg1:Number):void
        {
            this._count = arg1;
            return;
        }

        public function get arena():String
        {
            return this._arena;
        }

        public function set arena(arg1:String):void
        {
            this._arena = arg1;
            return;
        }

        public function get comment():String
        {
            return this._comment;
        }

        public function set comment(arg1:String):void
        {
            this._comment = arg1;
            return;
        }

        internal var _comment:String="";

        internal var _arena:String="";

        internal var _count:Number=0;

        internal var _total:Number=0;

        internal var _owner:String="";

        internal var _icon:String="";

        internal var _disabled:Boolean;

        internal var _id:Number=0;
    }
}
