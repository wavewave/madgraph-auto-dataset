module HEP.Automation.MadGraph.Dataset.Set20110715set3 where

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
  , workname   = "715_SChanC8V_TTBar0or1J_LHC"
  }

paramSet :: [ModelParam SChanC8V]
paramSet = [ SChanC8VParam { mnp = m, gnpqR = g1, gnpqL = 0, 
                             gnpbR = g1, gnpbL = 0,
                             gnptR = g2, gnptL = 0 }
           | (m,g1,g2) <-    (map (\x->(700,-0.05,x)) [2.0,2.5..6.0] )
                          ++ (map (\x->(850,-0.08,x)) [2.0,2.5..8.0] )
                          ++ [ (1000, -0.15, 3) , (1000, -0.125, 5) , (1000,-0.1,8) ]
                          ++ [ (1500, -0.4,5.5) , (1500, -0.3, 8) ] ]
          
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
webdavdir = WebDAVRemoteDir "paper3/ttbar_LHC_alvarez_pgsscan"
