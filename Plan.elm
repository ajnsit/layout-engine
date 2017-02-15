module Plan (plan) where

-- Defines `plan` which converts a Layout into a Plan

import Html exposing (text)

import List exposing (..)
import Maybe exposing (withDefault)

import Types exposing (..)

-- Convert a Layout into a Plan
plan : Position -> Layout -> Plan
plan startPos lyt =
  case lyt of
    Horizontal ls -> foldr (besides << plan startPos) nullPlan ls
    Vertical ls -> foldr (above << plan startPos) nullPlan ls
    Leaf leaf -> { rects = [toRect leaf.layoutId startPos.left startPos.top leaf.width leaf.height]
                 , height = leaf.height
                 , width = leaf.width
                 }


-- The rest are helper functions

toRect : String -> Int -> Int -> Int -> Int -> Rect
toRect lid x y w h =
  { pos = {top = y, left = x}
  , size = {height = h, width = w}
  , layoutId = lid
  }

-- Displace a list of rects by x and y deltas
displace : Int -> Int -> List Rect -> List Rect
displace dx dy =
  let movePos r = { r | pos = { left = r.pos.left + dx, top = r.pos.top + dy } }
  in map movePos

-- Arrange 2 plans horizontally
besides : Plan -> Plan -> Plan
besides plan1 plan2 =
  let
    p1 = plan1.rects
    p2 = displace plan1.width 0 plan2.rects
    bheight = max plan1.height plan2.height
    bwidth = plan1.width + plan2.width
  in { rects = append p1 p2, height = bheight, width = bwidth }

-- Arrange 2 plans vertically
above : Plan -> Plan -> Plan
above plan1 plan2 =
  let
    p1 = plan1.rects
    p2 = displace 0 plan1.height plan2.rects
    bheight = plan1.height + plan2.height
    bwidth = max plan1.width plan2.width
  in { rects = append p1 p2, height = bheight, width = bwidth }

-- Null plan
nullPlan : Plan
nullPlan = { rects = [], height = 0, width = 0 }
