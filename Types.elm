module Types where

-- 2D grid
-- X increases from left to right
-- Y increases from top to bottom

-- Size of a rectangle
type alias Size =
  { height : Int
  , width : Int
  }

-- A 2D Point
-- Origin is at top left
-- We use top and left instead of x and y for clarity
type alias Position =
  { top : Int
  , left : Int
  }

-- A 2D Rectangle
type alias Rect =
  { pos : Position
  , size : Size
  , layoutId : String
  }

-- A Layout is a structured Grid
-- It can be converted to a Plan for rendering
type Layout
  = Horizontal (List Layout)
  | Vertical   (List Layout)
  | Leaf
    { layoutId : String
    , width : Int
    , height : Int
    }

-- A Plan is a list of positioned rects
type alias Plan =
  { rects : List Rect
  , width : Int
  , height : Int
  }


-- SAMPLE LAYOUTS

input1 : Layout
input1 = Horizontal
  [ Leaf {layoutId ="1", width=2, height=2}
  , Leaf {layoutId ="2", width=1, height=1}
  , Leaf {layoutId ="3", width=3, height=3}
  ]

input2 : Layout
input2 = Vertical
  [ Horizontal
    [ Leaf {layoutId ="1", width=2, height=2}
    , Leaf {layoutId ="2", width=1, height=1}
    , Leaf {layoutId ="3", width=3, height=3}
    ]
  , Leaf {layoutId ="x", width=2, height=2}
  ]
