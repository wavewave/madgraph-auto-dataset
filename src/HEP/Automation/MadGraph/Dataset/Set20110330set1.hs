module HEP.Automation.MadGraph.Dataset.Set20110315set3 where


import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Dataset.Common

import HEP.Automation.MadGraph.Dataset.SUSY


processTB :: [Char]
processTB =  
  "\ngenerate P P > t b~ / g a z h w+ w-  QED=99 @1 \nadd process P P > t~ b / g a z h w+ w- QED=99 @2 \n"

psetup_sixfull_tb :: ProcessSetup
psetup_sixfull_tb = PS {  
    mversion = MadGraph5
  , model = SixFull
  , process = processTB 
  , processBrief = "tb"  
  , workname   = "330SixFull"
  }

my_csetup :: ClusterSetup
my_csetup = CS { cluster = Parallel 6 }

sixparamset :: [Param]
sixparamset = [ SixParam mass g g
                    | mass <- [200.0, 500.0, 800.0 ]  
                    , g   <- [0.6, 1.0 .. 4.0 ] ] 
          

psetuplist :: [ProcessSetup]
psetuplist = [ psetup_sixfull_tb ]

sets :: [Int]
sets = [1]

sixtasklist :: [WorkSetup]
sixtasklist =  [ WS my_ssetup (psetup_sixfull_tb) 
                        (rsetupGen p MLM NoUserCutDef NoPGS 20000 num) 
                        my_csetup  
                 | p <- sixparamset , num <- sets     ]

totaltasklist :: [WorkSetup]
totaltasklist = sixtasklist 



          