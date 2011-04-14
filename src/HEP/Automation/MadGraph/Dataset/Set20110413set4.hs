module HEP.Automation.MadGraph.Dataset.Set20110413set4 where

import HEP.Storage.WebDAV

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.ZpHFull

import HEP.Automation.MadGraph.Dataset.Common

import qualified Data.ByteString as B

{-
ucut :: UserCut
ucut = UserCut { 
    uc_metcut    = 15.0 
  , uc_etacutlep = 1.2 
  , uc_etcutlep  = 18.0
  , uc_etacutjet = 2.5
  , uc_etcutjet  = 15.0 
} -} 
 
processTTBarSemiZp :: [Char]
processTTBarSemiZp =  
  "\ngenerate P P > t t~ QED=99, ( t > b w+, w+ > l+ vl ), (t~ > u~ zput, zput > b~ d ) @1 \nadd process P P > t t~ QED=99, (t > u zptu, zptu > b d~ ), (t~ > b~ w-, w- > l- vl~ ) @2 \n"

psetup_zphfull_TTSemiZp :: ProcessSetup ZpHFull
psetup_zphfull_TTSemiZp = PS {  
    mversion = MadGraph4
  , model = ZpHFull
  , process = processTTBarSemiZp
  , processBrief = "TTSemiZp" 
  , workname   = "414ZpH_TTBarSemiZp"
  }

zpHFullParamSet :: [ModelParam ZpHFull]
zpHFullParamSet = [ ZpHFullParam m g (0.28) 
                    | m <-[150.0] 
                    , g <- [1.0] ] 
          

psetuplist :: [ProcessSetup ZpHFull]
psetuplist = [ psetup_zphfull_TTSemiZp ]

sets :: [Int]
sets = [1..10]

zptasklist :: ScriptSetup -> ClusterSetup -> [WorkSetup ZpHFull]
zptasklist ssetup csetup =  
  [ WS ssetup (psetup_zphfull_TTSemiZp) 
       (rsetupGen p NoMatch NoUserCutDef RunPGS 50000 num) 
       csetup  
       (WebDAVRemoteDir "mc/TeVatronFor3/ZpHFull0414BigTTBarSemiZp")
  | p <- zpHFullParamSet , num <- sets     ]


totaltasklist :: ScriptSetup -> ClusterSetup -> [WorkSetup ZpHFull]
totaltasklist = zptasklist 



          