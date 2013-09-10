package net.wg.infrastructure.managers.utils.impl 
{
    import net.wg.infrastructure.exceptions.*;
    import net.wg.utils.*;
    import scaleform.gfx.*;
    
    public final class Asserter extends Object implements net.wg.utils.IAssertable
    {
        public function Asserter()
        {
            super();
            ms_instance = this;
            this.assertProcessing = this.startingAssertProcessing;
            return;
        }

        public final function assert(arg1:Boolean, arg2:String, arg3:Class=null):void
        {
            this.assertProcessing(arg1, arg2, arg3);
            return;
        }

        public final function assertNotNull(arg1:Object, arg2:String, arg3:Class=null):void
        {
            this.assert(!(arg1 == null), arg2);
            return;
        }

        public final function assertNull(arg1:Object, arg2:String, arg3:Class=null):void
        {
            this.assert(arg1 == null, arg2);
            return;
        }

        internal function throwException(arg1:String, arg2:Class=null):void
        {
            var loc1:*=null;
            if (arg2 != null) 
            {
                loc1 = new arg2() as Error;
                this.assertNotNull(loc1, "ex argument must be Error object class");
            }
            else 
                loc1 = new net.wg.infrastructure.exceptions.AssertionException(arg1);
            loc1.message = arg1;
            DebugUtils.LOG_DEBUG(!scaleform.gfx.Extensions.isGFxPlayer && scaleform.gfx.Extensions.isScaleform);
            if (!scaleform.gfx.Extensions.isGFxPlayer && scaleform.gfx.Extensions.isScaleform) 
            {
                DebugUtils.LOG_ERROR(arg1);
                DebugUtils.LOG_ERROR(loc1.getStackTrace());
            }
            throw loc1;
        }

        internal function startingAssertProcessing(arg1:Boolean, arg2:String, arg3:Class):void
        {
            var loc1:*;
            if ((loc1 = Object(App.globalVarsMgr).isDevelopment) == null) 
                if (!arg1) 
                    this.throwException(arg2, arg3);
            else 
            {
                if (loc1()) 
                    this.assertProcessing = this.debugAssertProcessing;
                else 
                    this.assertProcessing = this.releaseAssertProcessing;
                this.assertProcessing(arg1, arg2, arg3);
            }
            return;
        }

        internal function debugAssertProcessing(arg1:Boolean, arg2:String, arg3:Class):void
        {
            if (!arg1) 
                this.throwException(arg2, arg3);
            return;
        }

        internal function releaseAssertProcessing(arg1:Boolean, arg2:String, arg3:Class):void
        {
            return;
        }

        
        {
            ms_instance = null;
        }

        internal var isDebug:Boolean=true;

        internal var assertProcessing:Function=null;

        internal static var ms_instance:net.wg.infrastructure.managers.utils.impl.Asserter=null;
    }
}
