module Sample where

import Types

input1 :: Layout
input1 = Horizontal
  [ Leaf (LayoutId "1") 2 2
  , Leaf (LayoutId "2") 1 1
  , Leaf (LayoutId "3") 3 3
  ]

input2 :: Layout
input2 = Vertical
  [ Horizontal
    [ Leaf (LayoutId "1") 2 2
    , Leaf (LayoutId "2") 1 1
    , Leaf (LayoutId "3") 3 3
    ]
  , Leaf (LayoutId "x") 2 2
  ]
