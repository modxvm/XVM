package net.wg.gui.lobby.techtree.math 
{
    public class ADG_ItemLevelsBuilder extends Object
    {
        public function ADG_ItemLevelsBuilder(arg1:Number, arg2:Number)
        {
            super();
            if (arg1 > 0) 
            {
                this.matrixDimension = arg1;
                this.createEmptyAdjacencyMatrix();
            }
            this.fixedPaths = {};
            this.maxLevelWidth = arg2;
            return;
        }

        internal function searchMaxPathLegth(arg1:Number, arg2:Number, arg3:Array, arg4:Number):void
        {
            if (arg4 > 20) 
            {
                this.isCyclicReference = true;
                this.maxPaths[arg2] = -1;
                return;
            }
            if (arg3[arg1] == -1 && (this.maxPaths[arg2] < arg4 || this.maxPaths[arg2] == undefined)) 
            {
                this.maxPaths[arg2] = arg4;
                if (arg4 > this.widthPartitioning) 
                {
                    this.widthPartitioning = arg4;
                }
                return;
            }
            var loc1:*=arg3.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (loc2 != arg1) 
                {
                    if (arg3[loc2] == -1) 
                    {
                        this.searchMaxPathLegth(arg1, arg2, this.adjacencyMatrix[loc2], arg4 + 1);
                    }
                }
                ++loc2;
            }
            return;
        }

        internal function distributionOfVerticesOnLevels():void
        {
            var loc1:*=NaN;
            var loc3:*=NaN;
            var loc6:*=null;
            var loc7:*=NaN;
            var loc8:*=null;
            var loc9:*=NaN;
            this.maxPaths = new Array(this.matrixDimension);
            this.widthPartitioning = 0;
            this.maxPaths[0] = 0;
            loc1 = 1;
            while (loc1 < this.matrixDimension) 
            {
                this.searchMaxPathLegth(0, loc1, this.adjacencyMatrix[loc1], 1);
                ++loc1;
            }
            var loc2:*=0;
            this.levels = new Array(this.widthPartitioning);
            this.addLevelItem(0, 0, false, false);
            var loc4:*=this.maxPaths.length;
            var loc5:*={};
            loc1 = 1;
            while (loc1 < loc4) 
            {
                loc3 = this.maxPaths[loc1];
                loc2 = this.fixedPaths[loc1];
                this.addLevelItem(loc3, loc1, false, false);
                if (!isNaN(loc2) && loc3 < loc2) 
                {
                    loc6 = this.levels[loc3][(this.levels[loc3].length - 1)];
                    loc7 = loc2 - loc3;
                    loc8 = this.adjacencyMatrix[loc1];
                    loc9 = 0;
                    while (loc9 < loc8.length) 
                    {
                        if (loc8[loc9] == -1) 
                        {
                            if (loc5[loc9] != null) 
                            {
                                this.adjacencyMatrix[loc6.index][loc5[loc9]] = -2;
                                this.adjacencyMatrix[loc5[loc9]][loc6.index] = 2;
                                this.adjacencyMatrix[loc6.index][loc9] = 0;
                                this.adjacencyMatrix[loc9][loc6.index] = 0;
                                this.addLevelItem(loc2, loc6.index, false, true);
                                this.removeLevelItem(loc3, loc6.index);
                            }
                            else 
                            {
                                loc5[loc9] = this.addFakeNodes(loc6, loc3, loc9, loc7);
                            }
                        }
                        ++loc9;
                    }
                }
                ++loc1;
            }
            this.normalizeLevels();
            return;
        }

        internal function getLines(arg1:Number, arg2:Boolean):Array
        {
            var loc2:*=null;
            var loc7:*=NaN;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=null;
            var loc14:*=NaN;
            var loc15:*=NaN;
            var loc1:*=[];
            if (arg1 == 0) 
            {
                return loc1;
            }
            var loc3:*;
            var loc4:*=(loc3 = this.levels[arg1]).length;
            var loc5:*;
            if (!(loc5 = this.levels[arg2 ? arg1 + 1 : (arg1 - 1)])) 
            {
                return loc1;
            }
            var loc6:*=loc5.length;
            var loc11:*=arg2 ? 1 : -1;
            var loc12:*=arg2 ? 2 : -2;
            var loc13:*=0;
            while (loc13 < loc4) 
            {
                if ((loc9 = loc3[loc13]) != null) 
                {
                    loc7 = (loc8 = this.adjacencyMatrix[loc9.index]).length;
                    loc14 = 0;
                    while (loc14 < loc7) 
                    {
                        if (loc8[loc14] == loc11 || loc8[loc14] == loc12) 
                        {
                            loc15 = 0;
                            while (loc15 < loc6) 
                            {
                                if (!((loc10 = loc5[loc15]) == null) && loc10.index == loc14) 
                                {
                                    loc2 = arg2 ? LevelLine.makeByNext(loc9, loc10) : LevelLine.makeByTop(loc9, loc10);
                                    loc1.push(loc2);
                                }
                                ++loc15;
                            }
                        }
                        ++loc14;
                    }
                }
                ++loc13;
            }
            return loc1;
        }

        internal function getCrossingCost(arg1:Array):Number
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc8:*=NaN;
            var loc1:*=0;
            var loc2:*=arg1.length;
            var loc7:*=0;
            while (loc7 < (loc2 - 1)) 
            {
                loc3 = arg1[loc7];
                loc8 = loc7 + 1;
                while (loc8 < loc2) 
                {
                    loc4 = arg1[loc8];
                    loc5 = loc3.start - loc4.start;
                    loc6 = loc3.end - loc4.end;
                    if ((loc4.start - loc3.start) * (loc4.end - loc3.end) < 0 && loc5 * loc6 < 0 || !(loc3.start == loc3.end) && loc5 == loc6 && Math.abs(loc3.start - loc4.start) == 1) 
                    {
                        loc1 = loc1 + (this.maxLevelWidth + 1);
                    }
                    ++loc8;
                }
                ++loc7;
            }
            return loc1;
        }

        internal function normalizeLevels():void
        {
            var loc1:*=NaN;
            loc1 = 0;
            while (loc1 < this.levels.length) 
            {
                if (this.levels[loc1].length > this.maxLevelWidth) 
                {
                    this.zipLevel(loc1);
                }
                ++loc1;
            }
            loc1 = 0;
            while (loc1 < this.levels.length) 
            {
                this.alignLevel(loc1);
                ++loc1;
            }
            return;
        }

        internal function getCrossingCostEx(arg1:Array):Number
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc8:*=NaN;
            var loc1:*=0;
            var loc2:*=arg1.length;
            var loc7:*=0;
            while (loc7 < (loc2 - 1)) 
            {
                loc3 = arg1[loc7];
                loc8 = loc7 + 1;
                while (loc8 < loc2) 
                {
                    loc4 = arg1[loc8];
                    loc5 = loc3.start - loc4.start;
                    loc6 = loc3.end - loc4.end;
                    if ((loc4.start - loc3.start) * (loc4.end - loc3.end) < 0 && loc5 * loc6 < 0 || !(loc3.start == loc3.end) && !(loc4.start == loc4.end) && (loc3.end >= loc4.start && loc3.start <= loc4.end || loc4.end <= loc3.start && loc3.end <= loc4.start) && !(loc3.start == loc4.start)) 
                    {
                        loc1 = loc1 + (this.maxLevelWidth + 1);
                    }
                    ++loc8;
                }
                ++loc7;
            }
            return loc1;
        }

        internal function findMaxChildCount(arg1:Array):Number
        {
            var loc3:*=NaN;
            if (this.isCyclicReference || arg1 == null) 
            {
                return 0;
            }
            var loc1:*=[];
            var loc2:*=0;
            loc3 = 0;
            while (loc3 < arg1.length) 
            {
                if (arg1[loc3] == 1 || arg1[loc3] == 2) 
                {
                    ++loc2;
                    loc1.push(loc3);
                }
                ++loc3;
            }
            loc3 = 0;
            while (loc3 < loc1.length) 
            {
                loc2 = Math.max(this.findMaxChildCount(this.adjacencyMatrix[loc1[loc3]]), loc2);
                ++loc3;
            }
            return loc2;
        }

        internal function breedNodesByNextRelations(arg1:Number):void
        {
            var loc3:*=NaN;
            var loc4:*=null;
            var loc10:*=NaN;
            var loc1:*=this.levels[arg1];
            var loc2:*=loc1.length;
            var loc5:*=0;
            var loc6:*=new Array(loc2);
            loc3 = 0;
            while (loc3 < loc2) 
            {
                loc6[loc3] = 1;
                ++loc3;
            }
            loc3 = 0;
            while (loc3 < loc2) 
            {
                if ((loc4 = loc1[loc3]) != null) 
                {
                    if (loc5 > 0) 
                    {
                        loc5 = 0;
                        break;
                    }
                }
                else 
                {
                    ++loc5;
                    if (!(loc1[(loc3 - 1)] == null) && loc1[(loc3 - 1)].fake && !(loc1[loc3 + 1] == null)) 
                    {
                        if (loc3 == 1) 
                        {
                            loc5 = 0;
                        }
                        break;
                    }
                }
                ++loc3;
            }
            if (loc5 < 1) 
            {
                return;
            }
            var loc7:*=false;
            var loc8:*=0;
            var loc9:*=0;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                if ((loc4 = loc1[loc3]) != null) 
                {
                    if ((loc8 = (this.findMaxChildCount(this.adjacencyMatrix[loc4.index]) - 1)) > 0) 
                    {
                        loc10 = 0;
                        while (loc10 < loc8 && loc5 > 0) 
                        {
                            if (loc3 + loc10 + 1 < loc2) 
                            {
                                loc6[loc3 + loc10 + loc9 + 1] = 0;
                                loc7 = true;
                            }
                            ++loc10;
                            --loc5;
                        }
                        ++loc9;
                    }
                }
                ++loc3;
            }
            if (!loc7) 
            {
                return;
            }
            this.mapLevel(arg1, loc6);
            return;
        }

        internal function makeMinCrossing(arg1:Number, arg2:Boolean):Number
        {
            var levelIdx:Number;
            var next:Boolean;
            var checkLevel:Array;
            var checkLevelLen:Number;
            var i:Number;
            var holdDxs:Array;
            var matrix:Array;
            var node:LevelItem;
            var other:LevelItem;
            var crossings:Array;
            var lines:Array;
            var algo:net.wg.gui.lobby.techtree.math.HungarianAlgorithm;
            var result:Array;
            var newLevel:Array;
            var row:Number;
            var column:Number;
            var profit:Number;
            var position:net.wg.gui.lobby.techtree.math.MatrixPosition;
            var x:Number;

            var loc1:*;
            i = NaN;
            node = null;
            other = null;
            crossings = null;
            lines = null;
            row = NaN;
            column = NaN;
            position = null;
            x = NaN;
            levelIdx = arg1;
            next = arg2;
            checkLevel = this.levels[levelIdx];
            checkLevelLen = checkLevel.length;
            holdDxs = new Array(checkLevelLen);
            matrix = new Array(checkLevelLen);
            i = 0;
            while (i < checkLevelLen) 
            {
                holdDxs[i] = checkLevel[i] == null ? 0 : checkLevel[i].dx;
                ++i;
            }
            i = 0;
            while (i < checkLevelLen) 
            {
                node = checkLevel[i];
                crossings = new Array(checkLevelLen);
                x = 0;
                while (x < checkLevelLen) 
                {
                    other = null;
                    if (i != x) 
                    {
                        if (node != null) 
                        {
                            node.dx = x;
                        }
                        other = checkLevel[x];
                        if (other != null) 
                        {
                            other.dx = i;
                        }
                    }
                    lines = this.getLines(levelIdx, next);
                    crossings[x] = this.getTotalCost(lines);
                    if (other != null) 
                    {
                        other.dx = x;
                    }
                    ++x;
                }
                if (node != null) 
                {
                    node.dx = holdDxs[i];
                }
                matrix[i] = crossings;
                ++i;
            }
            algo = new net.wg.gui.lobby.techtree.math.HungarianAlgorithm();
            result = algo.compute(algo.makeCostMatrix(matrix, function (arg1:Number):Number
            {
                return arg1;
            }))
            newLevel = new Array(checkLevelLen);
            profit = 0;
            i = 0;
            while (i < result.length) 
            {
                position = result[i];
                row = position.row;
                column = position.column;
                node = checkLevel[row];
                if (node != null) 
                {
                    node.dx = column;
                }
                newLevel[column] = node;
                profit = profit + matrix[row][column];
                ++i;
            }
            this.levels[levelIdx] = newLevel;
            return profit;
        }

        internal function findNodePositionInLevel(arg1:Number, arg2:Boolean):Array
        {
            var loc7:*=null;
            var loc1:*=-1;
            var loc2:*=0;
            var loc3:*=Number.MAX_VALUE;
            var loc4:*=0;
            var loc5:*=this.maxLevelWidth * this.maxLevelWidth;
            var loc6:*=0;
            while (!(loc1 == 0) && !(loc4 == 3) && !(loc2 == loc1) && loc6 < loc5) 
            {
                loc2 = loc1;
                loc1 = this.makeMinCrossing(arg1, arg2);
                loc7 = this.getLines(arg1, arg2);
                loc1 = loc1 * this.getTotalCost(loc7);
                if (loc1 <= loc3) 
                {
                    loc4 = loc1 != loc3 ? 0 : loc4 + 1;
                    loc3 = loc1;
                }
                ++loc6;
            }
            return loc7;
        }

        internal function determineNodesPositionsOnLevel():void
        {
            var loc1:*=null;
            var loc3:*=NaN;
            this.breedNodesByNextRelations(1);
            var loc2:*=2;
            while (loc2 < this.levels.length) 
            {
                loc1 = this.findNodePositionInLevel(loc2, false);
                if (this.hasFakeNode(loc2)) 
                {
                    this.breedNodesByNextRelations(loc2);
                }
                if (this.getCrossingCostEx(loc1) > 0) 
                {
                    loc3 = this.makeMinCrossing((loc2 - 1), true);
                    if (!(loc3 == 0) && loc2 == (this.levels.length - 1)) 
                    {
                        this.findNodePositionInLevel(loc2, false);
                    }
                }
                ++loc2;
            }
            this.buildLevelsCache();
            return;
        }

        public function get matrix():Array
        {
            return this.adjacencyMatrix;
        }

        public function get nodesByLevel():Array
        {
            return this.levels;
        }

        public function get levelDimension():net.wg.gui.lobby.techtree.math.MatrixPosition
        {
            var loc3:*=NaN;
            var loc4:*=null;
            var loc1:*=this.levels.length;
            var loc2:*=0;
            var loc5:*=1;
            while (loc5 < loc1) 
            {
                loc3 = (loc4 = this.levels[loc5]).length;
                while (loc3 >= 0) 
                {
                    if (loc4[loc3] != null) 
                    {
                        break;
                    }
                    --loc3;
                }
                loc2 = Math.max(loc3 + 1, loc2);
                ++loc5;
            }
            return new net.wg.gui.lobby.techtree.math.MatrixPosition(this.levels.length, loc2);
        }

        public function getParentLevelIdxs(arg1:Number):Array
        {
            return this.parentLevelIdxs[arg1];
        }

        public function getChildrenLevelIdxs(arg1:Number):Array
        {
            return this.childrenLevelIdxs[arg1];
        }

        public function hasCyclicReference():Boolean
        {
            return this.isCyclicReference;
        }

        public function addFixedPath(arg1:Number, arg2:Number):void
        {
            this.fixedPaths[arg1] = arg2;
            return;
        }

        public function process():void
        {
            this.isCyclicReference = false;
            this.distributionOfVerticesOnLevels();
            this.determineNodesPositionsOnLevel();
            return;
        }

        internal function createEmptyAdjacencyMatrix():void
        {
            var loc2:*=NaN;
            this.adjacencyMatrix = new Array(this.matrixDimension);
            var loc1:*=0;
            while (loc1 < this.matrixDimension) 
            {
                this.adjacencyMatrix[loc1] = [];
                loc2 = 0;
                while (loc2 < this.matrixDimension) 
                {
                    this.adjacencyMatrix[loc1][loc2] = 0;
                    ++loc2;
                }
                ++loc1;
            }
            return;
        }

        internal function getTotalCost(arg1:Array):Number
        {
            var loc2:*=null;
            var loc1:*=this.getCrossingCostEx(arg1);
            var loc3:*=0;
            while (loc3 < arg1.length) 
            {
                loc2 = arg1[loc3];
                if (loc2.start != loc2.end) 
                {
                    loc1 = loc1 + Math.abs(loc2.start - loc2.end);
                }
                ++loc3;
            }
            return loc1;
        }

        internal function alignLevel(arg1:Number):void
        {
            var loc3:*=NaN;
            var loc1:*=this.levels[arg1];
            var loc2:*=this.maxLevelWidth - loc1.length;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                loc1.push(null);
                ++loc3;
            }
            loc3 = 0;
            while (loc3 < loc1.length) 
            {
                if (loc1[loc3] != null) 
                {
                    loc1[loc3].dx = loc3;
                }
                ++loc3;
            }
            return;
        }

        internal function mapLevel(arg1:Number, arg2:Array):void
        {
            var loc1:*=arg2.length;
            var loc2:*;
            if ((loc2 = this.levels[arg1]) == null) 
            {
                return;
            }
            var loc3:*=new Array(loc1);
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=0;
            while (loc5 < loc1) 
            {
                if (arg2[loc5] != 0) 
                {
                    if (loc2[loc6] == null && loc4 > 0) 
                    {
                        ++loc6;
                        --loc4;
                    }
                    loc3[loc5] = loc2[loc6];
                    if (loc3[loc5] != null) 
                    {
                        loc3[loc5].dx = loc5;
                    }
                    ++loc6;
                }
                else 
                {
                    loc3[loc5] = null;
                    ++loc4;
                }
                ++loc5;
            }
            this.levels[arg1] = loc3;
            return;
        }

        internal function addLevelItem(arg1:Number, arg2:Number, arg3:Boolean, arg4:Boolean):void
        {
            var loc2:*=NaN;
            if (this.levels[arg1] == undefined) 
            {
                this.levels[arg1] = [];
            }
            this.levels[arg1].push(new LevelItem(arg2, this.levels[arg1].length, arg3));
            if (!arg4) 
            {
                return;
            }
            var loc1:*=this.adjacencyMatrix[arg2];
            var loc3:*=0;
            while (loc3 < loc1.length) 
            {
                if ((loc2 = loc1[loc3]) == 1 || loc2 == 2) 
                {
                    this.removeLevelItem(arg1, loc3);
                    this.addLevelItem(arg1 + 1, loc3, loc2 == 2, true);
                }
                ++loc3;
            }
            return;
        }

        internal function removeLevelItem(arg1:Number, arg2:Number):void
        {
            var loc1:*=this.levels[arg1];
            var loc2:*=[];
            var loc3:*=0;
            while (loc3 < loc1.length) 
            {
                if (loc1[loc3].index != arg2) 
                {
                    loc2.push(loc1[loc3]);
                }
                ++loc3;
            }
            this.levels[arg1] = loc2;
            return;
        }

        internal function zipLevel(arg1:Number):void
        {
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=NaN;
            var loc11:*=null;
            var loc12:*=NaN;
            var loc13:*=false;
            var loc14:*=NaN;
            var loc15:*=NaN;
            var loc16:*=NaN;
            if (arg1 < 1) 
            {
                return;
            }
            var loc1:*=this.levels[(arg1 - 1)];
            var loc2:*=loc1.length;
            var loc10:*=0;
            while (loc10 < loc2) 
            {
                if ((loc5 = loc1[loc10]) != null) 
                {
                    loc3 = (loc7 = this.adjacencyMatrix[loc5.index]).length;
                    loc4 = 0;
                    loc8 = [];
                    loc9 = 0;
                    while (loc9 < loc3) 
                    {
                        if (loc7[loc9] == 1) 
                        {
                            loc8.push(loc9);
                            ++loc4;
                        }
                        ++loc9;
                    }
                    if (loc4 > 1) 
                    {
                        loc11 = this.levels[arg1];
                        loc12 = -1;
                        loc13 = true;
                        loc14 = loc4 != 2 ? 1 : 0;
                        loc9 = 0;
                        while (loc9 < loc11.length) 
                        {
                            loc6 = loc11[loc9];
                            loc15 = 0;
                            while (loc15 < loc8.length) 
                            {
                                loc16 = loc8[loc15];
                                if (loc6.index == loc16 && loc4 > loc14) 
                                {
                                    if (loc13) 
                                    {
                                        loc12 = this.addFakeNode(loc6, arg1, loc5.index);
                                    }
                                    else if (loc12 > 0) 
                                    {
                                        this.addFakeRelations(loc5.index, loc6.index, loc12);
                                        this.addLevelItem(arg1 + 1, loc6.index, false, true);
                                        this.removeLevelItem(arg1, loc6.index);
                                    }
                                    loc13 = --loc4 % 2 > 0 && loc14 > 0;
                                }
                                ++loc15;
                            }
                            ++loc9;
                        }
                    }
                }
                ++loc10;
            }
            return;
        }

        internal function buildLevelsCache():void
        {
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=NaN;
            var loc9:*=null;
            var loc10:*=null;
            var loc11:*=NaN;
            var loc12:*=NaN;
            this.parentLevelIdxs = {};
            this.childrenLevelIdxs = {};
            var loc1:*=this.levels.length;
            this.levelByNode = new Array(loc1);
            loc3 = 0;
            while (loc3 < loc1) 
            {
                loc5 = this.levels[loc3];
                this.levelByNode[loc3] = {};
                loc2 = loc5.length;
                loc4 = 0;
                while (loc4 < loc2) 
                {
                    if ((loc6 = loc5[loc4]) != null) 
                    {
                        this.levelByNode[loc3][loc6.index] = loc4;
                    }
                    ++loc4;
                }
                ++loc3;
            }
            loc1 = this.levels.length;
            loc3 = 0;
            while (loc3 < loc1) 
            {
                loc2 = (loc5 = this.levels[loc3]).length;
                loc4 = 0;
                while (loc4 < loc2) 
                {
                    if ((loc6 = loc5[loc4]) != null) 
                    {
                        loc8 = (loc7 = this.adjacencyMatrix[loc6.index]).length;
                        loc9 = [];
                        loc10 = [];
                        loc11 = 0;
                        while (loc11 < loc8) 
                        {
                            if ((loc12 = loc7[loc11]) == 1 || loc12 == 2) 
                            {
                                loc9.push(this.levelByNode[loc3 + 1][loc11]);
                            }
                            if (loc12 == -1 || loc12 == -2) 
                            {
                                loc10.push(this.levelByNode[(loc3 - 1)][loc11]);
                            }
                            ++loc11;
                        }
                        this.parentLevelIdxs[loc6.index] = loc10;
                        this.childrenLevelIdxs[loc6.index] = loc9;
                    }
                    ++loc4;
                }
                ++loc3;
            }
            return;
        }

        internal function addFakeRelations(arg1:Number, arg2:Number, arg3:Number):void
        {
            this.adjacencyMatrix[arg3][arg2] = 2;
            this.adjacencyMatrix[arg2][arg3] = -2;
            this.adjacencyMatrix[arg3][arg1] = -2;
            this.adjacencyMatrix[arg1][arg3] = 2;
            return;
        }

        internal function addFakeNode(arg1:LevelItem, arg2:Number, arg3:Number):Number
        {
            var loc2:*=NaN;
            var loc1:*=arg1.index;
            this.adjacencyMatrix[arg3][loc1] = 0;
            this.adjacencyMatrix[loc1][arg3] = 0;
            loc2 = 0;
            while (loc2 < this.matrixDimension) 
            {
                this.adjacencyMatrix[loc2].push(0);
                ++loc2;
            }
            var loc3:*=this.matrixDimension;
            var loc5:*;
            var loc6:*=((loc5 = this).matrixDimension + 1);
            loc5.matrixDimension = loc6;
            var loc4:*=new Array(this.matrixDimension);
            loc2 = 0;
            while (loc2 < loc4.length) 
            {
                loc4[loc2] = 0;
                ++loc2;
            }
            this.adjacencyMatrix.push(loc4);
            this.addFakeRelations(arg3, loc1, loc3);
            this.addLevelItem(arg2 + 1, arg1.index, arg1.fake, true);
            arg1.index = loc3;
            arg1.fake = true;
            return loc3;
        }

        internal function addFakeNodes(arg1:LevelItem, arg2:Number, arg3:Number, arg4:Number):Number
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=0;
            while (loc3 < arg4) 
            {
                loc2 = this.addFakeNode(arg1, arg2, arg3);
                if (loc3 == 0) 
                {
                    loc1 = loc2;
                }
                arg1 = this.levels[arg2][(this.levels[arg2].length - 1)];
                ++loc3;
            }
            return loc1;
        }

        internal function hasFakeNode(arg1:Number):Boolean
        {
            var loc1:*=this.levels[arg1];
            var loc2:*=0;
            while (loc2 < loc1.length) 
            {
                if (!(loc1[loc2] == null) && loc1[loc2].fake) 
                {
                    return true;
                }
                ++loc2;
            }
            return false;
        }

        internal var matrixDimension:Number;

        internal var widthPartitioning:Number;

        internal var maxLevelWidth:Number;

        internal var adjacencyMatrix:Array;

        internal var levels:Array;

        internal var fixedPaths:Object;

        internal var levelByNode:Array;

        internal var parentLevelIdxs:Object;

        internal var childrenLevelIdxs:Object;

        internal var isCyclicReference:Boolean=false;

        internal var maxPaths:Array;
    }
}


class LevelItem extends Object
{
    public function LevelItem(arg1:uint, arg2:uint, arg3:Boolean)
    {
        super();
        this.index = arg1;
        this.dx = arg2;
        this.fake = arg3;
        return;
    }

    public var index:uint;

    public var dx:uint;

    public var fake:Boolean;
}

class LevelLine extends Object
{
    public function LevelLine(arg1:uint, arg2:uint, arg3:uint, arg4:uint)
    {
        super();
        this.start = arg1;
        this.end = arg2;
        this.parent = arg3;
        this.child = arg4;
        return;
    }

    public static function makeByTop(arg1:LevelItem, arg2:LevelItem):LevelLine
    {
        return new LevelLine(arg2.dx, arg1.dx, arg2.index, arg1.index);
    }

    public static function makeByNext(arg1:LevelItem, arg2:LevelItem):LevelLine
    {
        return new LevelLine(arg1.dx, arg2.dx, arg1.index, arg2.index);
    }

    public var start:uint;

    public var end:uint;

    public var parent:uint;

    public var child:uint;
}