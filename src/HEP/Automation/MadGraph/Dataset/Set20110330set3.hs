module HEP.Automation.MadGraph.Dataset.Set20110330set3 where


import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Dataset.Common

import HEP.Automation.MadGraph.Dataset.Desktop


processBBbar :: [Char]
processBBbar =  
  "\ngenerate P P > b b~ / g a z h w+ w-  QED=99"

psetup_wpfull_bb :: ProcessSetup
psetup_wpfull_bb = PS {  
    mversion = MadGraph4
  , model = WpFull
  , process = processBBbar 
  , processBrief = "bbbar"  
  , workname   = "331WpFull"
  }

my_csetup :: ClusterSetup
my_csetup = CS { cluster = Parallel 6 }

wpparamset :: [Param]
wpparamset = [ WpFullParam mass g g
                    | mass <- [200.0, 500.0, 800.0 ]  
                    , g   <- [0.6, 1.0 .. 4.0 ] ] 
          

psetuplist :: [ProcessSetup]
psetuplist = [ psetup_wpfull_bb ]

sets :: [Int]
sets = [1]

wptasklist :: [WorkSetup]
wptasklist =  [ WS my_ssetup (psetup_wpfull_bb) 
                        (rsetupGen p MLM NoUserCutDef NoPGS 20000 num) 
                        my_csetup  
                 | p <- wpparamset , num <- sets     ]

totaltasklist :: [WorkSetup]
totaltasklist = wptasklist 



          