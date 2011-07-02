module HEP.Automation.MadGraph.Dataset.Set20110702set1 where

import HEP.Storage.WebDAV.Type

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.SM

import HEP.Automation.MadGraph.Dataset.Processes

import HEP.Automation.JobQueue.JobType 

import qualified Data.ByteString as B

psetup_sm_eebardijet :: ProcessSetup SM
psetup_sm_eebardijet = PS {  
    mversion = MadGraph5
  , model = SM
  , process = preDefProcess EEDijet
  , processBrief = "EEDijet" 
  , workname   = "429SM_EEDijet"
  }

psetuplist :: [ProcessSetup SM]
psetuplist = [ psetup_sm_eebardijet ]

sets :: [Int]
sets = [1..10]

eventsets :: [EventSet] 
eventsets = 
  [ EventSet (psetup_sm_eebardijet) 
             (RS { param = SMParam 
                 , numevent = 10000
                 , machine = Parton energy LHC
                 , rgrun   = Fixed
                 , rgscale = 200.0
                 , match   = NoMatch
                 , cut     = DefCut 
                 , pythia  = RunPYTHIA
                 , usercut = NoUserCutDef
                 , pgs     = RunPGS 
                 , jetalgo = KTJet
                 , uploadhep = NoUploadHEP
                 , setnum  = num
                 })
  | energy <- [ 50,100..500], num <- sets ]


webdavdir :: WebDAVRemoteDir 
webdavdir = WebDAVRemoteDir "paper3/jetenergy"



