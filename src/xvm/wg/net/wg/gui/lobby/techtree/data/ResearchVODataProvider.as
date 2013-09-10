package net.wg.gui.lobby.techtree.data 
{
    import __AS3__.vec.*;
    import net.wg.gui.lobby.techtree.constants.*;
    import net.wg.gui.lobby.techtree.data.vo.*;
    import net.wg.gui.lobby.techtree.interfaces.*;
    import net.wg.gui.lobby.techtree.math.*;
    import net.wg.utils.*;
    
    public class ResearchVODataProvider extends net.wg.gui.lobby.techtree.data.AbstractDataProvider implements net.wg.gui.lobby.techtree.interfaces.IResearchDataProvider
    {
        public function ResearchVODataProvider()
        {
            super();
            this.topData = new Vector.<net.wg.gui.lobby.techtree.data.vo.NodeData>();
            return;
        }

        public function get topLength():Number
        {
            return this.topData.length;
        }

        public function getDepthOfPath(arg1:Number):Number
        {
            var loc1:*=this.depthOfPaths[arg1];
            return isNaN(loc1) ? 0 : loc1;
        }

        public function getMaxDepthOfPath():Number
        {
            var loc2:*=NaN;
            var loc1:*=0;
            var loc3:*=0;
            var loc4:*=this.depthOfPaths;
            for each (loc2 in loc4) 
                loc1 = Math.max(loc1, loc2);
            return loc1;
        }

        public function getGlobalStats():net.wg.gui.lobby.techtree.data.vo.VehGlobalStats
        {
            return this.global;
        }

        public function getTopLevelAt(arg1:Number):net.wg.gui.lobby.techtree.data.vo.NodeData
        {
            return this.topData[arg1];
        }

        public function getTopLevelIndexByID(arg1:Number):Number
        {
            return this.topLevelIdxCache[arg1] == undefined ? -1 : this.topLevelIdxCache[arg1];
        }

        public override function clearUp():void
        {
            super.clearUp();
            this.topData.splice(0, this.topData.length);
            this.topLevelIdxCache = {};
            this.depthOfPaths = [];
            return;
        }

        public override function parse(arg1:Object):void
        {
            var loc4:*=NaN;
            var loc5:*=null;
            var loc6:*=null;
            this.clearUp();
            net.wg.gui.lobby.techtree.data.vo.NodeData.setDisplayInfoClass(net.wg.gui.lobby.techtree.data.vo.ResearchDisplayInfo);
            var loc1:*=App.utils.locale;
            this.global = new net.wg.gui.lobby.techtree.data.vo.VehGlobalStats();
            this.global.fromObject(arg1.global, loc1);
            var loc2:*=arg1.nodes;
            var loc3:*=loc2.length;
            loc4 = 0;
            while (loc4 < loc3) 
            {
                (loc5 = new net.wg.gui.lobby.techtree.data.vo.NodeData()).fromObject(loc2[loc4], loc1);
                nodeIdxCache[loc5.id] = nodeData.length;
                nodeData.push(loc5);
                loc6 = loc5.displayInfo as net.wg.gui.lobby.techtree.data.vo.ResearchDisplayInfo;
                this.depthOfPaths.push(loc6 == null ? 0 : loc6.getDepthOfPath());
                ++loc4;
            }
            loc2 = arg1.top;
            loc3 = loc2.length;
            loc4 = 0;
            while (loc4 < loc3) 
            {
                (loc5 = new net.wg.gui.lobby.techtree.data.vo.NodeData()).fromObject(loc2[loc4], loc1);
                this.topLevelIdxCache[loc5.id] = this.topData.length;
                this.topData.push(loc5);
                ++loc4;
            }
            return;
        }

        public function populate(arg1:net.wg.gui.lobby.techtree.math.ADG_ItemLevelsBuilder):void
        {
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc10:*=NaN;
            var loc1:*=arg1.matrix;
            var loc2:*=nodeData.length;
            var loc9:*=0;
            while (loc9 < loc2) 
            {
                if ((loc8 = (loc6 = nodeData[loc9]).displayInfo as net.wg.gui.lobby.techtree.data.vo.ResearchDisplayInfo).level > -1) 
                    arg1.addFixedPath(loc9, loc8.level);
                loc5 = 0;
                loc7 = loc8.path;
                loc10 = 0;
                while (loc10 < loc7.length) 
                {
                    loc4 = getIndexByID(loc7[loc10]);
                    loc5 = Math.max(loc5, this.getDepthOfPath(loc4));
                    ++loc10;
                }
                loc10 = 0;
                while (loc10 < loc7.length) 
                {
                    loc3 = loc7[loc10];
                    if (!(isNaN(loc3) || loc3 == 0)) 
                    {
                        loc4 = getIndexByID(loc3);
                        if (!isNaN(loc4) && this.getDepthOfPath(loc4) == loc5) 
                        {
                            loc1[loc4][loc9] = 1;
                            loc1[loc9][loc4] = -1;
                        }
                    }
                    ++loc10;
                }
                ++loc9;
            }
            return;
        }

        public function setTopLevelDump(arg1:Number, arg2:String):Boolean
        {
            var loc1:*=false;
            if (arg1 < this.topData.length && !(this.topData[arg1] == null)) 
            {
                this.topData[arg1].pickleDump = arg2;
                loc1 = true;
            }
            return loc1;
        }

        public function setTopLevelState(arg1:Number, arg2:Number, arg3:Number):Boolean
        {
            return findAndSetState(this.topData, arg1, arg2, arg3);
        }

        public function setTopLevelUnlockProps(arg1:Number, arg2:net.wg.gui.lobby.techtree.data.vo.UnlockProps):Boolean
        {
            var loc1:*=false;
            if (arg1 < this.topData.length && !(this.topData[arg1] == null)) 
            {
                this.topData[arg1].unlockProps = arg2;
                loc1 = true;
            }
            return loc1;
        }

        public function setTopLevelXP(arg1:Number, arg2:Number):Boolean
        {
            var loc1:*=false;
            if (arg1 < this.topData.length && !(this.topData[arg1] == null)) 
            {
                this.topData[arg1].earnedXP = arg2;
                loc1 = true;
            }
            return loc1;
        }

        public function setTopLevelField(arg1:String, arg2:Number, arg3:Object):Boolean
        {
            var loc2:*=null;
            var loc1:*=false;
            var loc3:*=arg1;
            switch (loc3) 
            {
                case net.wg.gui.lobby.techtree.data.vo.NodeData.NODE_DUMP_FIELD:
                    loc1 = this.setTopLevelDump(arg2, String(arg3));
                    break;
                case net.wg.gui.lobby.techtree.data.vo.NodeData.UNLOCK_PROPS_FIELD:
                    (loc2 = new net.wg.gui.lobby.techtree.data.vo.UnlockProps()).fromArray(arg3 as Array, App.utils.locale);
                    loc1 = this.setTopLevelUnlockProps(arg2, loc2);
                    break;
            }
            return loc1;
        }

        public function resolveEntityType(arg1:net.wg.gui.lobby.techtree.data.vo.NodeData, arg2:Boolean=false):uint
        {
            var loc2:*=null;
            var loc1:*=0;
            if (arg1 != null) 
                if ((loc2 = arg1.displayInfo as net.wg.gui.lobby.techtree.data.vo.ResearchDisplayInfo) != null) 
                    if (loc2.isDrawVehicle()) 
                        loc1 = arg2 ? net.wg.gui.lobby.techtree.constants.NodeEntityType.TOP_VEHICLE : net.wg.gui.lobby.techtree.constants.NodeEntityType.NEXT_VEHICLE;
                    else 
                        loc1 = net.wg.gui.lobby.techtree.constants.NodeEntityType.RESEARCH_ITEM;
            return loc1;
        }

        protected var topData:__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.data.vo.NodeData>;

        protected var topLevelIdxCache:Object;

        protected var depthOfPaths:Array;

        protected var global:net.wg.gui.lobby.techtree.data.vo.VehGlobalStats;
    }
}
