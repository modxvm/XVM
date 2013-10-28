package net.wg.gui.login.impl
{


   internal class ErrorStates extends Object
   {
          
      function ErrorStates() {
         super();
      }

      internal static const NONE:int = 0;

      internal static const LOGIN_INVALID:int = 1;

      internal static const PASSWORD_INVALID:int = 2;

      internal static const LOGIN_PASSWORD_INVALID:int = LOGIN_INVALID | PASSWORD_INVALID;
   }

}