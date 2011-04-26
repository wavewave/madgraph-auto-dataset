module HEP.Automation.MadGraph.Dataset.Common where

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

rsetupLHC :: (Model a) => ModelParam a 
             -> MatchType 
             -> UserCutSet 
             -> PGSType
             -> Int          -- ^ number of events 
             -> Int          -- ^ set number
             -> RunSetup a
rsetupLHC p matchtype ucuttype pgstype numofevt set = RS { 
    param   = p
  , numevent = numofevt
  , machine = LHC7
  , rgrun   = Fixed
  , rgscale = 200.0 
  , match   = matchtype
  , cut     = case matchtype of 
      NoMatch -> NoCut 
      MLM     -> DefCut
  , pythia  = case matchtype of 
      NoMatch -> case pgstype of 
        RunPGS -> RunPYTHIA
        NoPGS  -> NoPYTHIA
      MLM     -> RunPYTHIA
  , usercut = ucuttype 
  , pgs     = pgstype
  , setnum  = set
}


rsetupGen :: (Model a) => ModelParam a 
             -> MatchType 
             -> UserCutSet 
             -> PGSType
             -> Int          -- ^ number of events 
             -> Int          -- ^ set number
             -> RunSetup a
rsetupGen p matchtype ucuttype pgstype numofevt set = RS { 
    param   = p
  , numevent = numofevt
  , machine = TeVatron 
  , rgrun   = Fixed
  , rgscale = 200.0 
  , match   = matchtype
  , cut     = case matchtype of 
      NoMatch -> NoCut 
      MLM     -> DefCut
  , pythia  = case matchtype of 
      NoMatch -> case pgstype of 
        RunPGS -> RunPYTHIA
        NoPGS  -> NoPYTHIA
      MLM     -> RunPYTHIA
  , usercut = ucuttype 
  , pgs     = pgstype
  , setnum  = set
}
