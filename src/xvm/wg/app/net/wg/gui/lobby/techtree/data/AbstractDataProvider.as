package net.wg.gui.lobby.techtree.data 
{
    import __AS3__.vec.*;
    import flash.events.*;
    import net.wg.gui.lobby.techtree.*;
    import net.wg.gui.lobby.techtree.data.vo.*;
    import net.wg.gui.lobby.techtree.interfaces.*;
    
    public class AbstractDataProvider extends Object implements net.wg.gui.lobby.techtree.interfaces.INodesDataProvider
    {
        public function AbstractDataProvider()
        {
            super();
            this.dispatcher = new flash.events.EventDispatcher(this);
            this.nodeData = new Vector.<net.wg.gui.lobby.techtree.data.vo.NodeData>();
            return;
        }

        public function get nation():String
        {
            return this._nation;
        }

        public function get length():Number
        {
            return this.nodeData.length;
        }

        public function clearUp():void
        {
            this.nodeData.splice(0, this.nodeData.length);
            this.nodeIdxCache = {};
            return;
        }

        public function invalidate(arg1:String, arg2:Object):void
        {
            this._nation = arg1;
            if (arg2 != null) 
            {
                this.parse(arg2);
                this.dispatchEvent(new net.wg.gui.lobby.techtree.TechTreeEvent(net.wg.gui.lobby.techtree.TechTreeEvent.DATA_BUILD_COMPLETE));
            }
            return;
        }

        public function parse(arg1:Object):void
        {
            throw new Error("Method \'raw\' must be override.");
        }

        public function getRootItem():net.wg.gui.lobby.techtree.data.vo.NodeData
        {
            return this.nodeData.length > 0 ? this.nodeData[0] : null;
        }

        public function getItemAt(arg1:Number):net.wg.gui.lobby.techtree.data.vo.NodeData
        {
            return this.nodeData[arg1];
        }

        public function getIndexByID(arg1:Number):Number
        {
            return this.nodeIdxCache[arg1] == undefined ? -1 : this.nodeIdxCache[arg1];
        }

        public function getItemByID(arg1:Number):net.wg.gui.lobby.techtree.data.vo.NodeData
        {
            var loc1:*=this.getIndexByID(arg1);
            var loc2:*=null;
            if (this.nodeData.length > loc1 > -1) 
            {
                loc2 = this.nodeData[loc1];
            }
            return loc2;
        }

        public function setState(arg1:Number, arg2:Number, arg3:Number):Boolean
        {
            return findAndSetState(this.nodeData, arg1, arg2, arg3);
        }

        public function setEarnedXP(arg1:Number, arg2:Number):Boolean
        {
            var loc1:*=false;
            if (arg1 < this.nodeData.length && !(this.nodeData[arg1] == null)) 
            {
                this.nodeData[arg1].earnedXP = arg2;
                loc1 = true;
            }
            return loc1;
        }

        public function setUnlockProps(arg1:Number, arg2:net.wg.gui.lobby.techtree.data.vo.UnlockProps):Boolean
        {
            var loc1:*=false;
            if (arg1 < this.nodeData.length && !(this.nodeData[arg1] == null)) 
            {
                this.nodeData[arg1].unlockProps = arg2;
                loc1 = true;
            }
            return loc1;
        }

        public function setDump(arg1:Number, arg2:String):Boolean
        {
            var loc1:*=false;
            if (arg1 < this.nodeData.length && !(this.nodeData[arg1] == null)) 
            {
                this.nodeData[arg1].pickleDump = arg2;
                loc1 = true;
            }
            return loc1;
        }

        public function setItemField(arg1:String, arg2:Number, arg3:Object):Boolean
        {
            var loc2:*=null;
            var loc1:*=false;
            var loc3:*=arg1;
            switch (loc3) 
            {
                case net.wg.gui.lobby.techtree.data.vo.NodeData.NODE_DUMP_FIELD:
                {
                    loc1 = this.setDump(arg2, String(arg3));
                    break;
                }
                case net.wg.gui.lobby.techtree.data.vo.NodeData.UNLOCK_PROPS_FIELD:
                {
                    (loc2 = new net.wg.gui.lobby.techtree.data.vo.UnlockProps()).fromArray(arg3 as Array, App.utils.locale);
                    loc1 = this.setUnlockProps(arg2, loc2);
                    break;
                }
            }
            return loc1;
        }

        public function addEventListener(arg1:String, arg2:Function, arg3:Boolean=false, arg4:int=0, arg5:Boolean=false):void
        {
            this.dispatcher.addEventListener(arg1, arg2, arg3, arg4, arg5);
            return;
        }

        public function removeEventListener(arg1:String, arg2:Function, arg3:Boolean=false):void
        {
            this.dispatcher.removeEventListener(arg1, arg2, arg3);
            return;
        }

        public function dispatchEvent(arg1:flash.events.Event):Boolean
        {
            return this.dispatcher.dispatchEvent(arg1);
        }

        public function hasEventListener(arg1:String):Boolean
        {
            return this.dispatcher.hasEventListener(arg1);
        }

        public function willTrigger(arg1:String):Boolean
        {
            return this.dispatcher.willTrigger(arg1);
        }

        protected static function findAndSetState(arg1:__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.data.vo.NodeData>, arg2:Number, arg3:Number, arg4:Number):Boolean
        {
            var loc1:*=false;
            var loc2:*;
            if ((loc2 = arg1[arg2]) != null) 
            {
                loc1 = !((loc2.state & arg3) == (arg4 & arg3));
                loc2.state = arg4;
            }
            return loc1;
        }

        protected var _nation:String="ussr";

        protected var nodeData:__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.data.vo.NodeData>;

        protected var nodeIdxCache:Object;

        protected var dispatcher:flash.events.EventDispatcher;
    }
}
