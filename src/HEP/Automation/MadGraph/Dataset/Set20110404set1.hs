module HEP.Automation.MadGraph.Dataset.Set20110404set1 where


import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Dataset.Common

import HEP.Automation.MadGraph.Dataset.SUSY


processTB :: [Char]
processTB =  
  "\ngenerate P P > t b / g a z h w+ w-  QED=99"

psetup_wpzpfull_bb :: ProcessSetup
psetup_wpzpfull_bb = PS {  
    mversion = MadGraph4
  , model = WpZpFull
  , process = processTB 
  , processBrief = "tb"  
  , workname   = "404WpZpFull"
  }

my_csetup :: ClusterSetup
my_csetup = CS { cluster = Parallel 3 }

wpzpparamset :: [Param]
wpzpparamset = [ WpZpFullParam m m gW gW gZ gZ gZ gZ 
                    | m <-[150.0] 
                    , gW <- [0.5*sqrt 2] 
                    , gZ <- [0.5]  ] 
          

psetuplist :: [ProcessSetup]
psetuplist = [ psetup_wpzpfull_bb ]

sets :: [Int]
sets = [1]

wpzptasklist :: [WorkSetup]
wpzptasklist =  [ WS my_ssetup (psetup_wpzpfull_bb) 
                        (rsetupGen p MLM NoUserCutDef NoPGS 20000 num) 
                        my_csetup  
                 | p <- wpzpparamset , num <- sets     ]

totaltasklist :: [WorkSetup]
totaltasklist = wpzptasklist 



          