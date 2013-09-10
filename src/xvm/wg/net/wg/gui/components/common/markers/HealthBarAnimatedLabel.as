package net.wg.gui.components.common.markers 
{
    public class HealthBarAnimatedLabel extends net.wg.gui.components.common.markers.HealthBarAnimatedPart
    {
        public function HealthBarAnimatedLabel()
        {
            super();
            return;
        }

        public function damage(arg1:Number, arg2:String):void
        {
            if (!(tweenState == INACTIVE_STATE) && !(tweenState == IMITATION_STATE)) 
                this._damage = this._damage + arg1;
            else 
                this._damage = arg1;
            this.damageLabel.color = arg2;
            this.damageLabel.text = this._damage > 0 ? String(-this._damage) : "";
            return;
        }

        public function get fakeDamage():Number
        {
            return this._fakeDamage;
        }

        public function set fakeDamage(arg1:Number):void
        {
            if (this._fakeDamage == arg1) 
                return;
            this._fakeDamage = arg1;
            invalidate(INVALIDATE_DAMAGE);
            return;
        }

        public function get imitationFlag():String
        {
            return this._imitationFlag;
        }

        public function set imitationFlag(arg1:String):void
        {
            if (arg1 == this._imitationFlag) 
                return;
            this._imitationFlag = arg1;
            invalidate(INVALIDATE_DAMAGE);
            return;
        }

        public function get imitation():Boolean
        {
            return this._imitation;
        }

        public function set imitation(arg1:Boolean):void
        {
            if (this._imitation == arg1) 
                return;
            this._imitation = arg1;
            invalidate(INVALIDATE_DAMAGE);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATE_DAMAGE)) 
                this.imitationDamage(this.imitation, this.fakeDamage, this.imitationFlag);
            return;
        }

        public function imitationDamage(arg1:Boolean, arg2:Number, arg3:String):void
        {
            if (arg1) 
            {
                this.damage(arg2, arg3);
                tweenState = IMITATION_STATE;
                setState();
            }
            visible = arg1;
            return;
        }

        
        {
            INVALIDATE_DAMAGE = "invalidateDamage";
        }

        public var damageLabel:net.wg.gui.components.common.markers.DamageLabel;

        internal var _damage:Number;

        internal var _fakeDamage:Number;

        internal var _imitation:Boolean=false;

        internal var _imitationFlag:String="";

        internal static var INVALIDATE_DAMAGE:String="invalidateDamage";
    }
}
