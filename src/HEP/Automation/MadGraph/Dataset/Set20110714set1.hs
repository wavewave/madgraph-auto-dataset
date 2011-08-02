module HEP.Automation.MadGraph.Dataset.Set20110714set1 where

import HEP.Storage.WebDAV.Type

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.Trip

import HEP.Automation.MadGraph.Dataset.Processes

import HEP.Automation.JobQueue.JobType

processSetup :: ProcessSetup Trip
processSetup = PS {  
    model = Trip
  , process = preDefProcess TTBar0or1J
  , processBrief = "TTBar0or1J" 
  , workname   = "714_Trip_TTBar0or1J_LHC"
  }

paramSet :: [ModelParam Trip]
paramSet = [ TripParam { massTrip = m, gRTrip = g } 
           | (m,g) <-    (map (\x->(400,x)) [1.5,1.55..3.50] )
                      ++ (map (\x->(600,x)) [2.5,2.55..4.50] ) 
                      ++ (map (\x->(800,x)) [3.5,3.55..5.50] ) ] 

{-           | (m,g) <-    (map (\x->(400,x)) [3.5,3.55..4.50] )
                      ++ (map (\x->(600,x)) [4.5,4.55..5.50] ) 
                      ++ (map (\x->(800,x)) [5.5,5.55..6.50] ) ] -}

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
webdavdir = WebDAVRemoteDir "paper3/ttbar_LHC_trip_pgsscan"
