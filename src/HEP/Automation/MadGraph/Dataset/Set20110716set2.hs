module HEP.Automation.MadGraph.Dataset.Set20110712set5 where

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
  , workname   = "711_C1V_TTBar0or1J_TEV"
  }

paramSet :: [ModelParam C1V]
paramSet = [ C1VParam { mnp = m, gnpR = g, gnpL = 0 } 
           | (m,g) <-    (map (\x->(200,x)) [0.65,0.70..0.95] )
                      ++ (map (\x->(300,x)) [1.05,1.1..1.30] )
                      ++ (map (\x->(400,x)) [1.15,1.20..1.40] )
                      ++ (map (\x->(600,x)) [1.65,1.70..1.90] ) 
                      ++ (map (\x->(800,x)) [1.55,1.60..2.2] ) ]

--           | (m,g) <-    (map (\x->(200,x)) [0.4,0.45,0.50,0.55,0.60] )
--                      ++ (map (\x->(300,x)) [0.4,0.45..1.0] )
--                      ++ (map (\x->(400,x)) [0.6,0.65..1.10] )
--                      ++ (map (\x->(600,x)) [1.0,1.05..1.60] ) 
--                      ++ (map (\x->(800,x)) [1.30,1.35..1.50] ) ]

--                    [ (200,0.5), (200,1.0)
--                    , (400,0.5), (400,1.0), (400,1.5), (400,2.0)
--                    , (600,0.5), (600,1.0), (600,1.5), (600,2.0), (600,2.5)
--                    , (800,0.5), (800,1.0), (800,1.5), (800,2.0), (800,2.5), (800,3.0), (800,3.5)
--                    , (1000,0.5), (1000,1.0), (1000,1.5), (1000,2.0), (1000,2.5), (1000,3.0), (1000,3.5), (1000,4.0) ] ]

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
webdavdir = WebDAVRemoteDir "paper3/ttbar_TEV_c1v_pgsscan"
