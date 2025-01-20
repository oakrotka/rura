-- the main resulting functions, as described in `wyliczenia.pdf`
module Lib (u) where

import Compose (weights, Weights, applyWeights)
import Matrix (solveTridiagonal)
import Integrate (integrateSpikes)

u :: Int -> Double -> Double
u n x = w n x + ushift

k :: RealFloat a => a -> a 
k x
  | 0 <= x && x <= 1 = 1 
  |           x <= 2 = 2
  | otherwise = error "x out of range when calling k"

ushift :: RealFloat a => a
ushift = 3

w :: RealFloat a => Int -> a -> a 
w n = applyWeights (wWeights n)

wWeights :: RealFloat a => Int -> Weights a
wWeights n = 
  weights (0,2) 
  $ solveTridiagonal 
      (g 0 0 - 1, g 1 0, -17) 
      (map row [1..n-2])
      (g (n-2) (n-1), g (n-1) (n-1), 0)
    ++ [0]
  where 
    row i = (gi (i-1), gi i, gi (i+1), 0) where gi = flip g $ i
    g = integrateSpikes (0,2) k 1 n
