{-# LANGUAGE PackageImports #-}

module HEP.Automation.MadGraph.Dataset.Set20110228 where

import "mtl" Control.Monad.Reader 

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType
import HEP.Automation.MadGraph.Run

my_ssetup :: ScriptSetup
my_ssetup = SS {
    scriptbase = "/Users/iankim/mac/workspace/ttbar/mc_script/"
  , mg5base    = "/Users/iankim/mac/montecarlo/MG_ME_V4.4.44/MadGraph5_v0_6_1/"
  , workbase   = "/Users/iankim/mac/workspace/ttbar/mc/"
  }

ucut :: UserCut
ucut = UserCut { 
    uc_metcut    = 15.0 
  , uc_etacutlep = 1.2 
  , uc_etcutlep  = 18.0
  , uc_etacutjet = 2.5
  , uc_etcutjet  = 15.0 
}

processTTBar0or1jet :: [Char]
processTTBar0or1jet =  
  "\ngenerate P P > t t~  QED=99 @1 \nadd process P P > t t~ J QED=99 @2 \n"

psetup_zp_ttbar01j :: ProcessSetup
psetup_zp_ttbar01j = PS {  
    mversion = MadGraph4
  , model = ZpH 
  , process = processTTBar0or1jet 
  , processBrief = "ttbar01j"  
  , workname   = "228ZpH1J"
  }

rsetupGen :: Param -> MatchType -> Int -> RunSetup
rsetupGen p matchtype num = RS { 
    param   = p
  , numevent = 20000
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
  , usercut = NoUserCutDef -- UserCutDef ucut 
  , pgs     = NoPGS -- RunPGS
  , setnum  = num
}

my_csetup :: ClusterSetup
my_csetup = CS { cluster = Parallel 3 
 -- Cluster "test" 
}

zpparamset :: [Param]
zpparamset = [ ZpHParam m x | x <- [0.6, 0.8 .. 4.0 ], m <- [200.0, 300.0 .. 800.0]  ]

psetuplist :: [ProcessSetup]
psetuplist = [ psetup_zp_ttbar01j ]

sets :: [Int]
sets = [1 ]

zptasklist :: [WorkSetup]
zptasklist =  [ WS my_ssetup (psetup_zp_ttbar01j) (rsetupGen p MLM num) my_csetup  
                | p <- zpparamset 
                , num <- sets     ]

totaltasklist :: [WorkSetup]
totaltasklist = zptasklist 



          