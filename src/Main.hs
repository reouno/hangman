module Main where

import           System.Random                  ( randomRIO )
import           Data.List                      ( intersperse )

main :: IO ()
main = do
    putStrLn "hello world"


type WordList = [String]

allWords :: IO WordList
allWords = do
    dict <- readFile "data/dict.txt"
    return $ lines dict

minWordLen :: Int
minWordLen = 5

maxWordLen :: Int
maxWordLen = 9

gameWords :: IO WordList
gameWords = filter gameLength <$> allWords
  where
    gameLength w = let len = length w in minWordLen < len && len < maxWordLen

randomWord :: IO String
randomWord = randomWord' =<< gameWords

randomWord' :: WordList -> IO String
randomWord' ws = do
    randomIndex <- randomRIO (0, length ws)
    return $ ws !! randomIndex

data Puzzle = Puzzle String [Maybe Char] String deriving (Eq)

instance Show Puzzle where
    show (Puzzle _ discovered guessed) =
        (intersperse ' ' $ fmap renderPuzzleChar discovered)
            ++ " Guessed so far: "
            ++ guessed

renderPuzzleChar :: Char -> Char
renderPuzzleChar = undefined
