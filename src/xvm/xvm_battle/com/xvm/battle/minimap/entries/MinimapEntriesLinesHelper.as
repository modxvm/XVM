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
        public static function createLines(linesCfg:Array):Sprite
        {
            var scaleFactor:Number = MinimapSizeConst.MAP_SIZE[0].width / BattleGlobalData.mapSize;
            var sprite:Sprite = new Sprite();
            if (linesCfg)
            {
                var len:int = linesCfg.length;
                for (var i:int = 0; i < len; ++i)
                {
                    var lineCfg:CMinimapLine = CMinimapLine.parse(linesCfg[i]);
                    if (lineCfg.enabled)
                    {
                        var from:Number = lineCfg.from;
                        var to:Number = lineCfg.to;

                        // Translate absolute minimap distance in points to game meters
                        if (lineCfg.inmeters)
                        {
                            from *= scaleFactor;
                            to   *= scaleFactor;
                        }
                        sprite.graphics.lineStyle(lineCfg.thickness, lineCfg.color, lineCfg.alpha);
                        sprite.graphics.moveTo(0, -from);
                        sprite.graphics.lineTo(0, -to);
                    }
                }
            }
            return sprite;
        }
    }
}
