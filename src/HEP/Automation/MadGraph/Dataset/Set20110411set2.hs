module HEP.Automation.MadGraph.Dataset.Set20110411set2 where

import HEP.Storage.WebDAV

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.ZpHFull

import HEP.Automation.MadGraph.Dataset.Common

import qualified Data.ByteString as B

processTTBarSemiZp :: [Char]
processTTBarSemiZp =  
  "\ngenerate P P > t t~ QED=99, ( t > b w+, w+ > l+ vl ), (t~ > u~ zput, zput > b~ d ) @1 \nadd process P P > t t~ QED=99, (t > u zptu, zptu > b d~ ), (t~ > b~ w-, w- > l- vl~ ) @2 \n"

psetup_zphfull_TTSemiZp :: ProcessSetup ZpHFull
psetup_zphfull_TTSemiZp = PS {  
    mversion = MadGraph4
  , model = ZpHFull
  , process = processTTBarSemiZp
  , processBrief = "TTSemiZp" 
  , workname   = "411ZpH_TTBarSemiZp"
  }

zpHFullParamSet :: [ModelParam ZpHFull]
zpHFullParamSet = [ ZpHFullParam m g (0.28) 
                    | m <-[135.0, 140.0 .. 155.0] 
                    , g <- [0.70, 0.75 .. 1.40] ] 
          

psetuplist :: [ProcessSetup ZpHFull]
psetuplist = [ psetup_zphfull_TTSemiZp ]

sets :: [Int]
sets = [1]

zptasklist :: ScriptSetup -> ClusterSetup -> [WorkSetup ZpHFull]
zptasklist ssetup csetup =  
  [ WS ssetup (psetup_zphfull_TTSemiZp) 
       (rsetupGen p NoMatch NoUserCutDef NoPGS 10000 num) 
       csetup  
       (WebDAVRemoteDir "mc/TeVatronFor3/ZpHFull0411ScanTTBarSemiZp")
  | p <- zpHFullParamSet , num <- sets     ]


totaltasklist :: ScriptSetup -> ClusterSetup -> [WorkSetup ZpHFull]
totaltasklist = zptasklist 



          