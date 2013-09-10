package net.wg.gui.lobby.techtree.nodes 
{
    import __AS3__.vec.*;
    import net.wg.gui.lobby.techtree.*;
    import net.wg.gui.lobby.techtree.constants.*;
    import net.wg.gui.lobby.techtree.interfaces.*;
    
    public class FakeNode extends net.wg.gui.lobby.techtree.nodes.Renderer
    {
        public function FakeNode()
        {
            super();
            return;
        }

        public override function isFake():Boolean
        {
            return true;
        }

        public override function isUnlocked():Boolean
        {
            return this.hasUnlockedParent();
        }

        public override function getInX():Number
        {
            return x + Math.round(_width);
        }

        public override function getOutX():Number
        {
            return x + Math.round(_width);
        }

        public override function getColorIdx(arg1:Number=-1):Number
        {
            var loc1:*=net.wg.gui.lobby.techtree.constants.ColorIndex.LOCKED;
            if (this.hasUnlockedChild()) 
            {
                if (arg1 == -1 || arg1 > 0 && isParentUnlocked(arg1)) 
                {
                    loc1 = net.wg.gui.lobby.techtree.constants.ColorIndex.UNLOCKED;
                }
            }
            else if (this.hasNext2UnlockChild()) 
            {
                if (arg1 == -1 || arg1 > 0 && isParentUnlocked(arg1)) 
                {
                    loc1 = net.wg.gui.lobby.techtree.constants.ColorIndex.NEXT2UNLOCK;
                }
            }
            return loc1;
        }

        public override function getColorIdxEx(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer):Number
        {
            var loc1:*=net.wg.gui.lobby.techtree.constants.ColorIndex.LOCKED;
            if (this.hasUnlockedChild()) 
            {
                if (arg1 == null || arg1.isUnlocked()) 
                {
                    loc1 = net.wg.gui.lobby.techtree.constants.ColorIndex.UNLOCKED;
                }
            }
            else if (this.hasNext2UnlockChild()) 
            {
                if (arg1 == null || arg1.isUnlocked()) 
                {
                    loc1 = net.wg.gui.lobby.techtree.constants.ColorIndex.NEXT2UNLOCK;
                }
            }
            return loc1;
        }

        public override function invalidateNodeState(arg1:Number):void
        {
            if (arg1 > -1 && !(this.lastPrimary == arg1)) 
            {
                this.lastPrimary = arg1;
                dispatchEvent(new net.wg.gui.lobby.techtree.TechTreeEvent(net.wg.gui.lobby.techtree.TechTreeEvent.STATE_CHANGED, arg1, index));
            }
            return;
        }

        public override function cleanUp():void
        {
            this.clearChildren();
            this.clearParents();
            super.cleanUp();
            return;
        }

        public function setChildren(arg1:__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>):void
        {
            this.clearChildren();
            this.children = arg1;
            var loc1:*=this.children.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                this.children[loc2].addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.STATE_CHANGED, this.handleChildStateChanged, false, 0, true);
                ++loc2;
            }
            return;
        }

        public function setParents(arg1:__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>):void
        {
            this.clearParents();
            this.parents = arg1;
            var loc1:*=this.parents.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                this.parents[loc2].addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.STATE_CHANGED, this.handleParentStateChanged, false, 0, true);
                ++loc2;
            }
            return;
        }

        public override function toString():String
        {
            return "[FakeNode " + index + ", " + name + "]";
        }

        protected override function preInitialize():void
        {
            super.preInitialize();
            this.parents = new Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>();
            this.children = new Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>();
            return;
        }

        internal function clearParents():void
        {
            var loc1:*=null;
            while (this.parents.length > 0) 
            {
                loc1 = this.parents.pop();
                if (loc1 == null) 
                {
                    continue;
                }
                loc1.removeEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.STATE_CHANGED, this.handleParentStateChanged);
            }
            return;
        }

        internal function clearChildren():void
        {
            var loc1:*=null;
            while (this.children.length > 0) 
            {
                loc1 = this.children.pop();
                if (loc1 == null) 
                {
                    continue;
                }
                loc1.removeEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.STATE_CHANGED, this.handleChildStateChanged);
            }
            return;
        }

        internal function hasUnlockedParent():Boolean
        {
            var loc1:*=null;
            var loc2:*=this.parents.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc1 = this.parents[loc3];
                if (loc1.isUnlocked()) 
                {
                    return true;
                }
                ++loc3;
            }
            return false;
        }

        internal function hasUnlockedChild():Boolean
        {
            var loc1:*=null;
            var loc2:*=this.children.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc1 = this.children[loc3];
                if (loc1.isFake()) 
                {
                    if ((loc1 as net.wg.gui.lobby.techtree.nodes.FakeNode).hasUnlockedChild()) 
                    {
                        return true;
                    }
                }
                else if (loc1.isUnlocked()) 
                {
                    return true;
                }
                ++loc3;
            }
            return false;
        }

        internal function hasNext2UnlockChild():Boolean
        {
            var loc1:*=null;
            var loc2:*=this.children.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc1 = this.children[loc3];
                if (loc1.isFake()) 
                {
                    if ((loc1 as net.wg.gui.lobby.techtree.nodes.FakeNode).hasNext2UnlockChild()) 
                    {
                        return true;
                    }
                }
                else if (loc1.isNext2Unlock()) 
                {
                    return true;
                }
                ++loc3;
            }
            return false;
        }

        internal function handleParentStateChanged(arg1:net.wg.gui.lobby.techtree.TechTreeEvent):void
        {
            this.invalidateNodeState(arg1.primary);
            return;
        }

        internal function handleChildStateChanged(arg1:net.wg.gui.lobby.techtree.TechTreeEvent):void
        {
            this.invalidateNodeState(arg1.primary);
            return;
        }

        internal var children:__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>;

        internal var parents:__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>;

        internal var lastPrimary:Number=NaN;
    }
}
