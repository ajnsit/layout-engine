module Settings where

-- A Grid is made of columns (grid units) with uniform gutter between them
-- Note that there is no framing gutter around the grid, only between elements
-- Elements in the grid span one or more columns and one or more rows

-- Grid Settings
type alias GridSettings =
  { gridWidth : Int
  , gutterWidth : Int
  , nColumns : Int
  }

-- Content space (in px) available to an element spanning x columns
colWidth : GridSettings -> Int -> Int
colWidth gs x =
  let
    w = gs.gridWidth
    g = gs.gutterWidth
    n = gs.nColumns
    c = (w - g * (n - 1)) // n
  in x * (c + g) - g

-- The width (in px) of the "span" of a grid column (content + one side gutter)
colSpan : GridSettings -> Int
colSpan gs = colWidth gs 1 + gs.gutterWidth

-- Convert from grid unit to px
-- Something with top left corner at x column will have its top left corner at (toPx x) pixels
-- This takes into account gutters etc.
toPx : GridSettings -> Int -> Int
toPx gs n = n * colSpan gs

-- Convert from px to grid units
-- This rounds the value (i.e. "snaps") to an integer column number
fromPx : GridSettings -> Int -> Int
fromPx gs x = x // colSpan gs
