{- |
Copyright   : Galois, Inc. 2012-2015
License     : BSD3
Maintainer  : jhendrix@galois.com
Stability   : experimental
Portability : non-portable (language extensions)
-}

module Tests.Parser where

import Control.Applicative
import Control.Lens
import Control.Monad.Identity
import Data.Bits
import Text.PrettyPrint.ANSI.Leijen hiding ((<$>))

import Verifier.SAW.Module
import Verifier.SAW.Prelude
import Verifier.SAW.SharedTerm
import Verifier.SAW.Term.Functor
import Verifier.SAW.Term.Pretty

import Test.Tasty
import Test.Tasty.HUnit

checkGroundTerm :: Term -> Bool
checkGroundTerm t = looseVars t == 0

namedMsg :: Ident -> String -> String
namedMsg sym msg = "In " ++ show sym ++ ": " ++ msg

checkEqn :: Ident -> DefEqn -> Assertion
checkEqn sym (DefEqn pats rhs) = do
  let nbound = sum $ patBoundVarCount <$> pats
  let lvd = emptyLocalVarDoc
          & docShowLocalNames .~ False
          & docShowLocalTypes .~ True
  let msg = "Equation right hand side has unbound variables:\n"
         ++ show (ppDefEqn (ppTerm defaultPPOpts) emptyLocalVarDoc (ppIdent sym) (DefEqn pats rhs)) ++ "\n"
         ++ show (ppTerm defaultPPOpts lvd PrecNone rhs) ++ "\n"
         ++ show (looseVars rhs) ++ "\n"
         ++ show (ppTermDoc (ppTermF defaultPPOpts (\_ _ _ -> TermDoc . text . show) lvd PrecNone (looseVars <$> unwrapTermF rhs)))

  assertEqual (namedMsg sym msg) 0 (looseVars rhs `shiftR` nbound)

checkDef :: Def -> Assertion
checkDef d = do
  let sym = defIdent d
  let tp = defType d
  let tpProp = assertBool (namedMsg sym "Type is not ground.") (checkGroundTerm tp)
  let eqProps = checkEqn sym <$> defEqs d

  sequence_ (tpProp : eqProps)

checkModule :: Module -> Assertion
checkModule m = sequence_ $ checkDef <$> moduleDefs m

parserTests :: [TestTree]
parserTests =
  [ testCase "preludeModule" $ checkModule preludeModule
  ]
