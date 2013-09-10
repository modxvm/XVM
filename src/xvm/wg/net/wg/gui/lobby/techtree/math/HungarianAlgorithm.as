package net.wg.gui.lobby.techtree.math 
{
    public final class HungarianAlgorithm extends Object
    {
        public function HungarianAlgorithm()
        {
            super();
            return;
        }

        public function makeCostMatrix(arg1:Array, arg2:Function):Array
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=NaN;
            var loc1:*=[];
            var loc2:*=0;
            while (loc2 < arg1.length) 
            {
                loc3 = arg1[loc2];
                loc4 = [];
                loc5 = 0;
                while (loc5 < loc3.length) 
                {
                    loc4.push(arg2(loc3[loc5]));
                    ++loc5;
                }
                loc1.push(loc4);
                ++loc2;
            }
            return loc1;
        }

        public function compute(arg1:Array):Array
        {
            var loc3:*=NaN;
            var loc7:*=NaN;
            this.C = this.padMatrix(arg1);
            this.n = this.C.length;
            var loc1:*=arg1.length;
            var loc2:*=arg1[0].length;
            this.rowCovered = [];
            loc3 = 0;
            while (loc3 < this.n) 
            {
                this.rowCovered.push(false);
                ++loc3;
            }
            this.columnCovered = [];
            loc3 = 0;
            while (loc3 < this.n) 
            {
                this.columnCovered.push(false);
                ++loc3;
            }
            this.Z0Row = 0;
            this.Z0Column = 0;
            this.path = this.makeMatrix(this.n * 2, 0);
            this.marked = this.makeMatrix(this.n, 0);
            var loc4:*=1;
            var loc5:*=false;
            label430: while (!loc5) 
            {
                var loc8:*=loc4;
                switch (loc8) 
                {
                    case 1:
                        loc4 = this.step1();
                        continue label430;
                    case 2:
                        loc4 = this.step2();
                        continue label430;
                    case 3:
                        loc4 = this.step3();
                        continue label430;
                    case 4:
                        loc4 = this.step4();
                        continue label430;
                    case 5:
                        loc4 = this.step5();
                        continue label430;
                    case 6:
                        loc4 = this.step6();
                        continue label430;
                    case 7:
                        loc5 = true;
                        continue label430;
                }
            }
            var loc6:*=[];
            loc3 = 0;
            while (loc3 < loc1) 
            {
                loc7 = 0;
                while (loc7 < loc2) 
                {
                    if (this.marked[loc3][loc7] == 1) 
                        loc6.push(new net.wg.gui.lobby.techtree.math.MatrixPosition(loc3, loc7));
                    ++loc7;
                }
                ++loc3;
            }
            return loc6;
        }

        internal function padMatrix(arg1:Array, arg2:Number=0):Array
        {
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=null;
            var loc1:*=0;
            var loc2:*=arg1.length;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                loc5 = arg1[loc3];
                loc1 = Math.max(loc1, loc5.length);
                ++loc3;
            }
            loc2 = Math.max(loc1, loc2);
            var loc6:*=[];
            loc3 = 0;
            while (loc3 < arg1.length) 
            {
                loc4 = (loc5 = arg1[loc3]).length;
                while (loc4 < loc2) 
                {
                    loc5.push(arg2);
                    ++loc4;
                }
                loc6.push(loc5);
                ++loc3;
            }
            while (loc3 < loc2) 
            {
                loc5 = [];
                loc4 = 0;
                while (loc4 < loc2) 
                {
                    loc5.push(arg2);
                    ++loc4;
                }
                loc6.push(loc5);
                ++loc3;
            }
            return loc6;
        }

        internal function makeMatrix(arg1:Number, arg2:Number):Array
        {
            var loc2:*=null;
            var loc4:*=NaN;
            var loc1:*=[];
            var loc3:*=0;
            while (loc3 < arg1) 
            {
                loc2 = [];
                loc4 = 0;
                while (loc4 < arg1) 
                {
                    loc2.push(arg2);
                    ++loc4;
                }
                loc1.push(loc2);
                ++loc3;
            }
            return loc1;
        }

        internal function clearCovers():void
        {
            var loc1:*=0;
            while (loc1 < this.n) 
            {
                this.rowCovered[loc1] = false;
                this.columnCovered[loc1] = false;
                ++loc1;
            }
            return;
        }

        internal function findZero():Object
        {
            var loc5:*=NaN;
            var loc1:*=-1;
            var loc2:*=-1;
            var loc3:*=0;
            var loc4:*=false;
            while (!loc4) 
            {
                loc5 = 0;
                for (;;) 
                {
                    if (this.C[loc3][loc5] == 0 && !this.rowCovered[loc3] && !this.columnCovered[loc5]) 
                    {
                        loc1 = loc3;
                        loc2 = loc5;
                        loc4 = true;
                    }
                    if (!((loc5 = loc5 + 1) >= this.n)) 
                        continue;
                    break;
                }
                loc3 = loc3 + 1;
                if (!(loc3 >= this.n)) 
                    continue;
                loc4 = true;
            }
            return {"row":loc1, "col":loc2};
        }

        internal function findSmallest():Number
        {
            var loc3:*=NaN;
            var loc1:*=Number.MAX_VALUE;
            var loc2:*=0;
            while (loc2 < this.n) 
            {
                loc3 = 0;
                while (loc3 < this.n) 
                {
                    if (!this.rowCovered[loc2] && !this.columnCovered[loc3]) 
                        if (loc1 > this.C[loc2][loc3]) 
                            loc1 = this.C[loc2][loc3];
                    ++loc3;
                }
                ++loc2;
            }
            return loc1;
        }

        internal function findStarInRow(arg1:Number):Number
        {
            var loc1:*=-1;
            var loc2:*=0;
            while (loc2 < this.n) 
            {
                if (this.marked[arg1][loc2] == 1) 
                {
                    loc1 = loc2;
                    break;
                }
                ++loc2;
            }
            return loc1;
        }

        internal function findStarInCol(arg1:Number):Number
        {
            var loc1:*=-1;
            var loc2:*=0;
            while (loc2 < this.n) 
            {
                if (this.marked[loc2][arg1] == 1) 
                {
                    loc1 = loc2;
                    break;
                }
                ++loc2;
            }
            return loc1;
        }

        internal function findPrimeInRow(arg1:Number):Number
        {
            var loc1:*=-1;
            var loc2:*=0;
            while (loc2 < this.n) 
            {
                if (this.marked[arg1][loc2] == 2) 
                {
                    loc1 = loc2;
                    break;
                }
                ++loc2;
            }
            return loc1;
        }

        internal function convertPath(arg1:Array, arg2:Number):void
        {
            var loc1:*=0;
            while (loc1 < arg2 + 1) 
            {
                if (this.marked[arg1[loc1][0]][arg1[loc1][1]] != 1) 
                    this.marked[arg1[loc1][0]][arg1[loc1][1]] = 1;
                else 
                    this.marked[arg1[loc1][0]][arg1[loc1][1]] = 0;
                ++loc1;
            }
            return;
        }

        internal function erasePrimes():void
        {
            var loc2:*=NaN;
            var loc1:*=0;
            while (loc1 < this.n) 
            {
                loc2 = 0;
                while (loc2 < this.n) 
                {
                    if (this.marked[loc1][loc2] == 2) 
                        this.marked[loc1][loc2] = 0;
                    ++loc2;
                }
                ++loc1;
            }
            return;
        }

        internal function step1():Number
        {
            var loc2:*=null;
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc1:*=0;
            while (loc1 < this.n) 
            {
                loc2 = this.C[loc1];
                loc3 = Number.MAX_VALUE;
                loc4 = 0;
                while (loc4 < this.n) 
                {
                    loc3 = Math.min(loc2[loc4], loc3);
                    ++loc4;
                }
                loc4 = 0;
                while (loc4 < this.n) 
                {
                    loc2[loc4] = loc2[loc4] - loc3;
                    ++loc4;
                }
                ++loc1;
            }
            return 2;
        }

        internal function step2():Number
        {
            var loc2:*=null;
            var loc3:*=NaN;
            var loc1:*=0;
            while (loc1 < this.n) 
            {
                loc2 = this.C[loc1];
                loc3 = 0;
                while (loc3 < this.n) 
                {
                    if (loc2[loc3] == 0 && !this.columnCovered[loc3] && !this.rowCovered[loc1]) 
                    {
                        this.marked[loc1][loc3] = 1;
                        this.columnCovered[loc3] = true;
                        this.rowCovered[loc1] = true;
                    }
                    ++loc3;
                }
                ++loc1;
            }
            this.clearCovers();
            return 3;
        }

        internal function step3():Number
        {
            var loc3:*=NaN;
            var loc1:*=0;
            var loc2:*=0;
            while (loc2 < this.n) 
            {
                loc3 = 0;
                while (loc3 < this.n) 
                {
                    if (this.marked[loc2][loc3] == 1) 
                    {
                        this.columnCovered[loc3] = true;
                        loc1 = loc1 + 1;
                    }
                    ++loc3;
                }
                ++loc2;
            }
            return loc1 >= this.n ? 7 : 4;
        }

        internal function step4():Number
        {
            var loc6:*=null;
            var loc1:*=0;
            var loc2:*=false;
            var loc3:*=-1;
            var loc4:*=-1;
            var loc5:*=-1;
            while (!loc2) 
            {
                loc3 = (loc6 = this.findZero()).row;
                loc4 = loc6.col;
                if (loc3 < 0) 
                {
                    loc2 = true;
                    loc1 = 6;
                    continue;
                }
                this.marked[loc3][loc4] = 2;
                if ((loc5 = this.findStarInRow(loc3)) >= 0) 
                {
                    loc4 = loc5;
                    this.rowCovered[loc3] = true;
                    this.columnCovered[loc4] = false;
                    continue;
                }
                loc2 = true;
                this.Z0Row = loc3;
                this.Z0Column = loc4;
                loc1 = 5;
            }
            return loc1;
        }

        internal function step5():Number
        {
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc1:*=0;
            this.path[loc1][0] = this.Z0Row;
            this.path[loc1][1] = this.Z0Column;
            var loc2:*=false;
            while (!loc2) 
            {
                loc3 = this.findStarInCol(this.path[loc1][1]);
                if (loc3 >= 0) 
                {
                    loc1 = loc1 + 1;
                    this.path[loc1][0] = loc3;
                    this.path[loc1][1] = this.path[(loc1 - 1)][1];
                }
                else 
                    loc2 = true;
                if (loc2) 
                    continue;
                loc4 = this.findPrimeInRow(this.path[loc1][0]);
                loc1 = loc1 + 1;
                this.path[loc1][0] = this.path[(loc1 - 1)][0];
                this.path[loc1][1] = loc4;
            }
            this.convertPath(this.path, loc1);
            this.clearCovers();
            this.erasePrimes();
            return 3;
        }

        internal function step6():Number
        {
            var loc3:*=NaN;
            var loc1:*=this.findSmallest();
            var loc2:*=0;
            while (loc2 < this.n) 
            {
                loc3 = 0;
                while (loc3 < this.n) 
                {
                    if (this.rowCovered[loc2]) 
                        this.C[loc2][loc3] = this.C[loc2][loc3] + loc1;
                    if (!this.columnCovered[loc3]) 
                        this.C[loc2][loc3] = this.C[loc2][loc3] - loc1;
                    ++loc3;
                }
                ++loc2;
            }
            return 4;
        }

        internal var C:Array;

        internal var rowCovered:Array;

        internal var columnCovered:Array;

        internal var n:Number;

        internal var Z0Row:Number;

        internal var Z0Column:Number;

        internal var marked:Array;

        internal var path:Array;
    }
}
