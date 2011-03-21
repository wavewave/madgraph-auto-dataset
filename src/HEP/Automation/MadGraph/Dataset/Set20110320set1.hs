{-# LANGUAGE PackageImports #-}

module HEP.Automation.MadGraph.Dataset.Set20110320set1 where


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

processPhiTopSemiTau :: [Char]
processPhiTopSemiTau =  
  "\ngenerate P P > wp- t, (wp- > t~ d, (t~ > b~ w-, w- > ta- vt~)), (t > b w+, w+ > J J) @1 \nadd process P P > wp- t, (wp- > t~ d, (t~ > b~ w-, w- > J J)), (t > b w+, w+ > ta+ vt ) @2 \nadd process P P > wp+ t~, (wp+ > t d~, (t > b w+, w+ > ta+ vt)), (t~ > b~ w-, w- > J J ) @3 \nadd process P P > wp+ t~ , (wp+ > t d~, (t > b w+, w+ > J J )), (t~ > b~ w- , w- > ta- vt~ ) @4 \n"

psetup_wp_phitop_semitau :: ProcessSetup
psetup_wp_phitop_semitau = PS {  
    mversion = MadGraph4
  , model = Wp
  , process = processPhiTopSemiTau
  , processBrief = "phit_semitau"  
  , workname   = "320Wp1J"
  }

rsetupLHC7 :: Param -> Int -> RunSetup
rsetupLHC7 p num = RS { 
    param   = p
  , numevent = 10000
  , machine = LHC7 
  , rgrun   = Fixed
  , rgscale = 200.0 
  , match   = NoMatch
  , cut     = DefCut
  , pythia  = RunPYTHIA
  , usercut = NoUserCutDef 
  , pgs     = RunPGS
  , setnum  = num
}

my_csetup :: ClusterSetup
my_csetup = CS { cluster = Parallel 3 }

wpparamset :: [Param]
wpparamset = [ WpParam 200.0 1.00 ]

psetuplist :: [ProcessSetup]
psetuplist = [ psetup_wp_phitop_semitau ]

sets :: [Int]
sets = [1 ]

wptasklist :: [WorkSetup]
wptasklist =  [ WS my_ssetup (psetup_wp_phitop_semitau) (rsetupLHC7 p num) my_csetup  
                | p <- wpparamset 
                , num <- sets     ]

totaltasklist :: [WorkSetup]
totaltasklist = wptasklist 



          