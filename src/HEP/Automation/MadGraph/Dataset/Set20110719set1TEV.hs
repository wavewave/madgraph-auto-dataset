module HEP.Automation.MadGraph.Dataset.Set20110719set1TEV where

import HEP.Storage.WebDAV.Type

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.SChanC8V

import HEP.Automation.MadGraph.Dataset.Processes

import HEP.Automation.JobQueue.JobType

processSetup :: ProcessSetup SChanC8V
processSetup = PS {  
    model = SChanC8V
  , process = preDefProcess TTBar0or1J
  , processBrief = "TTBar0or1J" 
  , workname   = "717_SChanC8V_TTBar0or1J_TEV"
  }

paramSet :: [ModelParam SChanC8V]
paramSet = [ SChanC8VParam { mnp = m, gnpqR = g12, gnpqL = -g12, 
                             gnpbR = g3, gnpbL = -g3,
                             gnptR = g3, gnptL = -g3 }
           | (m,g12,g3) <- [ (2000,-1,5) 
                           , (2400,-3.6,3.6) ] ] 
          
sets :: [Int]
sets =  [1..50]

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
                  , machine = TeVatron
                  , rgrun   = Fixed
                  , rgscale = 200.0
                  , match   = MLM
                  , cut     = DefCut 
                  , pythia  = RunPYTHIA
                  , usercut = UserCutDef ucut --  NoUserCutDef -- 
                  , pgs     = RunPGS
                  , jetalgo = Cone 0.4
                  , uploadhep = NoUploadHEP
                  , setnum  = num 
                  })
   | p <- paramSet , num <- sets     ]

webdavdir :: WebDAVRemoteDir
webdavdir = WebDAVRemoteDir "paper3/ttbar_TEV_schanc8v_big"
