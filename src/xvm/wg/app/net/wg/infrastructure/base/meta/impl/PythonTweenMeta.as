package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractTween;
    import net.wg.data.constants.Errors;
    
    public class PythonTweenMeta extends AbstractTween
    {
        
        public function PythonTweenMeta() {
            super();
        }
        
        public var getFinishScaleX:Function = null;
        
        public var setFinishScaleX:Function = null;
        
        public var getFinishScaleY:Function = null;
        
        public var setFinishScaleY:Function = null;
        
        public var getFinishX:Function = null;
        
        public var setFinishX:Function = null;
        
        public var getFinishY:Function = null;
        
        public var setFinishY:Function = null;
        
        public var getFinishAlpha:Function = null;
        
        public var setFinishAlpha:Function = null;
        
        public var getFinishRotation:Function = null;
        
        public var setFinishRotation:Function = null;
        
        public function getFinishScaleXS() : Number {
            App.utils.asserter.assertNotNull(this.getFinishScaleX,"getFinishScaleX" + Errors.CANT_NULL);
            return this.getFinishScaleX();
        }
        
        public function setFinishScaleXS(param1:Number) : void {
            App.utils.asserter.assertNotNull(this.setFinishScaleX,"setFinishScaleX" + Errors.CANT_NULL);
            this.setFinishScaleX(param1);
        }
        
        public function getFinishScaleYS() : Number {
            App.utils.asserter.assertNotNull(this.getFinishScaleY,"getFinishScaleY" + Errors.CANT_NULL);
            return this.getFinishScaleY();
        }
        
        public function setFinishScaleYS(param1:Number) : void {
            App.utils.asserter.assertNotNull(this.setFinishScaleY,"setFinishScaleY" + Errors.CANT_NULL);
            this.setFinishScaleY(param1);
        }
        
        public function getFinishXS() : int {
            App.utils.asserter.assertNotNull(this.getFinishX,"getFinishX" + Errors.CANT_NULL);
            return this.getFinishX();
        }
        
        public function setFinishXS(param1:int) : void {
            App.utils.asserter.assertNotNull(this.setFinishX,"setFinishX" + Errors.CANT_NULL);
            this.setFinishX(param1);
        }
        
        public function getFinishYS() : int {
            App.utils.asserter.assertNotNull(this.getFinishY,"getFinishY" + Errors.CANT_NULL);
            return this.getFinishY();
        }
        
        public function setFinishYS(param1:int) : void {
            App.utils.asserter.assertNotNull(this.setFinishY,"setFinishY" + Errors.CANT_NULL);
            this.setFinishY(param1);
        }
        
        public function getFinishAlphaS() : Number {
            App.utils.asserter.assertNotNull(this.getFinishAlpha,"getFinishAlpha" + Errors.CANT_NULL);
            return this.getFinishAlpha();
        }
        
        public function setFinishAlphaS(param1:Number) : void {
            App.utils.asserter.assertNotNull(this.setFinishAlpha,"setFinishAlpha" + Errors.CANT_NULL);
            this.setFinishAlpha(param1);
        }
        
        public function getFinishRotationS() : Number {
            App.utils.asserter.assertNotNull(this.getFinishRotation,"getFinishRotation" + Errors.CANT_NULL);
            return this.getFinishRotation();
        }
        
        public function setFinishRotationS(param1:Number) : void {
            App.utils.asserter.assertNotNull(this.setFinishRotation,"setFinishRotation" + Errors.CANT_NULL);
            this.setFinishRotation(param1);
        }
    }
}
