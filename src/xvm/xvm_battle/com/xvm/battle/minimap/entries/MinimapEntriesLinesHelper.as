/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.minimap.entries
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.types.cfg.*;
    import flash.display.*;
    import flash.geom.*;
    import net.wg.gui.battle.views.minimap.constants.*;

    public class MinimapEntriesLinesHelper
    {
        public static function createLines(linesCfg:Array, angle:Number = 0):MovieClip
        {
            var scaleFactor:Number = MinimapSizeConst.MAP_SIZE[0].width / BattleGlobalData.mapSize;
            var mc:MovieClip = new MovieClip();
            var len:int = linesCfg.length;
            for (var i:int = 0; i < len; ++i)
            {
                var lineCfg:CMinimapLine = CMinimapLine.parse(linesCfg[i]);
                if (lineCfg.enabled)
                {
                    var from:Point = horAnglePoint(lineCfg.from, angle);
                    var to:Point = horAnglePoint(lineCfg.to, angle);

                    // Translate absolute minimap distance in points to game meters
                    if (lineCfg.inmeters)
                    {
                        from.y *= scaleFactor;
                        to.y   *= scaleFactor;
                        from.x *= scaleFactor;
                        to.x   *= scaleFactor;
                    }
                    mc.graphics.lineStyle(lineCfg.thickness, lineCfg.color, lineCfg.alpha);
                    mc.graphics.moveTo(from.x, -from.y);
                    mc.graphics.lineTo(to.x, -to.y);
                }
            }
            return mc;
        }

        // PRIVATE

        private static function horAnglePoint(R:Number, angle:Number):Point
        {
            angle = angle * (Math.PI / 180);
            return new Point(R * Math.sin(angle), R * Math.cos(angle));
        }
    }
}
