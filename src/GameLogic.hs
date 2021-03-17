module GameLogic where

import System.Random (randomIO)
import Control.Monad (forever)

-- Making the types for the GoFish hands
type Value = Integer 
type Suit = String

newtype Hand = Hand [Card] deriving Show
newtype DiscardPile = DiscardPile [Card] deriving Show 
newtype DrawPile = DrawPile [Card] deriving Show

data Card = Card Value Suit deriving Show
data GamePlay = GamePlay Hand Hand DiscardPile DrawPile deriving Show

-- creating the deck of cards
createDeck :: [Card]
createDeck = [Card v s | v <- [1..13], s <- ["DIAMOND", "HEART", "SPADE", "CLUB"]]

-- dealing a card into a hand
dealHand :: [Card] -> GamePlay
dealHand deck = GamePlay userHand cpuHand (DiscardPile []) (DrawPile $ drop 10 deck) where 
    userHand = Hand $ filterFuncAndDeal odd 
    cpuHand = Hand $ filterFuncAndDeal even
    zippedDeck = zip [1..length deck] deck 
    filterFuncAndDeal f = take 5 [card | (x, card) <- zippedDeck, f x]

-- check if chosen card is in other players hand (One for the cpu )
checkGoFish :: Card -> Hand -> Bool
checkGoFish (Card val suit) (Hand cs) = any (\(Card v s) -> v==val && s==suit) cs 

-- draw a card
drawCard :: Bool -> GamePlay -> GamePlay
drawCard True (GamePlay (Hand cs) cpu (DiscardPile (d:ds)) (DrawPile [])) = GamePlay (Hand (d:cs)) cpu (DiscardPile []) (DrawPile ds)
drawCard False (GamePlay user (Hand cs) (DiscardPile (d:ds)) (DrawPile [])) = GamePlay user (Hand (d:cs)) (DiscardPile []) (DrawPile ds)
drawCard True (GamePlay (Hand cs) cpu discard (DrawPile (d:ds))) = GamePlay (Hand (d:cs)) cpu discard (DrawPile ds)
drawCard False (GamePlay user (Hand cs) discard (DrawPile (d:ds))) = GamePlay user (Hand (d:cs)) discard (DrawPile ds)
