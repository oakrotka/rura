module Matrix (solveTridiagonal) where 

solveTridiagonal :: Fractional a => (a,a,a) -> [(a,a,a,a)] -> (a,a,a) -> [a]
solveTridiagonal (b1,c1,d1) rows (an,bn,dn) = reverse revx
  where 
    revx = zipWith (\(b,c,d) x -> (d - c*x) / b) (reverse newVals) (0 : revx)

    -- [(b,c,d)] 
    newVals = (b1, c1, d1) : zipWith valCompute (rows ++ [(an,bn,0,dn)]) newVals

    valCompute (ai,bi,ci,di) (bp,cp,dp) = (bi - w * cp, ci, di - w * dp)
      where w = ai / bp
