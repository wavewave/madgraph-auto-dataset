module HEP.Automation.MadGraph.Dataset.Common where

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

rsetupGen :: Param 
             -> MatchType 
             -> UserCutSet 
             -> Int          -- ^ number of events 
             -> Int          -- ^ set number
             -> RunSetup
rsetupGen p matchtype ucuttype numofevt set = RS { 
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
      NoMatch -> NoPYTHIA
      MLM     -> RunPYTHIA
  , usercut = ucuttype 
  , pgs     = RunPGS
  , setnum  = set
}
