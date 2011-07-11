module HEP.Automation.MadGraph.Dataset.Set20110711set1 where

import HEP.Storage.WebDAV.Type

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.C1V

import HEP.Automation.MadGraph.Dataset.Processes

import HEP.Automation.JobQueue.JobType

processSetup :: ProcessSetup C1V
processSetup = PS {  
    model = C1V
  , process = preDefProcess TTBar0or1J
  , processBrief = "TTBar0or1J" 
  , workname   = "711_C1V_TTBar0or1J_LHC"
  }

paramSet :: [ModelParam C1V]
paramSet = [ C1VParam { mnp = m,  
                        gnpR = g,
                        gnpL = 0 } | m <- [200,300..1000], g <- [1,2,3,4,5] ]


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
                  , numevent = 10000
                  , machine = LHC7 ATLAS
                  , rgrun   = Fixed
                  , rgscale = 200.0
                  , match   = MLM
                  , cut     = DefCut 
                  , pythia  = RunPYTHIA
                  , usercut = NoUserCutDef -- UserCutDef ucut --  NoUserCutDef -- 
                  , pgs     = NoPGS -- RunPGS
                  , jetalgo = AntiKTJet 0.4
                  , uploadhep = NoUploadHEP
                  , setnum  = num 
                  })
   | p <- paramSet , num <- sets     ]

webdavdir :: WebDAVRemoteDir
webdavdir = WebDAVRemoteDir "paper3/ttbar_LHC_c1v_scan"
