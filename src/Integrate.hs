-- numeric integration
module Integrate (numericDerivative, integrateSpikes) where 

import Compose (spike)

-- computes the derivative of a function in a given point, numerically
numericDerivative :: RealFloat a => a -> (a -> a) -> a -> a
numericDerivative h f x = (f (x + h) - f (x - h)) / (2*h)

-- computes the integral of a continous function on a given interval, numerically.
-- this uses the gauss-legendre method for n=2
numericIntegration :: RealFloat a => (a -> a) -> a -> a -> a
numericIntegration f l r = shift * (fShifted (1/sqrt 3) + fShifted (-1/sqrt 3))
  where 
    shift = (r - l) / 2
    fShifted x = f (shift * x + (r + l) / 2)

-- integrates the product of function `k` with a loss of continuity in `breakpoint`
-- and derivatives of spikes of indexes `eidx` and `vidx` on the `(l,r)` interval.
-- this equivalent to the g function described in `wyliczenia.pdf`
integrateSpikes :: RealFloat a => (a,a) -> (a -> a) -> a -> Int -> Int -> Int -> a
integrateSpikes (l,r) k breakpoint n eidx vidx 
  | eidx == vidx = integratePart (x1 - h) x1 + integratePart x1 (x1 + h)
  | otherwise    = integratePart x1 x2
  where 
    h = (r - l) / fromIntegral n
    xOfIdx i = l + fromIntegral i * h
    sorted a b = if a <= b then (a,b) else (b,a)
    (x1,x2) = sorted (xOfIdx eidx) (xOfIdx vidx)

    -- breaking the interval into two parts if `breakpoint` is contained in it
    integratePart ri li = 
      let (a,b) = (max l ri, min r li)
      in if a < breakpoint && breakpoint < b 
         then integrateContinous a breakpoint + integrateContinous breakpoint b 
         else integrateContinous a b

    -- integration of a continous interval
    integrateContinous = numericIntegration $ \x -> (k x * ds x1 x * ds x2 x)

    -- derivative of a spike in a point
    ds p x = numericDerivative eps (spike h p) x
    eps = h / 1000
