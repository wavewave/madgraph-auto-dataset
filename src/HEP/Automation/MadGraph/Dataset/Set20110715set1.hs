module HEP.Automation.MadGraph.Dataset.Set20110715set1 where

import HEP.Storage.WebDAV.Type

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.FU8C1V

import HEP.Automation.MadGraph.Dataset.Processes

import HEP.Automation.JobQueue.JobType

processSetup :: ProcessSetup FU8C1V
processSetup = PS {  
    model = FU8C1V
  , process = preDefProcess TTBar0or1J
  , processBrief = "TTBar0or1J" 
  , workname   = "715_FU8C1V_TTBar0or1J_LHC"
  }

paramSet :: [ModelParam FU8C1V]
paramSet = [ FU8C1VParam { mMFV = m, dmMFV = 0, gMFV = 0.5, eta = e } 
           | m <- [ 200,400..800] , e <- [ 0.0,0.5..3.0 ] ] 

sets :: [Int]
sets =  [1]

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
  [ EventSet  processSetup 
              (RS { param = p
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
   | p <- paramSet , num <- sets     ]

webdavdir :: WebDAVRemoteDir
webdavdir = WebDAVRemoteDir "paper3/ttbar_LHC_FU8C1V_pgsscan"
