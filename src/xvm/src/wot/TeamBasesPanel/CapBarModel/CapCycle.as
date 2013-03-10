/**
 * Capture cycle consists of many capture point updates.
 * This class looks for pattern repetitions and calculates average speed for it.
 * Average capture speed is used for time left and number of capturers calculations.
 * Server sends many updates with defferent intervals and cap points.
 * a, b and c are different cap speed values.
 * "a a a a ..." - possibly one capturer.
 * "a b a b a b ..." - possibly two capturers.
 * "a b c a b c a b ..." - possibly three capturers.
 * 
 * More complex capture patten is possible in encounter battle type.
 * For that cases we have larger cycle steps - 4 and 5.
 */

class wot.TeamBasesPanel.CapBarModel.CapCycle
{
    private static var ABSOLUTE_MINIMAL_SPEED:Number = 0.4;
    
    private var m_averageSpeed:Number; // average speed for one cycle updates
    
   /**
    * Speed sequence.
    * Each element represents capture speed for one progress update.
    */
    private var m_sequence:Array;
    
    public function CapCycle()
    {
        m_sequence = [];
    }
    
    public function getAverageSpeed():Number
    {
        return m_averageSpeed;
    }
    
    public function clear():Void
    {
        m_averageSpeed = undefined;
        m_sequence = [];
    }
    
    public function update(curSpeed:Number):Void
    {
        /** Append to beginning of an array */
        m_sequence.unshift(curSpeed);
        
        /**
         * Assume second tick will be the same as the very first.
         * Produces first full 2-step cycle out of one tick.
         * Allows to guess earlier probable cap speed and capturers number.
         */
        if (m_sequence.length == 1)
        {
            m_sequence.unshift(curSpeed);
        }
        
       /**
        * All cycle calculators try to redefine average speed one by one.
        * If cycle calculation failed then previous cycle average speed persists.
        * 
        * Example sequences and cycle calc result:
        *          1 2 3
        * xxxxxx   v v v
        * xy xy xy   v 
        * xyz xyz      v
        * xyx xyx      v
        * xxy xxy      v
        * 
        * xyxyx xyxyx is for 4 tanks at encounter battle type
        * 
        * v - means cycle is found and average speed is redefined.
        */
       // TODO: translate to generic algorythm
        stepCycle(1);
        stepCycle(2);
        stepCycle(3);
        
        /**
         * Extra patterns greatly stabilize -speed- when more than 3 capturers.
         * But calculating more than 4 capturers is still too complicated.
         */
        stepCycle(4); /** Not sure if used */
        stepCycle(5); /** Used for 4 tanks at encounter. */
        
       /**
        * More than three steps is not a cycle,
        * because three tanks defines maximum capture speed.
        * At standart More capturing tanks cap with the same speed as four.
        */
       
       /**
        * Is is possible that cycle is not found at all
        * and average speed have not been calculated for this.update().
        * In this case previously calculated m_averageSpeed persists.
        * This provides smooth transition to different cycle steps.
        * And no irritating extra macro rejections occur
        * while number of capturers change.
        */ 
    }
    
    // -- Private
    
    private function stepCycle(size:Number):Void
    {
        if (m_sequence.length < size * 2)
            return;
        
        var cycleIsPresent:Boolean = true;
        for (var i:Number = 0; i < size; i++)
        {
            if (m_sequence[i] != m_sequence[i + size])
            {
                cycleIsPresent = false;
                break;
            }
        }
        
        if (cycleIsPresent)
            redefineAverage(size);
    }
    
    private function redefineAverage(stepSize:Number):Void
    {
        var summ:Number = 0;
        for (var i = 0; i < stepSize; i++)
            summ += m_sequence[i];
        m_averageSpeed = summ / stepSize;
    }
}
