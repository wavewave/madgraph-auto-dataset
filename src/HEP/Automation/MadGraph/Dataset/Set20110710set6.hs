module HEP.Automation.MadGraph.Dataset.Set20110710set6 where

import HEP.Storage.WebDAV.Type

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.ZpH

import HEP.Automation.MadGraph.Dataset.Processes

import HEP.Automation.JobQueue.JobType

processsetup :: ProcessSetup ZpH
processsetup = PS {  
    model = ZpH
  , process = preDefProcess TTBar
  , processBrief = "TTBar" 
  , workname   = "ZpHtest2"
  }

paramSet :: [ModelParam ZpH]
paramSet = [ ZpHParam { massZp = 500.0,  
                        gRZp = 1.4 } ]
              

psetuplist :: [ProcessSetup ZpH ]
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
