module HEP.Automation.MadGraph.Dataset.Set20110413set2 where

import HEP.Storage.WebDAV

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.AxiGluon

import HEP.Automation.MadGraph.Dataset.Common

import qualified Data.ByteString as B

processTTBar :: [Char]
processTTBar =  
  "\ngenerate P P > t t~ QED=99\n"

psetup_axi_ttbar :: ProcessSetup AxiGluon
psetup_axi_ttbar = PS {  
    mversion = MadGraph4
  , model = AxiGluon
  , process = processTTBar
  , processBrief = "ttbar" 
  , workname   = "413AxiGluon_TTBar"
  }

axiParamSet :: [ModelParam AxiGluon]
axiParamSet = [ AxiGluonParam m 0.0 0.0 g1 g2  
                    | m <-[150.0] 
                    , g1 <- [0.10, 0.20 .. 2.00] 
                    , g2 <- [0.10, 0.20 .. 2.00] ] 
          

psetuplist :: [ProcessSetup AxiGluon]
psetuplist = [ psetup_axi_ttbar ]

sets :: [Int]
sets = [1]

axitasklist :: ScriptSetup -> ClusterSetup AxiGluon -> [WorkSetup AxiGluon]
axitasklist ssetup csetup =  
  [ WS ssetup (psetup_axi_ttbar) 
       (rsetupGen p NoMatch NoUserCutDef NoPGS 10000 num) 
       csetup  
       (WebDAVRemoteDir "mc/TeVatronFor3/AxiGluon0413ScanTTBar")
  | p <- axiParamSet , num <- sets     ]


totaltasklist :: ScriptSetup -> ClusterSetup AxiGluon -> [WorkSetup AxiGluon]
totaltasklist = axitasklist 

          