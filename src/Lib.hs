module Lib
    ( someFunc
    ) where

{-
Game Logic:
    5 cards to start per player
        pair or more to put down on table
            once pair is in middle anyone is able to place same card value on pile
        if no pair then either ask oponent for card in hand
            if no recipricating card then person being aske question responds "Go Fish" and question asker draws card from deck
        Moves to next player in game    
        Repeats until a player has no more cards in their hand
-}

someFunc :: IO ()
someFunc = putStrLn "someFunc"
