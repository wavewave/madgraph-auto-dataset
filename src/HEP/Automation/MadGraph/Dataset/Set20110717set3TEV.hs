module HEP.Automation.MadGraph.Dataset.Set20110717set3TEV where

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
  , workname   = "717_SChanC8Vschmaltz_TTBar0or1J_TEV"
  }

paramSet :: [ModelParam SChanC8Vschmaltz]
paramSet = [ SChanC8VschmaltzParam { mnp = m, mphi = 100.0, ga = g, nphi = n} 
           | ( m, g, n ) <- [ (440,0.45,5) 
                            , (420,0.45,6) ] ] 


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
webdavdir = WebDAVRemoteDir "paper3/ttbar_TEV_schmaltz_big"
