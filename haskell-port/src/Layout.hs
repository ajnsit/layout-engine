module Layout where

import Types

-- Note that the output LayoutId is not checked, nor needed to be unique
layout :: Position -> Layout -> Rects
layout startPos lyt = rects $ plan startPos lyt

plan :: Position -> Layout -> Plan
plan startPos lyt =
  case lyt of
    Horizontal ls -> foldr (besides . plan startPos) nullPlan ls
    Vertical ls -> foldr (above . plan startPos) nullPlan ls
    leaf -> Plan { rects = [(layoutId leaf, startPos)], planHeight = height leaf, planWidth = width leaf }

  where

    -- Displace a plan by x and y deltas
    displace :: Int -> Int -> Rects -> Rects
    displace dx dy = map (fmap movePos)
      where
        movePos p = Position (x p + dx) (y p + dy)

    -- Arrange 2 plans horizontally
    besides :: Plan -> Plan -> Plan
    besides plan1 plan2 = Plan { rects = p1++p2, planHeight = bheight, planWidth = bwidth }
      where
        p1 = rects plan1
        p2 = displace (planWidth plan1) 0 (rects plan2)
        bheight = max (planHeight plan1) (planHeight plan2)
        bwidth = planWidth plan1 + planWidth plan2

    -- Arrange 2 plans vertically
    above :: Plan -> Plan -> Plan
    above plan1 plan2 = Plan { rects = p1++p2, planHeight = bheight, planWidth = bwidth }
      where
        p1 = rects plan1
        p2 = displace 0 (planHeight plan1) (rects plan2)
        bheight = planHeight plan1 + planHeight plan2
        bwidth = max (planWidth plan1) (planWidth plan2)

    -- Null plan
    nullPlan :: Plan
    nullPlan = Plan { rects = [], planHeight = 0, planWidth = 0 }
