package fl.motion
{


   public class AdjustColor extends Object
   {
          
      public function AdjustColor() {
         super();
      }

      private static var s_arrayOfDeltaIndex:Array;

      private var m_brightnessMatrix:ColorMatrix;

      private var m_contrastMatrix:ColorMatrix;

      private var m_saturationMatrix:ColorMatrix;

      private var m_hueMatrix:ColorMatrix;

      private var m_finalMatrix:ColorMatrix;

      public function set brightness(param1:Number) : void {
         if(this.m_brightnessMatrix == null)
         {
            this.m_brightnessMatrix = new ColorMatrix();
         }
         if(param1 != 0)
         {
            this.m_brightnessMatrix.SetBrightnessMatrix(param1);
         }
      }

      public function set contrast(param1:Number) : void {
         var _loc2_:Number = param1;
         if(param1 == 0)
         {
            _loc2_ = 127;
         }
         else
         {
            if(param1 > 0)
            {
               _loc2_ = s_arrayOfDeltaIndex[int(param1)] * 127 + 127;
            }
            else
            {
               _loc2_ = param1 / 100 * 127 + 127;
            }
         }
         if(this.m_contrastMatrix == null)
         {
            this.m_contrastMatrix = new ColorMatrix();
         }
         this.m_contrastMatrix.SetContrastMatrix(_loc2_);
      }

      public function set saturation(param1:Number) : void {
         var _loc2_:Number = param1;
         if(param1 == 0)
         {
            _loc2_ = 1;
         }
         else
         {
            if(param1 > 0)
            {
               _loc2_ = 1 + 3 * param1 / 100;
            }
            else
            {
               _loc2_ = param1 / 100 + 1;
            }
         }
         if(this.m_saturationMatrix == null)
         {
            this.m_saturationMatrix = new ColorMatrix();
         }
         this.m_saturationMatrix.SetSaturationMatrix(_loc2_);
      }

      public function set hue(param1:Number) : void {
         if(this.m_hueMatrix == null)
         {
            this.m_hueMatrix = new ColorMatrix();
         }
         if(param1 != 0)
         {
            this.m_hueMatrix.SetHueMatrix(param1 * Math.PI / 180);
         }
      }

      public function AllValuesAreSet() : Boolean {
         return (this.m_brightnessMatrix) && (this.m_contrastMatrix) && (this.m_saturationMatrix) && (this.m_hueMatrix);
      }

      public function CalculateFinalFlatArray() : Array {
         if(this.CalculateFinalMatrix())
         {
            return this.m_finalMatrix.GetFlatArray();
         }
         return null;
      }

      private function CalculateFinalMatrix() : Boolean {
         if(!this.AllValuesAreSet())
         {
            return false;
         }
         this.m_finalMatrix = new ColorMatrix();
         this.m_finalMatrix.Multiply(this.m_brightnessMatrix);
         this.m_finalMatrix.Multiply(this.m_contrastMatrix);
         this.m_finalMatrix.Multiply(this.m_saturationMatrix);
         this.m_finalMatrix.Multiply(this.m_hueMatrix);
         return true;
      }
   }

}