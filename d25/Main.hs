import Data.Char
import Data.List
import Data.List.Split
import Data.Graph

manhattan(p, q) = sum(zipWith (\a b -> abs(a-b)) p q)
near x = let y = (zip [1..] x) in
  [(fst(a), fst(b)) | a<-y, b<-y, manhattan(snd(a), snd(b)) <= 3]
constellations x = buildG (1, length x) (near x)

main = do
  contents <- getContents
  let input = map (map (read :: String -> Int) . splitOn ",") $ lines contents
  print $ length $ components $ constellations input
