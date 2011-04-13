module HEP.Automation.MadGraph.Dataset.Set20110412set3 where


import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.Trip

import HEP.Automation.MadGraph.Dataset.Common

import qualified Data.ByteString as B

processTTBar :: [Char]
processTTBar =  
  "\ngenerate P P > t t~ QED=99\n"

psetup_trip_ttbar :: ProcessSetup Trip
psetup_trip_ttbar = PS {  
    mversion = MadGraph5
  , model = Trip
  , process = processTTBar
  , processBrief = "ttbar" 
  , workname   = "412Trip_TTBar"
  }

tripParamSet :: [ModelParam Trip]
tripParamSet = [ TripParam m g  
                    | m <-[135.0, 140.0 .. 155.0] 
                    , g <- [1.0, 1.05 .. 2.00] ] 
          

psetuplist :: [ProcessSetup Trip]
psetuplist = [ psetup_trip_ttbar ]

sets :: [Int]
sets = [1]

triptasklist :: ScriptSetup -> ClusterSetup -> [WorkSetup Trip]
triptasklist ssetup csetup =  
  [ WS ssetup (psetup_trip_ttbar) 
       (rsetupGen p NoMatch NoUserCutDef NoPGS 10000 num) 
       csetup  
  | p <- tripParamSet , num <- sets     ]


totaltasklist :: ScriptSetup -> ClusterSetup -> [WorkSetup Trip]
totaltasklist = triptasklist 



          