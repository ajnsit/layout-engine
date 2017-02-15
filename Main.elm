module Main where

-- The Main module
-- Also handles all rendering to HTML

import List exposing (..)

import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)

import Text

import Types exposing (..)
import Settings exposing (..)
import Plan exposing (..)

-- MAIN
main = showPlan (plan {top=1, left=1} input2)

-- Our grid settings
gridSettings : GridSettings
gridSettings =
  { gridWidth = 1024
  , gutterWidth = 10
  , nColumns = 10
  }

-- Convert a rect from grid units to DISPLAY px
-- Subtracting from 0 is used to flip the y axis to go from top to bottom
-- Adding half height and width moves center to the center (instead of top left) of rect
toPixelRect : Rect -> Rect
toPixelRect r =
  let
    s = r.size
    p = r.pos
    gs = gridSettings
    rectWidth = colWidth gs s.width
    rectHeight = colWidth gs s.height
    rectLeftNoTranslate = toPx gs p.left
    rectLeft = rectLeftNoTranslate + rectWidth//2
    rectTopNoTranslate = toPx gs p.top
    rectTop = 0 - (rectTopNoTranslate + rectHeight//2)
  in {r | pos = {top = rectTop, left = rectLeft}, size = {height = rectHeight, width = rectWidth} }

-- Display a rect
showRect : Rect -> Form
showRect r =
  [ rect (toFloat r.size.width) (toFloat r.size.height) |> filled clearGrey
  , Graphics.Collage.text (Text.fromString r.layoutId)
  ] |> group |> move (toFloat r.pos.left, toFloat r.pos.top)

-- Display a plan as HTML
showPlan : Plan -> Element
showPlan l =
  let
    full = gridSettings.gridWidth
    half = toFloat (full // 2)
  in
    map (showRect << toPixelRect) l.rects
      |> group
      -- This movement moves canvas center to top left corner of canvas
      |> move (0-half, half)
      |> ungroup
      |> collage full full

-- Util
ungroup : Form -> List Form
ungroup x = [x]

-- Color of all rectangles
clearGrey : Color
clearGrey = rgba 111 111 111 0.6
