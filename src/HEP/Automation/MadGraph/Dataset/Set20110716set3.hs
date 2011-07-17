module HEP.Automation.MadGraph.Dataset.Set20110716set3 where

import HEP.Storage.WebDAV.Type

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.SChanC8Vschmaltz

import HEP.Automation.MadGraph.Dataset.Processes

import HEP.Automation.JobQueue.JobType

processSetup :: ProcessSetup SChanC8Vschmaltz
processSetup = PS {  
    model = SChanC8Vschmaltz
  , process = preDefProcess TTBar0or1J
  , processBrief = "TTBar0or1J" 
  , workname   = "713_SChanC8Vschmaltz_TTBar0or1J_LHC"
  }

paramSet :: [ModelParam SChanC8Vschmaltz]
paramSet = [ SChanC8VschmaltzParam { mnp = m, mphi = 100.0, ga = g, nphi = n} 
           | m <- [ 420 ]  
           , (g,n) <- [ (0.39*1.22,6.2), (0.37*1.22,5.3 ), (0.35*1.22,4.27) ]  ]  
           

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
                  , usercut = UserCutDef ucut --  NoUserCutDef -- 
                  , pgs     = RunPGS
                  , jetalgo = AntiKTJet 0.4
                  , uploadhep = NoUploadHEP
                  , setnum  = num 
                  })
   | p <- paramSet , num <- sets     ]

webdavdir :: WebDAVRemoteDir
webdavdir = WebDAVRemoteDir "paper3/ttbar_LHC_schmaltz_pgsscan"
