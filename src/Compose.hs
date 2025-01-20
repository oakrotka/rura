-- logic that the result is composed of - base functions (spikes) and weights
module Compose 
  ( applyWeights,
    Weights,
    weights,
    weightsData,
    spike
  ) where

import Data.Array

-- base function in a form of a spike
spike :: (Floating a, Ord a) => a -> a -> a -> a
spike h p x = max 0 (1 - abs ((x - p) / h))


-- data structure storing information about the computed weights and the interval they're 
-- defined on
data Weights a = MkWeights (a,a) (Array Int a) deriving Show

-- constructor
weights :: (a,a) -> [a] -> Weights a
weights (l, r) list = MkWeights (l,r) (array (0, length list - 1) (zip [0..] list))

-- information about the weights
weightsData :: Floating a => Weights a -> ((a,a), Int, a, Array Int a)
weightsData w = ((l,r), n, h, arr)
  where 
    MkWeights (l,r) arr = w 
    (_,n) = bounds arr 
    h = (r - l) / (fromIntegral n)


-- computes a value in a point determined by the weights
applyWeights :: RealFloat a => Weights a -> a -> a
applyWeights w x 
  | x == r          = w1 -- * s1
  | l <= x && x < r = w1 * s1 + w2 * s2
  | otherwise = error "Value of x out of range"
  where 
    ((l, r), _, h, weightVals) = weightsData w
    i = floor $ (x - l) / h

    positionAt idx = l + (fromIntegral idx) * h
    heightOfSpike idx = spike h (positionAt idx) x
    weighSpike idx = (weightVals ! idx, heightOfSpike idx)
    
    (w1, s1) = weighSpike i
    (w2, s2) = weighSpike (i + 1)
