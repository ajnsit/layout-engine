module Types where

-- Metadata associated with each rectangle
newtype LayoutId = LayoutId String
    deriving (Show, Eq)

-- 2D grid
-- X increases from left to right
-- Y increases from top to bottom

-- The input type
data Layout
  = Horizontal [Layout]
  | Vertical   [Layout]
  | Leaf
    { layoutId :: LayoutId
    , width :: Int
    , height :: Int
    }
    deriving (Show, Eq)

-- A 2D Point
-- Origin is at top left
data Position =
  Position
    { x :: Int
    , y :: Int
    }
    deriving (Show, Eq)

-- Rectangles laid out in 2d space
-- Also the output type
type Rects = [(LayoutId, Position)]

-- A Plan is a Rectangular region with rects
data Plan = Plan
  { rects :: Rects
  , planWidth :: Int
  , planHeight :: Int
  }
