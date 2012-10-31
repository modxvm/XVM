/**
 * Capture cycle consists of one, two or three capture point updates.
 * Server sends one, two or three updates with defferent intervals and cap points.
 * a, b and c are different cap speed values.
 * "a a a a ..." - possibly one capturer.
 * "a b a b a b ..." - possibly two capturers.
 * "a b c a b c a b ..." - possibly three capturers.
 * 
 * Thus to calculate time left and number of capturers
 * we need to define cycle and average speed between cycle updates.
 */

class wot.TeamBasesPanel.CapBarModel.CapCycle
{
    private static var ABSOLUTE_MINIMAL_SPEED:Number = 0.5;
    
    private var m_averageSpeed:Number; // average speed for one cycle updates
    
   /**
    * Speed sequence.
    * Each element represents capture speed for one progress update.
    */
    private var m_sequence:Array;
    
    public function CapCycle()
    {
        m_sequence = new Array();
    }
    
    public function getAverageSpeed():Number
    {
        return m_averageSpeed;
    }
    
    public function clear():Void
    {
        m_averageSpeed = undefined;
        m_sequence = new Array();
    }
    
    public function update(curSpeed:Number):Void
    {
        // Append to beginning of an array.
        m_sequence.unshift(curSpeed);
        
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
        * v - means cycle is found and average speed is redefined.
        */
        oneStepCycle();
        twoStepCycle();
        threeStepCycle();
       /**
        * More than three steps is not a cycle,
        * because three tanks defines maximum capture speed.
        * More capturing tanks cap with the same speed as four.
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
    
    private function oneStepCycle():Void
    {
        if (m_sequence.length < 1 + 1)
            return;
        
        if (m_sequence[0] == m_sequence[1])
            redefineAverage(1);
    }
    
    private function twoStepCycle():Void
    {
        if (m_sequence.length < 2 + 2)
            return;
            
        if (m_sequence[0] == m_sequence[2] &&
            m_sequence[1] == m_sequence[3])
            redefineAverage(2);
    }
    
    private function threeStepCycle():Void
    {
        if (m_sequence.length < 3 + 3)
            return;
        
        if (m_sequence[0] == m_sequence[3] &&
            m_sequence[1] == m_sequence[4] &&
            m_sequence[2] == m_sequence[5])
            redefineAverage(3);
    }
    
    private function redefineAverage(stepSize:Number):Void
    {
        var summ:Number = 0;
        for (var i = 0; i < stepSize; i++)
            summ += m_sequence[i];
        m_averageSpeed = summ / stepSize;
    }
}
