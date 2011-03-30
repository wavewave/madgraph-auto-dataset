module HEP.Automation.MadGraph.Dataset.Set20110330set2 where


import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Dataset.Common

import HEP.Automation.MadGraph.Dataset.Desktop


processTB :: [Char]
processTB =  
  "\ngenerate P P > t b~ / g a z h w+ w-  QED=99 @1 \nadd process P P > t~ b / g a z h w+ w- QED=99 @2 \n"

psetup_tripfull_tb :: ProcessSetup
psetup_tripfull_tb = PS {  
    mversion = MadGraph5
  , model = TripFull
  , process = processTB 
  , processBrief = "tb"  
  , workname   = "330TripFull"
  }

my_csetup :: ClusterSetup
my_csetup = CS { cluster = Parallel 6 }

tripparamset :: [Param]
tripparamset = [ TripFullParam mass g g
                    | mass <- [200.0, 500.0, 800.0 ]  
                    , g   <- [0.6, 1.0 .. 4.0 ] ] 
          

psetuplist :: [ProcessSetup]
psetuplist = [ psetup_tripfull_tb ]

sets :: [Int]
sets = [1]

triptasklist :: [WorkSetup]
triptasklist =  [ WS my_ssetup (psetup_tripfull_tb) 
                        (rsetupGen p MLM NoUserCutDef NoPGS 20000 num) 
                        my_csetup  
                 | p <- tripparamset , num <- sets     ]

totaltasklist :: [WorkSetup]
totaltasklist = triptasklist 



          