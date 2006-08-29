{-# OPTIONS -fglasgow-exts #-}

{- 

   (C) 2004, Oleg Kiselyov, Ralf Laemmel, Keean Schupke

   Some dedicated infix operators at the type and the value level.

-}


module GhcSyntax where

import FakePrelude
import HListPrelude
import HOccurs
import Record
import GhcRecord
import TIP
import TIC


{-----------------------------------------------------------------------------}

-- Convenience notation for type sequences

infixr 2 :*:
infixr 2 .*.
 
type e :*: l = HCons e l
 
(.*.) :: HExtend e l l' => e -> l -> l'
(.*.) =  hExtend


{-----------------------------------------------------------------------------}

-- Convenience notation for records
 
infixr 4 :=:
type l :=: v = F l v
 
infixr 4 .=.
l .=. v = newF l v

infixr 3 .!.
r .!. l =  hLookupByLabel l r

infixl 1 .-.
r .-. l =  hDeleteAtLabel l r

infixl 1 .@.
r .@. f@(F v) =  hUpdateAtLabel (labelF f) v r

infixr 1 .^.
f@(F v) .^. r = hUnproxyLabel (labelF f) v r

infixr 1 .<.
f@(F v) .<. r = hTPupdateAtLabel (labelF f) v r

infixl 1 .<++.
r .<++. r' = hLeftUnion r r'


{-----------------------------------------------------------------------------}

-- Convenience notation for TIRs

infixr 2 :+:
infixr 2 .+.

type e :+: l = HCons (Proxy e) l

(.+.) :: ( HTypeIndexed l
         , HTypeProxied l
         , HOccursNot (Proxy e) l
         )
      => e -> TIP l -> TIP (HCons (Proxy e) l)
e .+. r = hExtend (toProxy e) r


{-----------------------------------------------------------------------------}
