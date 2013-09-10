package net.wg.gui.lobby.techtree.helpers 
{
    import __AS3__.vec.*;
    import fl.transitions.easing.*;
    import flash.display.*;
    import flash.geom.*;
    import net.wg.gui.lobby.techtree.*;
    import net.wg.gui.lobby.techtree.constants.*;
    import net.wg.gui.lobby.techtree.controls.*;
    import net.wg.gui.lobby.techtree.data.state.*;
    import net.wg.gui.lobby.techtree.interfaces.*;
    import scaleform.clik.motion.*;
    
    public class NTGraphics extends net.wg.gui.lobby.techtree.helpers.LinesGraphics
    {
        public function NTGraphics()
        {
            this.parentIDs = {};
            super();
            return;
        }

        public function hide():void
        {
            if (this.tween != null) 
            {
                this.tween.reset();
                this.tween = null;
            }
            alpha = 0;
            return;
        }

        public function show():void
        {
            this.tween = new scaleform.clik.motion.Tween(150, this, {"alpha":1}, {"paused":false, "ease":fl.transitions.easing.Strong.easeIn});
            return;
        }

        public function drawTopLines(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer, arg2:Boolean):void
        {
            var loc7:*=null;
            var loc9:*=NaN;
            var loc11:*=NaN;
            var loc12:*=null;
            var loc13:*=null;
            var loc1:*=arg1.getDisplayInfo();
            if (loc1 == null || loc1.lines == null) 
                return;
            var loc2:*=loc1.lines[0];
            var loc3:*=arg1.getID();
            clearLinesAndArrows(arg1);
            if (loc2 == null) 
                return;
            var loc4:*=loc2.outPin;
            var loc5:*=loc2.inPins;
            var loc6:*=new flash.geom.Point(loc4[0], loc4[1]);
            var loc8:*=loc5.length;
            var loc10:*=Number.MAX_VALUE;
            var loc14:*=[];
            var loc15:*=[];
            loc11 = 0;
            while (loc11 < loc8) 
            {
                loc12 = loc5[loc11];
                loc7 = new flash.geom.Point(loc12.inPin[0], loc12.inPin[1]);
                if (!isNaN(loc12.childID)) 
                {
                    if (loc6.y > loc7.y) 
                        loc14.push(new TopLineInfo(loc12.childID, loc7));
                    else if (loc6.y < loc7.y) 
                        loc15.push(new TopLineInfo(loc12.childID, loc7));
                    else if (loc6.y == loc7.y) 
                    {
                        loc13 = _container.getNodeByID(loc12.childID);
                        loc9 = colorIdxs[loc13.getColorIdx(loc3)];
                        drawLine(arg1, loc9, loc6, loc7);
                        drawArrowEx(arg1, loc9, loc6, loc7);
                    }
                    loc10 = Math.min(loc10, loc7.x);
                }
                ++loc11;
            }
            var loc16:*;
            loc7 = (loc16 = new flash.geom.Point(loc6.x + (loc10 - loc6.x >> 1), 0)).clone();
            loc14.sortOn("y", Array.NUMERIC);
            loc15.sortOn("y", Array.NUMERIC | Array.DESCENDING);
            var loc17:*=net.wg.gui.lobby.techtree.constants.ColorIndex.DEFAULT;
            var loc18:*=net.wg.gui.lobby.techtree.constants.ColorIndex.DEFAULT;
            var loc19:*=net.wg.gui.lobby.techtree.constants.ColorIndex.DEFAULT;
            loc8 = loc14.length;
            loc11 = 0;
            while (loc11 < loc8) 
            {
                loc12 = loc14[loc11];
                loc19 = (loc13 = _container.getNodeByID(loc12.id)).getColorIdx(loc3);
                loc17 = Math.min(loc17, loc19);
                loc9 = colorIdxs[loc19];
                loc7.y = loc11 != (loc8 - 1) ? loc14[loc11 + 1].point.y : loc6.y;
                loc16.y = loc12.point.y;
                drawLine(arg1, loc9, loc16, loc12.point);
                drawArrow(arg1, loc9, loc12.point);
                drawLine(arg1, colorIdxs[loc17], loc16, loc7);
                if (!arg2) 
                    loc13.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.STATE_CHANGED, this.handleRootChildStateChanged, false, 0, true);
                ++loc11;
            }
            loc8 = loc15.length;
            loc11 = 0;
            while (loc11 < loc8) 
            {
                loc12 = loc15[loc11];
                loc19 = (loc13 = _container.getNodeByID(loc12.id)).getColorIdx(loc3);
                loc18 = Math.min(loc18, loc19);
                loc9 = colorIdxs[loc19];
                loc7.y = loc11 != (loc8 - 1) ? loc15[loc11 + 1].point.y : loc6.y;
                loc16.y = loc12.point.y;
                drawLine(arg1, loc9, loc16, loc12.point);
                drawArrow(arg1, loc9, loc12.point);
                drawLine(arg1, colorIdxs[loc18], loc16, loc7);
                if (!arg2) 
                    loc13.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.STATE_CHANGED, this.handleRootChildStateChanged, false, 0, true);
                ++loc11;
            }
            loc16.y = loc6.y;
            drawLine(arg1, colorIdxs[Math.min(loc17, loc18)], loc6, loc16);
            return;
        }

        public function drawLineSet(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer, arg2:Object, arg3:Boolean):void
        {
            if (arg1 == null || arg2 == null) 
                return;
            var loc1:*=arg2.outLiteral;
            clearLinesAndArrows(arg1, loc1);
            var loc2:*=loc1;
            switch (loc2) 
            {
                case net.wg.gui.lobby.techtree.constants.OutLiteral.RIGHT_MIDDLE:
                    this.drawLineRSet(arg1, arg2, arg3);
                    break;
                case net.wg.gui.lobby.techtree.constants.OutLiteral.TOP_MIDDLE:
                    this.drawLineTMSet(arg1, arg2, arg3);
                    break;
                case net.wg.gui.lobby.techtree.constants.OutLiteral.BOTTOM_MIDDLE:
                    this.drawLineBMSet(arg1, arg2, arg3);
                    break;
                case net.wg.gui.lobby.techtree.constants.OutLiteral.TOP_RIGHT:
                    this.drawLineTRSet(arg1, arg2, arg3);
                    break;
                case net.wg.gui.lobby.techtree.constants.OutLiteral.BOTTOM_RIGHT:
                    this.drawLineBRSet(arg1, arg2, arg3);
                    break;
            }
            return;
        }

        public function drawNodeLines(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer, arg2:Boolean):void
        {
            var loc3:*=null;
            var loc1:*=arg1.getDisplayInfo();
            if (loc1 == null) 
                return;
            if (!arg2) 
                arg1.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.STATE_CHANGED, this.handleNodeStateChanged, false, 0, true);
            var loc2:*;
            var loc4:*=(loc2 = loc1.lines).length;
            var loc5:*=0;
            while (loc5 < loc4) 
            {
                if ((loc3 = loc2[loc5]) == null) 
                    return;
                this.drawLineSet(arg1, loc3, arg2);
                ++loc5;
            }
            return;
        }

        public function drawLevelsDelimiters(arg1:__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.helpers.Distance>, arg2:Number, arg3:Number):Number
        {
            if (this.levels == null) 
                return 0;
            return this.levels.updateLevels(arg1, arg2, arg3);
        }

        public override function dispose():void
        {
            this.tween = null;
            this.clearUp();
            super.dispose();
            return;
        }

        public override function clearUp():void
        {
            var loc3:*=null;
            super.clearUp();
            var loc1:*=0;
            var loc2:*=0;
            if (this.levels != null) 
                ++loc2;
            while (numChildren > loc2) 
            {
                loc3 = getChildAt(loc1);
                if (loc3 != this.levels) 
                {
                    if (loc3 is net.wg.gui.lobby.techtree.interfaces.IRenderer) 
                        this.clearUpRenderer(net.wg.gui.lobby.techtree.interfaces.IRenderer(loc3));
                    removeChildAt(loc1);
                    continue;
                }
                ++loc1;
            }
            this.levels.dispose();
            this.parentIDs = {};
            return;
        }

        public override function clearUpRenderer(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer):void
        {
            arg1.removeEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.STATE_CHANGED, this.handleRootChildStateChanged);
            arg1.removeEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.STATE_CHANGED, this.handleNodeStateChanged);
            return;
        }

        public function clearCache():void
        {
            this.parentIDs = {};
            return;
        }

        internal function addParentID(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer, arg2:net.wg.gui.lobby.techtree.interfaces.IRenderer):void
        {
            var loc1:*=arg2.getID();
            if (this.parentIDs[loc1] == undefined) 
                this.parentIDs[loc1] = [];
            var loc2:*=this.parentIDs[loc1];
            loc1 = arg1.getID();
            if (loc2.indexOf(loc1) == -1) 
                loc2.push(loc1);
            return;
        }

        internal function drawSingleLine(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer, arg2:Array, arg3:Object, arg4:Boolean):void
        {
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=NaN;
            var loc1:*;
            if (!(loc1 = container.getNodeByID(arg3.childID))) 
                return;
            var loc2:*=arg3.inPin;
            var loc3:*=arg3.viaPins;
            var loc4:*=colorIdxs[Math.max(arg1.getColorIdx(), loc1.getColorIdx(arg1.getID()))];
            var loc5:*=new flash.geom.Point(arg2[0], arg2[1]);
            if (loc3.length > 0) 
            {
                loc8 = 0;
                while (loc8 < loc3.length) 
                {
                    loc7 = loc3[loc8];
                    loc6 = new flash.geom.Point(loc7[0], loc7[1]);
                    drawLine(arg1, loc4, loc5, loc6);
                    loc5 = loc6;
                    ++loc8;
                }
                loc6 = new flash.geom.Point(loc2[0], loc2[1]);
                drawLine(arg1, loc4, loc5, loc6);
                drawArrowEx(arg1, loc4, loc5, loc6);
            }
            else 
            {
                loc6 = new flash.geom.Point(loc2[0], loc2[1]);
                drawLine(arg1, loc4, loc5, loc6);
                drawArrowEx(arg1, loc4, loc5, loc6);
            }
            if (!arg4) 
                this.addParentID(arg1, loc1);
            return;
        }

        internal function drawLineRSet(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer, arg2:Object, arg3:Boolean):void
        {
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=null;
            var loc11:*=null;
            var loc15:*=NaN;
            var loc16:*=null;
            var loc18:*=NaN;
            var loc1:*=arg2.outPin;
            var loc2:*;
            var loc3:*;
            if ((loc3 = (loc2 = arg2.inPins).length) < 2) 
            {
                if (loc3 == 1) 
                    this.drawSingleLine(arg1, loc1, loc2[0], arg3);
                return;
            }
            var loc4:*=new flash.geom.Point(loc1[0], loc1[1]);
            var loc12:*=[];
            var loc13:*=[];
            var loc14:*=net.wg.gui.lobby.techtree.constants.ColorIndex.DEFAULT;
            var loc17:*=arg1.getID();
            loc15 = 0;
            while (loc15 < loc3) 
            {
                loc8 = (loc10 = loc2[loc15]).inPin;
                loc7 = loc10.viaPins;
                if (loc16 = container.getNodeByID(loc10.childID)) 
                {
                    loc14 = Math.max(arg1.getColorIdx(), loc16.getColorIdx(loc17));
                    if (loc7.length > 0) 
                    {
                        loc5 = new flash.geom.Point(loc7[0][0], loc7[0][1]);
                        if (loc4.y != loc5.y) 
                            loc13.push(loc15);
                        else 
                            loc12.push(new RSetLineInfo(loc15, loc5.x, false, loc14));
                    }
                    else if (loc4.y != loc8[1]) 
                        loc13.push(loc15);
                    else 
                        loc12.push(new RSetLineInfo(loc15, loc8[0], true, loc14));
                }
                ++loc15;
            }
            loc12.sortOn("childIdx", Array.NUMERIC | Array.DESCENDING);
            loc3 = loc12.length;
            loc15 = 0;
            while (loc15 < loc3) 
            {
                loc14 = (loc11 = loc12[loc15]).childIdx;
                loc10 = loc2[loc11.idx];
                loc5 = new flash.geom.Point(loc10.inPin[0], loc10.inPin[1]);
                loc7 = loc10.viaPins;
                loc18 = 0;
                while (loc18 < (loc7.length - 1)) 
                {
                    loc8 = loc7[loc18];
                    loc9 = loc7[loc18 + 1];
                    drawLine(arg1, colorIdxs[loc14], new flash.geom.Point(loc8[0], loc8[1]), new flash.geom.Point(loc9[0], loc9[1]));
                    ++loc18;
                }
                if (loc7.length > 0) 
                {
                    loc8 = loc7[(loc7.length - 1)];
                    loc6 = new flash.geom.Point(loc8[0], loc8[1]);
                    drawLine(arg1, colorIdxs[loc14], loc6, loc5);
                    drawArrowEx(arg1, colorIdxs[loc14], loc6, loc5);
                }
                loc5 = new flash.geom.Point(loc11.x, loc4.y);
                drawLine(arg1, colorIdxs[loc14], loc4, loc5);
                if (loc11.drawArrow) 
                    drawArrowEx(arg1, colorIdxs[loc14], loc4, loc5);
                if (!arg3) 
                    this.addParentID(arg1, loc16);
                ++loc15;
            }
            loc3 = loc13.length;
            loc15 = 0;
            while (loc15 < loc3) 
            {
                this.drawSingleLine(arg1, loc1, loc2[loc13[loc15]], arg3);
                ++loc15;
            }
            return;
        }

        internal function drawLineTMSet(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer, arg2:Object, arg3:Boolean):void
        {
            var loc1:*=arg2.outPin;
            var loc2:*;
            var loc3:*=(loc2 = arg2.inPins)[0];
            var loc4:*;
            if (!((loc4 = container.getNodeByID(loc3.childID)) == null) && loc4.isButtonVisible() && this.inButtonOffset > 0) 
                loc3 = {"childID":loc3.childID, "inPin":[Number(loc3.inPin[0]), Number(loc3.inPin[1]) + this.inButtonOffset], "viaPins":loc3.viaPins};
            this.drawSingleLine(arg1, loc1, loc3, arg3);
            if (loc2.length > 1) 
                trace("Warning! From top part of node can goes only one line.");
            return;
        }

        internal function drawLineTRSet(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer, arg2:Object, arg3:Boolean):void
        {
            var loc1:*=arg2.outPin;
            var loc2:*;
            var loc3:*=(loc2 = arg2.inPins)[0];
            this.drawSingleLine(arg1, loc1, loc3, arg3);
            if (loc2.length > 1) 
                trace("Warning! From top part of node can goes only one line.");
            return;
        }

        internal function drawLineBMSet(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer, arg2:Object, arg3:Boolean):void
        {
            var loc1:*=arg2.outPin;
            var loc2:*=arg2.inPins;
            if (arg1.isButtonVisible() && this.outButtonOffset > 0) 
                loc1 = [Number(loc1[0]), Number(loc1[1]) + this.outButtonOffset];
            this.drawSingleLine(arg1, loc1, loc2[0], arg3);
            if (loc2.length > 1) 
                trace("Warning! From bottom part of node can goes only one line.");
            return;
        }

        internal function drawLineBRSet(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer, arg2:Object, arg3:Boolean):void
        {
            var loc1:*=arg2.outPin;
            var loc2:*;
            var loc3:*=(loc2 = arg2.inPins)[0];
            this.drawSingleLine(arg1, loc1, loc3, arg3);
            if (loc2.length > 1) 
                trace("Warning! From bottom part of node can goes only one line.");
            return;
        }

        internal function handleRootChildStateChanged(arg1:net.wg.gui.lobby.techtree.TechTreeEvent):void
        {
            var loc1:*=container.getRootNode();
            if (!(loc1 == null) && net.wg.gui.lobby.techtree.data.state.NodeStateCollection.isRedrawNTLines(arg1.primary)) 
                this.drawTopLines(loc1, true);
            return;
        }

        internal function handleNodeStateChanged(arg1:net.wg.gui.lobby.techtree.TechTreeEvent):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=NaN;
            var loc4:*=null;
            var loc5:*=NaN;
            if (net.wg.gui.lobby.techtree.data.state.NodeStateCollection.isRedrawNTLines(arg1.primary)) 
            {
                loc1 = arg1.target as net.wg.gui.lobby.techtree.interfaces.IRenderer;
                if (loc1 != null) 
                {
                    this.drawNodeLines(loc1, true);
                    loc2 = this.parentIDs[loc1.getID()];
                    if (loc2 != null) 
                    {
                        loc3 = loc2.length;
                        loc5 = 0;
                        while (loc5 < loc3) 
                        {
                            if ((loc4 = container.getNodeByID(loc2[loc5])) != null) 
                                this.drawNodeLines(loc4, true);
                            ++loc5;
                        }
                    }
                }
            }
            return;
        }

        internal var tween:scaleform.clik.motion.Tween=null;

        internal var parentIDs:Object;

        public var levels:net.wg.gui.lobby.techtree.controls.LevelsContainer;

        public var inButtonOffset:Number=0;

        public var outButtonOffset:Number=0;
    }
}

import flash.geom.*;


class TopLineInfo extends Object
{
    public function TopLineInfo(arg1:Number, arg2:flash.geom.Point=null)
    {
        super();
        this.id = arg1;
        this.point = arg2;
        return;
    }

    public function get y():Number
    {
        return this.point.y;
    }

    public var id:Number;

    public var point:flash.geom.Point;
}

class RSetLineInfo extends Object
{
    public function RSetLineInfo(arg1:Number, arg2:Number, arg3:Boolean, arg4:Number)
    {
        super();
        this.idx = arg1;
        this.x = arg2;
        this.drawArrow = arg3;
        this.childIdx = arg4;
        return;
    }

    public var idx:Number;

    public var x:Number;

    public var drawArrow:Boolean;

    public var childIdx:Number;
}