module Verifier.SAW.Heapster.Token
  ( Token(..),
    tokenNat,
    tokenIdent,
    describeToken,
  ) where

import GHC.Natural (Natural)

-- | Lexical token generated by 'Verifier.SAW.Heapster.Lexer.lexer'
data Token
  = TOpenParen          -- ^ symbol @(@
  | TCloseParen         -- ^ symbol @)@
  | TOpenBrack          -- ^ symbol @[@
  | TCloseBrack         -- ^ symbol @]@
  | TOpenBrace          -- ^ symbol @{@
  | TCloseBrace         -- ^ symbol @}@
  | TOpenAngle          -- ^ symbol @<@
  | TCloseAngle         -- ^ symbol @>@
  | TColon              -- ^ symbol @:@
  | TDot                -- ^ symbol @.@
  | TSemicolon          -- ^ symbol @;@
  | TComma              -- ^ symbol @,@
  | TPlus               -- ^ symbol @+@
  | TStar               -- ^ symbol @*@
  | TAt                 -- ^ symbol @\@@
  | TLoli               -- ^ symbol @-o@
  | TMapsTo             -- ^ symbol @|->@
  | TEqual              -- ^ symbol @==@
  | TNotEqual           -- ^ symbol @/=@
  | TUnsignedLt         -- ^ symbol @<u@
  | TUnsignedLe         -- ^ symbol @<=u@
  | TOr                 -- ^ keyword @or@
  | TTrue               -- ^ keyword @true@
  | TFalse              -- ^ keyword @false@
  | TEmpty              -- ^ keyword @empty@
  | TExists             -- ^ keyword @exists@
  | TEq                 -- ^ keyword @eq@
  | TUnit               -- ^ keyword @unit@
  | TBool               -- ^ keyword @bool@
  | TNat                -- ^ keyword @nat@
  | TBV                 -- ^ keyword @bv@
  | TArray              -- ^ keyword @array@
  | TPtr                -- ^ keyword @ptr@
  | TPerm               -- ^ keyword @perm@
  | TLlvmPtr            -- ^ keyword @llvmptr@
  | TLlvmFunPtr         -- ^ keyword @llvmfunptr@
  | TLlvmFrame          -- ^ keyword @llvmframe@
  | TLlvmShape          -- ^ keyword @llvmshape@
  | TLlvmBlock          -- ^ keyword @llvmblock@
  | TLlvmWord           -- ^ keyword @llvmword@
  | TLifetime           -- ^ keyword @lifetime@
  | TLOwned             -- ^ keyword @lowned@
  | TLCurrent           -- ^ keyword @lcurrent@
  | TLFinished          -- ^ keyword @lfinished@
  | TRWModality         -- ^ keyword @rwmodality@
  | TPermList           -- ^ keyword @permlist@
  | TStruct             -- ^ keyword @struct@
  | TShape              -- ^ keyword @shape@
  | TEmptySh            -- ^ keyword @emptysh@
  | TFalseSh            -- ^ keyword @falsesh@
  | TEqSh               -- ^ keyword @eqsh@
  | TPtrSh              -- ^ keyword @ptrsh@
  | TFieldSh            -- ^ keyword @fieldsh@
  | TArraySh            -- ^ keyword @arraysh@
  | TExSh               -- ^ keyword @exsh@
  | TOrSh               -- ^ keyword @orsh@
  | TMemBlock           -- ^ keyword @memblock@
  | TFree               -- ^ keyword @free@
  | TAlways             -- ^ keyword @always@
  | TR                  -- ^ keyword @R@
  | TW                  -- ^ keyword @W@
  | TIdent String       -- ^ identifier
  | TNatLit Natural     -- ^ number literal
  | TError String       -- ^ lexical error
  deriving Show

-- | Recognizer for 'TNatLit' constructor.
-- Returns constructor argument if matched.
tokenNat :: Token -> Maybe Natural
tokenNat (TNatLit n) = Just n
tokenNat _           = Nothing

-- | Recognizer for 'TIdent' constructor.
-- Returns constructor argument if matched.
tokenIdent :: Token -> Maybe String
tokenIdent (TIdent n) = Just n
tokenIdent _          = Nothing

-- | Human readable description of a token for error reporting.
describeToken :: Token -> String
describeToken t =
  case t of
    TOpenParen          -> "'('"
    TCloseParen         -> "')'"
    TOpenBrack          -> "'['"
    TCloseBrack         -> "']'"
    TOpenBrace          -> "'{'"
    TCloseBrace         -> "'}'"
    TOpenAngle          -> "'<'"
    TCloseAngle         -> "'>'"
    TColon              -> "':'"
    TDot                -> "'.'"
    TComma              -> "','"
    TSemicolon          -> "';'"
    TPlus               -> "'+'"
    TStar               -> "'*'"
    TAt                 -> "'@'"
    TLoli               -> "'-o'"
    TMapsTo             -> "'|->'"
    TEqual              -> "'=='"
    TNotEqual           -> "'/='"
    TUnsignedLt         -> "'<u'"
    TUnsignedLe         -> "'<=u'"
    TOr                 -> "keyword 'or'"
    TTrue               -> "keyword 'true'"
    TFalse              -> "keyword 'false'"
    TEmpty              -> "keyword 'empty'"
    TExists             -> "keyword 'exists'"
    TEq                 -> "keyword 'eq'"
    TUnit               -> "keyword 'unit'"
    TBool               -> "keyword 'bool'"
    TNat                -> "keyword 'nat'"
    TBV                 -> "keyword 'bv'"
    TArray              -> "keyword 'array'"
    TPtr                -> "keyword 'ptr'"
    TPerm               -> "keyword 'perm'"
    TLlvmPtr            -> "keyword 'llvmptr'"
    TLlvmFunPtr         -> "keyword 'llvmfunptr'"
    TLlvmFrame          -> "keyword 'llvmframe'"
    TLlvmShape          -> "keyword 'llvmshape'"
    TLlvmBlock          -> "keyword 'llvmblock'"
    TLlvmWord           -> "keyword 'llvmword'"
    TLifetime           -> "keyword 'lifetime'"
    TLOwned             -> "keyword 'lowned'"
    TLCurrent           -> "keyword 'lcurrent'"
    TLFinished          -> "keyword 'lfinished'"
    TRWModality         -> "keyword 'rwmodality'"
    TPermList           -> "keyword 'permlist'"
    TStruct             -> "keyword 'struct'"
    TShape              -> "keyword 'shape'"
    TEmptySh            -> "keyword 'emptysh'"
    TFalseSh            -> "keyword 'falsesh'"
    TEqSh               -> "keyword 'eqsh'"
    TPtrSh              -> "keyword 'ptrsh'"
    TFieldSh            -> "keyword 'fieldsh'"
    TArraySh            -> "keyword 'arraysh'"
    TExSh               -> "keyword 'exsh'"
    TOrSh               -> "keyword 'orsh'"
    TMemBlock           -> "keyword 'memblock'"
    TFree               -> "keyword 'free'"
    TAlways             -> "keyword 'always'"
    TR                  -> "keyword 'R'"
    TW                  -> "keyword 'W'"
    TIdent  ident       -> "identifier " ++ ident
    TNatLit n           -> "literal " ++ show n
    TError  _           -> "lexical error"
