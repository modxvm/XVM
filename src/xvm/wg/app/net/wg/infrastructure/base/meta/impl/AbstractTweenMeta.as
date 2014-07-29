package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
    import net.wg.data.constants.Errors;
    import flash.display.DisplayObject;
    
    public class AbstractTweenMeta extends BaseDAAPIComponent
    {
        
        public function AbstractTweenMeta()
        {
            super();
        }
        
        public var initialiaze:Function = null;
        
        public var creatTweenPY:Function = null;
        
        public var getPaused:Function = null;
        
        public var setPaused:Function = null;
        
        public var getLoop:Function = null;
        
        public var setLoop:Function = null;
        
        public var getDuration:Function = null;
        
        public var setDuration:Function = null;
        
        public var getPosition:Function = null;
        
        public var setPosition:Function = null;
        
        public var getDelay:Function = null;
        
        public var setDelay:Function = null;
        
        public var resetAnim:Function = null;
        
        public var getTweenIdx:Function = null;
        
        public var getIsComplete:Function = null;
        
        public function initialiazeS(param1:ITweenPropertiesVO) : void
        {
            App.utils.asserter.assertNotNull(this.initialiaze,"initialiaze" + Errors.CANT_NULL);
            this.initialiaze(param1);
        }
        
        public function creatTweenPYS(param1:DisplayObject) : void
        {
            App.utils.asserter.assertNotNull(this.creatTweenPY,"creatTweenPY" + Errors.CANT_NULL);
            this.creatTweenPY(param1);
        }
        
        public function getPausedS() : Boolean
        {
            App.utils.asserter.assertNotNull(this.getPaused,"getPaused" + Errors.CANT_NULL);
            return this.getPaused();
        }
        
        public function setPausedS(param1:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.setPaused,"setPaused" + Errors.CANT_NULL);
            this.setPaused(param1);
        }
        
        public function getLoopS() : Boolean
        {
            App.utils.asserter.assertNotNull(this.getLoop,"getLoop" + Errors.CANT_NULL);
            return this.getLoop();
        }
        
        public function setLoopS(param1:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.setLoop,"setLoop" + Errors.CANT_NULL);
            this.setLoop(param1);
        }
        
        public function getDurationS() : uint
        {
            App.utils.asserter.assertNotNull(this.getDuration,"getDuration" + Errors.CANT_NULL);
            return this.getDuration();
        }
        
        public function setDurationS(param1:uint) : void
        {
            App.utils.asserter.assertNotNull(this.setDuration,"setDuration" + Errors.CANT_NULL);
            this.setDuration(param1);
        }
        
        public function getPositionS() : uint
        {
            App.utils.asserter.assertNotNull(this.getPosition,"getPosition" + Errors.CANT_NULL);
            return this.getPosition();
        }
        
        public function setPositionS(param1:uint) : void
        {
            App.utils.asserter.assertNotNull(this.setPosition,"setPosition" + Errors.CANT_NULL);
            this.setPosition(param1);
        }
        
        public function getDelayS() : uint
        {
            App.utils.asserter.assertNotNull(this.getDelay,"getDelay" + Errors.CANT_NULL);
            return this.getDelay();
        }
        
        public function setDelayS(param1:uint) : void
        {
            App.utils.asserter.assertNotNull(this.setDelay,"setDelay" + Errors.CANT_NULL);
            this.setDelay(param1);
        }
        
        public function resetAnimS() : void
        {
            App.utils.asserter.assertNotNull(this.resetAnim,"resetAnim" + Errors.CANT_NULL);
            this.resetAnim();
        }
        
        public function getTweenIdxS() : uint
        {
            App.utils.asserter.assertNotNull(this.getTweenIdx,"getTweenIdx" + Errors.CANT_NULL);
            return this.getTweenIdx();
        }
        
        public function getIsCompleteS() : Boolean
        {
            App.utils.asserter.assertNotNull(this.getIsComplete,"getIsComplete" + Errors.CANT_NULL);
            return this.getIsComplete();
        }
    }
}
