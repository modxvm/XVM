﻿intrinsic class gfx.core.UIComponent extends MovieClip
{
    function get disabled();
    function set disabled(value);
    function get visible();
    function set visible(value);
    function get width();
    function set width(value);
    function get height();
    function set height(value);
    function setSize(width, height);
    function get focused();
    function set focused(value);
    function get displayFocus();
    function set displayFocus(value);
    function handleInput(details, pathToFocus);
    function invalidate();
    function validateNow();
    function toString();
    function configUI();
    function initSize();
    function draw();
    function changeFocus();
    function onMouseWheel(delta, target);
    function scrollWheel(delta);
}