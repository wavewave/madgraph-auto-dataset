module HEP.Automation.MadGraph.Dataset.Set20110429set1 where

import HEP.Storage.WebDAV

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.SM

import HEP.Automation.MadGraph.Dataset.Common
import HEP.Automation.MadGraph.Dataset.Processes


import qualified Data.ByteString as B

psetup_eebardijet :: ProcessSetup SM
psetup_eebardijet = PS {  
    mversion = MadGraph5
  , model = SM
  , process = preDefProcess EEDijet
  , processBrief = "EEDijet" 
  , workname   = "429SM_EEDijet"
  }

          

psetuplist :: [ProcessSetup SM]
psetuplist = [ psetup_eebardijet ]

sets :: [Int]
sets = [2..10]

dijettasklist :: ScriptSetup -> ClusterSetup SM -> [WorkSetup SM]
dijettasklist ssetup csetup =  
  [ WS ssetup (psetup_eebardijet) 
       (RS { param = SMParam 
           , numevent = 10000
           , machine = Parton energy
           , rgrun   = Fixed
           , rgscale = 200.0
           , match   = NoMatch
           , cut     = DefCut 
           , pythia  = RunPYTHIA
           , usercut = NoUserCutDef
           , pgs     = RunPGS 
           , setnum  = num
           })
       csetup  
       (WebDAVRemoteDir "mc/TeVatronFor3/SM0429EEDijet")
  | energy <- [ 50,100..500], num <- sets ]


totaltasklist :: ScriptSetup -> ClusterSetup SM -> [WorkSetup SM]
totaltasklist = dijettasklist 


