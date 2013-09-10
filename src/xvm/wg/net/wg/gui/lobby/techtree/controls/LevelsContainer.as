package net.wg.gui.lobby.techtree.controls 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;
    import net.wg.gui.lobby.techtree.helpers.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public class LevelsContainer extends flash.display.Sprite implements net.wg.infrastructure.interfaces.entity.IDisposable
    {
        public function LevelsContainer()
        {
            super();
            scale9Grid = new flash.geom.Rectangle(0, 0, 1, 1);
            var loc1:*;
            mouseEnabled = loc1 = false;
            mouseChildren = loc1 = loc1;
            tabEnabled = loc1;
            this.delimiters = new Vector.<net.wg.gui.lobby.techtree.controls.LevelDelimiter>();
            return;
        }

        public function updateLevels(arg1:__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.helpers.Distance>, arg2:Number, arg3:Number):Number
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc1:*=arg1.length;
            var loc4:*=0;
            var loc5:*=0;
            var loc8:*=false;
            while (this.delimiters.length > loc1) 
            {
                this.removeLevelDelimiter(this.delimiters.pop());
            }
            var loc9:*=0;
            while (loc9 < loc1) 
            {
                loc2 = arg1[loc9];
                loc3 = null;
                loc8 = false;
                if (loc9 >= this.delimiters.length) 
                {
                    this.delimiters.push(null);
                }
                if (loc2) 
                {
                    if (loc9 != 0) 
                    {
                        if (arg1[(loc9 - 1)] != null) 
                        {
                            loc4 = loc2.start - arg3 - arg1[(loc9 - 1)].end >> 1;
                        }
                        if (loc9 < (loc1 - 1) && !(arg1[loc9 + 1] == null)) 
                        {
                            loc5 = arg1[loc9 + 1].start - loc2.end - arg3 >> 1;
                        }
                        else 
                        {
                            loc5 = loc4;
                        }
                    }
                    else if (arg1[loc9 + 1] == null) 
                    {
                        loc5 = loc10 = loc2.start;
                        loc4 = loc10;
                    }
                    else 
                    {
                        var loc10:*;
                        loc5 = loc10 = arg1[loc9 + 1].start - loc2.end - arg3 >> 1;
                        loc4 = loc10;
                    }
                    loc7 = loc2.start - loc4;
                    loc6 = loc2.end - loc2.start + arg3 + loc4 + loc5;
                    if ((loc3 = this.delimiters[loc9]) == null) 
                    {
                        loc3 = this.createLevelDelimiter(loc9 + 1, loc7, 0, loc6, arg2);
                        loc8 = true;
                    }
                    else 
                    {
                        updateLevelDelimiter(loc3, loc7, 0, loc6, arg2);
                    }
                    if (loc3 != null) 
                    {
                        loc3.validateNow();
                        if (loc8) 
                        {
                            addChild(loc3);
                            this.delimiters[loc9] = loc3;
                        }
                    }
                }
                else if (this.delimiters[loc9] != null) 
                {
                    if (this.removeLevelDelimiter(this.delimiters[loc9])) 
                    {
                        this.delimiters[loc9] = null;
                    }
                }
                ++loc9;
            }
            return loc5;
        }

        public function dispose():void
        {
            var loc1:*=null;
            while (this.delimiters.length) 
            {
                loc1 = this.delimiters.pop();
                if (!loc1) 
                {
                    continue;
                }
                loc1.dispose();
            }
            while (numChildren > 0) 
            {
                removeChildAt(0);
            }
            return;
        }

        internal function createLevelDelimiter(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number):net.wg.gui.lobby.techtree.controls.LevelDelimiter
        {
            return App.utils.classFactory.getComponent(arg1 % 2 ? this.oddLevelRenderer : this.evenLevelRenderer, net.wg.gui.lobby.techtree.controls.LevelDelimiter, {"x":arg2, "y":arg3, "width":arg4, "height":arg5, "levelNumber":arg1});
        }

        internal function removeLevelDelimiter(arg1:net.wg.gui.lobby.techtree.controls.LevelDelimiter):Boolean
        {
            var loc1:*=false;
            if (contains(arg1)) 
            {
                removeChild(arg1);
                loc1 = true;
            }
            return loc1;
        }

        internal static function updateLevelDelimiter(arg1:net.wg.gui.lobby.techtree.controls.LevelDelimiter, arg2:Number, arg3:Number, arg4:Number, arg5:Number):void
        {
            arg1.x = arg2;
            arg1.y = arg3;
            arg1.setSize(arg4, arg5);
            return;
        }

        internal var delimiters:__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.controls.LevelDelimiter>;

        public var oddLevelRenderer:String="OddLevelDelimiter";

        public var evenLevelRenderer:String="EvenLevelDelimiter";
    }
}
