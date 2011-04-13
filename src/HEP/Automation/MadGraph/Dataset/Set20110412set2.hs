module HEP.Automation.MadGraph.Dataset.Set20110412set2 where

import HEP.Storage.WebDAV

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.Octet

import HEP.Automation.MadGraph.Dataset.Common

import qualified Data.ByteString as B

processTTBar :: [Char]
processTTBar =  
  "\ngenerate P P > t t~ QED=99\n"

psetup_octet_ttbar :: ProcessSetup Octet
psetup_octet_ttbar = PS {  
    mversion = MadGraph4
  , model = Octet
  , process = processTTBar
  , processBrief = "ttbar" 
  , workname   = "412Octet_TTBar"
  }

octetParamSet :: [ModelParam Octet]
octetParamSet = [ OctetParam m g (0.28) 
                    | m <-[135.0, 140.0 .. 155.0] 
                    , g <- [1.0, 1.05 .. 2.00] ] 
          

psetuplist :: [ProcessSetup Octet]
psetuplist = [ psetup_octet_ttbar ]

sets :: [Int]
sets = [1]

octettasklist :: ScriptSetup -> ClusterSetup -> [WorkSetup Octet]
octettasklist ssetup csetup =  
  [ WS ssetup (psetup_octet_ttbar) 
       (rsetupGen p NoMatch NoUserCutDef NoPGS 10000 num) 
       csetup  
       (WebDAVRemoteDir "mc/TeVatronFor3/Octet0412ScanTTBar")
  | p <- octetParamSet , num <- sets     ]


totaltasklist :: ScriptSetup -> ClusterSetup -> [WorkSetup Octet]
totaltasklist = octettasklist 



          