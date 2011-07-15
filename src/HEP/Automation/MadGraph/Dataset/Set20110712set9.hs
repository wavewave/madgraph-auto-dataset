module HEP.Automation.MadGraph.Dataset.Set20110712set9 where

import HEP.Storage.WebDAV.Type

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.SM

import HEP.Automation.MadGraph.Dataset.Processes

import HEP.Automation.JobQueue.JobType

import qualified Data.ByteString as B

psetup_sm :: ProcessSetup SM
psetup_sm = PS {  
    model = SM
  , process = preDefProcess TTBar0or1J
  , processBrief = "TTBar0or1J" 
  , workname   = "712SM_TTBar0or1J_LHC"
  }

psetuplist :: [ProcessSetup SM]
psetuplist = [ psetup_sm ]

sets :: [Int]
sets = [1..50]

ucut :: UserCut 
ucut = UserCut { 
    uc_metcut = 15.0
  , uc_etacutlep = 2.7
  , uc_etcutlep = 18.0 
  , uc_etacutjet = 2.7
  , uc_etcutjet = 15.0 
}

eventsets :: [EventSet] 
eventsets = 
  [ EventSet psetup_sm 
             (RS { param = SMParam 
                 , numevent = 100000
                 , machine = LHC7 ATLAS
                 , rgrun   = Fixed
                 , rgscale = 200.0
                 , match   = MLM
                 , cut     = DefCut 
                 , pythia  = RunPYTHIA
                 , usercut = UserCutDef ucut
                 , pgs     = RunPGS 
                 , jetalgo = AntiKTJet 0.4
                 , uploadhep = NoUploadHEP
                 , setnum  = num
                 })
  | num <- sets ]


webdavdir :: WebDAVRemoteDir 
webdavdir = WebDAVRemoteDir "paper3/ttbar_LHC_sm_big"



