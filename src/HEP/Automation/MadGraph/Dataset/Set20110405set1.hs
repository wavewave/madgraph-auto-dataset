module HEP.Automation.MadGraph.Dataset.Set20110405set1 where

import HEP.Storage.WebDAV

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.WpZpFull

import HEP.Automation.MadGraph.Dataset.Common

processTB :: [Char]
processTB =  
  "\ngenerate P P > t b / g a z h w+ w-  QED=99 @1\nadd process P P > t~ b~ / g a z h w+ w- QED=99 @2\n"

psetup_wpzpfull_bb :: ProcessSetup WpZpFull
psetup_wpzpfull_bb = PS {  
    mversion = MadGraph4
  , model = WpZpFull
  , process = processTB 
  , processBrief = "tb"  
  , workname   = "405WpZpFull"
  }

wpzpparamset :: [ModelParam WpZpFull]
wpzpparamset = [ WpZpFullParam m m gW gW gZ gZ gZ gZ 
                    | m <-[150.0] 
                    , gW <- [0.5*sqrt 2] 
                    , gZ <- [0.5]  ] 
          

psetuplist :: [ProcessSetup WpZpFull]
psetuplist = [ psetup_wpzpfull_bb ]

sets :: [Int]
sets = [1]

wpzptasklist :: ScriptSetup -> ClusterSetup -> [WorkSetup WpZpFull]
wpzptasklist ssetup csetup =  
  [ WS ssetup (psetup_wpzpfull_bb) 
       (rsetupGen p NoMatch NoUserCutDef NoPGS 20000 num) 
       csetup  
       (WebDAVRemoteDir undefined)
  | p <- wpzpparamset , num <- sets     ]

wpzptasklist2 :: ScriptSetup -> ClusterSetup -> [WorkSetup WpZpFull]
wpzptasklist2 ssetup csetup =  
  [ WS ssetup (psetup_wpzpfull_bb) 
       (rsetupLHC p NoMatch NoUserCutDef NoPGS 20000 num) 
       csetup  
       (WebDAVRemoteDir undefined)
  | p <- wpzpparamset , num <- sets     ]


totaltasklist :: ScriptSetup -> ClusterSetup -> [WorkSetup WpZpFull]
totaltasklist ssetup csetup = 
  wpzptasklist ssetup csetup ++ wpzptasklist2 ssetup csetup



          