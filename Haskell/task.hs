import System.Random (randomRIO, newStdGen, randomR)
import Control.Monad (replicateM, when)
import Data.List (sort)

getRandomSize :: [Int] -> Int -> IO (Int, [Int])
getRandomSize sizes bound = do
    gen <- newStdGen
    let loop = do
        let size = fst $ randomR (1, bound) gen
        print size
        if not $ elem size sizes
            then return (size, size : sizes)
            else loop
    loop

getRandomList :: Int -> IO ([Int])
getRandomList size = replicateM size $ randomRIO (1, 100)

generateLists' :: Int -> [Int] -> IO([[Int]])
generateLists' 0 sizes = return []
generateLists' n sizes = do
    (randomSize, newSizes) <- getRandomSize sizes (5 * n)
    randomList <- getRandomList randomSize
    let sortedList = if (n - 1) `mod` 2 == 0
        then sort randomList
        else reverse $ sort randomList
    otherLists <- generateLists' (n - 1) newSizes
    print otherLists
    return $ sortedList : otherLists

generateLists n
    | n < 0 = error "The value of the n parameter must be positive."
    | otherwise = generateLists' n []
