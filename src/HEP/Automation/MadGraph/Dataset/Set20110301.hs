{-# LANGUAGE PackageImports #-}

module HEP.Automation.MadGraph.Dataset.Set20110301 where

import "mtl" Control.Monad.Reader 

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType
import HEP.Automation.MadGraph.Run



my_ssetup :: ScriptSetup
my_ssetup = SS {
    scriptbase = "/home/wavewave/nfs/workspace/ttbar/mc_script/"
  , mg5base    = "/home/wavewave/nfs/montecarlo/MG_ME_V4.4.44/MadGraph5_v0_6_1/"
  , workbase   = "/home/wavewave/nfs/workspace/ttbar/mc/"
  }

ucut :: UserCut
ucut = UserCut { 
    uc_metcut    = 15.0 
  , uc_etacutlep = 1.2 
  , uc_etcutlep  = 18.0
  , uc_etacutjet = 2.5
  , uc_etcutjet  = 15.0 
}

processTTBar :: [Char]
processTTBar =  
  "\ngenerate P P > t t~  QED=99 @1\n"

psetup_sm_ttbar :: ProcessSetup
psetup_sm_ttbar = PS {  
    mversion = MadGraph5
  , model = SM 
  , process = processTTBar 
  , processBrief = "ttbar"  
  , workname   = "301SM"
  }

rsetupGen :: Param -> MatchType -> Int -> RunSetup
rsetupGen p matchtype num = RS { 
    param   = p
  , numevent = 100000
  , machine = TeVatron 
  , rgrun   = Fixed
  , rgscale = 200.0 
  , match   = matchtype
  , cut     = case matchtype of 
      NoMatch -> NoCut 
      MLM     -> DefCut
  , pythia  = RunPYTHIA
    
    --pythia  = case matchtype of 
     -- NoMatch -> NoPYTHIA
    --  MLM     -> RunPYTHIA
  , usercut = NoUserCutDef  
  , pgs     = RunPGS
  , setnum  = num
}

my_csetup :: ClusterSetup
my_csetup = CS (Parallel 6) --  { cluster = Cluster "test" }

paramset :: [Param]
paramset = [ SMParam ]

psetuplist :: [ProcessSetup]
psetuplist = [ psetup_sm_ttbar ]

sets :: [Int]
sets = [ 1,2..5 ]

smtasklist :: [WorkSetup]
smtasklist =  [ WS my_ssetup (psetup_sm_ttbar) (rsetupGen p NoMatch num) my_csetup  
                | p <- paramset 
                , num <- sets     ]

totaltasklist :: [WorkSetup]
totaltasklist = smtasklist 
