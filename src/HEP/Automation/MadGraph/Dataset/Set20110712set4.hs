module HEP.Automation.MadGraph.Dataset.Set20110712set4 where

import HEP.Storage.WebDAV.Type

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.C8V

import HEP.Automation.MadGraph.Dataset.Processes

import HEP.Automation.JobQueue.JobType

processSetup :: ProcessSetup C8V
processSetup = PS {  
    model = C8V
  , process = preDefProcess TTBar0or1J
  , processBrief = "TTBar0or1J" 
  , workname   = "710_C8V_TTBar0or1J_LHC"
  }

paramSet :: [ModelParam C8V]
paramSet = [ C8VParam { mnp = m, gnpR = g, gnpL = 0 } 
           | (m,g) <- [ (200,0.5), (200,1.0)
                      , (400,0.5), (400,1.0), (400,1.5), (400,2.0)
                      , (600,0.5), (600,1.0), (600,1.5), (600,2.0), (600,2.5), (600,3.0)
                      , (800,0.5), (800,1.0), (800,1.5), (800,2.0), (800,2.5), (800,3.0), (800,3.5), (800,4.0)
                      , (1000,0.5), (1000,1.0), (1000,1.5), (1000,2.0), (1000,2.5), (1000,3.0), (1000,3.5), (1000,4.0), (1000,4.5), (1000,5.0) ]  ]

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
webdavdir = WebDAVRemoteDir "paper3/ttbar_LHC_c8v_pgsscan"
