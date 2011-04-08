module HEP.Automation.MadGraph.Dataset.Set20110407set1 where


import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Dataset.Common
import HEP.Automation.MadGraph.Dataset.SUSY

import HEP.Automation.MadGraph.Model.SM

import qualified Data.ByteString as B

processHW :: [Char]
processHW =  
  "\ngenerate P P > h w+ QED=99 @1\nadd process P P > h w- QED=99 @2" 

psetup_sm_hw :: ProcessSetup SMHiggs
psetup_sm_hw = PS {  
    mversion = MadGraph5
  , model = SMHiggs
  , process = processHW
  , processBrief = "hw"  
  , workname   = "407SM_HW"
  }

my_csetup :: ClusterSetup
my_csetup = CS { cluster = Parallel 3 }

smFullParamSet :: [ModelParam SMHiggs]
smFullParamSet = [ SMHiggsParam m w | m <- [144.0], w <- [1e-3] ]
          

psetuplist :: [ProcessSetup SMHiggs]
psetuplist = [ psetup_sm_hw ]

sets :: [Int]
sets = [1]

smtasklist :: [WorkSetup SMHiggs]
smtasklist =  [ WS my_ssetup (psetup_sm_hw) 
                   RS { param = p
                      , numevent = 10000
                      , machine = TeVatron
                      , rgrun = Auto
                      , rgscale = 200.0
                      , match = NoMatch
                      , cut = NoCut
                      , pythia = NoPYTHIA
                      , usercut = NoUserCutDef
                      , pgs = NoPGS
                      , setnum = num } 
                   my_csetup  
                 | p <- smFullParamSet , num <- sets     ]



totaltasklist :: [WorkSetup SMHiggs]
totaltasklist = smtasklist 



          