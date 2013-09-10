package net.wg.gui.lobby.techtree.helpers 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;
    import net.wg.gui.lobby.techtree.*;
    import net.wg.gui.lobby.techtree.constants.*;
    import net.wg.gui.lobby.techtree.controls.*;
    import net.wg.gui.lobby.techtree.data.state.*;
    import net.wg.gui.lobby.techtree.interfaces.*;
    import net.wg.gui.lobby.techtree.nodes.*;
    
    public class ResearchGraphics extends net.wg.gui.lobby.techtree.helpers.LinesGraphics
    {
        public function ResearchGraphics()
        {
            super();
            return;
        }

        public function get containerEx():net.wg.gui.lobby.techtree.interfaces.IResearchContainer
        {
            return _container as net.wg.gui.lobby.techtree.interfaces.IResearchContainer;
        }

        public function drawOutgoingLines(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer, arg2:__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>, arg3:Boolean, arg4:Boolean):void
        {
            var loc8:*=null;
            var loc9:*=null;
            var loc1:*;
            if ((loc1 = arg2.length) == 0) 
            {
                return;
            }
            if (arg3) 
            {
                clearLinesAndArrows(arg1, OUTGOING_LINES_LITERAL);
            }
            var loc2:*=new flash.geom.Point(arg1.getOutX(), arg1.getY());
            var loc3:*=new flash.geom.Point(loc2.x + this.xRatio, loc2.y);
            var loc4:*=[];
            var loc5:*=[];
            var loc6:*=null;
            var loc7:*=null;
            var loc10:*=0;
            while (loc10 < loc1) 
            {
                if ((loc9 = arg2[loc10]) != null) 
                {
                    loc8 = new flash.geom.Point(loc9.getInX() - lineRatio, loc9.getY());
                    loc7 = new ResearchLineInfo(arg1, loc9, loc8, !loc9.isFake());
                    if (loc2.y > loc8.y) 
                    {
                        loc4.push(loc7);
                    }
                    else if (loc2.y < loc8.y) 
                    {
                        loc5.push(loc7);
                    }
                    else if (loc2.y == loc8.y) 
                    {
                        loc6 = loc7;
                    }
                }
                ++loc10;
            }
            var loc11:*=net.wg.gui.lobby.techtree.constants.ColorIndex.DEFAULT;
            var loc12:*=this.drawUpLines(loc4, loc3, arg3, arg4, false);
            var loc13:*=this.drawDownLines(loc5, loc3, arg3, arg4, false);
            if (loc6 != null) 
            {
                loc9 = loc6.child;
                if (arg4) 
                {
                    loc11 = loc9.getColorIdxEx(arg1);
                }
                if (loc1 != 1) 
                {
                    drawLine(arg1, colorIdxs[loc11], new flash.geom.Point(loc3.x + lineRatio, loc2.y), loc6.point, OUTGOING_LINES_LITERAL);
                    if (loc6.drawArrow) 
                    {
                        drawArrowEx(arg1, colorIdxs[loc11], loc3, loc6.point, OUTGOING_LINES_LITERAL);
                    }
                    loc12 = Math.min(loc11, loc12);
                }
                else 
                {
                    drawLine(arg1, colorIdxs[loc11], loc2, loc6.point, OUTGOING_LINES_LITERAL);
                    if (loc6.drawArrow) 
                    {
                        drawArrowEx(arg1, colorIdxs[loc11], loc2, loc6.point, OUTGOING_LINES_LITERAL);
                    }
                }
                if (!arg3) 
                {
                    this.addNodeStateChangedListener(loc9);
                }
            }
            if (loc1 > 1 || loc6 == null) 
            {
                drawLine(arg1, colorIdxs[Math.min(loc12, loc13)], loc2, loc3, OUTGOING_LINES_LITERAL);
            }
            return;
        }

        public function drawTopLevelLines(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer, arg2:__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>, arg3:Boolean):void
        {
            var loc2:*=null;
            var loc5:*=null;
            var loc13:*=NaN;
            var loc1:*;
            if ((loc1 = arg2.length) == 0 || arg1 == null) 
            {
                return;
            }
            clearLinesAndArrows(arg1, TOP_LINES_LITERAL);
            if (!arg3) 
            {
                this.addTopStateChangedListener(arg1);
            }
            var loc3:*=new flash.geom.Point(arg1.getInX(), arg1.getY());
            var loc4:*=new flash.geom.Point(loc3.x - this.xRatio, loc3.y);
            var loc6:*=[];
            var loc7:*=[];
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=0;
            while (loc10 < loc1) 
            {
                if ((loc5 = arg2[loc10]) != null) 
                {
                    clearLinesAndArrows(loc5);
                    loc2 = new flash.geom.Point(loc5.getOutX(), loc5.getY());
                    loc9 = new ResearchLineInfo(loc5, arg1, loc2, false);
                    if (loc2.y < loc3.y) 
                    {
                        loc6.push(loc9);
                    }
                    else if (loc2.y > loc3.y) 
                    {
                        loc7.push(loc9);
                    }
                    else if (loc2.y == loc3.y) 
                    {
                        loc9.drawArrow = true;
                        loc8 = loc9;
                    }
                }
                ++loc10;
            }
            var loc11:*=this.drawUpLines(loc6, loc4, arg3, true, true);
            var loc12:*=this.drawDownLines(loc7, loc4, arg3, true, true);
            if (loc8 != null) 
            {
                loc5 = loc8.parent;
                loc13 = arg1.getColorIdx(loc8.parent.getID());
                if (loc1 != 1) 
                {
                    drawLine(loc5, colorIdxs[loc13], loc8.point, loc4, OUTGOING_LINES_LITERAL);
                    loc11 = Math.min(loc13, loc11);
                }
                else 
                {
                    drawLine(loc5, colorIdxs[loc13], loc8.point, loc3, OUTGOING_LINES_LITERAL);
                    drawArrowEx(loc5, colorIdxs[loc13], loc8.point, loc3, OUTGOING_LINES_LITERAL);
                }
                if (!arg3) 
                {
                    this.addTopStateChangedListener(loc5);
                }
            }
            if (loc1 > 1 || loc8 == null) 
            {
                loc13 = Math.min(loc11, loc12);
                drawLine(arg1, colorIdxs[loc13], loc4, loc3, TOP_LINES_LITERAL);
                drawArrowEx(arg1, colorIdxs[loc13], loc4, loc3, TOP_LINES_LITERAL);
                if (!arg3) 
                {
                    this.addTopStateChangedListener(arg1);
                }
            }
            return;
        }

        public override function setup():void
        {
            super.setup();
            if (this.xpInfo != null) 
            {
                this.xpInfo.setOwner(this.rootRenderer);
            }
            return;
        }

        public override function clearUp():void
        {
            var loc3:*=null;
            super.clearUp();
            var loc1:*=0;
            var loc2:*=0;
            if (this.rootRenderer != null) 
            {
                ++loc2;
            }
            if (this.xpInfo != null) 
            {
                ++loc2;
            }
            while (numChildren > loc2) 
            {
                loc3 = getChildAt(loc1);
                if (!(loc3 == this.rootRenderer) && !(loc3 == this.xpInfo)) 
                {
                    if (loc3 is net.wg.gui.lobby.techtree.interfaces.IRenderer) 
                    {
                        this.clearUpRenderer(net.wg.gui.lobby.techtree.interfaces.IRenderer(loc3));
                    }
                    removeChildAt(loc1);
                    continue;
                }
                ++loc1;
            }
            return;
        }

        public override function clearUpRenderer(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer):void
        {
            arg1.removeEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.STATE_CHANGED, this.handleTopLevelStatesChanged);
            arg1.removeEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.STATE_CHANGED, this.handleNodesStatesChanged);
            return;
        }

        public function removeReferences():void
        {
            container = null;
            if (this.xpInfo != null) 
            {
                this.xpInfo.dispose();
            }
            return;
        }

        internal function drawUpLines(arg1:Array, arg2:flash.geom.Point, arg3:Boolean, arg4:Boolean, arg5:Boolean):Number
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc1:*=arg1.length;
            var loc4:*=net.wg.gui.lobby.techtree.constants.ColorIndex.DEFAULT;
            var loc5:*=net.wg.gui.lobby.techtree.constants.ColorIndex.DEFAULT;
            arg1.sortOn("y", Array.NUMERIC);
            var loc9:*=0;
            while (loc9 < loc1) 
            {
                loc3 = (loc8 = arg1[loc9]).child;
                loc2 = loc8.parent;
                if (arg4) 
                {
                    loc5 = loc3.getColorIdxEx(loc2);
                    loc4 = Math.min(loc4, loc5);
                }
                loc6 = new flash.geom.Point(arg2.x, loc8.point.y);
                loc7 = new flash.geom.Point(arg2.x, (loc9 != (loc1 - 1) ? arg1[loc9 + 1].point.y : arg2.y) - lineThickness);
                drawLine(loc2, colorIdxs[loc5], loc6, loc8.point, OUTGOING_LINES_LITERAL);
                if (loc8.drawArrow) 
                {
                    drawArrowEx(loc2, colorIdxs[loc5], loc6, loc8.point, OUTGOING_LINES_LITERAL);
                }
                drawLine(loc2, colorIdxs[loc4], loc6, loc7, OUTGOING_LINES_LITERAL);
                if (!arg3) 
                {
                    if (arg5) 
                    {
                        this.addTopStateChangedListener(loc2);
                    }
                    else 
                    {
                        this.addNodeStateChangedListener(loc3);
                    }
                }
                ++loc9;
            }
            return loc4;
        }

        internal function drawDownLines(arg1:Array, arg2:flash.geom.Point, arg3:Boolean, arg4:Boolean, arg5:Boolean):Number
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc1:*=arg1.length;
            var loc4:*=net.wg.gui.lobby.techtree.constants.ColorIndex.DEFAULT;
            var loc5:*=net.wg.gui.lobby.techtree.constants.ColorIndex.DEFAULT;
            arg1.sortOn("y", Array.NUMERIC | Array.DESCENDING);
            var loc9:*=0;
            while (loc9 < loc1) 
            {
                loc3 = (loc8 = arg1[loc9]).child;
                loc2 = loc8.parent;
                if (arg4) 
                {
                    loc5 = loc3.getColorIdxEx(loc2);
                    loc4 = Math.min(loc4, loc5);
                }
                loc6 = new flash.geom.Point(arg2.x, loc8.point.y);
                loc7 = new flash.geom.Point(arg2.x, (loc9 != (loc1 - 1) ? arg1[loc9 + 1].point.y : arg2.y) + lineThickness);
                drawLine(loc2, colorIdxs[loc4], loc6, loc7, OUTGOING_LINES_LITERAL);
                drawLine(loc2, colorIdxs[loc5], loc6, loc8.point, OUTGOING_LINES_LITERAL);
                if (loc8.drawArrow) 
                {
                    drawArrowEx(loc2, colorIdxs[loc5], loc6, loc8.point, OUTGOING_LINES_LITERAL);
                }
                if (!arg3) 
                {
                    if (arg5) 
                    {
                        this.addTopStateChangedListener(loc2);
                    }
                    else 
                    {
                        this.addNodeStateChangedListener(loc3);
                    }
                }
                ++loc9;
            }
            return loc4;
        }

        internal function addNodeStateChangedListener(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer):void
        {
            arg1.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.STATE_CHANGED, this.handleNodesStatesChanged, false, 0, true);
            return;
        }

        internal function addTopStateChangedListener(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer):void
        {
            arg1.addEventListener(net.wg.gui.lobby.techtree.TechTreeEvent.STATE_CHANGED, this.handleTopLevelStatesChanged, false, 0, true);
            return;
        }

        internal function handleTopLevelStatesChanged(arg1:net.wg.gui.lobby.techtree.TechTreeEvent):void
        {
            if (net.wg.gui.lobby.techtree.data.state.NodeStateCollection.isRedrawResearchLines(arg1.primary)) 
            {
                this.drawTopLevelLines(this.rootRenderer, this.containerEx.getTopLevel(), true);
            }
            return;
        }

        internal function handleNodesStatesChanged(arg1:net.wg.gui.lobby.techtree.TechTreeEvent):void
        {
            var loc1:*=null;
            var loc2:*=false;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=NaN;
            if (net.wg.gui.lobby.techtree.data.state.NodeStateCollection.isRedrawResearchLines(arg1.primary)) 
            {
                loc1 = arg1.target as net.wg.gui.lobby.techtree.interfaces.IRenderer;
                loc2 = this.containerEx.isRootUnlocked();
                if (loc1 != null) 
                {
                    loc3 = this.containerEx.getParents(loc1);
                    loc5 = 0;
                    while (loc5 < loc3.length) 
                    {
                        loc4 = loc3[loc5];
                        this.drawOutgoingLines(loc4, this.containerEx.getChildren(loc4), true, loc2);
                        ++loc5;
                    }
                    this.drawOutgoingLines(loc1, this.containerEx.getChildren(loc1), true, loc2);
                }
            }
            return;
        }

        internal static const OUTGOING_LINES_LITERAL:String="lines";

        internal static const TOP_LINES_LITERAL:String="topLines";

        public var xRatio:Number=0;

        public var rootRenderer:net.wg.gui.lobby.techtree.nodes.ResearchRoot;

        public var xpInfo:net.wg.gui.lobby.techtree.controls.ExperienceInformation;
    }
}

import flash.geom.*;
import net.wg.gui.lobby.techtree.interfaces.*;


class ResearchLineInfo extends Object
{
    public function ResearchLineInfo(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer, arg2:net.wg.gui.lobby.techtree.interfaces.IRenderer, arg3:flash.geom.Point, arg4:Boolean)
    {
        super();
        this.parent = arg1;
        this.child = arg2;
        this.point = arg3;
        this.drawArrow = arg4;
        return;
    }

    public function get y():Number
    {
        return this.point.y;
    }

    public var point:flash.geom.Point;

    public var parent:net.wg.gui.lobby.techtree.interfaces.IRenderer;

    public var child:net.wg.gui.lobby.techtree.interfaces.IRenderer;

    public var drawArrow:Boolean;
}