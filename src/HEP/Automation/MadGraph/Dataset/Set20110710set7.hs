module HEP.Automation.MadGraph.Dataset.Set20110710set7 where

import HEP.Storage.WebDAV.Type

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.C1V

import HEP.Automation.MadGraph.Dataset.Processes

import HEP.Automation.JobQueue.JobType

processsetup :: ProcessSetup C1V
processsetup = PS {  
    model = C1V
  , process = preDefProcess TTBar0or1J
  , processBrief = "TTBar0or1J" 
  , workname   = "C1VtestNext"
  }

paramSet :: [ModelParam C1V]
paramSet = [ C1VParam { mnp = 500.0,  
                        gnpR = 1.0, 
                        gnpL = 0.0 } ]
              

psetuplist :: [ProcessSetup C1V ]
psetuplist = [ processsetup ]

sets :: [Int]
sets = [1] 

ucut :: UserCut 
ucut = UserCut { 
    uc_metcut = 15.0
  , uc_etacutlep = 1.2
  , uc_etcutlep = 18.0 
  , uc_etacutjet = 2.5
  , uc_etcutjet = 15.0 
}


eventsets :: [EventSet]
eventsets =  
  [ EventSet  processsetup 
              (RS { param = p
                  , numevent = 10000
                  , machine = LHC7 ATLAS
                  , rgrun   = Fixed
                  , rgscale = 200.0
                  , match   = MLM
                  , cut     = DefCut 
                  , pythia  = RunPYTHIA
                  , usercut = NoUserCutDef -- UserCutDef ucut
                  , pgs     = NoPGS -- RunPGS
                  , jetalgo = AntiKTJet 0.4
                  , uploadhep = NoUploadHEP
                  , setnum  = num 
                  })
   | p <- paramSet , num <- sets     ]

webdavdir :: WebDAVRemoteDir
webdavdir = WebDAVRemoteDir "paper3/test"
