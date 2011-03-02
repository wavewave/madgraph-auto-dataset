{-# LANGUAGE PackageImports #-}

module HEP.Automation.MadGraph.Dataset.Set20110302v1 where


import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

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

psetup_wp_ttbar01j :: ProcessSetup
psetup_wp_ttbar01j = PS {  
    mversion = MadGraph4
  , model = Wp
  , process = processTTBar0or1jet 
  , processBrief = "ttbar01j"  
  , workname   = "302Wp1J"
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
  , pythia  = case matchtype of 
      NoMatch -> NoPYTHIA
      MLM     -> RunPYTHIA
  , usercut = UserCutDef ucut 
  , pgs     = RunPGS
  , setnum  = num
}

my_csetup :: ClusterSetup
my_csetup = CS { cluster = Parallel 3 }

wpparamset :: [Param]
wpparamset = [ WpParam 400.0 2.55 ]

psetuplist :: [ProcessSetup]
psetuplist = [ psetup_wp_ttbar01j ]

sets :: [Int]
sets = [1 .. 50 ]

wptasklist :: [WorkSetup]
wptasklist =  [ WS my_ssetup (psetup_wp_ttbar01j) (rsetupGen p MLM num) my_csetup  
                | p <- wpparamset 
                , num <- sets     ]

totaltasklist :: [WorkSetup]
totaltasklist = wptasklist 



          