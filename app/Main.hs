module Main (main) where

import System.Environment (getArgs)

import Lib (u, wWeights)

import Graphics.Gnuplot.Simple (plotFunc, linearScale)

-- testWeights :: Weights Double 
-- testWeights = weights (-10,10) [2,1,3,7]
--
-- plotFEM :: Weights Double -> Integer -> IO ()
-- plotFEM w precision = plotFunc [] (linearScale precision (l,r)) $ applyWeights w
--   where ((l,r),_,_,_) = weightsData w 
--
-- callThenWait :: IO a -> IO ()
-- callThenWait = (>> threadDelay 100000)

parseArgs :: [String] -> Int 
parseArgs [] = 10 
parseArgs [arg] = read arg
parseArgs _ = error "too many arguments!"

main :: IO ()
main = do 
  args <- getArgs
  let n = parseArgs args :: Int
  let resWeights = wWeights n
  let resFn = u resWeights 
  -- check if the boundary conditions are correct
  print $ (resFn 2, resFn 0 + (resFn (2/fromIntegral n) - resFn 0) / (2/fromIntegral n))
  -- plot the resulting function
  plotFunc [] (linearScale (max 100 (toInteger n)) (0,2)) $ resFn
  -- wait for user input before exiting,
  -- if we don't do this the plot sometimes doesn't show up on time for big `n`s
  _ <- getChar
  return ()
